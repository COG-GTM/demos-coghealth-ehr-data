#!/usr/bin/env bash
# Fails if any image in docker-compose.yml ships a JDK affected by
# Java4Shell (CVE-2026-114938, java.util.Base64 decoder RCE).
#
# Usage:
#   scripts/check-jdk-versions.sh              # check every compose image (pulls them)
#   scripts/check-jdk-versions.sh IMAGE...     # check specific images
#   scripts/check-jdk-versions.sh --self-test  # test the version logic only
set -euo pipefail

# Lowest fixed build per affected major. 8 and 11 are not affected.
fixed_min_for_major() {
  case "$1" in
    8|11) echo "unaffected" ;;
    17) echo "17.0.21.1" ;;
    21) echo "21.0.13.1" ;;
    25) echo "25.0.5.1" ;;
    27) echo "27.0.1.1" ;;
    *) echo "unknown" ;;
  esac
}

# Returns 0 when version $1 >= $2 (dotted numeric, missing parts count as 0).
version_ge() {
  local IFS=.
  local -a a=($1) b=($2)
  local i n=$(( ${#a[@]} > ${#b[@]} ? ${#a[@]} : ${#b[@]} ))
  for ((i = 0; i < n; i++)); do
    local x=$((10#${a[i]:-0})) y=$((10#${b[i]:-0}))
    ((x > y)) && return 0
    ((x < y)) && return 1
  done
  return 0
}

# Prints OK/FAIL for a JDK version string such as 17.0.10 or 1.8.0_402.
evaluate_version() {
  local v="$1" major min
  if [[ "$v" == 1.* ]]; then major="${v#1.}"; major="${major%%.*}"; else major="${v%%.*}"; fi
  v="${v%%[-_+]*}"
  min="$(fixed_min_for_major "$major")"
  case "$min" in
    unaffected) echo "OK (Java $major is not affected)" ;;
    unknown) echo "FAIL (Java $major is not covered by a fixed release; use 17.0.21.1+, 21.0.13.1+, 25.0.5.1+ or 27.0.1.1+)"; return 1 ;;
    *)
      if version_ge "$v" "$min"; then echo "OK (>= $min)"; else echo "FAIL (below fixed $min)"; return 1; fi ;;
  esac
}

self_test() {
  local fail=0 v want got
  while read -r v want; do
    if evaluate_version "$v" >/dev/null; then got=OK; else got=FAIL; fi
    if [[ "$got" != "$want" ]]; then echo "self-test: $v expected $want, got $got"; fail=1; fi
  done <<'CASES'
1.8.0_402 OK
11.0.22 OK
17.0.10 FAIL
17.0.21 FAIL
17.0.21.1 OK
17.0.22 OK
21.0.1 FAIL
21.0.13 FAIL
21.0.13.1 OK
25.0.5 FAIL
25.0.5.1 OK
27.0.1.0.3 FAIL
27.0.1.1 OK
26.0.1 FAIL
CASES
  ((fail == 0)) && echo "self-test passed"
  return "$fail"
}

# Prints the runtime JDK version of an image, or nothing if it has no JDK.
image_java_version() {
  docker run --rm --entrypoint sh "$1" -c '
    for j in "${JAVA_HOME:+$JAVA_HOME/bin/java}" "$(command -v java 2>/dev/null)" \
             /usr/share/elasticsearch/jdk/bin/java /opt/java/openjdk/bin/java; do
      if [ -n "$j" ] && [ -x "$j" ]; then "$j" -version 2>&1 | head -n1; exit 0; fi
    done' 2>/dev/null | sed -n 's/.*version "\([^"]*\)".*/\1/p'
}

if [[ "${1:-}" == "--self-test" ]]; then
  self_test
  exit $?
fi

cd "$(dirname "$0")/.."
if (($#)); then images=("$@"); else mapfile -t images < <(docker compose config --images | sort -u); fi

status=0
for image in "${images[@]}"; do
  docker pull -q "$image" >/dev/null
  version="$(image_java_version "$image" || true)"
  if [[ -z "$version" ]]; then
    printf '%-60s no JDK\n' "$image"
    continue
  fi
  if result="$(evaluate_version "$version")"; then :; else status=1; fi
  printf '%-60s java %-12s %s\n' "$image" "$version" "$result"
done

if ((status)); then echo "Java4Shell (CVE-2026-114938): affected JDK found" >&2; fi
exit "$status"

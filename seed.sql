--
-- PostgreSQL database dump
--

\restrict iFyufdwuajiSZqa81JuyWBWMQvvJoVYgpi4HRQvarBfPdKBbqQXChwWaKtteCJ2

-- Dumped from database version 14.20
-- Dumped by pg_dump version 14.20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO coghealth;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO coghealth;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO coghealth;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO coghealth;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO coghealth;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO coghealth;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO coghealth;

--
-- Name: client; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO coghealth;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO coghealth;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO coghealth;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO coghealth;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO coghealth;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO coghealth;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO coghealth;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO coghealth;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO coghealth;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO coghealth;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO coghealth;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO coghealth;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO coghealth;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO coghealth;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO coghealth;

--
-- Name: component; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO coghealth;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO coghealth;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO coghealth;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO coghealth;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO coghealth;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO coghealth;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO coghealth;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO coghealth;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO coghealth;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO coghealth;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO coghealth;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO coghealth;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO coghealth;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO coghealth;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO coghealth;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO coghealth;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO coghealth;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO coghealth;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO coghealth;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO coghealth;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO coghealth;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO coghealth;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO coghealth;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO coghealth;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO coghealth;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO coghealth;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO coghealth;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO coghealth;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO coghealth;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO coghealth;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO coghealth;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO coghealth;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO coghealth;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO coghealth;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO coghealth;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO coghealth;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO coghealth;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO coghealth;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO coghealth;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO coghealth;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO coghealth;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO coghealth;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO coghealth;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO coghealth;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO coghealth;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO coghealth;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO coghealth;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO coghealth;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO coghealth;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO coghealth;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO coghealth;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO coghealth;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO coghealth;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO coghealth;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO coghealth;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO coghealth;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO coghealth;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO coghealth;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO coghealth;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO coghealth;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO coghealth;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO coghealth;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO coghealth;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO coghealth;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO coghealth;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO coghealth;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO coghealth;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO coghealth;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO coghealth;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: coghealth
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO coghealth;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
9859e911-81cb-4adc-8905-9748c3537546	\N	auth-cookie	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	674e94fd-03fe-4ca2-8f12-45c3dc68daea	2	10	f	\N	\N
543764f8-2ef1-487b-a034-02b4d2a2184a	\N	auth-spnego	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	674e94fd-03fe-4ca2-8f12-45c3dc68daea	3	20	f	\N	\N
a6bb6417-66de-4e85-b6ce-de3b5dca8071	\N	identity-provider-redirector	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	674e94fd-03fe-4ca2-8f12-45c3dc68daea	2	25	f	\N	\N
dce5def2-5afb-4095-afb1-651346ccde03	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	674e94fd-03fe-4ca2-8f12-45c3dc68daea	2	30	t	fe84279d-9670-4325-ade6-f08f168ee211	\N
586e2e42-2b34-42a7-b445-13ba387e652d	\N	auth-username-password-form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	fe84279d-9670-4325-ade6-f08f168ee211	0	10	f	\N	\N
cf82b623-a743-4350-9f67-6495da95e9b2	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	fe84279d-9670-4325-ade6-f08f168ee211	1	20	t	88aa797b-9280-4e9d-b642-11e76e34594c	\N
b0bb6844-63fd-48dc-8040-63861d6e3453	\N	conditional-user-configured	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	88aa797b-9280-4e9d-b642-11e76e34594c	0	10	f	\N	\N
a8f5d0ff-35e9-404c-9cc2-2f939905821a	\N	auth-otp-form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	88aa797b-9280-4e9d-b642-11e76e34594c	0	20	f	\N	\N
fe7147c1-c9fb-4c50-9f78-98988ba9899a	\N	direct-grant-validate-username	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b17776a8-b1fa-496a-a780-d675b4cd2f9e	0	10	f	\N	\N
5b8d315d-0502-4f62-b2f1-18c30d818882	\N	direct-grant-validate-password	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b17776a8-b1fa-496a-a780-d675b4cd2f9e	0	20	f	\N	\N
03da085e-6c6e-4ad7-8752-7c524bb46418	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b17776a8-b1fa-496a-a780-d675b4cd2f9e	1	30	t	42bdbcc1-244c-4859-9a8a-51ec714a2e26	\N
aa5c0e4f-fe81-4cf4-b91c-0def9e720561	\N	conditional-user-configured	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	42bdbcc1-244c-4859-9a8a-51ec714a2e26	0	10	f	\N	\N
d75e1c51-bd59-47d3-891f-3513b531a7ea	\N	direct-grant-validate-otp	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	42bdbcc1-244c-4859-9a8a-51ec714a2e26	0	20	f	\N	\N
73e99b4e-f335-469e-bc57-26e0826c7095	\N	registration-page-form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	c6427deb-02e4-4f03-a3a3-05852e129673	0	10	t	150a526a-0aa5-47a8-ac5f-f7e38445bb81	\N
11fa02a3-af49-4571-94ce-7ab3a9bf68c0	\N	registration-user-creation	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	150a526a-0aa5-47a8-ac5f-f7e38445bb81	0	20	f	\N	\N
4ecaab6d-4d02-4106-bb97-6bac9e681123	\N	registration-password-action	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	150a526a-0aa5-47a8-ac5f-f7e38445bb81	0	50	f	\N	\N
a4463472-b669-4348-8e92-203f3d92468f	\N	registration-recaptcha-action	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	150a526a-0aa5-47a8-ac5f-f7e38445bb81	3	60	f	\N	\N
3104c6ef-37bd-43cf-b9d9-c81a41593101	\N	registration-terms-and-conditions	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	150a526a-0aa5-47a8-ac5f-f7e38445bb81	3	70	f	\N	\N
b073cb4c-74b1-4a55-b99f-04b0febf7d7e	\N	reset-credentials-choose-user	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b7121eda-997e-4039-a728-ef8d1fcef36e	0	10	f	\N	\N
077aeeae-b181-404c-b6f8-341f0a5a15b2	\N	reset-credential-email	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b7121eda-997e-4039-a728-ef8d1fcef36e	0	20	f	\N	\N
5fe1b42a-10e1-4401-98ce-659d584115df	\N	reset-password	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b7121eda-997e-4039-a728-ef8d1fcef36e	0	30	f	\N	\N
e7f750c0-d0b8-4646-b1d5-7a18c4eb7430	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b7121eda-997e-4039-a728-ef8d1fcef36e	1	40	t	da8c7ab4-e21d-4403-9ceb-0e617bc5526b	\N
de5228d1-3653-4c3a-b602-54f5ab075b37	\N	conditional-user-configured	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	da8c7ab4-e21d-4403-9ceb-0e617bc5526b	0	10	f	\N	\N
e3932eaa-f4f6-46ae-bc2e-f8447592764e	\N	reset-otp	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	da8c7ab4-e21d-4403-9ceb-0e617bc5526b	0	20	f	\N	\N
277cec3a-e964-4713-af1f-7b664930a5a0	\N	client-secret	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	4db4d26b-fb63-40f1-8248-108d75193d2e	2	10	f	\N	\N
cedf6f75-c9a2-4706-94e0-5be376423b1a	\N	client-jwt	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	4db4d26b-fb63-40f1-8248-108d75193d2e	2	20	f	\N	\N
cc7820a1-8844-4669-8dd8-25ee319ff7f8	\N	client-secret-jwt	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	4db4d26b-fb63-40f1-8248-108d75193d2e	2	30	f	\N	\N
a472c2a1-37ae-46b8-95f7-f2611516f34e	\N	client-x509	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	4db4d26b-fb63-40f1-8248-108d75193d2e	2	40	f	\N	\N
4ebbcf54-b98b-4aa9-9f85-9cebe5aeed7b	\N	idp-review-profile	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	818f8cb4-760c-4e04-b449-6ee76d233997	0	10	f	\N	28a231fa-8adb-4af9-b9ab-5e75297b6f1a
f4edca55-f813-41c0-8fca-7b12e7d524a3	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	818f8cb4-760c-4e04-b449-6ee76d233997	0	20	t	06f4816f-ab9e-4eff-a973-dc0048406ad8	\N
f9736698-9329-4cc9-b79c-84b461ee4f4e	\N	idp-create-user-if-unique	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	06f4816f-ab9e-4eff-a973-dc0048406ad8	2	10	f	\N	a71c6ba2-3fd2-4b62-9ccc-33ace70b9095
6476bcd8-9e47-478c-ac37-27c9402baa90	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	06f4816f-ab9e-4eff-a973-dc0048406ad8	2	20	t	963cfcb5-2860-46d7-b1a5-ab07b073011c	\N
2e5186f2-ab43-472f-8504-763e07ca9756	\N	idp-confirm-link	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	963cfcb5-2860-46d7-b1a5-ab07b073011c	0	10	f	\N	\N
7466d6fa-b379-4db2-a212-daad3225646d	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	963cfcb5-2860-46d7-b1a5-ab07b073011c	0	20	t	f4d4badb-ac18-47e7-bb9b-6e52d7727d6f	\N
962284ad-2ca7-4032-82fb-88b1d40b6506	\N	idp-email-verification	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f4d4badb-ac18-47e7-bb9b-6e52d7727d6f	2	10	f	\N	\N
a2e9634a-8a7e-426b-b8b9-0d117c12cc92	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f4d4badb-ac18-47e7-bb9b-6e52d7727d6f	2	20	t	1c870a3e-5ffb-4ae2-a9c9-081820e1bce0	\N
e75adea7-1d8f-41a2-938e-80ae6bfb27c7	\N	idp-username-password-form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	1c870a3e-5ffb-4ae2-a9c9-081820e1bce0	0	10	f	\N	\N
3e72732f-5b98-4fae-9df0-fa4cdccf2c27	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	1c870a3e-5ffb-4ae2-a9c9-081820e1bce0	1	20	t	a3d741fd-516a-4a6a-a59f-5b6ba0593e6d	\N
6cadf0d7-7737-4665-a664-0b0ec5c7e0f9	\N	conditional-user-configured	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	a3d741fd-516a-4a6a-a59f-5b6ba0593e6d	0	10	f	\N	\N
74d8e388-e86f-485a-b20f-2a23de4bcb10	\N	auth-otp-form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	a3d741fd-516a-4a6a-a59f-5b6ba0593e6d	0	20	f	\N	\N
3ea036b8-7458-4010-b708-e72dc81d9ae0	\N	http-basic-authenticator	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8181e488-8fca-43db-9ab5-6d01a2eced4b	0	10	f	\N	\N
4beecde1-f87c-40f4-bfa7-17be192ad94f	\N	docker-http-basic-authenticator	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	ac267a26-2339-42b0-b24a-a4ab0993d5c7	0	10	f	\N	\N
08165742-48b1-405f-b9e9-b026210b6dfc	\N	auth-cookie	8741d434-aa5e-4cee-a356-84d10a6eb2ff	24b487e7-a6af-477d-ae7b-6cfef4992c03	2	10	f	\N	\N
0f1a9778-cae5-41ec-b6b0-eb4762d91a7b	\N	auth-spnego	8741d434-aa5e-4cee-a356-84d10a6eb2ff	24b487e7-a6af-477d-ae7b-6cfef4992c03	3	20	f	\N	\N
58d337cf-dfae-4e02-a567-4b44d6552c45	\N	identity-provider-redirector	8741d434-aa5e-4cee-a356-84d10a6eb2ff	24b487e7-a6af-477d-ae7b-6cfef4992c03	2	25	f	\N	\N
0068287c-99de-4754-8fc5-8bc5cb9f53a4	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	24b487e7-a6af-477d-ae7b-6cfef4992c03	2	30	t	ffebe1dc-bd1c-4cb0-ba11-937a696791ff	\N
137de0d1-1990-4948-9385-0b7ecd49153e	\N	auth-username-password-form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	ffebe1dc-bd1c-4cb0-ba11-937a696791ff	0	10	f	\N	\N
97377fd7-3113-41e9-82da-231a6acaafcf	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	ffebe1dc-bd1c-4cb0-ba11-937a696791ff	1	20	t	c3e5e653-7f0b-416e-936b-920c7092ac34	\N
fe305ff1-b338-4ab9-b721-47fee029d32f	\N	conditional-user-configured	8741d434-aa5e-4cee-a356-84d10a6eb2ff	c3e5e653-7f0b-416e-936b-920c7092ac34	0	10	f	\N	\N
5690bad1-1f2c-4162-a2bf-815d7679ca31	\N	auth-otp-form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	c3e5e653-7f0b-416e-936b-920c7092ac34	0	20	f	\N	\N
404481ea-ac41-498a-804b-e929f507b831	\N	direct-grant-validate-username	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f3f5a4b0-eb0e-4571-8151-f4b8a4e62145	0	10	f	\N	\N
a5c9772e-6ea1-4c2f-b7b2-e80a380bdab7	\N	direct-grant-validate-password	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f3f5a4b0-eb0e-4571-8151-f4b8a4e62145	0	20	f	\N	\N
723aaf23-c5d8-44d1-90d2-a2dbf9d3cf64	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f3f5a4b0-eb0e-4571-8151-f4b8a4e62145	1	30	t	fab3b0a9-2ac1-4d38-a1d2-d1b53e34d8b9	\N
da61c939-3bc8-4b07-9188-084311b2f5c4	\N	conditional-user-configured	8741d434-aa5e-4cee-a356-84d10a6eb2ff	fab3b0a9-2ac1-4d38-a1d2-d1b53e34d8b9	0	10	f	\N	\N
6a33a922-8169-40c6-b940-5927c4bb22f4	\N	direct-grant-validate-otp	8741d434-aa5e-4cee-a356-84d10a6eb2ff	fab3b0a9-2ac1-4d38-a1d2-d1b53e34d8b9	0	20	f	\N	\N
30152b07-a885-4c5f-949e-1ee01767c80b	\N	registration-page-form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	8d24e44f-f501-4e8a-834a-296f4143f3aa	0	10	t	834e3648-980e-4bcb-9bf4-b4d816146000	\N
a8daf4a7-cd2a-4b72-a871-f89419a49739	\N	registration-user-creation	8741d434-aa5e-4cee-a356-84d10a6eb2ff	834e3648-980e-4bcb-9bf4-b4d816146000	0	20	f	\N	\N
fa3fd10a-73b3-4153-8cad-d15ed9ebd26b	\N	registration-password-action	8741d434-aa5e-4cee-a356-84d10a6eb2ff	834e3648-980e-4bcb-9bf4-b4d816146000	0	50	f	\N	\N
ffb4341b-1377-4a59-8ac2-262858c9c1e4	\N	registration-recaptcha-action	8741d434-aa5e-4cee-a356-84d10a6eb2ff	834e3648-980e-4bcb-9bf4-b4d816146000	3	60	f	\N	\N
2fd8b927-8500-4680-bd73-298018859bdf	\N	reset-credentials-choose-user	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5fbdd64a-d2f9-493f-a634-d70352b4db9c	0	10	f	\N	\N
e27ffd1a-1563-4d81-b10e-72045e392e11	\N	reset-credential-email	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5fbdd64a-d2f9-493f-a634-d70352b4db9c	0	20	f	\N	\N
bb2cebd3-7cf3-40ae-9518-c305a5352562	\N	reset-password	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5fbdd64a-d2f9-493f-a634-d70352b4db9c	0	30	f	\N	\N
a5c8e799-8b17-40ec-b7a1-dbe2312d3d0b	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5fbdd64a-d2f9-493f-a634-d70352b4db9c	1	40	t	282313a9-b7c2-40fd-8dd2-cedc102ea42b	\N
238ccdc5-853a-4b19-acd0-a87ad1d9e3a6	\N	conditional-user-configured	8741d434-aa5e-4cee-a356-84d10a6eb2ff	282313a9-b7c2-40fd-8dd2-cedc102ea42b	0	10	f	\N	\N
a0cc4b97-302d-46ad-9fa2-fea4ff124e3c	\N	reset-otp	8741d434-aa5e-4cee-a356-84d10a6eb2ff	282313a9-b7c2-40fd-8dd2-cedc102ea42b	0	20	f	\N	\N
b7eb68e4-dec9-454b-8f0e-34cb09ca9645	\N	client-secret	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	2	10	f	\N	\N
b8d2bda0-ac0b-4538-9d7b-fd3fa51419c7	\N	client-jwt	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	2	20	f	\N	\N
c693a70c-407b-4979-aac6-6c0f6255f9f3	\N	client-secret-jwt	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	2	30	f	\N	\N
599b7a6b-2e6a-4ad6-abbb-6981ad594f57	\N	client-x509	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	2	40	f	\N	\N
a040c7a3-22cb-4742-9871-c12fcd7c94ad	\N	idp-review-profile	8741d434-aa5e-4cee-a356-84d10a6eb2ff	4742251f-e5af-40fd-aac7-70278f6d8f90	0	10	f	\N	e34b542a-ac3e-459c-b699-4431b369d9f2
597a3360-4211-4099-92e8-2ec5d1768ce0	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	4742251f-e5af-40fd-aac7-70278f6d8f90	0	20	t	e7aa5124-92ae-4158-8d00-dfbdd0d4ba2d	\N
93109fc5-bdc5-438d-a5a1-1a157fcd3362	\N	idp-create-user-if-unique	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e7aa5124-92ae-4158-8d00-dfbdd0d4ba2d	2	10	f	\N	fc0648fb-96a2-462b-94f2-e4f430d57923
42d13823-91c3-4f24-a6ae-d1268ad20ed1	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e7aa5124-92ae-4158-8d00-dfbdd0d4ba2d	2	20	t	7e5934dd-fb28-4cca-b581-14186819e95e	\N
7c82ed45-51b2-403e-93d7-d950f1ad8214	\N	idp-confirm-link	8741d434-aa5e-4cee-a356-84d10a6eb2ff	7e5934dd-fb28-4cca-b581-14186819e95e	0	10	f	\N	\N
33248fbd-26b0-4e76-9319-10d5fccd52c3	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	7e5934dd-fb28-4cca-b581-14186819e95e	0	20	t	1dee363c-f4e8-4c1f-84a4-4c08212eba7c	\N
1c4292ab-4aba-4a93-a29c-d025b35dad7c	\N	idp-email-verification	8741d434-aa5e-4cee-a356-84d10a6eb2ff	1dee363c-f4e8-4c1f-84a4-4c08212eba7c	2	10	f	\N	\N
710a2cb5-a75c-4586-a8d4-9cedcb512822	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	1dee363c-f4e8-4c1f-84a4-4c08212eba7c	2	20	t	08f2c7a2-fc0a-4ac3-a1c2-c91ed94c5e18	\N
7528dcd7-ab3d-48c3-835e-40b35d70d40d	\N	idp-username-password-form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	08f2c7a2-fc0a-4ac3-a1c2-c91ed94c5e18	0	10	f	\N	\N
44b00d6f-3e11-4e34-92a9-852a8ad94a4b	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	08f2c7a2-fc0a-4ac3-a1c2-c91ed94c5e18	1	20	t	7abe519a-27f5-4968-8eb1-f8bcb3dd50ec	\N
e16f71ee-dbc1-4ea7-afc8-c608bbae35b2	\N	conditional-user-configured	8741d434-aa5e-4cee-a356-84d10a6eb2ff	7abe519a-27f5-4968-8eb1-f8bcb3dd50ec	0	10	f	\N	\N
6231e49e-1c97-4848-84f3-b94ee5e0995a	\N	auth-otp-form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	7abe519a-27f5-4968-8eb1-f8bcb3dd50ec	0	20	f	\N	\N
ae33b097-b586-4fa9-8a74-4b1179f1e0b0	\N	http-basic-authenticator	8741d434-aa5e-4cee-a356-84d10a6eb2ff	afdf35d1-55aa-4818-932e-4881f292c7db	0	10	f	\N	\N
14c8b428-7c5b-40e7-855b-087afcdf410c	\N	docker-http-basic-authenticator	8741d434-aa5e-4cee-a356-84d10a6eb2ff	1fbb82c0-b1e9-4ee5-ab87-519ad0d8e03c	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
674e94fd-03fe-4ca2-8f12-45c3dc68daea	browser	browser based authentication	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
fe84279d-9670-4325-ade6-f08f168ee211	forms	Username, password, otp and other auth forms.	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
88aa797b-9280-4e9d-b642-11e76e34594c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
b17776a8-b1fa-496a-a780-d675b4cd2f9e	direct grant	OpenID Connect Resource Owner Grant	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
42bdbcc1-244c-4859-9a8a-51ec714a2e26	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
c6427deb-02e4-4f03-a3a3-05852e129673	registration	registration flow	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
150a526a-0aa5-47a8-ac5f-f7e38445bb81	registration form	registration form	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	form-flow	f	t
b7121eda-997e-4039-a728-ef8d1fcef36e	reset credentials	Reset credentials for a user if they forgot their password or something	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
da8c7ab4-e21d-4403-9ceb-0e617bc5526b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
4db4d26b-fb63-40f1-8248-108d75193d2e	clients	Base authentication for clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	client-flow	t	t
818f8cb4-760c-4e04-b449-6ee76d233997	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
06f4816f-ab9e-4eff-a973-dc0048406ad8	User creation or linking	Flow for the existing/non-existing user alternatives	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
963cfcb5-2860-46d7-b1a5-ab07b073011c	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
f4d4badb-ac18-47e7-bb9b-6e52d7727d6f	Account verification options	Method with which to verity the existing account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
1c870a3e-5ffb-4ae2-a9c9-081820e1bce0	Verify Existing Account by Re-authentication	Reauthentication of existing account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
a3d741fd-516a-4a6a-a59f-5b6ba0593e6d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	f	t
8181e488-8fca-43db-9ab5-6d01a2eced4b	saml ecp	SAML ECP Profile Authentication Flow	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
ac267a26-2339-42b0-b24a-a4ab0993d5c7	docker auth	Used by Docker clients to authenticate against the IDP	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	basic-flow	t	t
24b487e7-a6af-477d-ae7b-6cfef4992c03	browser	browser based authentication	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
ffebe1dc-bd1c-4cb0-ba11-937a696791ff	forms	Username, password, otp and other auth forms.	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
c3e5e653-7f0b-416e-936b-920c7092ac34	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
f3f5a4b0-eb0e-4571-8151-f4b8a4e62145	direct grant	OpenID Connect Resource Owner Grant	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
fab3b0a9-2ac1-4d38-a1d2-d1b53e34d8b9	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
8d24e44f-f501-4e8a-834a-296f4143f3aa	registration	registration flow	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
834e3648-980e-4bcb-9bf4-b4d816146000	registration form	registration form	8741d434-aa5e-4cee-a356-84d10a6eb2ff	form-flow	f	t
5fbdd64a-d2f9-493f-a634-d70352b4db9c	reset credentials	Reset credentials for a user if they forgot their password or something	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
282313a9-b7c2-40fd-8dd2-cedc102ea42b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	clients	Base authentication for clients	8741d434-aa5e-4cee-a356-84d10a6eb2ff	client-flow	t	t
4742251f-e5af-40fd-aac7-70278f6d8f90	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
e7aa5124-92ae-4158-8d00-dfbdd0d4ba2d	User creation or linking	Flow for the existing/non-existing user alternatives	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
7e5934dd-fb28-4cca-b581-14186819e95e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
1dee363c-f4e8-4c1f-84a4-4c08212eba7c	Account verification options	Method with which to verity the existing account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
08f2c7a2-fc0a-4ac3-a1c2-c91ed94c5e18	Verify Existing Account by Re-authentication	Reauthentication of existing account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
7abe519a-27f5-4968-8eb1-f8bcb3dd50ec	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	f	t
afdf35d1-55aa-4818-932e-4881f292c7db	saml ecp	SAML ECP Profile Authentication Flow	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
1fbb82c0-b1e9-4ee5-ab87-519ad0d8e03c	docker auth	Used by Docker clients to authenticate against the IDP	8741d434-aa5e-4cee-a356-84d10a6eb2ff	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
28a231fa-8adb-4af9-b9ab-5e75297b6f1a	review profile config	ca1ec25d-8038-4d0f-af0d-a5cf91b69828
a71c6ba2-3fd2-4b62-9ccc-33ace70b9095	create unique user config	ca1ec25d-8038-4d0f-af0d-a5cf91b69828
e34b542a-ac3e-459c-b699-4431b369d9f2	review profile config	8741d434-aa5e-4cee-a356-84d10a6eb2ff
fc0648fb-96a2-462b-94f2-e4f430d57923	create unique user config	8741d434-aa5e-4cee-a356-84d10a6eb2ff
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
28a231fa-8adb-4af9-b9ab-5e75297b6f1a	missing	update.profile.on.first.login
a71c6ba2-3fd2-4b62-9ccc-33ace70b9095	false	require.password.update.after.registration
e34b542a-ac3e-459c-b699-4431b369d9f2	missing	update.profile.on.first.login
fc0648fb-96a2-462b-94f2-e4f430d57923	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
795f0199-5cb3-4541-8249-5aef9a18a26a	t	f	master-realm	0	f	\N	\N	t	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
10aec783-08cc-4792-a3f5-645814268124	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b039e641-b58c-44e6-9778-5752f91da0ab	t	f	broker	0	f	\N	\N	t	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
fc782392-2fad-485e-8b08-7e84c46643f3	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	t	f	admin-cli	0	t	\N	\N	f	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8736a2c1-4240-492b-954e-6be06c2237d0	t	f	coghealth-realm	0	f	\N	\N	t	\N	f	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	0	f	f	coghealth Realm	f	client-secret	\N	\N	\N	t	f	f	f
23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	f	realm-management	0	f	\N	\N	t	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	f	account	0	t	\N	/realms/coghealth/account/	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	t	f	account-console	0	t	\N	/realms/coghealth/account/	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2c7cff96-dac8-442d-a30d-051c55f585e6	t	f	broker	0	f	\N	\N	t	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
af14a8e6-8c4e-4917-b870-2c059aa51000	t	f	security-admin-console	0	t	\N	/admin/coghealth/console/	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
21d9aa5f-6206-411b-8b49-9b374f4ed545	t	f	admin-cli	0	t	\N	\N	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
96465aa2-3c46-429e-a392-7e57bfc5e79f	t	t	coghealth-api	0	f	coghealth-api-secret-2024	\N	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
96eab09a-8df0-4a33-8a7b-d80320ef6c88	t	t	coghealth-web	0	t	\N	\N	f	\N	f	8741d434-aa5e-4cee-a356-84d10a6eb2ff	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
10aec783-08cc-4792-a3f5-645814268124	post.logout.redirect.uris	+
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	post.logout.redirect.uris	+
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	pkce.code.challenge.method	S256
fc782392-2fad-485e-8b08-7e84c46643f3	post.logout.redirect.uris	+
fc782392-2fad-485e-8b08-7e84c46643f3	pkce.code.challenge.method	S256
e98f490e-fb2d-4cac-a41d-b398c8c9813e	post.logout.redirect.uris	+
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	post.logout.redirect.uris	+
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	pkce.code.challenge.method	S256
af14a8e6-8c4e-4917-b870-2c059aa51000	post.logout.redirect.uris	+
af14a8e6-8c4e-4917-b870-2c059aa51000	pkce.code.challenge.method	S256
96465aa2-3c46-429e-a392-7e57bfc5e79f	post.logout.redirect.uris	+
96eab09a-8df0-4a33-8a7b-d80320ef6c88	post.logout.redirect.uris	+
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2383e822-b426-491c-b95b-12280fb1955b	offline_access	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect built-in scope: offline_access	openid-connect
55ebb439-9a7e-4eff-8285-ed09687b5287	role_list	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	SAML role list	saml
f39aa328-689e-4dd0-8ff4-06b8b11b46bf	profile	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect built-in scope: profile	openid-connect
26326d06-ef09-44a7-8790-82cfa2cf6f3c	email	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect built-in scope: email	openid-connect
263ecf96-09f5-4851-9c57-2c64d3c15d78	address	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect built-in scope: address	openid-connect
a68fceb2-aa9c-4982-8e70-893ce56d0087	phone	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect built-in scope: phone	openid-connect
3d6f9114-61fc-4714-b3d7-6f1275013988	roles	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect scope for add user roles to the access token	openid-connect
21dfe6ef-90e6-474d-a9a0-454919f06e69	web-origins	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect scope for add allowed web origins to the access token	openid-connect
8c345651-3574-441d-a9e8-4d9474d08323	microprofile-jwt	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	Microprofile - JWT built-in scope	openid-connect
143b768e-3fb1-4bc3-a4c4-df0fb992b8de	acr	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	offline_access	8741d434-aa5e-4cee-a356-84d10a6eb2ff	OpenID Connect built-in scope: offline_access	openid-connect
9565c2b6-8f08-42b2-a5f2-262af88b7750	coghealth-scope	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2383e822-b426-491c-b95b-12280fb1955b	true	display.on.consent.screen
2383e822-b426-491c-b95b-12280fb1955b	${offlineAccessScopeConsentText}	consent.screen.text
55ebb439-9a7e-4eff-8285-ed09687b5287	true	display.on.consent.screen
55ebb439-9a7e-4eff-8285-ed09687b5287	${samlRoleListScopeConsentText}	consent.screen.text
f39aa328-689e-4dd0-8ff4-06b8b11b46bf	true	display.on.consent.screen
f39aa328-689e-4dd0-8ff4-06b8b11b46bf	${profileScopeConsentText}	consent.screen.text
f39aa328-689e-4dd0-8ff4-06b8b11b46bf	true	include.in.token.scope
26326d06-ef09-44a7-8790-82cfa2cf6f3c	true	display.on.consent.screen
26326d06-ef09-44a7-8790-82cfa2cf6f3c	${emailScopeConsentText}	consent.screen.text
26326d06-ef09-44a7-8790-82cfa2cf6f3c	true	include.in.token.scope
263ecf96-09f5-4851-9c57-2c64d3c15d78	true	display.on.consent.screen
263ecf96-09f5-4851-9c57-2c64d3c15d78	${addressScopeConsentText}	consent.screen.text
263ecf96-09f5-4851-9c57-2c64d3c15d78	true	include.in.token.scope
a68fceb2-aa9c-4982-8e70-893ce56d0087	true	display.on.consent.screen
a68fceb2-aa9c-4982-8e70-893ce56d0087	${phoneScopeConsentText}	consent.screen.text
a68fceb2-aa9c-4982-8e70-893ce56d0087	true	include.in.token.scope
3d6f9114-61fc-4714-b3d7-6f1275013988	true	display.on.consent.screen
3d6f9114-61fc-4714-b3d7-6f1275013988	${rolesScopeConsentText}	consent.screen.text
3d6f9114-61fc-4714-b3d7-6f1275013988	false	include.in.token.scope
21dfe6ef-90e6-474d-a9a0-454919f06e69	false	display.on.consent.screen
21dfe6ef-90e6-474d-a9a0-454919f06e69		consent.screen.text
21dfe6ef-90e6-474d-a9a0-454919f06e69	false	include.in.token.scope
8c345651-3574-441d-a9e8-4d9474d08323	false	display.on.consent.screen
8c345651-3574-441d-a9e8-4d9474d08323	true	include.in.token.scope
143b768e-3fb1-4bc3-a4c4-df0fb992b8de	false	display.on.consent.screen
143b768e-3fb1-4bc3-a4c4-df0fb992b8de	false	include.in.token.scope
cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	true	display.on.consent.screen
cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	${offlineAccessScopeConsentText}	consent.screen.text
9565c2b6-8f08-42b2-a5f2-262af88b7750	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
10aec783-08cc-4792-a3f5-645814268124	3d6f9114-61fc-4714-b3d7-6f1275013988	t
10aec783-08cc-4792-a3f5-645814268124	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
10aec783-08cc-4792-a3f5-645814268124	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
10aec783-08cc-4792-a3f5-645814268124	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
10aec783-08cc-4792-a3f5-645814268124	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
10aec783-08cc-4792-a3f5-645814268124	2383e822-b426-491c-b95b-12280fb1955b	f
10aec783-08cc-4792-a3f5-645814268124	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
10aec783-08cc-4792-a3f5-645814268124	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
10aec783-08cc-4792-a3f5-645814268124	8c345651-3574-441d-a9e8-4d9474d08323	f
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	3d6f9114-61fc-4714-b3d7-6f1275013988	t
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	2383e822-b426-491c-b95b-12280fb1955b	f
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	8c345651-3574-441d-a9e8-4d9474d08323	f
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	3d6f9114-61fc-4714-b3d7-6f1275013988	t
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	2383e822-b426-491c-b95b-12280fb1955b	f
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
d9b27b2d-f9b4-4fc5-80b3-a23c846611df	8c345651-3574-441d-a9e8-4d9474d08323	f
b039e641-b58c-44e6-9778-5752f91da0ab	3d6f9114-61fc-4714-b3d7-6f1275013988	t
b039e641-b58c-44e6-9778-5752f91da0ab	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
b039e641-b58c-44e6-9778-5752f91da0ab	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
b039e641-b58c-44e6-9778-5752f91da0ab	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
b039e641-b58c-44e6-9778-5752f91da0ab	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
b039e641-b58c-44e6-9778-5752f91da0ab	2383e822-b426-491c-b95b-12280fb1955b	f
b039e641-b58c-44e6-9778-5752f91da0ab	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
b039e641-b58c-44e6-9778-5752f91da0ab	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
b039e641-b58c-44e6-9778-5752f91da0ab	8c345651-3574-441d-a9e8-4d9474d08323	f
795f0199-5cb3-4541-8249-5aef9a18a26a	3d6f9114-61fc-4714-b3d7-6f1275013988	t
795f0199-5cb3-4541-8249-5aef9a18a26a	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
795f0199-5cb3-4541-8249-5aef9a18a26a	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
795f0199-5cb3-4541-8249-5aef9a18a26a	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
795f0199-5cb3-4541-8249-5aef9a18a26a	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
795f0199-5cb3-4541-8249-5aef9a18a26a	2383e822-b426-491c-b95b-12280fb1955b	f
795f0199-5cb3-4541-8249-5aef9a18a26a	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
795f0199-5cb3-4541-8249-5aef9a18a26a	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
795f0199-5cb3-4541-8249-5aef9a18a26a	8c345651-3574-441d-a9e8-4d9474d08323	f
fc782392-2fad-485e-8b08-7e84c46643f3	3d6f9114-61fc-4714-b3d7-6f1275013988	t
fc782392-2fad-485e-8b08-7e84c46643f3	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
fc782392-2fad-485e-8b08-7e84c46643f3	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
fc782392-2fad-485e-8b08-7e84c46643f3	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
fc782392-2fad-485e-8b08-7e84c46643f3	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
fc782392-2fad-485e-8b08-7e84c46643f3	2383e822-b426-491c-b95b-12280fb1955b	f
fc782392-2fad-485e-8b08-7e84c46643f3	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
fc782392-2fad-485e-8b08-7e84c46643f3	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
fc782392-2fad-485e-8b08-7e84c46643f3	8c345651-3574-441d-a9e8-4d9474d08323	f
96465aa2-3c46-429e-a392-7e57bfc5e79f	cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2383e822-b426-491c-b95b-12280fb1955b	9a07e760-f0e4-4b74-a9a7-77ce8836fc0a
cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	1f054e28-15d8-4090-bbf8-4e70cf0aa7b4
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e95f569c-9977-4e19-8911-559a8f5f5e94	Trusted Hosts	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
452cacc8-3561-4f8c-ac22-45018051d0e3	Consent Required	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
512a2839-b19b-4d19-a9e3-f2d977ccb0eb	Full Scope Disabled	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
bfe6ebc3-d4f6-4ba6-b668-df1dd65c9711	Max Clients Limit	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
6399c4b5-8387-4e57-9dcf-1454d2ba2621	Allowed Protocol Mapper Types	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
535726e9-d11b-4932-9b59-b131b1dd0095	Allowed Client Scopes	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	anonymous
3f64d763-2145-4f48-8319-0dd486313f95	Allowed Protocol Mapper Types	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	authenticated
073000a8-95d6-48c4-8eee-68a3af1f0076	Allowed Client Scopes	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	authenticated
113a02b3-f146-4500-8664-359f6fc0d760	rsa-generated	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	rsa-generated	org.keycloak.keys.KeyProvider	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N
5bccad54-818a-4dbb-9562-0f34c9f89c79	rsa-enc-generated	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	rsa-enc-generated	org.keycloak.keys.KeyProvider	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N
1f01af69-7991-4f03-890b-d9837c6af788	hmac-generated	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	hmac-generated	org.keycloak.keys.KeyProvider	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N
ebccbd08-1a0b-4ae6-8932-4d350d2096d9	aes-generated	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	aes-generated	org.keycloak.keys.KeyProvider	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N
dab8edd9-0282-48ad-9381-cd319836d858	rsa-generated	8741d434-aa5e-4cee-a356-84d10a6eb2ff	rsa-generated	org.keycloak.keys.KeyProvider	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N
1f36980b-9c81-4c7c-9a7f-070d3c12b881	rsa-enc-generated	8741d434-aa5e-4cee-a356-84d10a6eb2ff	rsa-enc-generated	org.keycloak.keys.KeyProvider	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N
08594908-8adf-42be-85d4-602a06181983	hmac-generated	8741d434-aa5e-4cee-a356-84d10a6eb2ff	hmac-generated	org.keycloak.keys.KeyProvider	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N
14f9a2cc-df62-4bb1-9a42-eac58b9c85ab	aes-generated	8741d434-aa5e-4cee-a356-84d10a6eb2ff	aes-generated	org.keycloak.keys.KeyProvider	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N
05cc2c7f-470f-437b-9a99-22522363d9c3	Trusted Hosts	8741d434-aa5e-4cee-a356-84d10a6eb2ff	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
c297d4c5-ea83-49d5-bf6f-2140a3b2aac9	Consent Required	8741d434-aa5e-4cee-a356-84d10a6eb2ff	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
4d013c26-e07e-40b0-94e5-b5b97d131e8a	Full Scope Disabled	8741d434-aa5e-4cee-a356-84d10a6eb2ff	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
bc31ee41-c76f-4ac1-b2a3-9fdc7bdfa4db	Max Clients Limit	8741d434-aa5e-4cee-a356-84d10a6eb2ff	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
c006fb7e-d646-41ec-9790-466bdf676201	Allowed Protocol Mapper Types	8741d434-aa5e-4cee-a356-84d10a6eb2ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
8d0dfc33-4996-4aba-bd98-b0382000b940	Allowed Client Scopes	8741d434-aa5e-4cee-a356-84d10a6eb2ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	anonymous
77915b66-d849-4d19-b23d-9b9135769f0e	Allowed Protocol Mapper Types	8741d434-aa5e-4cee-a356-84d10a6eb2ff	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	authenticated
5cc483ef-cb30-4330-88fd-a68310f19cca	Allowed Client Scopes	8741d434-aa5e-4cee-a356-84d10a6eb2ff	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
4a1ce4e8-155d-438b-bacd-0e12459d921e	535726e9-d11b-4932-9b59-b131b1dd0095	allow-default-scopes	true
96adc3c5-1f48-4937-a2c3-a0cc600d317b	bfe6ebc3-d4f6-4ba6-b668-df1dd65c9711	max-clients	200
c9182d05-a8f3-410a-8244-6bf10dc2b93e	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	oidc-full-name-mapper
abb8796c-6e12-45f8-b0d2-480fcbc86466	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	saml-user-property-mapper
411fe5c5-2798-49ca-8804-ea273f8540ab	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ff497852-0310-4154-94f0-c383c42e3d94	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
08b5eabd-f51d-44e8-9a53-caf865b9435d	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	oidc-address-mapper
86ae6238-efdc-4c75-806f-37fc0eeb5248	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	saml-role-list-mapper
aacfea7e-2db5-4ee9-a7cf-388706092053	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
afc90c11-26f2-4d0a-955b-ff4e004b90c4	3f64d763-2145-4f48-8319-0dd486313f95	allowed-protocol-mapper-types	saml-user-attribute-mapper
b2b3faef-f890-4a01-a422-88f2e2afaaaa	073000a8-95d6-48c4-8eee-68a3af1f0076	allow-default-scopes	true
32cf2169-2059-4822-ae5d-8c7ff3d2effe	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	saml-user-attribute-mapper
0d7fe929-c8a4-49be-95c5-404c9cbb240d	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	oidc-address-mapper
dfdc0376-306d-4978-9f95-e3334e3c27ab	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	oidc-full-name-mapper
00ad8d30-d8bd-42bd-bfa7-398174854151	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	saml-user-property-mapper
da48aa89-26ed-4a29-9524-66f61362bdd3	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e06f723e-066f-4596-8c52-4b4a9bbd0964	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	saml-role-list-mapper
1c7cea2c-f8d6-4e9b-918a-a31126c21c4b	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
e568ee47-aae9-4a6c-864b-bbc14dbcad1a	6399c4b5-8387-4e57-9dcf-1454d2ba2621	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a03094b5-21cb-4c60-aac8-3d86079a9733	e95f569c-9977-4e19-8911-559a8f5f5e94	host-sending-registration-request-must-match	true
1b5f1351-e53a-44fe-b04a-9562a7d502a5	e95f569c-9977-4e19-8911-559a8f5f5e94	client-uris-must-match	true
befdedd0-bc02-4bac-8c71-503142b6193c	1f01af69-7991-4f03-890b-d9837c6af788	priority	100
a0d24baf-2a0d-435b-8eb2-b4ec288b6e26	1f01af69-7991-4f03-890b-d9837c6af788	secret	AK5_wY_hwgCGZuC-0M45yqAGYZ9rzgXDhqd3b1pBndpctiH_U87a-HDFjEgmVF1NSNOOaQOZqQs3aAM0Pvs56Q
9c570f7a-a3cc-41b8-80f3-ec7ae50e7381	1f01af69-7991-4f03-890b-d9837c6af788	algorithm	HS256
f04e92be-4022-4010-b6ae-ffd35a5bef7a	1f01af69-7991-4f03-890b-d9837c6af788	kid	723abdfe-b3a3-4a77-9dfe-8cf2fef8551e
3c0f839c-3e9d-4feb-855a-234ab085e9a1	ebccbd08-1a0b-4ae6-8932-4d350d2096d9	kid	0be57403-581e-4a65-9da1-8807375214ce
5ddc2cc4-a32c-438a-9feb-359fcb01dded	ebccbd08-1a0b-4ae6-8932-4d350d2096d9	priority	100
e3517188-cdf7-4de2-8ead-1a1c8aff15b0	ebccbd08-1a0b-4ae6-8932-4d350d2096d9	secret	eoiLP34g8AheyvZI5TL-Zw
04dd1903-fb5e-4ef9-b100-cc793d39f86c	113a02b3-f146-4500-8664-359f6fc0d760	privateKey	MIIEpAIBAAKCAQEA52MPHaU42BYobMSKgP332QrYdFefPMxQU34OP6RihGrV/EAHFr5ZdiBIytZWo/kLTrCWRWwSMS+N4LEIS4vqk3xCTr9zB8ep5PAMiDeRhuKBqEcYb8QTGhMNu5BLwxZs/iYsAU2DeyOcJLHgyw6/5GG5BnB0WyxrUCTgb2jQSnffnKp3wblY3ZLjMWzMC9Z/7QuONBo49CloNb/m1YoJaOiqwqaa3lKQK+mdi/NOGpq7HZ4WWiZDhtarovhC7MUR3wqI08tjc246zlKeCxyQ3FldyH8a4g6YNfshxKD1BzqNiDjxkQ6JE3IAS5xvcguP6SSdrTxP0Hj7b9Zj8dt9XwIDAQABAoIBAG+3zdQP8naumB0P9hmaxcCW8nSV2830jfIKAmIrAeASXzf4SBPsmvAkXVEGFPX9qD55l0x0hgIWhkeO4kTrjLph+/feivEeL4LYfgyE2/BGy7hOf1dzUY+81FwTqujKGpzJHGUSomFhi6HR+onAGNlxb27S+/MLatLawzw3XJ4fAIOe4x2urfbDoq+6wvsCIGwuoFzdDUMT2DLUqVognJZbaVN9RNnpqzpjMJWYE7xz6FN3vV3tDPX71Fnp5pqhQr6Q+2mdT/akJybuiIQFoYmmsxiij3ES2nLP0WkGGTxI6LuZsu8c064mVPT9QYFVOMxnuPVi5utz2WLcJNpzpTkCgYEA+3ryN3Nhzrx8mUPnbJnWzXGogAHUOgqsUAIIZKuhRsSqo4RimidSbm7ndv3eRdtMt58MkZeXdtvyhLSztGXmi5prnpoBZBgrx0pz/K3ceBVL5GW3UNn3F9sIdmSF47uWbwWvSd6uDAzgwmrakXySrp1G9ACGhkC1YAL3BD2RV0kCgYEA64uqA6XWSlprNLMiEuRTxNxfwyZp4jj2s/LXVq36Ga6mjPAI7qCYEnaVD2HA7hQlOk7KRiOaRs/VZ5ZNlNhdYfrjIAnESgHAK11H843U+se44x7VAhzySRKEQARs6GU97/6B2gMtcZs0LFCvoJaqzw44lGA2bRC9I+JVIsErZ2cCgYEAzTEaJciNi8Qb3mqbj+9OZz9P/3J+mgVPZ9DgzFOGOloJ6XYBhkqDZfwz/NFT5af0RvcNqFYKjj8U+NcAsjdbD5mmKjj63ZMjVW8YiJnMBGdMD0Y3d08B4IMluoR3AsRzEI+Q4TNCzC5NzhSl1oPQo41M8ZbkLPLrizWgG+OojZECgYEAiJYFcXYR7C3Aat/RS2kxlj9AHJbC4ZasoC6aZj4egBQBqkpqs41WgaZXy4Kg8K2n5MbZjpCInrVYB2hl9oD8rZthZyuislOPjtXZqka9kOqNsM4pML9+U5c0LzchvCUxJGDOBZDAIlegim4DWbjktYqGjqu4A8ioFQ3i1nNzatMCgYA1YSFUPFUyLag134t0BV6VUlQfgYvZOx7mrhdc7gcmls5z1TQ5tZq/vK0sszy5J04ydbzauG+m4H7dyHwyacBnAktNGItUY8H52JmEfcZLsKXQrPtvsRZN81CcQ2s98+QjvxpM9EebcRVQVW2OJdljNuRLh16pMERAcDmnT4Vd5w==
249cc281-f0f9-4488-a9f8-db036e0a3857	113a02b3-f146-4500-8664-359f6fc0d760	priority	100
00d00275-e9b8-4ed7-87a6-d5aded98d097	113a02b3-f146-4500-8664-359f6fc0d760	certificate	MIICmzCCAYMCBgGb+jgt2jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTI2MTIxMDQ0WhcNMzYwMTI2MTIxMjI0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDnYw8dpTjYFihsxIqA/ffZCth0V588zFBTfg4/pGKEatX8QAcWvll2IEjK1laj+QtOsJZFbBIxL43gsQhLi+qTfEJOv3MHx6nk8AyIN5GG4oGoRxhvxBMaEw27kEvDFmz+JiwBTYN7I5wkseDLDr/kYbkGcHRbLGtQJOBvaNBKd9+cqnfBuVjdkuMxbMwL1n/tC440Gjj0KWg1v+bViglo6KrCppreUpAr6Z2L804amrsdnhZaJkOG1qui+ELsxRHfCojTy2NzbjrOUp4LHJDcWV3IfxriDpg1+yHEoPUHOo2IOPGRDokTcgBLnG9yC4/pJJ2tPE/QePtv1mPx231fAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAOa4oNDwkDO2LA+yjKvPT0dvVt4Hwo++0XqGdymAuDrSGpWXg/m5Sm4O+U4gj/AaqnxTurJS9Kkc56MRnzTw25ljwiT+Tt4kL3oI7qmv7YmwihrxIBmISLEalFaNDYp35tOfnRaxnjLpaHX0FBMSxgBcZ2NT/MKVkP+Ow0zV9ZHYmjiTsMzexWx2o2rQHuijPcZILy/SALa+Ym5+Apnf4obI9vh5Bhi585XfzeseFbBwUpvsvDs+cj26sZWSmTwxd2E48VFbuYOODarvsote8qeFwmLdNyJtSQs+NQ/p/9WD8to2/jW4TE0XxF9EZ2GHClzZfh4iupqh+F83mPVfXGg=
4cf6f7cd-9d2c-45b9-98bf-9995520928e2	113a02b3-f146-4500-8664-359f6fc0d760	keyUse	SIG
1395a576-940a-4d47-a0b2-0be61bae791e	5bccad54-818a-4dbb-9562-0f34c9f89c79	keyUse	ENC
7e28b6a7-5284-4131-8803-9bb9d6ab0a5e	5bccad54-818a-4dbb-9562-0f34c9f89c79	privateKey	MIIEowIBAAKCAQEA1mxE/9BsIliEb1kBS9klXE8U2mt0Of1E1DVUulCet3bkmjDLUoSBtwBkHxSS0K4qQL6iB+v8nRjHP61tOq3bkSKI7K9EjszjmIsfLOh2lcUaydDjvC0/gn2/p8poVX/mRyuzBWUArsbfEThOMn6Q62P18ojktNOLCuB+/u7yY9j/VFLi127X9bGD5+dfqYP+0yogOOq5xSz5rfZvRN6+KU9yf8LGk4qL/S5l2hZaPVE2yNOgf1lAWcluG5aBaJbtPkJAtOoKZapm/HYWwl6tCvU1AmEG2gsMOxUnIOUrHYkze82c9KOocXdnlxvlFv0/8iJENuKXkuV8+Pm1w/aRWwIDAQABAoIBAByXuRxlthhfC7XvZ/aty5zDZ4lNZ+UYYAEY5XtSJyqu04K40VFnyFusqoKMffFkMCU3ESiTmuQgpZKDtVDsVcmaPH5XTCyV/MmJemGaKWoFAR1QBMuXOw9TERILschTnaj4QPnjWJPLLXwV295Bi2CgO+/uD5VfWidb/Vilvgkl7DS3GuAFKjrFVJ2fpg9olu+sFPGONI1/RgYwfzhtZ1KKikpyIVxJ05ynBeXrIfjykV0njAmppca+rpIJFJjk0MJVgdqCQc/B0hJqRHgO659UkqguvDYwzfIT79hSIfl8bpMRD6Vv9lcEvAW0SaL5t1OmBHg3KzAkA3u78YheG2kCgYEA85nN4R8bIt/uPVesIJ3ljgSn5eItAqntq2WdJicAmnXn1CtdN7QZ2ZKbFXMysQI90uFjTdSx8xWQkf/bkEe2a+2sMufeqNfHzeT6+LtLXLUus8hU3dVjhJndk37KwcUEDteYvMEzt6JQd/jgVryIgf9pj+u798u/+JqN6CW242kCgYEA4VZEtb0wQoj2Vl5YxgXafecmGMJ6VlWoly9rYb6wlzTSexrRZI+UthLfNPmofJcTTZIyklgnKNphoIJnc6keSQwrIKGandC0VYZCN96ZnmoH7Vdb1OZB1C/IJFXKI4997ifd33z4Zpk7ArRdT8ZglEq/dTQQSS1yqFp5OLXsaiMCgYB5aINymsU0iXS8f/CaxPc+49UmPqZ+OGDq1pcPB8tGMFNdrEsmUw27IVVHyIVQMTTM4GZUyRfzdiD6kxFEBGnHusnjCSsw7XJ4jJIE25wA1ZA0LDkX4p1Z3jHPrBazolSWbR+Dm6sB79S5JoHw2MAUQk7DWxLwukywQ59MP1e6WQKBgBG6W8WAkN9rLxY0bf+GTl5BZTnlcwJ/0reyP1x9SB9dRIHy5i5nLWf1rCHa0mqa6CXeLqRc0xfftnaOS91JnNxaXLpAfI2V8doYqfUDSkqwRNdjXBIv21X6PGC/bxvFGj82W7pNdq17uKzJy92O2eJQzydFZVKchLzCAW94wJTJAoGBALrCgPu0RQuepK7M1wswSQ4jFIOhy54aC3goFsMQB+TDGJQiCLun8sWe2ei0pJNj2QgGjEevp0M1XE4/9JEb3GbUq6+FSPq4vvVKduVDDe8xFAkaufj8FvUiUoLehnSTUSp/VDczh1OfNDgIFrjXB9C58zVxrQfD3svAFLX8FSRq
2ac836ad-d280-435c-b27e-39247865d12e	5bccad54-818a-4dbb-9562-0f34c9f89c79	certificate	MIICmzCCAYMCBgGb+jgu2TANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTI2MTIxMDQ0WhcNMzYwMTI2MTIxMjI0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDWbET/0GwiWIRvWQFL2SVcTxTaa3Q5/UTUNVS6UJ63duSaMMtShIG3AGQfFJLQripAvqIH6/ydGMc/rW06rduRIojsr0SOzOOYix8s6HaVxRrJ0OO8LT+Cfb+nymhVf+ZHK7MFZQCuxt8ROE4yfpDrY/XyiOS004sK4H7+7vJj2P9UUuLXbtf1sYPn51+pg/7TKiA46rnFLPmt9m9E3r4pT3J/wsaTiov9LmXaFlo9UTbI06B/WUBZyW4bloFolu0+QkC06gplqmb8dhbCXq0K9TUCYQbaCww7FScg5SsdiTN7zZz0o6hxd2eXG+UW/T/yIkQ24peS5Xz4+bXD9pFbAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAFqVYospwt6usBqg+76PH8qAp/zmQ3pnYWbX2bREZgmRjpPufDEg8A00jNmpyHu5agfiZ6RFt8+Fi1fpD9Oyq1+TY8Omln5YUhMXEL4/z3IPTzdpJLPb5ZX5RjHsmlAZ+bL9PO5lcabp22v68WRfm05BmHUGqrkfzuXMp5hRpNsilFAMsRtjBLfowIHq3/iqn+6FfWtZmok5Ea63UajhPV9F97InhhZEe0BFOJdls/MKaZYiBYRXYibfd+gFISFmOYKW1lgPRH/NuuPzSTvHz+3NssuacnzzMKzmMBRraCbEHhFyCwiiPARfyFuqPOtIFAPQQW288+M7WvGTC8HQZc=
8ad29710-4843-4954-82e8-e3d5d1de54b9	5bccad54-818a-4dbb-9562-0f34c9f89c79	priority	100
301efdde-abc3-4081-9ca6-e2eb67902de0	5bccad54-818a-4dbb-9562-0f34c9f89c79	algorithm	RSA-OAEP
754472d0-e6b1-4aa0-8907-5843b7898009	08594908-8adf-42be-85d4-602a06181983	priority	100
0d8ab979-6db0-463c-aba9-5d53b6a7198f	08594908-8adf-42be-85d4-602a06181983	secret	MXxrS_YNB6DH0XozF7ApC562WmJftgxaqb4wc8ZSI2k3qIDdfFO4nnSEph5a1-qYR30zzQeoXV3UnTbzsiitSg
9aab64c3-d2a5-476c-bb27-4120c06fa653	08594908-8adf-42be-85d4-602a06181983	kid	bbc2068a-a905-42a2-add6-289fa950f204
ad64798d-747d-4c56-9367-54e462894f67	08594908-8adf-42be-85d4-602a06181983	algorithm	HS256
530b21a2-2d3f-4c93-a867-77317defc8a5	14f9a2cc-df62-4bb1-9a42-eac58b9c85ab	secret	p_3y0BV1ATDz9ZwAHUqnBQ
103353e3-be62-4cad-a1cb-d61d1ac9b91a	14f9a2cc-df62-4bb1-9a42-eac58b9c85ab	priority	100
7f884890-2afd-4435-83e4-2c8770d9a51b	14f9a2cc-df62-4bb1-9a42-eac58b9c85ab	kid	88461e18-0d4e-43a9-8b5c-df0376d2866d
859a49a7-9965-4789-93b9-bca92de95f55	dab8edd9-0282-48ad-9381-cd319836d858	certificate	MIICoTCCAYkCBgGb+jgxZjANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAljb2doZWFsdGgwHhcNMjYwMTI2MTIxMDQ1WhcNMzYwMTI2MTIxMjI1WjAUMRIwEAYDVQQDDAljb2doZWFsdGgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDZp4QoN6Ly7i4nlfCmCCUxzPItXqpFIXjK91DSpGTBvJKUJJOHZzw0pGIA2nwXUhXRyWqzCumLXn6uMGLvhXRGwcAL4038F3CNi5ZjjiL7nHWxcUpC1sUWjpo1SK6EWnY0Feyv7U6gx78t6T2/zx//1wFmvfAIzSrwzOhP4Bq4tnm7uNVD+93z9GtWCm2z2KFXsMcYySkhYZFMtz2pvbd6/361OCUUt0dhF2+TkuA3dt2dRyO29iaph4IDJmLYtUuJeKl3Q3syqz7bdKnT8gO8uHxq9kfMrV0l7s7UDdmwJPw85gUKMBowq+vC3K2l26milM021xuk62m/cdz7q18TAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJp/TMD06we40bBLh8iyMrGkQVMz+hl6XIh5E9RPFOH64mhTNakyE3KukC2d2hTIt/ZNedvrzbfunhSDbL9JXjY9/2bNDBwQeGIbLz/PuesET6m03uBBIwSy8SmBoDkESwJchMwe45lmLqvXmMdNzSOI0nkN2fIASYlFtfnz8gwKQ1oF1JKG/ofSCqxq6vyYjRdZJZBGENSIp6fltVjrRLx7YdiwAnCW3G0sHrH6fDRskIhCmY2oztm7qUf3xlwcK/Yht3HlshgJ1CqxMonScFY6Xh41icYOaj0lcE38nFoRpKAmbiEEU9dsrwJdsjoIqmAbY1j6HpG9tI/FhZ5cGtM=
9bce7c3b-aeeb-40e8-9bc8-2d2459c4b6d7	dab8edd9-0282-48ad-9381-cd319836d858	keyUse	SIG
977da3b3-eef7-43c3-88ee-72d827e40f48	dab8edd9-0282-48ad-9381-cd319836d858	privateKey	MIIEogIBAAKCAQEA2aeEKDei8u4uJ5XwpgglMczyLV6qRSF4yvdQ0qRkwbySlCSTh2c8NKRiANp8F1IV0clqswrpi15+rjBi74V0RsHAC+NN/BdwjYuWY44i+5x1sXFKQtbFFo6aNUiuhFp2NBXsr+1OoMe/Lek9v88f/9cBZr3wCM0q8MzoT+AauLZ5u7jVQ/vd8/RrVgpts9ihV7DHGMkpIWGRTLc9qb23ev9+tTglFLdHYRdvk5LgN3bdnUcjtvYmqYeCAyZi2LVLiXipd0N7Mqs+23Sp0/IDvLh8avZHzK1dJe7O1A3ZsCT8POYFCjAaMKvrwtytpdupopTNNtcbpOtpv3Hc+6tfEwIDAQABAoIBAA/U5oECYwDmoEbS2jlJeGMh9C+mph33LFEfIirgOE/7RnIuIukDclal6lcDjWko2Ft1GiTB03EGw5IqBNhFTcrjxvNWalK+5bn2AE9nhFXm8Iyin/Myqg1U/BSKH9+SsOxi999oFIMPZHGTeKFeEIbMfdaaVD5fphLz5KYCuA7dXK60tsgZCx/+ttm4UsDREX5OxR0if/s8ibOqz4G6Mp1QYkmCw+gl0HQ/pG+zbls/W6VY+yqNNZpuzHvH5DRMLSTRZ6mxqbOTdMdDpF/LmkS3tC5wVOfYl4Fzm3gqCiMU0vZF4vW9dzVx0CQGsEUm7eVEvOyXzAhB4tqptAY8nMECgYEA8Man29qFGfZkl3/oDALjmW1HJ+UfRj23RkrdMKSR71RWghU+EFXZYDWcTCZ5VptY7EPuqRAdfPiaELSqUPSyn8b29OJegHPRJsxg2oVFxUhCDJ4Gb+htRutZMpy4tVJdgAUYTaS0uSIdGlGPP158HXfEBfdkNWXz42ppVnu3LTMCgYEA52qZkT048Sb5oTmwgb5/8VclZaNHOn4IONhCK7WLyJtbFfpovVKQUwBMip+/lSxS2HJkGt8bPuVfkKNCxSO8IsPR24K5ukol2WcuQDhjNIC1U+vXjSDM0oHy8xC/MDpkL9kG1+gQTIwc/bO93jQVU/vYcoqKOfceBgHfMPR0RqECgYAF+ylYUMlVp8U/7jF5eujkes51sz9fo1DWMi3kc3Icm9+6Q4TTKw7HUQ2c5qfE+v7uf5GCKaBR5msNVy+T60A0r+CanLT0Q+xCJnmRdBYTnIPnhFVsmj18sYP5ueLsvisMbxP3ecvzfWFzser5DAPRR5RbAZY/rVStpYsQVupp+QKBgHfR9RODfJE4WfZFlYOILFy8f4uBoCbEDOPJ7XEOPgMvlVjq4AJu1nVzaS45iovleDvD9tsG++d0Aig0sCS83POvKmCa7ilrrO9FAmiUCaGsprZ+HYxgGE1CpZV+7U8+XJN9rpJqAM5xma0uvLdphkWG18puuyVKM0xu+a4yVGYhAoGAHQ53rgjloioTho1zqj97bok8u7+V7taoNiXx9gKxZJg8ydD5PHszlr4L7igKDV0Tp95LoyN/bC5PkxhC2oS41Wf8Rk7x+hsKm8ZDsGfsMBP6CN9dtNoJ0B1dPmmLiP87/cRSaH5VCm9ie4xb8uoO0k10ggfL5XQduSVtiJ+TzQ4=
a31e7c62-e3eb-4c4b-a759-eacee3227a3c	dab8edd9-0282-48ad-9381-cd319836d858	priority	100
5bbbb801-c1cc-46e9-a191-8a600d888d8e	1f36980b-9c81-4c7c-9a7f-070d3c12b881	keyUse	ENC
fd121739-4163-4983-9083-2dd3053d6f38	1f36980b-9c81-4c7c-9a7f-070d3c12b881	certificate	MIICoTCCAYkCBgGb+jgxwzANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAljb2doZWFsdGgwHhcNMjYwMTI2MTIxMDQ1WhcNMzYwMTI2MTIxMjI1WjAUMRIwEAYDVQQDDAljb2doZWFsdGgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBiLuSV++PQVEWx21tCwVf2rX46OcI7V1pN8+8j5WvKwtAyKnujKYUcPuFLzhiZI45F7jBYElGxjFb6kK1SHRamZP3Q9pR3XmcvsONrSEuHhi6J+tp3kNi6tFGMGiZt05gHKi2e3wcw6wRuDecDrNpXHQZK2c/Bd9vyscNJ7fHl/Tmro/Gs4qPJzlpOl06uUtVE0T33VMr3c4ziuGv8AupraLwr4JEtN6tjgqidd27fwe7MhdNbQRYT1+34MOVwH4xMEpmsqp9HyIYOqVbbso6iVuwTtixrM/JpFHqVpIw5Vx/WzKFgWytWRMRfsOS1LBuov8f4DlFmIA/qVQjre9LAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADS/ko+bkfCqta8jWkb9SGz3/tNtcKkprXRV50b4c/KR0/O+A4CAmwNm6T4T1qaDcG9r5hERZwRBwjkX/QpOph7oauKl3m5+o/9seTePkhodNWS3kp1GGTkVyu0GT5V3f55zXNvbloQuhd5z1XWUGodPSrYEpN2i+9UIX4oVaMh8hsNXn1f+YSzLheQ8wJ2K8nvcR1UOJHfLC5GfqoM7XNomTL2wo5snBUIHGGI7z/l0sKIK/1fxtsujus2shF+auVqkzaPKQyAuF5aJqrYU5vKsNz6/+r+fznCu8YAn5VwiAWRE6CrFq7dVPtaLm4PKkhRehMo0UjySm3lOfCuIQRA=
16d6c78e-4aa9-46ef-b5b3-ef5c463c8915	1f36980b-9c81-4c7c-9a7f-070d3c12b881	privateKey	MIIEowIBAAKCAQEAwYi7klfvj0FRFsdtbQsFX9q1+OjnCO1daTfPvI+VrysLQMip7oymFHD7hS84YmSOORe4wWBJRsYxW+pCtUh0WpmT90PaUd15nL7Dja0hLh4Yuifrad5DYurRRjBombdOYByotnt8HMOsEbg3nA6zaVx0GStnPwXfb8rHDSe3x5f05q6PxrOKjyc5aTpdOrlLVRNE991TK93OM4rhr/ALqa2i8K+CRLTerY4KonXdu38HuzIXTW0EWE9ft+DDlcB+MTBKZrKqfR8iGDqlW27KOolbsE7YsazPyaRR6laSMOVcf1syhYFsrVkTEX7DktSwbqL/H+A5RZiAP6lUI63vSwIDAQABAoIBAB8OpzMr42i0zaN/K2NFUn54ZZ1lGrZHCSd6al7TF+09Vhf2W7bJYVmEbAiKdFzt0Bj/Yom9vuSZp5AdfskCsJFdde5HOEDM7tglkNIqh1mUQNmW0GNz5JJ6Jk1CNXb9gJlR4A0wsdEX4YQScPIdNdNhn8vuOCpX8exJuTm2NvrTcxvfaCRJh5LvTPmw1NPr4ifgKRlQZKAH/HaL7mSttoubxusomw/i1SPT+q7VR1N8/u9x9/exTeEC/6pM01S5ZV4MJCdS2cXy3uCHG6jMrA76ekfk2lRZvGagcWWNJ7LLulO8ws1TbLl5UdBThTUS+mfzoc869fLKd7JtOkumPWECgYEA9GrNA9lTasZhFUmDcDFCSIX2eaU5OcfIwfsNfnhMs8CV8vovHgKIh4VtZiPe3bN09z6rBSgiHcCGgpSsnPX1Lskii5Z8PS0riHHR7DECgWrjh117ea0cGxvIqMM/DpM8TS3mN0ds6cq5a/ZyOHtcSNdj+oFUIMwVecYYln8I4LECgYEAyrSiCgYdT1xV4U56t3eeDYytPNDdQS3VmgWCTld/oQAWYmmNHex+WLLSnY/M3TRPCbusAuRLRrv7xRSvKF0IL6d/7TipfLN37NC9SAEPAtZzSj/PyZrAQDhp9fmJD7PftB+adEp25gfjtGeejiTtO3xS0EOWp82/bdsgzQFyLrsCgYBqRzpoTwqfpi02xWV61mB9Cos3L+nnPwEDoDeo44RusPJC2hi80tstGo6MWFKjUlIs5DoXHvFewIV8qEs6YRTAyELWMZRKQabpSJzAODtfrOvMw5BaQzSycO1avLNhkhIpeSjeppcsPbNMx7e46aMiJU5a8ftz22oHLmUoo4pnsQKBgEbPnyN9S1Pj36RbdAcPZEk7cXEjTYdtaYbqkcCoVE975lXupXtkmCaIIYclKt3DXjD6PHauJZXKKYOJXD7vcOKk0s2d06daUnSJ3vV+WS4WmCPB8uZshuhoTKu+xiCUJ3uW5q/lK2/kJalp4TuqrqzvG0bhtYldGJhZyjWTYb3tAoGBAKpBCXE571LPaeRUpnMsLYjJhC0fdqCZmcSWmg2S4v/UWkdGfCsDG5LCooP1GqTqNMTQb6rtZbCftaVdNxBQQnae1LSUJTcjuXLzqBlizeOmZDNFXNfIL/Gj8HRSZp+1oIVHGYS9OAYYwsr+ns6znVbPxePwhq8KhZEwgf0aTyMh
0a4154d8-1262-471f-902f-315f03f0cf54	1f36980b-9c81-4c7c-9a7f-070d3c12b881	algorithm	RSA-OAEP
cd2592e6-f711-4c11-b7d8-3f8d7806a79f	1f36980b-9c81-4c7c-9a7f-070d3c12b881	priority	100
2d0548bf-8d5d-48a5-a38d-4d1a27849190	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	oidc-full-name-mapper
0b613feb-c4ff-4292-badc-991477b6aa84	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	saml-user-property-mapper
44c78328-cc8e-47e5-b0fe-7e8abf4a90ef	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
50050bed-2a6b-4120-9521-287701c97802	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	saml-user-attribute-mapper
3e9d5d19-cecc-4276-8a48-fd71e4a4a7e1	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	saml-role-list-mapper
d660c9bd-917a-43b2-b58a-87dad4564d71	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	oidc-address-mapper
737e9e22-2576-4443-9625-1ba8e6e62ea1	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
88755b19-c5b7-45df-94a4-ac6d52328f06	c006fb7e-d646-41ec-9790-466bdf676201	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a2524d80-e955-4dff-a529-8d4d975232b8	8d0dfc33-4996-4aba-bd98-b0382000b940	allow-default-scopes	true
86e7a554-7002-4e52-bbb7-9c3292092df6	bc31ee41-c76f-4ac1-b2a3-9fdc7bdfa4db	max-clients	200
9a73a063-0748-4315-bb6b-d068e9546373	05cc2c7f-470f-437b-9a99-22522363d9c3	client-uris-must-match	true
c7c3cd12-d3ea-4ae6-948d-00de98d23341	05cc2c7f-470f-437b-9a99-22522363d9c3	host-sending-registration-request-must-match	true
e150c7ca-5a43-4cff-83c5-dc677fdf234b	5cc483ef-cb30-4330-88fd-a68310f19cca	allow-default-scopes	true
239af6e3-2e35-4930-aca7-37df1befa58a	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
dd024857-e4c7-495c-b81d-14a0453a9982	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3fb9c535-1516-48ab-a96b-092ce572634f	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
be73689e-1770-45a0-a596-c94b5c80a7c1	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	saml-user-attribute-mapper
18beed72-1c89-478b-b124-ce41a10b512c	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	saml-role-list-mapper
a26b4c50-bcfb-4c8d-beb9-42c33df32cee	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	saml-user-property-mapper
9301e518-f380-420f-8937-6d8caa0e0ce4	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	oidc-full-name-mapper
727a8239-df40-4a1a-9872-2d56ba624fc5	77915b66-d849-4d19-b23d-9b9135769f0e	allowed-protocol-mapper-types	oidc-address-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.composite_role (composite, child_role) FROM stdin;
c25369e1-c3ca-42bd-bce1-cf16437107ab	83d339a4-903e-478f-8cd4-ba42f300d364
c25369e1-c3ca-42bd-bce1-cf16437107ab	86d90d81-becd-4212-a584-701884939cc1
c25369e1-c3ca-42bd-bce1-cf16437107ab	d3960f33-634b-479c-8050-1a3d5596d233
c25369e1-c3ca-42bd-bce1-cf16437107ab	48a37f7f-074d-4ebe-94c2-f5b295b69d6d
c25369e1-c3ca-42bd-bce1-cf16437107ab	49b253be-5339-473c-a0e7-9db18deb6249
c25369e1-c3ca-42bd-bce1-cf16437107ab	44cf7bce-2b1f-4eb0-9bef-c86461d700b4
c25369e1-c3ca-42bd-bce1-cf16437107ab	356f6cd8-2f6a-432d-ab78-e69c38d1c836
c25369e1-c3ca-42bd-bce1-cf16437107ab	6ec99e0f-bd27-4147-a643-b379d0779310
c25369e1-c3ca-42bd-bce1-cf16437107ab	a2af23c2-d476-4757-9c10-82a85887fdc4
c25369e1-c3ca-42bd-bce1-cf16437107ab	884d2d3d-f42a-4d07-a0a4-fd0bfa65dfc6
c25369e1-c3ca-42bd-bce1-cf16437107ab	a52befe7-de99-4dba-8c6f-e984a0ba68ed
c25369e1-c3ca-42bd-bce1-cf16437107ab	fa339236-25ea-4946-a82c-2750d1621162
c25369e1-c3ca-42bd-bce1-cf16437107ab	edb8baaf-173c-422d-976b-fd680633ed88
c25369e1-c3ca-42bd-bce1-cf16437107ab	1cce54af-4865-4fe8-ba27-5ef0bf8d3f41
c25369e1-c3ca-42bd-bce1-cf16437107ab	c9a491b8-9675-4b9a-9e23-954154a36f89
c25369e1-c3ca-42bd-bce1-cf16437107ab	b8b18624-8c93-492e-b1d1-2969de208abf
c25369e1-c3ca-42bd-bce1-cf16437107ab	64029d32-a021-41ea-8a20-34a0374205c2
c25369e1-c3ca-42bd-bce1-cf16437107ab	12a10e5c-c2fa-426f-ba67-ec2754703e93
48a37f7f-074d-4ebe-94c2-f5b295b69d6d	c9a491b8-9675-4b9a-9e23-954154a36f89
48a37f7f-074d-4ebe-94c2-f5b295b69d6d	12a10e5c-c2fa-426f-ba67-ec2754703e93
49b253be-5339-473c-a0e7-9db18deb6249	b8b18624-8c93-492e-b1d1-2969de208abf
acd283c0-ab3d-4ffb-9c02-88ca1165081e	77cba1c4-d03e-4b2f-9705-21a1f4aee4db
acd283c0-ab3d-4ffb-9c02-88ca1165081e	70d486a3-c5a2-4b29-b5b4-5d16abf2cdbb
70d486a3-c5a2-4b29-b5b4-5d16abf2cdbb	e37d31c5-ab65-49e6-a1dc-c79cb8cde943
75d208cd-a4b3-4d64-a565-8f090bf26360	45503d46-1833-49cd-b677-8d809b942295
c25369e1-c3ca-42bd-bce1-cf16437107ab	9039ac64-2ceb-4bc0-9a94-c37e0460531a
acd283c0-ab3d-4ffb-9c02-88ca1165081e	9a07e760-f0e4-4b74-a9a7-77ce8836fc0a
acd283c0-ab3d-4ffb-9c02-88ca1165081e	21d2138a-0700-4a25-87a7-c2af2c2bf9d7
c25369e1-c3ca-42bd-bce1-cf16437107ab	bba5d100-34f9-478f-9cf6-b1ac279c726c
c25369e1-c3ca-42bd-bce1-cf16437107ab	ddc604b6-dd2b-4ea1-a4d7-4822112c100f
c25369e1-c3ca-42bd-bce1-cf16437107ab	188053be-bfdf-4a37-b49f-0a4cb0644535
c25369e1-c3ca-42bd-bce1-cf16437107ab	7b484401-6fca-402d-95d4-55905f4e0990
c25369e1-c3ca-42bd-bce1-cf16437107ab	3994a8de-360b-4645-b346-42bfba429fed
c25369e1-c3ca-42bd-bce1-cf16437107ab	696f0c04-58e7-41ab-b119-85b72b00a3c3
c25369e1-c3ca-42bd-bce1-cf16437107ab	d387aa24-199a-409a-90d9-242a16c0369b
c25369e1-c3ca-42bd-bce1-cf16437107ab	611ec675-194e-4f35-9cde-91969386fa87
c25369e1-c3ca-42bd-bce1-cf16437107ab	81115095-34fb-40d8-bee7-3c7803fd379e
c25369e1-c3ca-42bd-bce1-cf16437107ab	4ce9c86a-dd95-4181-9345-e78de243ed6f
c25369e1-c3ca-42bd-bce1-cf16437107ab	f3814869-56c6-4821-8230-41efe3d0a9b9
c25369e1-c3ca-42bd-bce1-cf16437107ab	3cd658d3-64e8-42a0-ad44-58ea4defe4d1
c25369e1-c3ca-42bd-bce1-cf16437107ab	21d4a47e-8245-4cfe-81c9-60c2332bc476
c25369e1-c3ca-42bd-bce1-cf16437107ab	85e62a22-722b-4f16-a253-6c847837b087
c25369e1-c3ca-42bd-bce1-cf16437107ab	add8aee9-93cb-4b26-aba9-686d893c498d
c25369e1-c3ca-42bd-bce1-cf16437107ab	2edf15d4-c48e-40cd-a9cc-e67c5049a132
c25369e1-c3ca-42bd-bce1-cf16437107ab	6cfe9942-8c4b-4b4c-b589-edebb235f5b5
188053be-bfdf-4a37-b49f-0a4cb0644535	6cfe9942-8c4b-4b4c-b589-edebb235f5b5
188053be-bfdf-4a37-b49f-0a4cb0644535	85e62a22-722b-4f16-a253-6c847837b087
7b484401-6fca-402d-95d4-55905f4e0990	add8aee9-93cb-4b26-aba9-686d893c498d
cc3029d7-22a1-4a31-994d-abda88040049	4df7c160-eb84-49dc-8a3c-f9d21dd9292e
cc3029d7-22a1-4a31-994d-abda88040049	43f664af-8c39-46a0-bd86-46ca9beffa75
cc3029d7-22a1-4a31-994d-abda88040049	58187b38-d443-48fd-8ea7-8750dad16125
cc3029d7-22a1-4a31-994d-abda88040049	95043922-1942-4b89-8a5f-ddb90122cef4
cc3029d7-22a1-4a31-994d-abda88040049	b6c1c681-660d-4961-b86d-74cbe8f498cb
cc3029d7-22a1-4a31-994d-abda88040049	5bd13ab0-975e-45e9-a21b-447891834330
cc3029d7-22a1-4a31-994d-abda88040049	c2403f3c-daab-4042-9911-58a31f874a70
cc3029d7-22a1-4a31-994d-abda88040049	96392e95-a529-4e99-9ef0-aad80a7aeffb
cc3029d7-22a1-4a31-994d-abda88040049	aedf38fe-5105-4bc9-9257-6a6655eeea88
cc3029d7-22a1-4a31-994d-abda88040049	51930965-afc1-4f09-b558-92d9ef340963
cc3029d7-22a1-4a31-994d-abda88040049	e2347c6e-38a1-4c88-bec8-5590e8268cc7
cc3029d7-22a1-4a31-994d-abda88040049	94150bd6-a3da-4708-be80-36351de73cf9
cc3029d7-22a1-4a31-994d-abda88040049	4ae9b8f9-ccb9-4320-9047-4bd5ee29bffe
cc3029d7-22a1-4a31-994d-abda88040049	7152b4b0-cf57-4346-9d9f-afa406b16ee8
cc3029d7-22a1-4a31-994d-abda88040049	fa213ae9-90af-4ee9-84cc-a2d42eb9c8a0
cc3029d7-22a1-4a31-994d-abda88040049	087b4fc2-570e-43ed-9177-527f06496a7f
cc3029d7-22a1-4a31-994d-abda88040049	3d5e9bc8-6e25-47dd-a3c5-56698edd853e
58187b38-d443-48fd-8ea7-8750dad16125	7152b4b0-cf57-4346-9d9f-afa406b16ee8
58187b38-d443-48fd-8ea7-8750dad16125	3d5e9bc8-6e25-47dd-a3c5-56698edd853e
63fdf290-8a2d-49d9-98c3-eb950b9f6701	2dfc6e45-4c08-4735-b958-77e65712b3a4
95043922-1942-4b89-8a5f-ddb90122cef4	fa213ae9-90af-4ee9-84cc-a2d42eb9c8a0
63fdf290-8a2d-49d9-98c3-eb950b9f6701	87931b8e-7ccc-4dbf-bbb6-368daed1a2e5
87931b8e-7ccc-4dbf-bbb6-368daed1a2e5	63072893-da7c-4e7e-a972-b9e4f3288926
4c7cb7d3-ced4-454f-962a-f1d61ca5be46	be66d381-e9ed-4886-b265-08d5f5f5ac0b
c25369e1-c3ca-42bd-bce1-cf16437107ab	39c1d294-4b4c-403c-b76a-e6fa15b255ec
cc3029d7-22a1-4a31-994d-abda88040049	33c7aced-0424-4c14-b767-1b7a0bec6004
63fdf290-8a2d-49d9-98c3-eb950b9f6701	1f054e28-15d8-4090-bbf8-4e70cf0aa7b4
63fdf290-8a2d-49d9-98c3-eb950b9f6701	194f3317-fc84-4be8-91b5-ff7027c42496
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
1dc566b0-e70f-4e88-8b0f-516da04218e9	\N	password	4932442e-78cb-4065-a7d6-ddbe500f24c8	1769429545090	\N	{"value":"6icx/ttL418iGP/q5o3wDCInMys+5pYy013rcUaQZi8=","salt":"cY6g12AXhLP53RCOrItDOA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
69bf100d-9998-4a83-a938-4df22d61d573	\N	password	377e3ee7-930e-4e0f-a1b0-d84abcda8b10	1769429545111	\N	{"value":"jnZ5krOvb65BInYb4pCYHmE+8STloxFmAI7wWcHJVko=","salt":"CZLAVRV1nQ0quFU6PjnN8w==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
382cf1b0-eade-4f0f-9683-af60b29af0e8	\N	password	c3183c42-e7fc-4e31-9b5a-e94281ec8f5a	1769429545128	\N	{"value":"Ypj+/UhuwJ4Sot/1Pbl43VD07PW4xBmCryDBmGKWGL0=","salt":"VcdM0cbpGbYCDkevrSJFHw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6415b9b0-8dbb-4851-b709-c30665922866	\N	password	9d058a4d-4478-485c-a7ad-1e425699efdf	1769429545144	\N	{"value":"g7pXGJN2aoTVAbuRXE28PoiNBqVRN3JH+AO46hRuOMU=","salt":"aCK534f0/YXMs58pFgQzYg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
896be936-c42b-4f11-a117-7040f901e767	\N	password	7feaffc1-ee64-46fd-bb09-3b67ac017adc	1769429545160	\N	{"value":"iA+j4Jt8di3QRITyjmak2SyDDzKtxnl4nhCd+HC2ob4=","salt":"xuL8+2ZrrMz7O/R78NehMA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f0a056d6-7436-4306-be84-873457972b19	\N	password	90829df7-9329-445f-b1c9-9b1369682dff	1769429545177	\N	{"value":"kW6iTLpzyQgGvuByMP7d0iyr8HM45q6Ze0mBYgGPyrk=","salt":"ZxNsQNt8SDoPS6YWde/muw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
8060a3e7-c1fa-4bac-bb8a-5930db502079	\N	password	c108dff6-5292-4b6c-80ef-bf03d18b33bd	1769429545193	\N	{"value":"Mv2k1SMBuq9fHBegGrvR4PsvQ1RP1Qp62NgDiUnQhpo=","salt":"gE00qMFKuv++LUw2td7tTw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
e086bebb-08aa-4f57-ad87-f7d03f26fb82	\N	password	ecef6554-bc2a-4b8c-813b-34839618bebc	1769429545587	\N	{"value":"eEtMF0xaCXNcihusshCnfSzS2zbtV+3xcZY4M+b18SY=","salt":"T/PUDrGyuUxx3DlTvya4bQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-01-26 12:12:23.212206	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9429542905
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-01-26 12:12:23.234359	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9429542905
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-01-26 12:12:23.267532	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	9429542905
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-01-26 12:12:23.269707	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9429542905
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-01-26 12:12:23.326141	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9429542905
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-01-26 12:12:23.333938	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9429542905
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-01-26 12:12:23.374878	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9429542905
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-01-26 12:12:23.384494	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9429542905
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-01-26 12:12:23.387696	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	9429542905
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-01-26 12:12:23.430167	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	9429542905
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-01-26 12:12:23.451706	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9429542905
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-01-26 12:12:23.456332	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9429542905
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-01-26 12:12:23.46503	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9429542905
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-26 12:12:23.473262	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	9429542905
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-26 12:12:23.473828	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9429542905
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-26 12:12:23.475031	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	9429542905
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-26 12:12:23.475958	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	9429542905
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-01-26 12:12:23.495005	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	9429542905
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-01-26 12:12:23.514318	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9429542905
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-01-26 12:12:23.5159	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9429542905
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-26 12:12:23.520142	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9429542905
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-26 12:12:23.521898	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9429542905
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-01-26 12:12:23.530373	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	9429542905
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-01-26 12:12:23.531954	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9429542905
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-01-26 12:12:23.532424	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9429542905
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-01-26 12:12:23.543593	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	9429542905
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-01-26 12:12:23.574845	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	9429542905
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-01-26 12:12:23.576866	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9429542905
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-01-26 12:12:23.599474	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	9429542905
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-01-26 12:12:23.604983	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	9429542905
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-01-26 12:12:23.610895	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	9429542905
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-01-26 12:12:23.612229	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	9429542905
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-26 12:12:23.613587	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9429542905
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-26 12:12:23.615194	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9429542905
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-26 12:12:23.626831	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9429542905
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-01-26 12:12:23.628538	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	9429542905
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-26 12:12:23.630367	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9429542905
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-01-26 12:12:23.631412	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	9429542905
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-01-26 12:12:23.63246	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	9429542905
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-26 12:12:23.632873	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9429542905
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-26 12:12:23.634097	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9429542905
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-01-26 12:12:23.635742	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	9429542905
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-26 12:12:23.68648	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	9429542905
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-01-26 12:12:23.688071	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	9429542905
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-26 12:12:23.68927	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9429542905
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-26 12:12:23.69073	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	9429542905
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-26 12:12:23.691259	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9429542905
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-26 12:12:23.706681	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	9429542905
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-26 12:12:23.707988	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	9429542905
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-01-26 12:12:23.723396	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	9429542905
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-01-26 12:12:23.733689	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	9429542905
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-01-26 12:12:23.734622	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-01-26 12:12:23.735384	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	9429542905
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-01-26 12:12:23.736	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	9429542905
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-26 12:12:23.738289	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	9429542905
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-26 12:12:23.740049	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	9429542905
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-26 12:12:23.748011	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	9429542905
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-26 12:12:23.785759	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	9429542905
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-01-26 12:12:23.797594	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	9429542905
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-01-26 12:12:23.801351	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9429542905
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-26 12:12:23.804626	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	9429542905
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-26 12:12:23.806178	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	9429542905
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-01-26 12:12:23.806964	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9429542905
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-01-26 12:12:23.807768	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9429542905
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-26 12:12:23.80857	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	9429542905
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-01-26 12:12:23.813067	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	9429542905
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-26 12:12:23.814406	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	9429542905
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-01-26 12:12:23.815591	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	9429542905
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-01-26 12:12:23.818573	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	9429542905
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-01-26 12:12:23.819823	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	9429542905
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-01-26 12:12:23.820934	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9429542905
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-26 12:12:23.822997	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9429542905
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-26 12:12:23.825625	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9429542905
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-26 12:12:23.826416	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9429542905
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-26 12:12:23.833274	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	9429542905
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-26 12:12:23.835549	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	9429542905
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-26 12:12:23.836561	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	9429542905
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-26 12:12:23.837034	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	9429542905
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-26 12:12:23.844899	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	9429542905
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-26 12:12:23.846326	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	9429542905
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-26 12:12:23.84823	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	9429542905
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-26 12:12:23.848548	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9429542905
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-26 12:12:23.849695	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9429542905
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-26 12:12:23.850181	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9429542905
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-26 12:12:23.851719	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9429542905
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-01-26 12:12:23.853386	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	9429542905
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-26 12:12:23.856488	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	9429542905
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-26 12:12:23.859202	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	9429542905
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.861343	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	9429542905
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.864008	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	9429542905
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.865787	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9429542905
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.869021	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	9429542905
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.869965	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9429542905
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.872947	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9429542905
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.873819	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	9429542905
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-26 12:12:23.875408	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	9429542905
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.878492	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9429542905
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.878931	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.88181	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.88357	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.884072	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.886156	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	9429542905
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-26 12:12:23.887443	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	9429542905
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-01-26 12:12:23.889163	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	9429542905
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-01-26 12:12:23.890811	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	9429542905
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-01-26 12:12:23.892356	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	9429542905
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-01-26 12:12:23.893586	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	9429542905
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-26 12:12:23.895187	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9429542905
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-26 12:12:23.895589	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9429542905
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-26 12:12:23.897688	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9429542905
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-01-26 12:12:23.898928	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	9429542905
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-26 12:12:23.908528	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9429542905
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-26 12:12:23.909574	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	9429542905
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-26 12:12:23.911203	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	9429542905
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-26 12:12:23.911574	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	9429542905
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-26 12:12:23.913231	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	9429542905
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-26 12:12:23.914244	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9429542905
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	2383e822-b426-491c-b95b-12280fb1955b	f
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	55ebb439-9a7e-4eff-8285-ed09687b5287	t
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f39aa328-689e-4dd0-8ff4-06b8b11b46bf	t
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	26326d06-ef09-44a7-8790-82cfa2cf6f3c	t
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	263ecf96-09f5-4851-9c57-2c64d3c15d78	f
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	a68fceb2-aa9c-4982-8e70-893ce56d0087	f
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	3d6f9114-61fc-4714-b3d7-6f1275013988	t
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	21dfe6ef-90e6-474d-a9a0-454919f06e69	t
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8c345651-3574-441d-a9e8-4d9474d08323	f
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	143b768e-3fb1-4bc3-a4c4-df0fb992b8de	t
8741d434-aa5e-4cee-a356-84d10a6eb2ff	cbe7c6e1-4a52-4b32-b8cd-f1f32aa48cde	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
acd283c0-ab3d-4ffb-9c02-88ca1165081e	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	${role_default-roles}	default-roles-master	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	\N
83d339a4-903e-478f-8cd4-ba42f300d364	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	${role_create-realm}	create-realm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	\N
c25369e1-c3ca-42bd-bce1-cf16437107ab	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	${role_admin}	admin	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	\N
86d90d81-becd-4212-a584-701884939cc1	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_create-client}	create-client	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
d3960f33-634b-479c-8050-1a3d5596d233	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-realm}	view-realm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
48a37f7f-074d-4ebe-94c2-f5b295b69d6d	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-users}	view-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
49b253be-5339-473c-a0e7-9db18deb6249	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-clients}	view-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
44cf7bce-2b1f-4eb0-9bef-c86461d700b4	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-events}	view-events	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
356f6cd8-2f6a-432d-ab78-e69c38d1c836	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-identity-providers}	view-identity-providers	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
6ec99e0f-bd27-4147-a643-b379d0779310	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_view-authorization}	view-authorization	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
a2af23c2-d476-4757-9c10-82a85887fdc4	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-realm}	manage-realm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
884d2d3d-f42a-4d07-a0a4-fd0bfa65dfc6	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-users}	manage-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
a52befe7-de99-4dba-8c6f-e984a0ba68ed	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-clients}	manage-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
fa339236-25ea-4946-a82c-2750d1621162	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-events}	manage-events	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
edb8baaf-173c-422d-976b-fd680633ed88	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-identity-providers}	manage-identity-providers	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
1cce54af-4865-4fe8-ba27-5ef0bf8d3f41	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_manage-authorization}	manage-authorization	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
c9a491b8-9675-4b9a-9e23-954154a36f89	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_query-users}	query-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
b8b18624-8c93-492e-b1d1-2969de208abf	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_query-clients}	query-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
64029d32-a021-41ea-8a20-34a0374205c2	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_query-realms}	query-realms	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
12a10e5c-c2fa-426f-ba67-ec2754703e93	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_query-groups}	query-groups	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
77cba1c4-d03e-4b2f-9705-21a1f4aee4db	10aec783-08cc-4792-a3f5-645814268124	t	${role_view-profile}	view-profile	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
70d486a3-c5a2-4b29-b5b4-5d16abf2cdbb	10aec783-08cc-4792-a3f5-645814268124	t	${role_manage-account}	manage-account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
e37d31c5-ab65-49e6-a1dc-c79cb8cde943	10aec783-08cc-4792-a3f5-645814268124	t	${role_manage-account-links}	manage-account-links	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
9ca73f2c-e333-4501-8c48-ee1554a94da1	10aec783-08cc-4792-a3f5-645814268124	t	${role_view-applications}	view-applications	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
45503d46-1833-49cd-b677-8d809b942295	10aec783-08cc-4792-a3f5-645814268124	t	${role_view-consent}	view-consent	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
75d208cd-a4b3-4d64-a565-8f090bf26360	10aec783-08cc-4792-a3f5-645814268124	t	${role_manage-consent}	manage-consent	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
d38628ee-42be-42fd-8e66-5a028cf389ae	10aec783-08cc-4792-a3f5-645814268124	t	${role_view-groups}	view-groups	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
58c25e2a-5cd8-42ac-b468-a01ac89ffdfa	10aec783-08cc-4792-a3f5-645814268124	t	${role_delete-account}	delete-account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	10aec783-08cc-4792-a3f5-645814268124	\N
8efde5c3-083f-4192-a81e-5bad376edc45	b039e641-b58c-44e6-9778-5752f91da0ab	t	${role_read-token}	read-token	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	b039e641-b58c-44e6-9778-5752f91da0ab	\N
9039ac64-2ceb-4bc0-9a94-c37e0460531a	795f0199-5cb3-4541-8249-5aef9a18a26a	t	${role_impersonation}	impersonation	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	795f0199-5cb3-4541-8249-5aef9a18a26a	\N
9a07e760-f0e4-4b74-a9a7-77ce8836fc0a	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	${role_offline-access}	offline_access	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	\N
21d2138a-0700-4a25-87a7-c2af2c2bf9d7	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	${role_uma_authorization}	uma_authorization	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	\N	\N
63fdf290-8a2d-49d9-98c3-eb950b9f6701	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	${role_default-roles}	default-roles-coghealth	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
bba5d100-34f9-478f-9cf6-b1ac279c726c	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_create-client}	create-client	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
ddc604b6-dd2b-4ea1-a4d7-4822112c100f	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-realm}	view-realm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
188053be-bfdf-4a37-b49f-0a4cb0644535	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-users}	view-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
7b484401-6fca-402d-95d4-55905f4e0990	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-clients}	view-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
3994a8de-360b-4645-b346-42bfba429fed	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-events}	view-events	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
696f0c04-58e7-41ab-b119-85b72b00a3c3	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-identity-providers}	view-identity-providers	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
d387aa24-199a-409a-90d9-242a16c0369b	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_view-authorization}	view-authorization	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
611ec675-194e-4f35-9cde-91969386fa87	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-realm}	manage-realm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
81115095-34fb-40d8-bee7-3c7803fd379e	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-users}	manage-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
4ce9c86a-dd95-4181-9345-e78de243ed6f	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-clients}	manage-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
f3814869-56c6-4821-8230-41efe3d0a9b9	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-events}	manage-events	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
3cd658d3-64e8-42a0-ad44-58ea4defe4d1	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-identity-providers}	manage-identity-providers	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
21d4a47e-8245-4cfe-81c9-60c2332bc476	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_manage-authorization}	manage-authorization	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
85e62a22-722b-4f16-a253-6c847837b087	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_query-users}	query-users	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
add8aee9-93cb-4b26-aba9-686d893c498d	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_query-clients}	query-clients	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
2edf15d4-c48e-40cd-a9cc-e67c5049a132	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_query-realms}	query-realms	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
6cfe9942-8c4b-4b4c-b589-edebb235f5b5	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_query-groups}	query-groups	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
cc3029d7-22a1-4a31-994d-abda88040049	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_realm-admin}	realm-admin	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
4df7c160-eb84-49dc-8a3c-f9d21dd9292e	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_create-client}	create-client	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
43f664af-8c39-46a0-bd86-46ca9beffa75	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-realm}	view-realm	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
58187b38-d443-48fd-8ea7-8750dad16125	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-users}	view-users	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
95043922-1942-4b89-8a5f-ddb90122cef4	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-clients}	view-clients	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
b6c1c681-660d-4961-b86d-74cbe8f498cb	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-events}	view-events	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
5bd13ab0-975e-45e9-a21b-447891834330	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-identity-providers}	view-identity-providers	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
c2403f3c-daab-4042-9911-58a31f874a70	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_view-authorization}	view-authorization	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
96392e95-a529-4e99-9ef0-aad80a7aeffb	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-realm}	manage-realm	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
aedf38fe-5105-4bc9-9257-6a6655eeea88	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-users}	manage-users	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
51930965-afc1-4f09-b558-92d9ef340963	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-clients}	manage-clients	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
e2347c6e-38a1-4c88-bec8-5590e8268cc7	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-events}	manage-events	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
94150bd6-a3da-4708-be80-36351de73cf9	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-identity-providers}	manage-identity-providers	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
4ae9b8f9-ccb9-4320-9047-4bd5ee29bffe	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_manage-authorization}	manage-authorization	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
7152b4b0-cf57-4346-9d9f-afa406b16ee8	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_query-users}	query-users	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
fa213ae9-90af-4ee9-84cc-a2d42eb9c8a0	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_query-clients}	query-clients	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
087b4fc2-570e-43ed-9177-527f06496a7f	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_query-realms}	query-realms	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
3d5e9bc8-6e25-47dd-a3c5-56698edd853e	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_query-groups}	query-groups	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
2dfc6e45-4c08-4735-b958-77e65712b3a4	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_view-profile}	view-profile	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
87931b8e-7ccc-4dbf-bbb6-368daed1a2e5	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_manage-account}	manage-account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
63072893-da7c-4e7e-a972-b9e4f3288926	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_manage-account-links}	manage-account-links	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
f3dc4226-da26-4f69-9dbe-1ac3ec6224be	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_view-applications}	view-applications	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
be66d381-e9ed-4886-b265-08d5f5f5ac0b	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_view-consent}	view-consent	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
4c7cb7d3-ced4-454f-962a-f1d61ca5be46	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_manage-consent}	manage-consent	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
51e78af1-f242-4be9-b5c8-e6e041b4734e	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_view-groups}	view-groups	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
00c52b89-c268-4281-8091-5017e5c3d3d5	e98f490e-fb2d-4cac-a41d-b398c8c9813e	t	${role_delete-account}	delete-account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	e98f490e-fb2d-4cac-a41d-b398c8c9813e	\N
39c1d294-4b4c-403c-b76a-e6fa15b255ec	8736a2c1-4240-492b-954e-6be06c2237d0	t	${role_impersonation}	impersonation	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	8736a2c1-4240-492b-954e-6be06c2237d0	\N
33c7aced-0424-4c14-b767-1b7a0bec6004	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	t	${role_impersonation}	impersonation	8741d434-aa5e-4cee-a356-84d10a6eb2ff	23978e44-f11b-44c1-bd2c-e200b5f8f2bf	\N
561abe19-8b06-4aee-90c2-f8d16d9eefda	2c7cff96-dac8-442d-a30d-051c55f585e6	t	${role_read-token}	read-token	8741d434-aa5e-4cee-a356-84d10a6eb2ff	2c7cff96-dac8-442d-a30d-051c55f585e6	\N
1f054e28-15d8-4090-bbf8-4e70cf0aa7b4	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	${role_offline-access}	offline_access	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
c0b906d2-46b7-4cb2-85a7-62520cf772e4	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Licensed physician - full clinical access	physician	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
82dfe246-4724-43e1-9253-c2fad818891d	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Registered nurse - clinical access, limited prescribing	nurse	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
c43c8169-f02c-415c-8c78-d7055a6d703d	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Medical assistant - vitals, scheduling, limited chart access	medical_assistant	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
e801194c-76c7-4948-b99b-60371cca904d	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Front desk staff - scheduling, demographics only	front_desk	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
c0c4cf01-2b99-4282-a1ab-c7cf3f10c70e	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Billing staff - claims, payments, limited PHI	billing	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
82fc88f5-8eb7-4270-8516-c331f14f9525	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	System administrator - full access	admin	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
28079df2-7c9a-4a11-b2ed-355e2875572e	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	Compliance - audit logs, reports, no clinical modification	compliance_officer	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
194f3317-fc84-4be8-91b5-ff7027c42496	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	${role_uma_authorization}	uma_authorization	8741d434-aa5e-4cee-a356-84d10a6eb2ff	\N	\N
3e63947f-e86a-4669-bb74-152b371f568e	96465aa2-3c46-429e-a392-7e57bfc5e79f	t	\N	uma_protection	8741d434-aa5e-4cee-a356-84d10a6eb2ff	96465aa2-3c46-429e-a392-7e57bfc5e79f	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.migration_model (id, version, update_time) FROM stdin;
900g1	23.0.7	1769429544
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
30ca7888-b6dd-46c8-b220-b06cd4437ec3	audience resolve	openid-connect	oidc-audience-resolve-mapper	43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	\N
7de61544-49a2-4588-a1c0-fc9b4745a06d	locale	openid-connect	oidc-usermodel-attribute-mapper	fc782392-2fad-485e-8b08-7e84c46643f3	\N
3d0e76bb-5b34-4e41-b5f6-c3ef080aed2d	role list	saml	saml-role-list-mapper	\N	55ebb439-9a7e-4eff-8285-ed09687b5287
17c41f0a-774d-4edc-818e-cc836e6b8a04	full name	openid-connect	oidc-full-name-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
0cf47aaa-1343-41e1-b73c-8685db7a54ad	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
7dc53d58-2057-46fd-8133-26b128418c65	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
1729fb9b-c2f1-43c3-9d72-8d6673060d55	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
c508f13f-cbd8-4e45-a905-3b499a2737ba	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
debe9b46-6977-40ee-a155-ac887b6614cb	username	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
92925cc1-eab0-4ded-a28a-a34cd22267f1	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
b3dc2a6b-a492-41be-9c13-bf4a2b369341	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
ef21d8e0-7252-4efe-bf24-b497d0c6a766	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
6e733edc-0b89-468b-a557-8ecf7e9ac814	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
32e9a747-28a5-4453-ae18-9ead8a2c3436	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
cbfd52ba-631b-428b-b14b-f2a562e62858	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
d9f882df-8449-4f57-95a3-3a936499aded	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f39aa328-689e-4dd0-8ff4-06b8b11b46bf
e3eed706-c6d1-4f42-ad95-b90930f9f234	email	openid-connect	oidc-usermodel-attribute-mapper	\N	26326d06-ef09-44a7-8790-82cfa2cf6f3c
031e4332-4f4f-4be1-bacc-f9f7f905809f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	26326d06-ef09-44a7-8790-82cfa2cf6f3c
1034e3ce-c6d3-4d0a-a16a-978219976cd9	address	openid-connect	oidc-address-mapper	\N	263ecf96-09f5-4851-9c57-2c64d3c15d78
080f7f06-7e64-423a-bbac-10d877553d2d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	a68fceb2-aa9c-4982-8e70-893ce56d0087
22418663-0774-4531-af81-25dd022eeada	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	a68fceb2-aa9c-4982-8e70-893ce56d0087
9e13bd7b-878b-4bd3-a637-702d46ac4df5	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	3d6f9114-61fc-4714-b3d7-6f1275013988
7fe237eb-2f49-469f-913a-15d474b513b6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	3d6f9114-61fc-4714-b3d7-6f1275013988
c1d3287f-3465-4590-a28a-4c8e16ac2a33	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	3d6f9114-61fc-4714-b3d7-6f1275013988
f8483400-6712-41c9-94de-655b0acc67ea	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	21dfe6ef-90e6-474d-a9a0-454919f06e69
39c556ea-ba08-4ee6-ab80-1e8c828b8960	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	8c345651-3574-441d-a9e8-4d9474d08323
90995156-edb8-450b-aacb-f34d46f4724b	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	8c345651-3574-441d-a9e8-4d9474d08323
4ba50637-783f-4265-a959-1d2402e5de7e	acr loa level	openid-connect	oidc-acr-mapper	\N	143b768e-3fb1-4bc3-a4c4-df0fb992b8de
7949e6d3-21ec-4702-b889-910dd829747d	audience resolve	openid-connect	oidc-audience-resolve-mapper	b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	\N
352a9e7e-65e3-4a82-82b7-253dbec74219	realm-roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	9565c2b6-8f08-42b2-a5f2-262af88b7750
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	npi	openid-connect	oidc-usermodel-attribute-mapper	\N	9565c2b6-8f08-42b2-a5f2-262af88b7750
c8e57b3c-6e3c-412c-8f8e-6e613284c672	locale	openid-connect	oidc-usermodel-attribute-mapper	af14a8e6-8c4e-4917-b870-2c059aa51000	\N
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	96465aa2-3c46-429e-a392-7e57bfc5e79f	\N
d9a1404f-7ed8-456f-9e55-7f940fbcd239	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	96465aa2-3c46-429e-a392-7e57bfc5e79f	\N
12352f77-a77e-44ae-a8ab-065447b7b840	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	96465aa2-3c46-429e-a392-7e57bfc5e79f	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
7de61544-49a2-4588-a1c0-fc9b4745a06d	true	introspection.token.claim
7de61544-49a2-4588-a1c0-fc9b4745a06d	true	userinfo.token.claim
7de61544-49a2-4588-a1c0-fc9b4745a06d	locale	user.attribute
7de61544-49a2-4588-a1c0-fc9b4745a06d	true	id.token.claim
7de61544-49a2-4588-a1c0-fc9b4745a06d	true	access.token.claim
7de61544-49a2-4588-a1c0-fc9b4745a06d	locale	claim.name
7de61544-49a2-4588-a1c0-fc9b4745a06d	String	jsonType.label
3d0e76bb-5b34-4e41-b5f6-c3ef080aed2d	false	single
3d0e76bb-5b34-4e41-b5f6-c3ef080aed2d	Basic	attribute.nameformat
3d0e76bb-5b34-4e41-b5f6-c3ef080aed2d	Role	attribute.name
0cf47aaa-1343-41e1-b73c-8685db7a54ad	true	introspection.token.claim
0cf47aaa-1343-41e1-b73c-8685db7a54ad	true	userinfo.token.claim
0cf47aaa-1343-41e1-b73c-8685db7a54ad	lastName	user.attribute
0cf47aaa-1343-41e1-b73c-8685db7a54ad	true	id.token.claim
0cf47aaa-1343-41e1-b73c-8685db7a54ad	true	access.token.claim
0cf47aaa-1343-41e1-b73c-8685db7a54ad	family_name	claim.name
0cf47aaa-1343-41e1-b73c-8685db7a54ad	String	jsonType.label
1729fb9b-c2f1-43c3-9d72-8d6673060d55	true	introspection.token.claim
1729fb9b-c2f1-43c3-9d72-8d6673060d55	true	userinfo.token.claim
1729fb9b-c2f1-43c3-9d72-8d6673060d55	middleName	user.attribute
1729fb9b-c2f1-43c3-9d72-8d6673060d55	true	id.token.claim
1729fb9b-c2f1-43c3-9d72-8d6673060d55	true	access.token.claim
1729fb9b-c2f1-43c3-9d72-8d6673060d55	middle_name	claim.name
1729fb9b-c2f1-43c3-9d72-8d6673060d55	String	jsonType.label
17c41f0a-774d-4edc-818e-cc836e6b8a04	true	introspection.token.claim
17c41f0a-774d-4edc-818e-cc836e6b8a04	true	userinfo.token.claim
17c41f0a-774d-4edc-818e-cc836e6b8a04	true	id.token.claim
17c41f0a-774d-4edc-818e-cc836e6b8a04	true	access.token.claim
32e9a747-28a5-4453-ae18-9ead8a2c3436	true	introspection.token.claim
32e9a747-28a5-4453-ae18-9ead8a2c3436	true	userinfo.token.claim
32e9a747-28a5-4453-ae18-9ead8a2c3436	zoneinfo	user.attribute
32e9a747-28a5-4453-ae18-9ead8a2c3436	true	id.token.claim
32e9a747-28a5-4453-ae18-9ead8a2c3436	true	access.token.claim
32e9a747-28a5-4453-ae18-9ead8a2c3436	zoneinfo	claim.name
32e9a747-28a5-4453-ae18-9ead8a2c3436	String	jsonType.label
6e733edc-0b89-468b-a557-8ecf7e9ac814	true	introspection.token.claim
6e733edc-0b89-468b-a557-8ecf7e9ac814	true	userinfo.token.claim
6e733edc-0b89-468b-a557-8ecf7e9ac814	birthdate	user.attribute
6e733edc-0b89-468b-a557-8ecf7e9ac814	true	id.token.claim
6e733edc-0b89-468b-a557-8ecf7e9ac814	true	access.token.claim
6e733edc-0b89-468b-a557-8ecf7e9ac814	birthdate	claim.name
6e733edc-0b89-468b-a557-8ecf7e9ac814	String	jsonType.label
7dc53d58-2057-46fd-8133-26b128418c65	true	introspection.token.claim
7dc53d58-2057-46fd-8133-26b128418c65	true	userinfo.token.claim
7dc53d58-2057-46fd-8133-26b128418c65	firstName	user.attribute
7dc53d58-2057-46fd-8133-26b128418c65	true	id.token.claim
7dc53d58-2057-46fd-8133-26b128418c65	true	access.token.claim
7dc53d58-2057-46fd-8133-26b128418c65	given_name	claim.name
7dc53d58-2057-46fd-8133-26b128418c65	String	jsonType.label
92925cc1-eab0-4ded-a28a-a34cd22267f1	true	introspection.token.claim
92925cc1-eab0-4ded-a28a-a34cd22267f1	true	userinfo.token.claim
92925cc1-eab0-4ded-a28a-a34cd22267f1	profile	user.attribute
92925cc1-eab0-4ded-a28a-a34cd22267f1	true	id.token.claim
92925cc1-eab0-4ded-a28a-a34cd22267f1	true	access.token.claim
92925cc1-eab0-4ded-a28a-a34cd22267f1	profile	claim.name
92925cc1-eab0-4ded-a28a-a34cd22267f1	String	jsonType.label
b3dc2a6b-a492-41be-9c13-bf4a2b369341	true	introspection.token.claim
b3dc2a6b-a492-41be-9c13-bf4a2b369341	true	userinfo.token.claim
b3dc2a6b-a492-41be-9c13-bf4a2b369341	picture	user.attribute
b3dc2a6b-a492-41be-9c13-bf4a2b369341	true	id.token.claim
b3dc2a6b-a492-41be-9c13-bf4a2b369341	true	access.token.claim
b3dc2a6b-a492-41be-9c13-bf4a2b369341	picture	claim.name
b3dc2a6b-a492-41be-9c13-bf4a2b369341	String	jsonType.label
c508f13f-cbd8-4e45-a905-3b499a2737ba	true	introspection.token.claim
c508f13f-cbd8-4e45-a905-3b499a2737ba	true	userinfo.token.claim
c508f13f-cbd8-4e45-a905-3b499a2737ba	nickname	user.attribute
c508f13f-cbd8-4e45-a905-3b499a2737ba	true	id.token.claim
c508f13f-cbd8-4e45-a905-3b499a2737ba	true	access.token.claim
c508f13f-cbd8-4e45-a905-3b499a2737ba	nickname	claim.name
c508f13f-cbd8-4e45-a905-3b499a2737ba	String	jsonType.label
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	true	introspection.token.claim
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	true	userinfo.token.claim
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	gender	user.attribute
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	true	id.token.claim
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	true	access.token.claim
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	gender	claim.name
c791d578-cc0d-4f9f-b424-5dcc6b63cfdb	String	jsonType.label
cbfd52ba-631b-428b-b14b-f2a562e62858	true	introspection.token.claim
cbfd52ba-631b-428b-b14b-f2a562e62858	true	userinfo.token.claim
cbfd52ba-631b-428b-b14b-f2a562e62858	locale	user.attribute
cbfd52ba-631b-428b-b14b-f2a562e62858	true	id.token.claim
cbfd52ba-631b-428b-b14b-f2a562e62858	true	access.token.claim
cbfd52ba-631b-428b-b14b-f2a562e62858	locale	claim.name
cbfd52ba-631b-428b-b14b-f2a562e62858	String	jsonType.label
d9f882df-8449-4f57-95a3-3a936499aded	true	introspection.token.claim
d9f882df-8449-4f57-95a3-3a936499aded	true	userinfo.token.claim
d9f882df-8449-4f57-95a3-3a936499aded	updatedAt	user.attribute
d9f882df-8449-4f57-95a3-3a936499aded	true	id.token.claim
d9f882df-8449-4f57-95a3-3a936499aded	true	access.token.claim
d9f882df-8449-4f57-95a3-3a936499aded	updated_at	claim.name
d9f882df-8449-4f57-95a3-3a936499aded	long	jsonType.label
debe9b46-6977-40ee-a155-ac887b6614cb	true	introspection.token.claim
debe9b46-6977-40ee-a155-ac887b6614cb	true	userinfo.token.claim
debe9b46-6977-40ee-a155-ac887b6614cb	username	user.attribute
debe9b46-6977-40ee-a155-ac887b6614cb	true	id.token.claim
debe9b46-6977-40ee-a155-ac887b6614cb	true	access.token.claim
debe9b46-6977-40ee-a155-ac887b6614cb	preferred_username	claim.name
debe9b46-6977-40ee-a155-ac887b6614cb	String	jsonType.label
ef21d8e0-7252-4efe-bf24-b497d0c6a766	true	introspection.token.claim
ef21d8e0-7252-4efe-bf24-b497d0c6a766	true	userinfo.token.claim
ef21d8e0-7252-4efe-bf24-b497d0c6a766	website	user.attribute
ef21d8e0-7252-4efe-bf24-b497d0c6a766	true	id.token.claim
ef21d8e0-7252-4efe-bf24-b497d0c6a766	true	access.token.claim
ef21d8e0-7252-4efe-bf24-b497d0c6a766	website	claim.name
ef21d8e0-7252-4efe-bf24-b497d0c6a766	String	jsonType.label
031e4332-4f4f-4be1-bacc-f9f7f905809f	true	introspection.token.claim
031e4332-4f4f-4be1-bacc-f9f7f905809f	true	userinfo.token.claim
031e4332-4f4f-4be1-bacc-f9f7f905809f	emailVerified	user.attribute
031e4332-4f4f-4be1-bacc-f9f7f905809f	true	id.token.claim
031e4332-4f4f-4be1-bacc-f9f7f905809f	true	access.token.claim
031e4332-4f4f-4be1-bacc-f9f7f905809f	email_verified	claim.name
031e4332-4f4f-4be1-bacc-f9f7f905809f	boolean	jsonType.label
e3eed706-c6d1-4f42-ad95-b90930f9f234	true	introspection.token.claim
e3eed706-c6d1-4f42-ad95-b90930f9f234	true	userinfo.token.claim
e3eed706-c6d1-4f42-ad95-b90930f9f234	email	user.attribute
e3eed706-c6d1-4f42-ad95-b90930f9f234	true	id.token.claim
e3eed706-c6d1-4f42-ad95-b90930f9f234	true	access.token.claim
e3eed706-c6d1-4f42-ad95-b90930f9f234	email	claim.name
e3eed706-c6d1-4f42-ad95-b90930f9f234	String	jsonType.label
1034e3ce-c6d3-4d0a-a16a-978219976cd9	formatted	user.attribute.formatted
1034e3ce-c6d3-4d0a-a16a-978219976cd9	country	user.attribute.country
1034e3ce-c6d3-4d0a-a16a-978219976cd9	true	introspection.token.claim
1034e3ce-c6d3-4d0a-a16a-978219976cd9	postal_code	user.attribute.postal_code
1034e3ce-c6d3-4d0a-a16a-978219976cd9	true	userinfo.token.claim
1034e3ce-c6d3-4d0a-a16a-978219976cd9	street	user.attribute.street
1034e3ce-c6d3-4d0a-a16a-978219976cd9	true	id.token.claim
1034e3ce-c6d3-4d0a-a16a-978219976cd9	region	user.attribute.region
1034e3ce-c6d3-4d0a-a16a-978219976cd9	true	access.token.claim
1034e3ce-c6d3-4d0a-a16a-978219976cd9	locality	user.attribute.locality
080f7f06-7e64-423a-bbac-10d877553d2d	true	introspection.token.claim
080f7f06-7e64-423a-bbac-10d877553d2d	true	userinfo.token.claim
080f7f06-7e64-423a-bbac-10d877553d2d	phoneNumber	user.attribute
080f7f06-7e64-423a-bbac-10d877553d2d	true	id.token.claim
080f7f06-7e64-423a-bbac-10d877553d2d	true	access.token.claim
080f7f06-7e64-423a-bbac-10d877553d2d	phone_number	claim.name
080f7f06-7e64-423a-bbac-10d877553d2d	String	jsonType.label
22418663-0774-4531-af81-25dd022eeada	true	introspection.token.claim
22418663-0774-4531-af81-25dd022eeada	true	userinfo.token.claim
22418663-0774-4531-af81-25dd022eeada	phoneNumberVerified	user.attribute
22418663-0774-4531-af81-25dd022eeada	true	id.token.claim
22418663-0774-4531-af81-25dd022eeada	true	access.token.claim
22418663-0774-4531-af81-25dd022eeada	phone_number_verified	claim.name
22418663-0774-4531-af81-25dd022eeada	boolean	jsonType.label
7fe237eb-2f49-469f-913a-15d474b513b6	true	introspection.token.claim
7fe237eb-2f49-469f-913a-15d474b513b6	true	multivalued
7fe237eb-2f49-469f-913a-15d474b513b6	foo	user.attribute
7fe237eb-2f49-469f-913a-15d474b513b6	true	access.token.claim
7fe237eb-2f49-469f-913a-15d474b513b6	resource_access.${client_id}.roles	claim.name
7fe237eb-2f49-469f-913a-15d474b513b6	String	jsonType.label
9e13bd7b-878b-4bd3-a637-702d46ac4df5	true	introspection.token.claim
9e13bd7b-878b-4bd3-a637-702d46ac4df5	true	multivalued
9e13bd7b-878b-4bd3-a637-702d46ac4df5	foo	user.attribute
9e13bd7b-878b-4bd3-a637-702d46ac4df5	true	access.token.claim
9e13bd7b-878b-4bd3-a637-702d46ac4df5	realm_access.roles	claim.name
9e13bd7b-878b-4bd3-a637-702d46ac4df5	String	jsonType.label
c1d3287f-3465-4590-a28a-4c8e16ac2a33	true	introspection.token.claim
c1d3287f-3465-4590-a28a-4c8e16ac2a33	true	access.token.claim
f8483400-6712-41c9-94de-655b0acc67ea	true	introspection.token.claim
f8483400-6712-41c9-94de-655b0acc67ea	true	access.token.claim
39c556ea-ba08-4ee6-ab80-1e8c828b8960	true	introspection.token.claim
39c556ea-ba08-4ee6-ab80-1e8c828b8960	true	userinfo.token.claim
39c556ea-ba08-4ee6-ab80-1e8c828b8960	username	user.attribute
39c556ea-ba08-4ee6-ab80-1e8c828b8960	true	id.token.claim
39c556ea-ba08-4ee6-ab80-1e8c828b8960	true	access.token.claim
39c556ea-ba08-4ee6-ab80-1e8c828b8960	upn	claim.name
39c556ea-ba08-4ee6-ab80-1e8c828b8960	String	jsonType.label
90995156-edb8-450b-aacb-f34d46f4724b	true	introspection.token.claim
90995156-edb8-450b-aacb-f34d46f4724b	true	multivalued
90995156-edb8-450b-aacb-f34d46f4724b	foo	user.attribute
90995156-edb8-450b-aacb-f34d46f4724b	true	id.token.claim
90995156-edb8-450b-aacb-f34d46f4724b	true	access.token.claim
90995156-edb8-450b-aacb-f34d46f4724b	groups	claim.name
90995156-edb8-450b-aacb-f34d46f4724b	String	jsonType.label
4ba50637-783f-4265-a959-1d2402e5de7e	true	introspection.token.claim
4ba50637-783f-4265-a959-1d2402e5de7e	true	id.token.claim
4ba50637-783f-4265-a959-1d2402e5de7e	true	access.token.claim
352a9e7e-65e3-4a82-82b7-253dbec74219	true	multivalued
352a9e7e-65e3-4a82-82b7-253dbec74219	true	userinfo.token.claim
352a9e7e-65e3-4a82-82b7-253dbec74219	true	id.token.claim
352a9e7e-65e3-4a82-82b7-253dbec74219	true	access.token.claim
352a9e7e-65e3-4a82-82b7-253dbec74219	roles	claim.name
352a9e7e-65e3-4a82-82b7-253dbec74219	String	jsonType.label
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	npi	user.attribute
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	true	id.token.claim
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	true	access.token.claim
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	npi	claim.name
593e6a0a-1bde-450c-92c2-9f5b9f7ee967	true	userinfo.token.claim
c8e57b3c-6e3c-412c-8f8e-6e613284c672	true	introspection.token.claim
c8e57b3c-6e3c-412c-8f8e-6e613284c672	true	userinfo.token.claim
c8e57b3c-6e3c-412c-8f8e-6e613284c672	locale	user.attribute
c8e57b3c-6e3c-412c-8f8e-6e613284c672	true	id.token.claim
c8e57b3c-6e3c-412c-8f8e-6e613284c672	true	access.token.claim
c8e57b3c-6e3c-412c-8f8e-6e613284c672	locale	claim.name
c8e57b3c-6e3c-412c-8f8e-6e613284c672	String	jsonType.label
12352f77-a77e-44ae-a8ab-065447b7b840	clientAddress	user.session.note
12352f77-a77e-44ae-a8ab-065447b7b840	true	introspection.token.claim
12352f77-a77e-44ae-a8ab-065447b7b840	true	id.token.claim
12352f77-a77e-44ae-a8ab-065447b7b840	true	access.token.claim
12352f77-a77e-44ae-a8ab-065447b7b840	clientAddress	claim.name
12352f77-a77e-44ae-a8ab-065447b7b840	String	jsonType.label
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	client_id	user.session.note
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	true	introspection.token.claim
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	true	id.token.claim
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	true	access.token.claim
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	client_id	claim.name
aac66f88-01b4-494d-aa16-8dcafaaf3c0f	String	jsonType.label
d9a1404f-7ed8-456f-9e55-7f940fbcd239	clientHost	user.session.note
d9a1404f-7ed8-456f-9e55-7f940fbcd239	true	introspection.token.claim
d9a1404f-7ed8-456f-9e55-7f940fbcd239	true	id.token.claim
d9a1404f-7ed8-456f-9e55-7f940fbcd239	true	access.token.claim
d9a1404f-7ed8-456f-9e55-7f940fbcd239	clientHost	claim.name
d9a1404f-7ed8-456f-9e55-7f940fbcd239	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	795f0199-5cb3-4541-8249-5aef9a18a26a	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	674e94fd-03fe-4ca2-8f12-45c3dc68daea	c6427deb-02e4-4f03-a3a3-05852e129673	b17776a8-b1fa-496a-a780-d675b4cd2f9e	b7121eda-997e-4039-a728-ef8d1fcef36e	4db4d26b-fb63-40f1-8248-108d75193d2e	2592000	f	900	t	f	ac267a26-2339-42b0-b24a-a4ab0993d5c7	0	f	0	0	acd283c0-ab3d-4ffb-9c02-88ca1165081e
8741d434-aa5e-4cee-a356-84d10a6eb2ff	60	300	300	\N	\N	\N	t	f	0	\N	coghealth	0	\N	f	f	t	f	NONE	1800	36000	f	f	8736a2c1-4240-492b-954e-6be06c2237d0	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	24b487e7-a6af-477d-ae7b-6cfef4992c03	8d24e44f-f501-4e8a-834a-296f4143f3aa	f3f5a4b0-eb0e-4571-8151-f4b8a4e62145	5fbdd64a-d2f9-493f-a634-d70352b4db9c	5458a72f-e8ba-48d4-9ee0-47a7a0b7ff1c	2592000	f	900	t	f	1fbb82c0-b1e9-4ee5-ab87-519ad0d8e03c	0	f	0	0	63fdf290-8a2d-49d9-98c3-eb950b9f6701
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	
_browser_header.xContentTypeOptions	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	nosniff
_browser_header.referrerPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	no-referrer
_browser_header.xRobotsTag	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	none
_browser_header.xFrameOptions	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	SAMEORIGIN
_browser_header.contentSecurityPolicy	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	1; mode=block
_browser_header.strictTransportSecurity	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	max-age=31536000; includeSubDomains
bruteForceProtected	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	false
permanentLockout	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	false
maxFailureWaitSeconds	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	900
minimumQuickLoginWaitSeconds	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	60
waitIncrementSeconds	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	60
quickLoginCheckMilliSeconds	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	1000
maxDeltaTimeSeconds	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	43200
failureFactor	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	30
realmReusableOtpCode	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	false
displayName	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	Keycloak
displayNameHtml	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	RS256
offlineSessionMaxLifespanEnabled	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	false
offlineSessionMaxLifespan	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	5184000
_browser_header.contentSecurityPolicyReportOnly	8741d434-aa5e-4cee-a356-84d10a6eb2ff	
_browser_header.xContentTypeOptions	8741d434-aa5e-4cee-a356-84d10a6eb2ff	nosniff
_browser_header.referrerPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	no-referrer
_browser_header.xRobotsTag	8741d434-aa5e-4cee-a356-84d10a6eb2ff	none
_browser_header.xFrameOptions	8741d434-aa5e-4cee-a356-84d10a6eb2ff	SAMEORIGIN
_browser_header.contentSecurityPolicy	8741d434-aa5e-4cee-a356-84d10a6eb2ff	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	8741d434-aa5e-4cee-a356-84d10a6eb2ff	1; mode=block
_browser_header.strictTransportSecurity	8741d434-aa5e-4cee-a356-84d10a6eb2ff	max-age=31536000; includeSubDomains
permanentLockout	8741d434-aa5e-4cee-a356-84d10a6eb2ff	false
maxFailureWaitSeconds	8741d434-aa5e-4cee-a356-84d10a6eb2ff	900
minimumQuickLoginWaitSeconds	8741d434-aa5e-4cee-a356-84d10a6eb2ff	60
waitIncrementSeconds	8741d434-aa5e-4cee-a356-84d10a6eb2ff	60
quickLoginCheckMilliSeconds	8741d434-aa5e-4cee-a356-84d10a6eb2ff	1000
maxDeltaTimeSeconds	8741d434-aa5e-4cee-a356-84d10a6eb2ff	43200
realmReusableOtpCode	8741d434-aa5e-4cee-a356-84d10a6eb2ff	false
displayName	8741d434-aa5e-4cee-a356-84d10a6eb2ff	CogHealth EHR
defaultSignatureAlgorithm	8741d434-aa5e-4cee-a356-84d10a6eb2ff	RS256
bruteForceProtected	8741d434-aa5e-4cee-a356-84d10a6eb2ff	true
failureFactor	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5
offlineSessionMaxLifespanEnabled	8741d434-aa5e-4cee-a356-84d10a6eb2ff	false
offlineSessionMaxLifespan	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5184000
actionTokenGeneratedByAdminLifespan	8741d434-aa5e-4cee-a356-84d10a6eb2ff	43200
actionTokenGeneratedByUserLifespan	8741d434-aa5e-4cee-a356-84d10a6eb2ff	300
oauth2DeviceCodeLifespan	8741d434-aa5e-4cee-a356-84d10a6eb2ff	600
oauth2DevicePollingInterval	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5
webAuthnPolicyRpEntityName	8741d434-aa5e-4cee-a356-84d10a6eb2ff	keycloak
webAuthnPolicySignatureAlgorithms	8741d434-aa5e-4cee-a356-84d10a6eb2ff	ES256
webAuthnPolicyRpId	8741d434-aa5e-4cee-a356-84d10a6eb2ff	
webAuthnPolicyAttestationConveyancePreference	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyAuthenticatorAttachment	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyRequireResidentKey	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyUserVerificationRequirement	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyCreateTimeout	8741d434-aa5e-4cee-a356-84d10a6eb2ff	0
webAuthnPolicyAvoidSameAuthenticatorRegister	8741d434-aa5e-4cee-a356-84d10a6eb2ff	false
webAuthnPolicyRpEntityNamePasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	ES256
webAuthnPolicyRpIdPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	
webAuthnPolicyAttestationConveyancePreferencePasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyRequireResidentKeyPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	not specified
webAuthnPolicyCreateTimeoutPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	false
cibaBackchannelTokenDeliveryMode	8741d434-aa5e-4cee-a356-84d10a6eb2ff	poll
cibaExpiresIn	8741d434-aa5e-4cee-a356-84d10a6eb2ff	120
cibaInterval	8741d434-aa5e-4cee-a356-84d10a6eb2ff	5
cibaAuthRequestedUserHint	8741d434-aa5e-4cee-a356-84d10a6eb2ff	login_hint
parRequestUriLifespan	8741d434-aa5e-4cee-a356-84d10a6eb2ff	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
ca1ec25d-8038-4d0f-af0d-a5cf91b69828	jboss-logging
8741d434-aa5e-4cee-a356-84d10a6eb2ff	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	ca1ec25d-8038-4d0f-af0d-a5cf91b69828
password	password	t	t	8741d434-aa5e-4cee-a356-84d10a6eb2ff
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.redirect_uris (client_id, value) FROM stdin;
10aec783-08cc-4792-a3f5-645814268124	/realms/master/account/*
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	/realms/master/account/*
fc782392-2fad-485e-8b08-7e84c46643f3	/admin/master/console/*
e98f490e-fb2d-4cac-a41d-b398c8c9813e	/realms/coghealth/account/*
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	/realms/coghealth/account/*
af14a8e6-8c4e-4917-b870-2c059aa51000	/admin/coghealth/console/*
96465aa2-3c46-429e-a392-7e57bfc5e79f	http://localhost:8080/*
96eab09a-8df0-4a33-8a7b-d80320ef6c88	http://localhost:5173/*
96eab09a-8df0-4a33-8a7b-d80320ef6c88	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
9fd7c10d-a8c0-4ccf-b9b7-fc11a4c97786	VERIFY_EMAIL	Verify Email	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	VERIFY_EMAIL	50
e96e347e-fa62-4455-8a3b-7025cb591925	UPDATE_PROFILE	Update Profile	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	UPDATE_PROFILE	40
4e2ae0a3-4076-4122-a2ba-7a89a4ab2942	CONFIGURE_TOTP	Configure OTP	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	CONFIGURE_TOTP	10
66aed5d1-aaf2-44d0-81c6-4a9e3fca9332	UPDATE_PASSWORD	Update Password	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	UPDATE_PASSWORD	30
1dfd7b8d-c170-442c-9101-152182a3e0ed	TERMS_AND_CONDITIONS	Terms and Conditions	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	f	TERMS_AND_CONDITIONS	20
21211ac0-6b73-4764-8c02-09061d3cc88d	delete_account	Delete Account	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	f	f	delete_account	60
142c2f03-e65c-45c0-a352-82ceb5d4b388	update_user_locale	Update User Locale	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	update_user_locale	1000
4217071e-d42e-4fa5-b234-1fdfa7de01f4	webauthn-register	Webauthn Register	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	webauthn-register	70
d65d98f1-cb50-44f4-aff0-0ff5dcd4d61a	webauthn-register-passwordless	Webauthn Register Passwordless	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	t	f	webauthn-register-passwordless	80
2a21a144-3bd3-423a-88b9-494dfc3d57f0	VERIFY_EMAIL	Verify Email	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	VERIFY_EMAIL	50
eb7f53c2-9dd3-44bb-989a-fe59bf62be2d	UPDATE_PROFILE	Update Profile	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	UPDATE_PROFILE	40
39cd124d-9dac-49d2-aa70-0627990406b9	CONFIGURE_TOTP	Configure OTP	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	CONFIGURE_TOTP	10
e0085ba5-0c8a-4db9-8fcd-488ddd382e4c	UPDATE_PASSWORD	Update Password	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	UPDATE_PASSWORD	30
48057f38-bc7e-43a4-9ef0-4bf392d2e650	TERMS_AND_CONDITIONS	Terms and Conditions	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	f	TERMS_AND_CONDITIONS	20
2e94e341-acb3-4bd6-bdcf-1fe8a043ea45	delete_account	Delete Account	8741d434-aa5e-4cee-a356-84d10a6eb2ff	f	f	delete_account	60
f10a1c17-6bd6-42fe-8905-9780f8fafb4c	update_user_locale	Update User Locale	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	update_user_locale	1000
df6dcd16-f1b5-408d-b1a2-8282d58c4db5	webauthn-register	Webauthn Register	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	webauthn-register	70
a1bbda96-78ea-49a0-b861-ab1f0275639a	webauthn-register-passwordless	Webauthn Register Passwordless	8741d434-aa5e-4cee-a356-84d10a6eb2ff	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
96465aa2-3c46-429e-a392-7e57bfc5e79f	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	70d486a3-c5a2-4b29-b5b4-5d16abf2cdbb
43e96b00-d9cc-4a0b-9109-b6b7576d9bd1	d38628ee-42be-42fd-8e66-5a028cf389ae
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	51e78af1-f242-4be9-b5c8-e6e041b4734e
b55c70e9-59b6-4e70-979d-b56f4b1ca9b6	87931b8e-7ccc-4dbf-bbb6-368daed1a2e5
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
dea	FA1234567	4932442e-78cb-4065-a7d6-ddbe500f24c8	f5228978-1074-4abf-8233-d4bc91406623
specialty	Internal Medicine	4932442e-78cb-4065-a7d6-ddbe500f24c8	65a1f40b-3fcb-426e-be94-216ab9092eab
npi	1234567890	4932442e-78cb-4065-a7d6-ddbe500f24c8	32786918-8a49-40f8-bfad-b13a09e304d0
license	RN-12345	377e3ee7-930e-4e0f-a1b0-d84abcda8b10	5c0a7993-74fe-449b-88d9-ac67ddfdab89
department	Primary Care	377e3ee7-930e-4e0f-a1b0-d84abcda8b10	0acdfa90-fab2-49ca-beb5-622b5ec041c4
department	Primary Care	c3183c42-e7fc-4e31-9b5a-e94281ec8f5a	abb492d1-0a63-4ee3-add7-466d06b0f3d8
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
4932442e-78cb-4065-a7d6-ddbe500f24c8	sarah.anderson@coghealth.com	sarah.anderson@coghealth.com	f	t	\N	Sarah	Anderson	8741d434-aa5e-4cee-a356-84d10a6eb2ff	dr.anderson	\N	\N	0
377e3ee7-930e-4e0f-a1b0-d84abcda8b10	mike.johnson@coghealth.com	mike.johnson@coghealth.com	f	t	\N	Mike	Johnson	8741d434-aa5e-4cee-a356-84d10a6eb2ff	nurse.johnson	\N	\N	0
c3183c42-e7fc-4e31-9b5a-e94281ec8f5a	jane.smith@coghealth.com	jane.smith@coghealth.com	f	t	\N	Jane	Smith	8741d434-aa5e-4cee-a356-84d10a6eb2ff	ma.smith	\N	\N	0
9d058a4d-4478-485c-a7ad-1e425699efdf	tom.wilson@coghealth.com	tom.wilson@coghealth.com	f	t	\N	Tom	Wilson	8741d434-aa5e-4cee-a356-84d10a6eb2ff	frontdesk.wilson	\N	\N	0
7feaffc1-ee64-46fd-bb09-3b67ac017adc	maria.garcia@coghealth.com	maria.garcia@coghealth.com	f	t	\N	Maria	Garcia	8741d434-aa5e-4cee-a356-84d10a6eb2ff	billing.garcia	\N	\N	0
90829df7-9329-445f-b1c9-9b1369682dff	admin@coghealth.com	admin@coghealth.com	f	t	\N	System	Administrator	8741d434-aa5e-4cee-a356-84d10a6eb2ff	admin	\N	\N	0
c108dff6-5292-4b6c-80ef-bf03d18b33bd	jennifer.lee@coghealth.com	jennifer.lee@coghealth.com	f	t	\N	Jennifer	Lee	8741d434-aa5e-4cee-a356-84d10a6eb2ff	compliance.lee	\N	\N	0
6bc7bd6e-6097-471a-9744-1184369a3db7	\N	cb16d2e8-8be2-4763-8df0-2bd552438c5d	f	t	\N	\N	\N	8741d434-aa5e-4cee-a356-84d10a6eb2ff	service-account-coghealth-api	1769429545495	96465aa2-3c46-429e-a392-7e57bfc5e79f	0
ecef6554-bc2a-4b8c-813b-34839618bebc	\N	3470e335-cf2c-458d-bb05-d48bcc439618	f	t	\N	\N	\N	ca1ec25d-8038-4d0f-af0d-a5cf91b69828	admin	1769429545573	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
c0b906d2-46b7-4cb2-85a7-62520cf772e4	4932442e-78cb-4065-a7d6-ddbe500f24c8
82dfe246-4724-43e1-9253-c2fad818891d	377e3ee7-930e-4e0f-a1b0-d84abcda8b10
c43c8169-f02c-415c-8c78-d7055a6d703d	c3183c42-e7fc-4e31-9b5a-e94281ec8f5a
e801194c-76c7-4948-b99b-60371cca904d	9d058a4d-4478-485c-a7ad-1e425699efdf
c0c4cf01-2b99-4282-a1ab-c7cf3f10c70e	7feaffc1-ee64-46fd-bb09-3b67ac017adc
82fc88f5-8eb7-4270-8516-c331f14f9525	90829df7-9329-445f-b1c9-9b1369682dff
28079df2-7c9a-4a11-b2ed-355e2875572e	c108dff6-5292-4b6c-80ef-bf03d18b33bd
63fdf290-8a2d-49d9-98c3-eb950b9f6701	6bc7bd6e-6097-471a-9744-1184369a3db7
3e63947f-e86a-4669-bb74-152b371f568e	6bc7bd6e-6097-471a-9744-1184369a3db7
acd283c0-ab3d-4ffb-9c02-88ca1165081e	ecef6554-bc2a-4b8c-813b-34839618bebc
c25369e1-c3ca-42bd-bce1-cf16437107ab	ecef6554-bc2a-4b8c-813b-34839618bebc
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: coghealth
--

COPY public.web_origins (client_id, value) FROM stdin;
fc782392-2fad-485e-8b08-7e84c46643f3	+
af14a8e6-8c4e-4917-b870-2c059aa51000	+
96465aa2-3c46-429e-a392-7e57bfc5e79f	http://localhost:8080
96eab09a-8df0-4a33-8a7b-d80320ef6c88	http://localhost:5173
96eab09a-8df0-4a33-8a7b-d80320ef6c88	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: coghealth
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: coghealth
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict iFyufdwuajiSZqa81JuyWBWMQvvJoVYgpi4HRQvarBfPdKBbqQXChwWaKtteCJ2


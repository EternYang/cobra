--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: app01_campaign; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaign (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    description character varying(128),
    gender smallint[],
    min_age integer,
    max_age integer,
    repetition_periods smallint[],
    days_of_month smallint[],
    effective_date date NOT NULL,
    expiring_date date NOT NULL,
    every_1_dollar_bouns_points double precision,
    event_venue character varying(64),
    state smallint NOT NULL,
    CONSTRAINT app01_campaign_state_check CHECK ((state >= 0))
);


ALTER TABLE public.app01_campaign OWNER TO cobra_user;

--
-- Name: app01_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaign_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaign_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaign_id_seq OWNED BY public.app01_campaign.id;


--
-- Name: app01_campaign_memberships; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaign_memberships (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    membership_id integer NOT NULL
);


ALTER TABLE public.app01_campaign_memberships OWNER TO cobra_user;

--
-- Name: app01_campaign_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaign_memberships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaign_memberships_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaign_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaign_memberships_id_seq OWNED BY public.app01_campaign_memberships.id;


--
-- Name: app01_campaign_occupations; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaign_occupations (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    occupation_id integer NOT NULL
);


ALTER TABLE public.app01_campaign_occupations OWNER TO cobra_user;

--
-- Name: app01_campaign_occupations_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaign_occupations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaign_occupations_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaign_occupations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaign_occupations_id_seq OWNED BY public.app01_campaign_occupations.id;


--
-- Name: app01_campaign_outlets; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaign_outlets (
    id integer NOT NULL,
    campaign_id integer NOT NULL,
    outlet_id integer NOT NULL
);


ALTER TABLE public.app01_campaign_outlets OWNER TO cobra_user;

--
-- Name: app01_campaign_outlets_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaign_outlets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaign_outlets_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaign_outlets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaign_outlets_id_seq OWNED BY public.app01_campaign_outlets.id;


--
-- Name: app01_campaigncondition; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigncondition (
    id integer NOT NULL,
    every_spent double precision,
    every_top_up double precision,
    every_use_points double precision,
    every_purchase_points double precision,
    online_actions smallint[],
    every_customers integer,
    ordering_modes smallint[],
    payment_modes smallint[],
    other_actions text,
    limit_redemption integer,
    campaign_id integer NOT NULL
);


ALTER TABLE public.app01_campaigncondition OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigncondition_every_purchase_l_drinks_flavors (
    id integer NOT NULL,
    campaigncondition_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_campaigncondition_every_purchase_l_drinks_flavors OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq OWNED BY public.app01_campaigncondition_every_purchase_l_drinks_flavors.id;


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigncondition_every_purchase_m_drinks_flavors (
    id integer NOT NULL,
    campaigncondition_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_campaigncondition_every_purchase_m_drinks_flavors OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq OWNED BY public.app01_campaigncondition_every_purchase_m_drinks_flavors.id;


--
-- Name: app01_campaigncondition_every_purchase_products; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigncondition_every_purchase_products (
    id integer NOT NULL,
    campaigncondition_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_campaigncondition_every_purchase_products OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_products_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigncondition_every_purchase_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigncondition_every_purchase_products_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_every_purchase_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigncondition_every_purchase_products_id_seq OWNED BY public.app01_campaigncondition_every_purchase_products.id;


--
-- Name: app01_campaigncondition_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigncondition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigncondition_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigncondition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigncondition_id_seq OWNED BY public.app01_campaigncondition.id;


--
-- Name: app01_campaigntype; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigntype (
    id integer NOT NULL,
    first_discount_per double precision,
    last_discount_per double precision,
    first_discount_price double precision,
    last_discount_price double precision,
    bouns_points double precision,
    top_up_money double precision,
    campaign_id integer NOT NULL,
    campaign_condition_id integer NOT NULL,
    upgrade_membership_id integer
);


ALTER TABLE public.app01_campaigntype OWNER TO cobra_user;

--
-- Name: app01_campaigntype_free_vouchers; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_campaigntype_free_vouchers (
    id integer NOT NULL,
    campaigntype_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.app01_campaigntype_free_vouchers OWNER TO cobra_user;

--
-- Name: app01_campaigntype_free_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigntype_free_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigntype_free_vouchers_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigntype_free_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigntype_free_vouchers_id_seq OWNED BY public.app01_campaigntype_free_vouchers.id;


--
-- Name: app01_campaigntype_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_campaigntype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_campaigntype_id_seq OWNER TO cobra_user;

--
-- Name: app01_campaigntype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_campaigntype_id_seq OWNED BY public.app01_campaigntype.id;


--
-- Name: app01_card; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_card (
    id integer NOT NULL,
    card_no character varying(64) NOT NULL,
    printed_name character varying(64),
    membership_type_code character varying(64),
    membership_status_code character varying(64),
    membership_photo character varying(64),
    issue_date timestamp with time zone,
    effective_date timestamp with time zone,
    expiry_date timestamp with time zone,
    printed boolean,
    printed_date timestamp with time zone,
    renewed_date timestamp with time zone,
    tmp_effective_date timestamp with time zone,
    tmp_expiry_date timestamp with time zone,
    tmp_membership_status_code character varying(64),
    points_bal double precision,
    total_points_bal double precision,
    holding_points double precision,
    remarks character varying(64),
    membership_discount double precision,
    tier_code character varying(64),
    tier_anniversary_start_date timestamp with time zone,
    tier_anniversary_end_date timestamp with time zone,
    loyalty_message character varying(64),
    dollar_to_points_ratio double precision,
    is_supplementary boolean,
    is_burn_supplementary boolean,
    relation_id character varying(64),
    primary_card_no character varying(64),
    primary_relation_id character varying(64),
    primary_card_expiry_date timestamp with time zone,
    primary_card_effective_date timestamp with time zone,
    pts_holding_days integer,
    current_net_spent double precision,
    pass_code character varying(64),
    stored_value_balance double precision,
    currency character varying(64),
    last_visited_date timestamp with time zone,
    last_visited_outlet character varying(64),
    points_to_next_tier double precision,
    nett_to_next_tier double precision,
    lucky_draw_conversion_pts_usage_type character varying(64),
    lucky_draw_conversion_rate character varying(64),
    spent_quota_increasement double precision,
    spent_quota_increasement_expired_on character varying(64),
    pickup_date timestamp with time zone,
    pickup_by character varying(64),
    current_rcnett_spent integer,
    cmc_earned_points double precision,
    crc_earned_points integer,
    current_tier_nett double precision,
    current_tier_amt double precision,
    bring_fwd_tier_nett double precision,
    bring_fwd_tier_amt double precision,
    bring_fwd_tier_expiry character varying(64),
    bring_fwd_tier_start_date timestamp with time zone,
    extended_tier_anniversary_end_date timestamp with time zone,
    member_id integer
);


ALTER TABLE public.app01_card OWNER TO cobra_user;

--
-- Name: app01_card_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_card_id_seq OWNER TO cobra_user;

--
-- Name: app01_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_card_id_seq OWNED BY public.app01_card.id;


--
-- Name: app01_cart; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_cart (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    created timestamp with time zone NOT NULL,
    updated timestamp with time zone NOT NULL,
    status integer NOT NULL,
    flavours character varying(32),
    tea_base integer,
    sweetness integer,
    size integer,
    toppings integer,
    ice_level integer,
    sugar_level integer,
    concentration integer,
    is_new boolean NOT NULL,
    member_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_cart OWNER TO cobra_user;

--
-- Name: app01_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_cart_id_seq OWNER TO cobra_user;

--
-- Name: app01_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_cart_id_seq OWNED BY public.app01_cart.id;


--
-- Name: app01_category; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_category (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    category_code character varying(64) NOT NULL,
    description character varying(128)
);


ALTER TABLE public.app01_category OWNER TO cobra_user;

--
-- Name: app01_category_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_category_id_seq OWNER TO cobra_user;

--
-- Name: app01_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_category_id_seq OWNED BY public.app01_category.id;


--
-- Name: app01_evaluation; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_evaluation (
    id integer NOT NULL,
    service_content character varying(128),
    service_satisfaction smallint NOT NULL,
    product_quality_content character varying(128),
    product_quality_satisfaction smallint NOT NULL,
    created timestamp with time zone NOT NULL,
    transaction_id integer NOT NULL,
    CONSTRAINT app01_evaluation_product_quality_satisfaction_check CHECK ((product_quality_satisfaction >= 0)),
    CONSTRAINT app01_evaluation_service_satisfaction_check CHECK ((service_satisfaction >= 0))
);


ALTER TABLE public.app01_evaluation OWNER TO cobra_user;

--
-- Name: app01_evaluation_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_evaluation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_evaluation_id_seq OWNER TO cobra_user;

--
-- Name: app01_evaluation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_evaluation_id_seq OWNED BY public.app01_evaluation.id;


--
-- Name: app01_interestgroup; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_interestgroup (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.app01_interestgroup OWNER TO cobra_user;

--
-- Name: app01_interestgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_interestgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_interestgroup_id_seq OWNER TO cobra_user;

--
-- Name: app01_interestgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_interestgroup_id_seq OWNED BY public.app01_interestgroup.id;


--
-- Name: app01_member; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_member (
    id integer NOT NULL,
    mobile_no character varying(64) NOT NULL,
    registration_date timestamp with time zone NOT NULL,
    username character varying(64) NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    last_purchase_date date,
    name character varying(64),
    points_bal double precision NOT NULL,
    dob date,
    telephone character varying(64),
    email character varying(254),
    membership_id integer NOT NULL,
    role_id integer NOT NULL,
    total_points double precision NOT NULL,
    race character varying(64)
);


ALTER TABLE public.app01_member OWNER TO cobra_user;

--
-- Name: app01_member_campaigntype; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_member_campaigntype (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    campaign_type_id integer NOT NULL,
    member_id integer NOT NULL
);


ALTER TABLE public.app01_member_campaigntype OWNER TO cobra_user;

--
-- Name: app01_member_campaigntype_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_member_campaigntype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_member_campaigntype_id_seq OWNER TO cobra_user;

--
-- Name: app01_member_campaigntype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_member_campaigntype_id_seq OWNED BY public.app01_member_campaigntype.id;


--
-- Name: app01_member_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_member_id_seq OWNER TO cobra_user;

--
-- Name: app01_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_member_id_seq OWNED BY public.app01_member.id;


--
-- Name: app01_member_interestGroups; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public."app01_member_interestGroups" (
    id integer NOT NULL,
    member_id integer NOT NULL,
    interestgroup_id integer NOT NULL
);


ALTER TABLE public."app01_member_interestGroups" OWNER TO cobra_user;

--
-- Name: app01_member_interestGroups_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public."app01_member_interestGroups_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."app01_member_interestGroups_id_seq" OWNER TO cobra_user;

--
-- Name: app01_member_interestGroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public."app01_member_interestGroups_id_seq" OWNED BY public."app01_member_interestGroups".id;


--
-- Name: app01_membership; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_membership (
    id integer NOT NULL,
    description character varying(128),
    start_points integer NOT NULL,
    renewal_points integer NOT NULL,
    complimentary_m_drink_points double precision,
    name character varying(64) NOT NULL,
    state smallint NOT NULL,
    CONSTRAINT app01_membership_state_check CHECK ((state >= 0))
);


ALTER TABLE public.app01_membership OWNER TO cobra_user;

--
-- Name: app01_membership_birthday_vouchers; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_membership_birthday_vouchers (
    id integer NOT NULL,
    membership_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.app01_membership_birthday_vouchers OWNER TO cobra_user;

--
-- Name: app01_membership_birthday_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_membership_birthday_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_membership_birthday_vouchers_id_seq OWNER TO cobra_user;

--
-- Name: app01_membership_birthday_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_membership_birthday_vouchers_id_seq OWNED BY public.app01_membership_birthday_vouchers.id;


--
-- Name: app01_membership_complimentary_vouchers; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_membership_complimentary_vouchers (
    id integer NOT NULL,
    membership_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.app01_membership_complimentary_vouchers OWNER TO cobra_user;

--
-- Name: app01_membership_complimentary_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_membership_complimentary_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_membership_complimentary_vouchers_id_seq OWNER TO cobra_user;

--
-- Name: app01_membership_complimentary_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_membership_complimentary_vouchers_id_seq OWNED BY public.app01_membership_complimentary_vouchers.id;


--
-- Name: app01_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_membership_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_membership_id_seq OWNER TO cobra_user;

--
-- Name: app01_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_membership_id_seq OWNED BY public.app01_membership.id;


--
-- Name: app01_membership_member; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_membership_member (
    id integer NOT NULL,
    effective_date timestamp with time zone NOT NULL,
    expiring_date timestamp with time zone NOT NULL,
    status smallint NOT NULL,
    member_id integer NOT NULL,
    membership_id integer NOT NULL,
    CONSTRAINT app01_membership_member_status_check CHECK ((status >= 0))
);


ALTER TABLE public.app01_membership_member OWNER TO cobra_user;

--
-- Name: app01_membership_member_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_membership_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_membership_member_id_seq OWNER TO cobra_user;

--
-- Name: app01_membership_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_membership_member_id_seq OWNED BY public.app01_membership_member.id;


--
-- Name: app01_occupation; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_occupation (
    id integer NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.app01_occupation OWNER TO cobra_user;

--
-- Name: app01_occupation_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_occupation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_occupation_id_seq OWNER TO cobra_user;

--
-- Name: app01_occupation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_occupation_id_seq OWNED BY public.app01_occupation.id;


--
-- Name: app01_outlet; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_outlet (
    id integer NOT NULL,
    outlet_name character varying(64) NOT NULL,
    outlet_code character varying(64) NOT NULL,
    outlet_manager character varying(64) NOT NULL,
    outlet_district character varying(64) NOT NULL,
    outlet_floor_area double precision NOT NULL,
    outlet_address character varying(64) NOT NULL
);


ALTER TABLE public.app01_outlet OWNER TO cobra_user;

--
-- Name: app01_outlet_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_outlet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_outlet_id_seq OWNER TO cobra_user;

--
-- Name: app01_outlet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_outlet_id_seq OWNED BY public.app01_outlet.id;


--
-- Name: app01_points_member; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_points_member (
    id integer NOT NULL,
    points_number double precision NOT NULL,
    method smallint NOT NULL,
    created timestamp with time zone NOT NULL,
    campaigntype_id integer,
    member_id integer NOT NULL,
    CONSTRAINT app01_points_member_method_check CHECK ((method >= 0))
);


ALTER TABLE public.app01_points_member OWNER TO cobra_user;

--
-- Name: app01_points_member_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_points_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_points_member_id_seq OWNER TO cobra_user;

--
-- Name: app01_points_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_points_member_id_seq OWNED BY public.app01_points_member.id;


--
-- Name: app01_product; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_product (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    description character varying(128),
    price double precision NOT NULL,
    tea_base character varying(32),
    item_code character varying(64) NOT NULL,
    created timestamp with time zone NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.app01_product OWNER TO cobra_user;

--
-- Name: app01_product_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_product_id_seq OWNER TO cobra_user;

--
-- Name: app01_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_product_id_seq OWNED BY public.app01_product.id;


--
-- Name: app01_rechargerecord; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_rechargerecord (
    id integer NOT NULL,
    money double precision NOT NULL,
    created timestamp with time zone NOT NULL,
    wallet_id integer NOT NULL
);


ALTER TABLE public.app01_rechargerecord OWNER TO cobra_user;

--
-- Name: app01_rechargerecord_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_rechargerecord_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_rechargerecord_id_seq OWNER TO cobra_user;

--
-- Name: app01_rechargerecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_rechargerecord_id_seq OWNED BY public.app01_rechargerecord.id;


--
-- Name: app01_role; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_role (
    id integer NOT NULL,
    name smallint NOT NULL,
    CONSTRAINT app01_role_name_check CHECK ((name >= 0))
);


ALTER TABLE public.app01_role OWNER TO cobra_user;

--
-- Name: app01_role_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_role_id_seq OWNER TO cobra_user;

--
-- Name: app01_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_role_id_seq OWNED BY public.app01_role.id;


--
-- Name: app01_token; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.app01_token OWNER TO cobra_user;

--
-- Name: app01_toppings; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_toppings (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    description character varying(128),
    price double precision NOT NULL
);


ALTER TABLE public.app01_toppings OWNER TO cobra_user;

--
-- Name: app01_toppings_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_toppings_id_seq OWNER TO cobra_user;

--
-- Name: app01_toppings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_toppings_id_seq OWNED BY public.app01_toppings.id;


--
-- Name: app01_transactdetails; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transactdetails (
    id integer NOT NULL,
    remark character varying(128),
    quantity integer NOT NULL,
    price double precision NOT NULL,
    method integer NOT NULL,
    sweetness integer,
    size integer NOT NULL,
    ice_level integer,
    sugar_level integer,
    concentration integer,
    product_id integer NOT NULL,
    toppings_id integer,
    transaction_id integer NOT NULL
);


ALTER TABLE public.app01_transactdetails OWNER TO cobra_user;

--
-- Name: app01_transactdetails_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transactdetails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transactdetails_id_seq OWNER TO cobra_user;

--
-- Name: app01_transactdetails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transactdetails_id_seq OWNED BY public.app01_transactdetails.id;


--
-- Name: app01_transaction; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transaction (
    id integer NOT NULL,
    reward_points double precision,
    redeemed_points double precision,
    ordering_modes smallint NOT NULL,
    payment_modes smallint NOT NULL,
    pos_no character varying(32),
    cashier_no character varying(32),
    receipt_no character varying(32) NOT NULL,
    transact_datetime timestamp with time zone NOT NULL,
    total_money double precision NOT NULL,
    remark character varying(64),
    member_id integer,
    outlet_id integer NOT NULL,
    CONSTRAINT app01_transaction_ordering_modes_check CHECK ((ordering_modes >= 0)),
    CONSTRAINT app01_transaction_payment_modes_check CHECK ((payment_modes >= 0))
);


ALTER TABLE public.app01_transaction OWNER TO cobra_user;

--
-- Name: app01_transaction_campaigns; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transaction_campaigns (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    campaign_id integer NOT NULL
);


ALTER TABLE public.app01_transaction_campaigns OWNER TO cobra_user;

--
-- Name: app01_transaction_campaigns_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transaction_campaigns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transaction_campaigns_id_seq OWNER TO cobra_user;

--
-- Name: app01_transaction_campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transaction_campaigns_id_seq OWNED BY public.app01_transaction_campaigns.id;


--
-- Name: app01_transaction_campaigntypes; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transaction_campaigntypes (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    campaigntype_id integer NOT NULL
);


ALTER TABLE public.app01_transaction_campaigntypes OWNER TO cobra_user;

--
-- Name: app01_transaction_campaigntypes_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transaction_campaigntypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transaction_campaigntypes_id_seq OWNER TO cobra_user;

--
-- Name: app01_transaction_campaigntypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transaction_campaigntypes_id_seq OWNED BY public.app01_transaction_campaigntypes.id;


--
-- Name: app01_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transaction_id_seq OWNER TO cobra_user;

--
-- Name: app01_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transaction_id_seq OWNED BY public.app01_transaction.id;


--
-- Name: app01_transaction_redeemed_vouchers; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transaction_redeemed_vouchers (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.app01_transaction_redeemed_vouchers OWNER TO cobra_user;

--
-- Name: app01_transaction_redeemed_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transaction_redeemed_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transaction_redeemed_vouchers_id_seq OWNER TO cobra_user;

--
-- Name: app01_transaction_redeemed_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transaction_redeemed_vouchers_id_seq OWNED BY public.app01_transaction_redeemed_vouchers.id;


--
-- Name: app01_transaction_reward_vouchers; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_transaction_reward_vouchers (
    id integer NOT NULL,
    transaction_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.app01_transaction_reward_vouchers OWNER TO cobra_user;

--
-- Name: app01_transaction_reward_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_transaction_reward_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_transaction_reward_vouchers_id_seq OWNER TO cobra_user;

--
-- Name: app01_transaction_reward_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_transaction_reward_vouchers_id_seq OWNED BY public.app01_transaction_reward_vouchers.id;


--
-- Name: app01_voucher; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    type smallint NOT NULL,
    description character varying(128),
    voucher_code character varying(32) NOT NULL,
    effective_date date NOT NULL,
    expiring_date date NOT NULL,
    redemption_points double precision NOT NULL,
    toppings_number integer,
    product_size smallint[],
    product_number integer,
    number_purchase integer,
    number_complimentary_drinks integer,
    state smallint NOT NULL,
    exclusive_new_members boolean NOT NULL,
    exclusive_non_members boolean NOT NULL,
    redemption_per integer,
    limit_first_redemption integer,
    other_limits smallint[],
    CONSTRAINT app01_voucher_state_check CHECK ((state >= 0)),
    CONSTRAINT app01_voucher_type_check CHECK ((type >= 0))
);


ALTER TABLE public.app01_voucher OWNER TO cobra_user;

--
-- Name: app01_voucher_discount_per_unparticipated_products; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_discount_per_unparticipated_products (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_discount_per_unparticipated_products OWNER TO cobra_user;

--
-- Name: app01_voucher_discount_per_unparticipated_products_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_discount_per_unparticipated_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_discount_per_unparticipated_products_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_discount_per_unparticipated_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_discount_per_unparticipated_products_id_seq OWNED BY public.app01_voucher_discount_per_unparticipated_products.id;


--
-- Name: app01_voucher_discount_price_unparticipated_products; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_discount_price_unparticipated_products (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_discount_price_unparticipated_products OWNER TO cobra_user;

--
-- Name: app01_voucher_discount_price_unparticipated_products_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_discount_price_unparticipated_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_discount_price_unparticipated_products_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_discount_price_unparticipated_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_discount_price_unparticipated_products_id_seq OWNED BY public.app01_voucher_discount_price_unparticipated_products.id;


--
-- Name: app01_voucher_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_id_seq OWNED BY public.app01_voucher.id;


--
-- Name: app01_voucher_limit_memberships; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_limit_memberships (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    membership_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_limit_memberships OWNER TO cobra_user;

--
-- Name: app01_voucher_limit_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_limit_memberships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_limit_memberships_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_limit_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_limit_memberships_id_seq OWNED BY public.app01_voucher_limit_memberships.id;


--
-- Name: app01_voucher_member; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_member (
    id integer NOT NULL,
    status smallint NOT NULL,
    created timestamp with time zone NOT NULL,
    member_id integer NOT NULL,
    voucher_id integer NOT NULL,
    CONSTRAINT app01_voucher_member_status_check CHECK ((status >= 0))
);


ALTER TABLE public.app01_voucher_member OWNER TO cobra_user;

--
-- Name: app01_voucher_member_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_member_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_member_id_seq OWNED BY public.app01_voucher_member.id;


--
-- Name: app01_voucher_redemption_products; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_redemption_products (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_redemption_products OWNER TO cobra_user;

--
-- Name: app01_voucher_redemption_products_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_redemption_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_redemption_products_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_redemption_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_redemption_products_id_seq OWNED BY public.app01_voucher_redemption_products.id;


--
-- Name: app01_voucher_redemption_toppings; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_redemption_toppings (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    toppings_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_redemption_toppings OWNER TO cobra_user;

--
-- Name: app01_voucher_redemption_toppings_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_redemption_toppings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_redemption_toppings_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_redemption_toppings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_redemption_toppings_id_seq OWNED BY public.app01_voucher_redemption_toppings.id;


--
-- Name: app01_voucher_size_upgrade_unparticipated_products; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_size_upgrade_unparticipated_products (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_size_upgrade_unparticipated_products OWNER TO cobra_user;

--
-- Name: app01_voucher_size_upgrade_unparticipated_products_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_size_upgrade_unparticipated_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_size_upgrade_unparticipated_products_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_size_upgrade_unparticipated_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_size_upgrade_unparticipated_products_id_seq OWNED BY public.app01_voucher_size_upgrade_unparticipated_products.id;


--
-- Name: app01_voucher_unparticipated_outlets; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_voucher_unparticipated_outlets (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    outlet_id integer NOT NULL
);


ALTER TABLE public.app01_voucher_unparticipated_outlets OWNER TO cobra_user;

--
-- Name: app01_voucher_unparticipated_outlets_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_voucher_unparticipated_outlets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_voucher_unparticipated_outlets_id_seq OWNER TO cobra_user;

--
-- Name: app01_voucher_unparticipated_outlets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_voucher_unparticipated_outlets_id_seq OWNED BY public.app01_voucher_unparticipated_outlets.id;


--
-- Name: app01_wallet; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.app01_wallet (
    id integer NOT NULL,
    balance double precision NOT NULL,
    created timestamp with time zone NOT NULL,
    lastest_top_up date,
    member_id integer NOT NULL
);


ALTER TABLE public.app01_wallet OWNER TO cobra_user;

--
-- Name: app01_wallet_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.app01_wallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app01_wallet_id_seq OWNER TO cobra_user;

--
-- Name: app01_wallet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.app01_wallet_id_seq OWNED BY public.app01_wallet.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO cobra_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO cobra_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO cobra_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO cobra_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO cobra_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO cobra_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO cobra_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO cobra_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO cobra_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO cobra_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO cobra_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: cobra_user
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO cobra_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cobra_user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: cobra_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO cobra_user;

--
-- Name: app01_campaign id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign ALTER COLUMN id SET DEFAULT nextval('public.app01_campaign_id_seq'::regclass);


--
-- Name: app01_campaign_memberships id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_memberships ALTER COLUMN id SET DEFAULT nextval('public.app01_campaign_memberships_id_seq'::regclass);


--
-- Name: app01_campaign_occupations id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_occupations ALTER COLUMN id SET DEFAULT nextval('public.app01_campaign_occupations_id_seq'::regclass);


--
-- Name: app01_campaign_outlets id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_outlets ALTER COLUMN id SET DEFAULT nextval('public.app01_campaign_outlets_id_seq'::regclass);


--
-- Name: app01_campaigncondition id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigncondition_id_seq'::regclass);


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_l_drinks_flavors ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq'::regclass);


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_m_drinks_flavors ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq'::regclass);


--
-- Name: app01_campaigncondition_every_purchase_products id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_products ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigncondition_every_purchase_products_id_seq'::regclass);


--
-- Name: app01_campaigntype id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigntype_id_seq'::regclass);


--
-- Name: app01_campaigntype_free_vouchers id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype_free_vouchers ALTER COLUMN id SET DEFAULT nextval('public.app01_campaigntype_free_vouchers_id_seq'::regclass);


--
-- Name: app01_card id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_card ALTER COLUMN id SET DEFAULT nextval('public.app01_card_id_seq'::regclass);


--
-- Name: app01_cart id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_cart ALTER COLUMN id SET DEFAULT nextval('public.app01_cart_id_seq'::regclass);


--
-- Name: app01_category id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_category ALTER COLUMN id SET DEFAULT nextval('public.app01_category_id_seq'::regclass);


--
-- Name: app01_evaluation id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_evaluation ALTER COLUMN id SET DEFAULT nextval('public.app01_evaluation_id_seq'::regclass);


--
-- Name: app01_interestgroup id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_interestgroup ALTER COLUMN id SET DEFAULT nextval('public.app01_interestgroup_id_seq'::regclass);


--
-- Name: app01_member id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member ALTER COLUMN id SET DEFAULT nextval('public.app01_member_id_seq'::regclass);


--
-- Name: app01_member_campaigntype id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member_campaigntype ALTER COLUMN id SET DEFAULT nextval('public.app01_member_campaigntype_id_seq'::regclass);


--
-- Name: app01_member_interestGroups id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public."app01_member_interestGroups" ALTER COLUMN id SET DEFAULT nextval('public."app01_member_interestGroups_id_seq"'::regclass);


--
-- Name: app01_membership id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership ALTER COLUMN id SET DEFAULT nextval('public.app01_membership_id_seq'::regclass);


--
-- Name: app01_membership_birthday_vouchers id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_birthday_vouchers ALTER COLUMN id SET DEFAULT nextval('public.app01_membership_birthday_vouchers_id_seq'::regclass);


--
-- Name: app01_membership_complimentary_vouchers id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_complimentary_vouchers ALTER COLUMN id SET DEFAULT nextval('public.app01_membership_complimentary_vouchers_id_seq'::regclass);


--
-- Name: app01_membership_member id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_member ALTER COLUMN id SET DEFAULT nextval('public.app01_membership_member_id_seq'::regclass);


--
-- Name: app01_occupation id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_occupation ALTER COLUMN id SET DEFAULT nextval('public.app01_occupation_id_seq'::regclass);


--
-- Name: app01_outlet id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_outlet ALTER COLUMN id SET DEFAULT nextval('public.app01_outlet_id_seq'::regclass);


--
-- Name: app01_points_member id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_points_member ALTER COLUMN id SET DEFAULT nextval('public.app01_points_member_id_seq'::regclass);


--
-- Name: app01_product id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_product ALTER COLUMN id SET DEFAULT nextval('public.app01_product_id_seq'::regclass);


--
-- Name: app01_rechargerecord id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_rechargerecord ALTER COLUMN id SET DEFAULT nextval('public.app01_rechargerecord_id_seq'::regclass);


--
-- Name: app01_role id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_role ALTER COLUMN id SET DEFAULT nextval('public.app01_role_id_seq'::regclass);


--
-- Name: app01_toppings id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_toppings ALTER COLUMN id SET DEFAULT nextval('public.app01_toppings_id_seq'::regclass);


--
-- Name: app01_transactdetails id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transactdetails ALTER COLUMN id SET DEFAULT nextval('public.app01_transactdetails_id_seq'::regclass);


--
-- Name: app01_transaction id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction ALTER COLUMN id SET DEFAULT nextval('public.app01_transaction_id_seq'::regclass);


--
-- Name: app01_transaction_campaigns id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigns ALTER COLUMN id SET DEFAULT nextval('public.app01_transaction_campaigns_id_seq'::regclass);


--
-- Name: app01_transaction_campaigntypes id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigntypes ALTER COLUMN id SET DEFAULT nextval('public.app01_transaction_campaigntypes_id_seq'::regclass);


--
-- Name: app01_transaction_redeemed_vouchers id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_redeemed_vouchers ALTER COLUMN id SET DEFAULT nextval('public.app01_transaction_redeemed_vouchers_id_seq'::regclass);


--
-- Name: app01_transaction_reward_vouchers id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_reward_vouchers ALTER COLUMN id SET DEFAULT nextval('public.app01_transaction_reward_vouchers_id_seq'::regclass);


--
-- Name: app01_voucher id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_id_seq'::regclass);


--
-- Name: app01_voucher_discount_per_unparticipated_products id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_per_unparticipated_products ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_discount_per_unparticipated_products_id_seq'::regclass);


--
-- Name: app01_voucher_discount_price_unparticipated_products id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_price_unparticipated_products ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_discount_price_unparticipated_products_id_seq'::regclass);


--
-- Name: app01_voucher_limit_memberships id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_limit_memberships ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_limit_memberships_id_seq'::regclass);


--
-- Name: app01_voucher_member id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_member ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_member_id_seq'::regclass);


--
-- Name: app01_voucher_redemption_products id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_products ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_redemption_products_id_seq'::regclass);


--
-- Name: app01_voucher_redemption_toppings id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_toppings ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_redemption_toppings_id_seq'::regclass);


--
-- Name: app01_voucher_size_upgrade_unparticipated_products id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_size_upgrade_unparticipated_products ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_size_upgrade_unparticipated_products_id_seq'::regclass);


--
-- Name: app01_voucher_unparticipated_outlets id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_unparticipated_outlets ALTER COLUMN id SET DEFAULT nextval('public.app01_voucher_unparticipated_outlets_id_seq'::regclass);


--
-- Name: app01_wallet id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_wallet ALTER COLUMN id SET DEFAULT nextval('public.app01_wallet_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: app01_campaign; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaign (id, name, description, gender, min_age, max_age, repetition_periods, days_of_month, effective_date, expiring_date, every_1_dollar_bouns_points, event_venue, state) FROM stdin;
2	test campaign2	\N	{0}	1	22	{0}	\N	2018-05-31	2019-05-31	\N	any	2
1	test campaign1	\N	{1}	1	22	{0}	\N	2018-01-01	2019-05-31	\N	any	2
\.


--
-- Data for Name: app01_campaign_memberships; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaign_memberships (id, campaign_id, membership_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	1
5	2	2
6	2	3
\.


--
-- Data for Name: app01_campaign_occupations; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaign_occupations (id, campaign_id, occupation_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_campaign_outlets; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaign_outlets (id, campaign_id, outlet_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_campaigncondition; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigncondition (id, every_spent, every_top_up, every_use_points, every_purchase_points, online_actions, every_customers, ordering_modes, payment_modes, other_actions, limit_redemption, campaign_id) FROM stdin;
1	10	1	12	12	\N	100	{0,1}	{0,1}	\N	\N	1
2	10	1	12	12	\N	100	{0,1}	{0,1}	\N	\N	1
\.


--
-- Data for Name: app01_campaigncondition_every_purchase_l_drinks_flavors; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigncondition_every_purchase_l_drinks_flavors (id, campaigncondition_id, product_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_campaigncondition_every_purchase_m_drinks_flavors; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigncondition_every_purchase_m_drinks_flavors (id, campaigncondition_id, product_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_campaigncondition_every_purchase_products; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigncondition_every_purchase_products (id, campaigncondition_id, product_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_campaigntype; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigntype (id, first_discount_per, last_discount_per, first_discount_price, last_discount_price, bouns_points, top_up_money, campaign_id, campaign_condition_id, upgrade_membership_id) FROM stdin;
1	0.20000000000000001	\N	\N	11	1	100	1	1	\N
2	0.20000000000000001	\N	\N	11	1	100	1	2	1
\.


--
-- Data for Name: app01_campaigntype_free_vouchers; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_campaigntype_free_vouchers (id, campaigntype_id, voucher_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: app01_card; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_card (id, card_no, printed_name, membership_type_code, membership_status_code, membership_photo, issue_date, effective_date, expiry_date, printed, printed_date, renewed_date, tmp_effective_date, tmp_expiry_date, tmp_membership_status_code, points_bal, total_points_bal, holding_points, remarks, membership_discount, tier_code, tier_anniversary_start_date, tier_anniversary_end_date, loyalty_message, dollar_to_points_ratio, is_supplementary, is_burn_supplementary, relation_id, primary_card_no, primary_relation_id, primary_card_expiry_date, primary_card_effective_date, pts_holding_days, current_net_spent, pass_code, stored_value_balance, currency, last_visited_date, last_visited_outlet, points_to_next_tier, nett_to_next_tier, lucky_draw_conversion_pts_usage_type, lucky_draw_conversion_rate, spent_quota_increasement, spent_quota_increasement_expired_on, pickup_date, pickup_by, current_rcnett_spent, cmc_earned_points, crc_earned_points, current_tier_nett, current_tier_amt, bring_fwd_tier_nett, bring_fwd_tier_amt, bring_fwd_tier_expiry, bring_fwd_tier_start_date, extended_tier_anniversary_end_date, member_id) FROM stdin;
1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	\N	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N	\N	\N	0	0	\N	\N	0	\N	\N	\N	\N	0	\N	0	0	0	0	\N	\N	\N	1
2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	0	0	\N	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	0	\N	0	\N	\N	\N	0	0	\N	\N	0	\N	\N	\N	\N	0	\N	0	0	0	0	\N	\N	\N	2
\.


--
-- Data for Name: app01_cart; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_cart (id, quantity, price, created, updated, status, flavours, tea_base, sweetness, size, toppings, ice_level, sugar_level, concentration, is_new, member_id, product_id) FROM stdin;
\.


--
-- Data for Name: app01_category; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_category (id, name, category_code, description) FROM stdin;
1	test category1	001	\N
2	test category2	002	\N
3	test category3	003	\N
4	test category4	004	\N
5	test category5	005	\N
6	test category6	006	\N
7	test category7	007	\N
\.


--
-- Data for Name: app01_evaluation; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_evaluation (id, service_content, service_satisfaction, product_quality_content, product_quality_satisfaction, created, transaction_id) FROM stdin;
1	nice	8	good	8	2018-07-06 15:24:46.114+08	1
2	nice	7	good	7	2018-07-06 15:34:57.762+08	2
3	nice	6	good	6	2018-07-06 15:38:23.075+08	3
4	nice	7	good	7	2018-07-06 15:39:19.444+08	4
\.


--
-- Data for Name: app01_interestgroup; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_interestgroup (id, name) FROM stdin;
1	Dancing
2	Dancing2
\.


--
-- Data for Name: app01_member; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_member (id, mobile_no, registration_date, username, password, last_login, last_purchase_date, name, points_bal, dob, telephone, email, membership_id, role_id, total_points, race) FROM stdin;
10	a3	2018-07-08 18:25:12.288+08	a3	a3	\N	\N	member3	0	1990-08-01	a3	a3@simple.com	1	3	0	\N
11	a4	2018-07-08 18:25:12.288+08	a4	pbkdf2_sha256$100000$WbCu34BAXRmu$E3fe/OZbEsSU2+HdoOjK4t62sonyFeHRkLkRrtPj2i8=	\N	\N	member4	0	1990-08-01	a4	a4@simple.com	1	3	0	\N
12	123	2018-07-08 12:37:28.095+08	123	pbkdf2_sha256$100000$FX1UG6rOkv1e$0POefnLnDNVx5iDYnXImnljyZ1jPWfv8aSwmkNwkyB8=	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
13	1234	2018-07-09 10:40:59.749+08	1234	pbkdf2_sha256$100000$RUav7xjsYb3X$976BlyA6+KE44amuJSmSqW01OMhXNSdjbdRUU96otlE=	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
14	a5	2018-07-08 18:25:12.288+08	a5	pbkdf2_sha256$100000$BBtziptvm2GP$FgSStei7UFKs8R0KLlGi1vNsoyCIGSuO080ztLfC3CU=	\N	\N	member4	0	1990-08-01	a4	a4@simple.com	1	3	0	\N
15	a6	2018-07-08 18:25:12.288+08	a6	pbkdf2_sha256$100000$vSlKPRixP7Q8$cd/V7TBA4IomAA2AiyTOTJGveD5ESRsr76jaNcWhHvg=	\N	\N	member4	0	1990-08-01	a4	a4@simple.com	1	3	0	\N
16	11	2018-07-10 19:03:43.828573+08	11	pbkdf2_sha256$100000$xiWadqFHhyge$gq/OBcVloT1ACwqi4vjFsbxYDrD05LiBoTrnU8rn5K8=	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
36	11222	2018-07-13 17:17:47.35151+08	11222	pbkdf2_sha256$100000$k4SToktht215$1v/kEDewfryRSu9BY9m+OBi9OSihIhi+pG3wpu1Sa7s=	\N	\N	\N	0	1990-01-01	\N	\N	1	3	0	\N
2	pos	2018-06-01 00:00:00+08	pos	root1234	\N	2018-07-19	\N	105	\N	\N	\N	2	2	125	\N
1	root	2018-06-01 00:00:00+08	root	root1234	\N	\N	\N	4	\N	\N	\N	1	1	20	\N
3	member01	2018-06-01 00:00:00+08	member01	root1234	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
4	app	2018-06-01 00:00:00+08	app	root1234	\N	\N	\N	0	\N	\N	\N	1	5	0	\N
5	1	2018-06-28 18:25:12.288+08	1	pbkdf2_sha256$100000$li6rb36QHjwa$jfVBP6IdU6F2vJvm9962TnOuaaR2MOKsgcK4w7N+cfQ=	\N	\N	\N	6	\N	\N	a@simple.com	1	3	0	\N
6	12	2018-07-05 18:48:48.351+08	12	pbkdf2_sha256$100000$RZA4m6un6Fzy$7+IyNu1Q51dKWZHH4OCI7se7/mjo+tM/iwNPNcg3ooM=	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
7	122	2018-07-05 18:49:17.687+08	122	pbkdf2_sha256$100000$0wDRHlNs1P0H$EDHMbjUqytQDNBAImwsVJAFsdxq6mte1VUn0SIxD3Z8=	\N	\N	\N	0	\N	\N	\N	1	3	0	\N
8	a1	2018-06-28 18:25:12.288+08	a1	pbkdf2_sha256$100000$A3iFDPRmMj97$61g8j5bYBLFlQ/Vo/TPxxMx6+lSMW168Vd2Ag40R3ZQ=	\N	\N	member1	200	1990-07-01	a1	a1@simple.com	3	3	200	\N
9	a2	2018-07-08 18:25:12.288+08	a2	pbkdf2_sha256$100000$KxHgOZFRkDd4$UulON04rWLFaV3cdV4o0KKNFmjrpOjc40mCGe0x2SPA=	\N	\N	member2	0	1990-08-01	a2	a2@simple.com	1	3	0	\N
34	112	2018-07-13 17:11:00.738037+08	112	pbkdf2_sha256$100000$bGFi3yb10OSK$mV4TQpzSP7lqAkANB2yogjOcfSTzsJjabE5y9PuG8o0=	\N	\N	\N	0	1990-01-01	\N	\N	1	3	0	\N
35	1122	2018-07-13 17:11:44.508569+08	1122	pbkdf2_sha256$100000$w6yTSfFFVfPw$kiSkCJl2jcCWweKoJx5Q0iGzU7QmLvtVOdQCLVglyEU=	\N	\N	\N	0	1990-01-01	\N	\N	1	3	0	\N
\.


--
-- Data for Name: app01_member_campaigntype; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_member_campaigntype (id, created, campaign_type_id, member_id) FROM stdin;
1	2018-07-06 15:24:28.039+08	1	1
2	2018-07-06 15:25:22.824+08	1	1
3	2018-07-06 15:37:20.339+08	1	1
4	2018-07-06 15:38:57.516+08	1	1
5	2018-07-06 16:10:07.78+08	1	2
6	2018-07-07 13:15:23.903+08	1	2
7	2018-07-07 13:47:24.783+08	1	8
8	2018-07-07 13:49:30.821+08	1	8
9	2018-07-07 14:57:43.394+08	1	2
10	2018-07-07 20:00:42.321+08	1	2
11	2018-07-07 21:01:25.53+08	1	2
12	2018-07-12 16:50:51.977065+08	1	2
\.


--
-- Data for Name: app01_member_interestGroups; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public."app01_member_interestGroups" (id, member_id, interestgroup_id) FROM stdin;
2	5	1
3	8	1
6	9	1
7	9	2
8	11	1
9	11	2
10	14	1
11	14	2
12	15	1
13	15	2
\.


--
-- Data for Name: app01_membership; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_membership (id, description, start_points, renewal_points, complimentary_m_drink_points, name, state) FROM stdin;
1	\N	0	0	\N	W	1
2	\N	40	40	40	C	1
3	\N	200	200	35	P	1
\.


--
-- Data for Name: app01_membership_birthday_vouchers; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_membership_birthday_vouchers (id, membership_id, voucher_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_membership_complimentary_vouchers; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_membership_complimentary_vouchers (id, membership_id, voucher_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_membership_member; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_membership_member (id, effective_date, expiring_date, status, member_id, membership_id) FROM stdin;
1	2018-07-05 17:21:47.433+08	2019-07-05 17:21:47.433+08	0	5	1
2	2018-07-06 16:10:07.794+08	2019-07-06 16:10:07.794+08	0	2	2
3	2018-07-07 13:46:53.473+08	2019-07-07 13:46:53.473+08	1	8	1
4	2018-07-07 13:47:24.792+08	2019-07-07 13:47:24.792+08	1	8	2
5	2018-07-07 13:49:30.833+08	2019-07-07 13:49:30.833+08	0	8	3
6	2018-07-07 16:15:19.866+08	2019-07-07 16:15:19.866+08	1	9	1
7	2018-07-07 16:16:52.198+08	2019-07-07 16:16:52.198+08	1	9	1
8	2018-07-07 16:17:12.075+08	2019-07-07 16:17:12.075+08	0	9	1
9	2018-07-07 16:30:39.462+08	2019-07-07 16:30:39.462+08	0	11	1
10	2018-07-09 18:58:57.064+08	2019-07-09 18:58:57.064+08	0	14	1
11	2018-07-09 18:59:29.96+08	2019-07-09 18:59:29.96+08	0	15	1
\.


--
-- Data for Name: app01_occupation; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_occupation (id, name) FROM stdin;
1	students
2	teachers
3	moms
4	dads
5	cleaners
6	nurses
\.


--
-- Data for Name: app01_outlet; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_outlet (id, outlet_name, outlet_code, outlet_manager, outlet_district, outlet_floor_area, outlet_address) FROM stdin;
1	test outlet1	test_outlet_code1	jack1	district1	101	address1
2	test outlet2	test_outlet_code2	jack2	district2	102	address2
\.


--
-- Data for Name: app01_points_member; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_points_member (id, points_number, method, created, campaigntype_id, member_id) FROM stdin;
22	5	2	2018-07-12 16:50:52.006143+08	1	2
23	-4	3	2018-07-12 16:50:52.025193+08	1	2
1	3	1	2018-07-05 17:29:22.608+08	\N	5
2	3	0	2018-07-05 17:29:22.621+08	\N	5
3	5	2	2018-07-06 15:24:28.062+08	1	1
4	-4	3	2018-07-06 15:24:28.076+08	1	1
5	5	2	2018-07-06 15:25:22.842+08	1	1
6	-4	3	2018-07-06 15:25:22.854+08	1	1
7	5	2	2018-07-06 15:37:20.358+08	1	1
8	-4	3	2018-07-06 15:37:20.369+08	1	1
9	5	2	2018-07-06 15:38:57.536+08	1	1
10	-4	3	2018-07-06 15:38:57.547+08	1	1
11	100	2	2018-07-06 16:10:07.783+08	1	2
12	5	2	2018-07-07 13:15:23.92+08	1	2
13	-4	3	2018-07-07 13:15:23.932+08	1	2
14	100	2	2018-07-07 13:47:24.784+08	1	8
15	100	2	2018-07-07 13:49:30.823+08	1	8
16	5	2	2018-07-07 14:57:43.412+08	1	2
17	-4	3	2018-07-07 14:57:43.424+08	1	2
18	5	2	2018-07-07 20:00:42.35+08	1	2
19	-4	3	2018-07-07 20:00:42.371+08	1	2
20	5	2	2018-07-07 21:01:25.551+08	1	2
21	-4	3	2018-07-07 21:01:25.563+08	1	2
\.


--
-- Data for Name: app01_product; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_product (id, name, description, price, tea_base, item_code, created, category_id) FROM stdin;
1	test product1	\N	11.109999999999999	\N	001	2018-06-01 00:00:00+08	1
2	test product2	\N	11.109999999999999	\N	002	2018-06-01 00:00:00+08	2
3	test product3	\N	11.109999999999999	\N	003	2018-06-01 00:00:00+08	3
4	test product4	\N	22.109999999999999	\N	004	2018-06-01 00:00:00+08	4
5	test product5	\N	33.109999999999999	\N	005	2018-06-01 00:00:00+08	5
6	test product6	\N	44.109999999999999	green tea	006	2018-06-01 00:00:00+08	6
7	test product7	\N	55.109999999999999	green tea	007	2018-06-01 00:00:00+08	7
\.


--
-- Data for Name: app01_rechargerecord; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_rechargerecord (id, money, created, wallet_id) FROM stdin;
1	100	2018-07-05 17:30:25.795+08	1
2	100	2018-07-06 16:07:52.189+08	2
3	100	2018-07-06 16:10:07.644+08	2
4	100	2018-07-07 13:47:24.762+08	8
5	100	2018-07-07 13:49:30.796+08	8
\.


--
-- Data for Name: app01_role; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_role (id, name) FROM stdin;
1	0
2	1
3	2
4	3
5	4
\.


--
-- Data for Name: app01_token; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_token (key, created, user_id) FROM stdin;
11e1a2bcbcc71e59b2770d5827fb104ada626ba4	2018-07-10 10:34:02.758+08	5
1336161b67b86cf40faa3a86f8cb6b9e32dca5e3	2018-06-01 00:00:00+08	3
24d78689b7fc97e6721bdc4ea0c6cdd725b2ce87	2018-07-10 10:34:02.77+08	6
3c9964967d799822b1022b3cbf4eb71889dcc795	2018-07-10 10:34:02.667+08	9
4993b1aaf6843468c679130c21fd8f8434e818c6	2018-07-10 10:34:02.685+08	10
62c366bacc6365c035fad818d2a77be51097e95d	2018-06-01 00:00:00+08	2
6c184f9c121c117a999b8f060c8f154e0af450fd	2018-06-01 00:00:00+08	4
9172aaade5e40df9fbd7de84dfe423340773d49a	2018-07-10 10:34:02.788+08	8
a03d19021b55117cdb4bd2b51074f8d9aad6d982	2018-07-10 10:34:02.728+08	14
b5abf2dca635fe5a6a0b3cad84d819e1f796eb9a	2018-07-10 10:34:02.71+08	12
c53696067160e320e972ee2f0041d992bffdbc3e	2018-07-10 10:34:02.695+08	11
ce1ec64a4e5476a7828b3c64f6cf34bb0c86f53c	2018-07-10 10:34:02.779+08	7
e0189ef86b801a6c166d5fdd3a99533f0d2b75ad	2018-07-10 10:34:02.719+08	13
e7d675a740d19d0bd62be6ddc116c7cd71020941	2018-07-10 10:34:02.739+08	15
fa3c5db850ada70422a02e4638984dc08822f010	2018-06-01 00:00:00+08	1
\.


--
-- Data for Name: app01_toppings; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_toppings (id, name, description, price) FROM stdin;
1	test toppings1	\N	11.109999999999999
2	test toppings3	\N	11.109999999999999
\.


--
-- Data for Name: app01_transactdetails; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transactdetails (id, remark, quantity, price, method, sweetness, size, ice_level, sugar_level, concentration, product_id, toppings_id, transaction_id) FROM stdin;
18	\N	2	55.109999999999999	1	1	1	1	1	1	7	1	1
19	\N	10	55.109999999999999	1	1	1	1	1	1	7	1	1
1	\N	2	11.109999999999999	1	0	0	0	0	0	1	2	1
2	\N	2	11.109999999999999	1	0	0	0	0	0	1	2	2
3	\N	2	11.109999999999999	1	0	0	0	0	0	2	2	1
4	\N	2	11.109999999999999	1	0	0	0	0	0	3	2	1
5	\N	2	11.109999999999999	1	0	0	0	0	0	1	2	1
6	\N	2	11.109999999999999	1	0	0	0	0	0	1	2	2
7	\N	2	11.109999999999999	1	0	0	0	0	0	4	2	2
8	\N	2	22.109999999999999	1	0	0	0	0	0	4	2	2
9	\N	2	33.109999999999999	1	0	0	0	0	0	5	2	2
10	\N	2	44.109999999999999	1	1	1	1	1	1	6	2	2
11	\N	2	44.109999999999999	1	1	1	1	1	1	6	2	5
12	\N	2	44.109999999999999	1	1	1	1	1	1	6	2	5
13	\N	2	55.109999999999999	1	1	1	1	1	1	7	2	5
14	\N	2	55.109999999999999	1	1	1	1	1	1	7	1	5
15	\N	2	55.109999999999999	1	1	1	1	1	1	7	1	5
16	\N	2	55.109999999999999	1	1	1	1	1	1	7	1	5
17	\N	2	55.109999999999999	1	1	1	1	1	1	7	1	8
\.


--
-- Data for Name: app01_transaction; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transaction (id, reward_points, redeemed_points, ordering_modes, payment_modes, pos_no, cashier_no, receipt_no, transact_datetime, total_money, remark, member_id, outlet_id) FROM stdin;
1	5	4	0	1	0001	0001	0001	2018-07-02 12:00:00+08	11	\N	1	2
2	5	4	0	1	0001	0001	0001	2018-07-02 12:00:00+08	11	\N	1	1
3	5	4	0	1	0001	0001	0001	2018-07-02 12:00:00+08	11	\N	1	1
4	5	4	0	1	0001	0001	0001	2018-07-02 12:00:00+08	11	\N	1	2
5	5	4	0	1	0001	0001	0001	2018-07-07 12:00:00+08	11	\N	2	1
6	5	4	0	1	0001	0001	0001	2018-07-07 12:00:00+08	11	\N	2	1
7	5	4	0	1	0001	0001	0001	2018-07-07 12:00:00+08	11	\N	2	1
8	5	4	0	1	0001	0001	0001	2018-07-19 12:00:00+08	11	\N	2	1
9	5	4	0	1	0001	0001	0001	2018-07-19 12:00:00+08	11	\N	2	2
\.


--
-- Data for Name: app01_transaction_campaigns; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transaction_campaigns (id, transaction_id, campaign_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	2
9	9	1
\.


--
-- Data for Name: app01_transaction_campaigntypes; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transaction_campaigntypes (id, transaction_id, campaigntype_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
\.


--
-- Data for Name: app01_transaction_redeemed_vouchers; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transaction_redeemed_vouchers (id, transaction_id, voucher_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
\.


--
-- Data for Name: app01_transaction_reward_vouchers; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_transaction_reward_vouchers (id, transaction_id, voucher_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	4	1
5	5	1
6	6	1
7	7	1
8	8	1
9	9	1
\.


--
-- Data for Name: app01_voucher; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher (id, name, type, description, voucher_code, effective_date, expiring_date, redemption_points, toppings_number, product_size, product_number, number_purchase, number_complimentary_drinks, state, exclusive_new_members, exclusive_non_members, redemption_per, limit_first_redemption, other_limits) FROM stdin;
1	test voucher1	0	\N	mother's day-00001	2018-01-10	2019-11-11	10	1	{0}	1	1	1	2	f	f	10	10	{0,1}
4	Any one drink(M)-2018-07-14 11:21:05	0	\N	any_one_drink(M)-00002	2018-01-01	2099-01-01	9999	\N	{0}	1	\N	\N	2	f	f	\N	\N	\N
\.


--
-- Data for Name: app01_voucher_discount_per_unparticipated_products; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_discount_per_unparticipated_products (id, voucher_id, product_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_discount_price_unparticipated_products; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_discount_price_unparticipated_products (id, voucher_id, product_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_limit_memberships; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_limit_memberships (id, voucher_id, membership_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_member; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_member (id, status, created, member_id, voucher_id) FROM stdin;
1	1	2018-07-06 15:24:28.046+08	1	1
2	1	2018-07-06 15:25:22.83+08	1	1
3	1	2018-07-06 15:37:20.344+08	1	1
4	1	2018-07-06 15:38:57.522+08	1	1
5	1	2018-07-06 16:10:07.817+08	2	1
6	1	2018-07-07 13:15:23.909+08	2	1
7	0	2018-07-07 13:47:24.805+08	8	1
8	0	2018-07-07 13:49:30.851+08	8	1
9	1	2018-07-07 14:57:43.399+08	2	1
10	1	2018-07-07 20:00:42.331+08	2	1
12	0	2018-07-10 19:03:44.449223+08	16	1
13	0	2018-07-12 16:50:51.986089+08	2	1
11	1	2018-07-07 21:01:25.536+08	2	1
14	0	2018-07-13 17:11:00.931532+08	34	1
15	0	2018-07-13 17:11:44.802732+08	35	1
16	0	2018-07-13 17:17:47.553046+08	36	1
\.


--
-- Data for Name: app01_voucher_redemption_products; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_redemption_products (id, voucher_id, product_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_redemption_toppings; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_redemption_toppings (id, voucher_id, toppings_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_size_upgrade_unparticipated_products; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_size_upgrade_unparticipated_products (id, voucher_id, product_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_voucher_unparticipated_outlets; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_voucher_unparticipated_outlets (id, voucher_id, outlet_id) FROM stdin;
1	1	1
\.


--
-- Data for Name: app01_wallet; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.app01_wallet (id, balance, created, lastest_top_up, member_id) FROM stdin;
15	0	2018-07-10 10:34:48.354489+08	\N	10
1	100	2018-06-01 00:00:00+08	2018-07-05	1
2	100	2018-06-01 00:00:00+08	2018-07-06	2
3	0	2018-06-01 00:00:00+08	\N	3
4	0	2018-06-01 00:00:00+08	\N	4
5	0	2018-07-05 17:21:47.258+08	\N	5
6	0	2018-07-05 18:48:48.358+08	\N	6
7	0	2018-07-05 18:49:17.694+08	\N	7
8	200	2018-07-07 13:46:53.303+08	2018-07-07	8
9	0	2018-07-07 16:15:19.683+08	\N	9
10	0	2018-07-07 16:30:39.242+08	\N	11
11	0	2018-07-08 12:37:28.125+08	\N	12
12	0	2018-07-09 10:40:59.792+08	\N	13
13	0	2018-07-09 18:58:56.775+08	\N	14
14	0	2018-07-09 18:59:29.755+08	\N	15
16	0	2018-07-10 19:03:43.853641+08	\N	16
17	0	2018-07-13 17:11:00.752079+08	\N	34
18	0	2018-07-13 17:11:44.52762+08	\N	35
19	0	2018-07-13 17:17:47.363544+08	\N	36
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add permission	3	add_permission
8	Can change permission	3	change_permission
9	Can delete permission	3	delete_permission
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
35	Can change membership	12	change_membership
36	Can delete membership	12	delete_membership
37	Can add membership_ member	13	add_membership_member
38	Can change membership_ member	13	change_membership_member
39	Can delete membership_ member	13	delete_membership_member
40	Can add cart	14	add_cart
41	Can change cart	14	change_cart
42	Can delete cart	14	delete_cart
43	Can add product	15	add_product
44	Can change product	15	change_product
45	Can delete product	15	delete_product
46	Can add points_ member	16	add_points_member
47	Can change points_ member	16	change_points_member
48	Can delete points_ member	16	delete_points_member
49	Can add occupation	17	add_occupation
50	Can change occupation	17	change_occupation
51	Can delete occupation	17	delete_occupation
52	Can add member	18	add_member
53	Can change member	18	change_member
54	Can delete member	18	delete_member
55	Can add category	19	add_category
56	Can change category	19	change_category
78	Can delete voucher	26	delete_voucher
79	Can add campaign	27	add_campaign
80	Can change campaign	27	change_campaign
81	Can delete campaign	27	delete_campaign
82	Can add campaign type	28	add_campaigntype
83	Can change campaign type	28	change_campaigntype
84	Can delete campaign type	28	delete_campaigntype
85	Can add role	29	add_role
86	Can change role	29	change_role
87	Can delete role	29	delete_role
88	Can add Token	30	add_token
89	Can change Token	30	change_token
90	Can delete Token	30	delete_token
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add interest group	6	add_interestgroup
17	Can change interest group	6	change_interestgroup
18	Can delete interest group	6	delete_interestgroup
19	Can add member_ campaign type	7	add_member_campaigntype
20	Can change member_ campaign type	7	change_member_campaigntype
21	Can delete member_ campaign type	7	delete_member_campaigntype
22	Can add evaluation	8	add_evaluation
23	Can change evaluation	8	change_evaluation
24	Can delete evaluation	8	delete_evaluation
25	Can add recharge record	9	add_rechargerecord
26	Can change recharge record	9	change_rechargerecord
27	Can delete recharge record	9	delete_rechargerecord
28	Can add toppings	10	add_toppings
29	Can change toppings	10	change_toppings
30	Can delete toppings	10	delete_toppings
31	Can add transaction	11	add_transaction
32	Can change transaction	11	change_transaction
33	Can delete transaction	11	delete_transaction
34	Can add membership	12	add_membership
57	Can delete category	19	delete_category
58	Can add voucher_ member	20	add_voucher_member
59	Can change voucher_ member	20	change_voucher_member
60	Can delete voucher_ member	20	delete_voucher_member
61	Can add transact details	21	add_transactdetails
62	Can change transact details	21	change_transactdetails
63	Can delete transact details	21	delete_transactdetails
64	Can add campaign condition	22	add_campaigncondition
65	Can change campaign condition	22	change_campaigncondition
66	Can delete campaign condition	22	delete_campaigncondition
67	Can add card	23	add_card
68	Can change card	23	change_card
69	Can delete card	23	delete_card
70	Can add wallet	24	add_wallet
71	Can change wallet	24	change_wallet
72	Can delete wallet	24	delete_wallet
73	Can add outlet	25	add_outlet
74	Can change outlet	25	change_outlet
75	Can delete outlet	25	delete_outlet
76	Can add voucher	26	add_voucher
77	Can change voucher	26	change_voucher
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	contenttypes	contenttype
5	sessions	session
6	app01	interestgroup
7	app01	member_campaigntype
8	app01	evaluation
9	app01	rechargerecord
10	app01	toppings
11	app01	transaction
12	app01	membership
13	app01	membership_member
14	app01	cart
15	app01	product
16	app01	points_member
17	app01	occupation
18	app01	member
19	app01	category
20	app01	voucher_member
21	app01	transactdetails
22	app01	campaigncondition
23	app01	card
24	app01	wallet
25	app01	outlet
26	app01	voucher
27	app01	campaign
28	app01	campaigntype
29	app01	role
30	app01	token
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2018-07-05 17:18:14.725936+08
2	app01	0001_initial	2018-07-05 17:18:17.827001+08
3	admin	0001_initial	2018-07-05 17:18:17.93427+08
4	admin	0002_logentry_remove_auto_add	2018-07-05 17:18:17.983401+08
5	contenttypes	0002_remove_content_type_name	2018-07-05 17:18:18.07364+08
6	auth	0001_initial	2018-07-05 17:18:18.411017+08
7	auth	0002_alter_permission_name_max_length	2018-07-05 17:18:18.426032+08
8	auth	0003_alter_user_email_max_length	2018-07-05 17:18:18.439091+08
9	auth	0004_alter_user_username_opts	2018-07-05 17:18:18.451123+08
10	auth	0005_alter_user_last_login_null	2018-07-05 17:18:18.463154+08
11	auth	0006_require_contenttypes_0002	2018-07-05 17:18:18.469145+08
12	auth	0007_alter_validators_add_error_messages	2018-07-05 17:18:18.480775+08
13	auth	0008_alter_user_username_max_length	2018-07-05 17:18:18.492807+08
14	auth	0009_alter_user_last_name_max_length	2018-07-05 17:18:18.506845+08
15	sessions	0001_initial	2018-07-05 17:18:18.541782+08
16	app01	0002_auto_20180706_0917	2018-07-06 09:17:36.958139+08
17	app01	0003_member_total_points	2018-07-06 10:02:32.451081+08
18	app01	0004_member_race	2018-07-07 11:54:15.576084+08
19	app01	0005_auto_20180707_1513	2018-07-07 15:13:51.750461+08
20	app01	0006_auto_20180707_1534	2018-07-07 15:34:10.088224+08
21	app01	0007_auto_20180710_1008	2018-07-10 10:08:48.492033+08
22	app01	0008_auto_20180710_1028	2018-07-10 10:29:06.978385+08
23	app01	0009_auto_20180710_1031	2018-07-10 10:32:05.764916+08
24	app01	0010_auto_20180710_1532	2018-07-10 15:32:21.637424+08
25	app01	0011_auto_20180714_1120	2018-07-14 11:20:36.173284+08
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: cobra_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Name: app01_campaign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaign_id_seq', 2, true);


--
-- Name: app01_campaign_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaign_memberships_id_seq', 6, true);


--
-- Name: app01_campaign_occupations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaign_occupations_id_seq', 2, true);


--
-- Name: app01_campaign_outlets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaign_outlets_id_seq', 2, true);


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigncondition_every_purchase_l_drinks_flavors_id_seq', 2, true);


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigncondition_every_purchase_m_drinks_flavors_id_seq', 2, true);


--
-- Name: app01_campaigncondition_every_purchase_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigncondition_every_purchase_products_id_seq', 2, true);


--
-- Name: app01_campaigncondition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigncondition_id_seq', 2, true);


--
-- Name: app01_campaigntype_free_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigntype_free_vouchers_id_seq', 2, true);


--
-- Name: app01_campaigntype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_campaigntype_id_seq', 2, true);


--
-- Name: app01_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_card_id_seq', 2, true);


--
-- Name: app01_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_cart_id_seq', 1, false);


--
-- Name: app01_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_category_id_seq', 7, true);


--
-- Name: app01_evaluation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_evaluation_id_seq', 4, true);


--
-- Name: app01_interestgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_interestgroup_id_seq', 2, true);


--
-- Name: app01_member_campaigntype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_member_campaigntype_id_seq', 12, true);


--
-- Name: app01_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_member_id_seq', 36, true);


--
-- Name: app01_member_interestGroups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public."app01_member_interestGroups_id_seq"', 13, true);


--
-- Name: app01_membership_birthday_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_membership_birthday_vouchers_id_seq', 1, true);


--
-- Name: app01_membership_complimentary_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_membership_complimentary_vouchers_id_seq', 1, true);


--
-- Name: app01_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_membership_id_seq', 3, true);


--
-- Name: app01_membership_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_membership_member_id_seq', 11, true);


--
-- Name: app01_occupation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_occupation_id_seq', 6, true);


--
-- Name: app01_outlet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_outlet_id_seq', 2, true);


--
-- Name: app01_points_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_points_member_id_seq', 23, true);


--
-- Name: app01_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_product_id_seq', 7, true);


--
-- Name: app01_rechargerecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_rechargerecord_id_seq', 5, true);


--
-- Name: app01_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_role_id_seq', 5, true);


--
-- Name: app01_toppings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_toppings_id_seq', 2, true);


--
-- Name: app01_transactdetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transactdetails_id_seq', 19, true);


--
-- Name: app01_transaction_campaigns_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transaction_campaigns_id_seq', 9, true);


--
-- Name: app01_transaction_campaigntypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transaction_campaigntypes_id_seq', 9, true);


--
-- Name: app01_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transaction_id_seq', 9, true);


--
-- Name: app01_transaction_redeemed_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transaction_redeemed_vouchers_id_seq', 9, true);


--
-- Name: app01_transaction_reward_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_transaction_reward_vouchers_id_seq', 9, true);


--
-- Name: app01_voucher_discount_per_unparticipated_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_discount_per_unparticipated_products_id_seq', 1, true);


--
-- Name: app01_voucher_discount_price_unparticipated_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_discount_price_unparticipated_products_id_seq', 1, true);


--
-- Name: app01_voucher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_id_seq', 4, true);


--
-- Name: app01_voucher_limit_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_limit_memberships_id_seq', 1, true);


--
-- Name: app01_voucher_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_member_id_seq', 16, true);


--
-- Name: app01_voucher_redemption_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_redemption_products_id_seq', 15, true);


--
-- Name: app01_voucher_redemption_toppings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_redemption_toppings_id_seq', 1, true);


--
-- Name: app01_voucher_size_upgrade_unparticipated_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_size_upgrade_unparticipated_products_id_seq', 1, true);


--
-- Name: app01_voucher_unparticipated_outlets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_voucher_unparticipated_outlets_id_seq', 1, true);


--
-- Name: app01_wallet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.app01_wallet_id_seq', 19, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 90, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 30, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cobra_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 25, true);


--
-- Name: app01_campaign_memberships app01_campaign_membershi_campaign_id_membership_i_e60b7f7b_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_memberships
    ADD CONSTRAINT app01_campaign_membershi_campaign_id_membership_i_e60b7f7b_uniq UNIQUE (campaign_id, membership_id);


--
-- Name: app01_campaign_memberships app01_campaign_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_memberships
    ADD CONSTRAINT app01_campaign_memberships_pkey PRIMARY KEY (id);


--
-- Name: app01_campaign_occupations app01_campaign_occupatio_campaign_id_occupation_i_c083fb0a_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_occupations
    ADD CONSTRAINT app01_campaign_occupatio_campaign_id_occupation_i_c083fb0a_uniq UNIQUE (campaign_id, occupation_id);


--
-- Name: app01_campaign_occupations app01_campaign_occupations_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_occupations
    ADD CONSTRAINT app01_campaign_occupations_pkey PRIMARY KEY (id);


--
-- Name: app01_campaign_outlets app01_campaign_outlets_campaign_id_outlet_id_93690f87_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_outlets
    ADD CONSTRAINT app01_campaign_outlets_campaign_id_outlet_id_93690f87_uniq UNIQUE (campaign_id, outlet_id);


--
-- Name: app01_campaign_outlets app01_campaign_outlets_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_outlets
    ADD CONSTRAINT app01_campaign_outlets_pkey PRIMARY KEY (id);


--
-- Name: app01_campaign app01_campaign_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign
    ADD CONSTRAINT app01_campaign_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigncondition_every_purchase_products app01_campaigncondition__campaigncondition_id_pro_836897b3_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_products
    ADD CONSTRAINT app01_campaigncondition__campaigncondition_id_pro_836897b3_uniq UNIQUE (campaigncondition_id, product_id);


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors app01_campaigncondition__campaigncondition_id_pro_db861642_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_m_drinks_flavors
    ADD CONSTRAINT app01_campaigncondition__campaigncondition_id_pro_db861642_uniq UNIQUE (campaigncondition_id, product_id);


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors app01_campaigncondition__campaigncondition_id_pro_f1d0bc52_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_l_drinks_flavors
    ADD CONSTRAINT app01_campaigncondition__campaigncondition_id_pro_f1d0bc52_uniq UNIQUE (campaigncondition_id, product_id);


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors app01_campaigncondition_every_purchase_l_drinks_flavors_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_l_drinks_flavors
    ADD CONSTRAINT app01_campaigncondition_every_purchase_l_drinks_flavors_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors app01_campaigncondition_every_purchase_m_drinks_flavors_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_m_drinks_flavors
    ADD CONSTRAINT app01_campaigncondition_every_purchase_m_drinks_flavors_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigncondition_every_purchase_products app01_campaigncondition_every_purchase_products_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_products
    ADD CONSTRAINT app01_campaigncondition_every_purchase_products_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigncondition app01_campaigncondition_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition
    ADD CONSTRAINT app01_campaigncondition_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigntype app01_campaigntype_campaign_condition_id_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype
    ADD CONSTRAINT app01_campaigntype_campaign_condition_id_key UNIQUE (campaign_condition_id);


--
-- Name: app01_campaigntype_free_vouchers app01_campaigntype_free__campaigntype_id_voucher__ace08c05_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype_free_vouchers
    ADD CONSTRAINT app01_campaigntype_free__campaigntype_id_voucher__ace08c05_uniq UNIQUE (campaigntype_id, voucher_id);


--
-- Name: app01_campaigntype_free_vouchers app01_campaigntype_free_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype_free_vouchers
    ADD CONSTRAINT app01_campaigntype_free_vouchers_pkey PRIMARY KEY (id);


--
-- Name: app01_campaigntype app01_campaigntype_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype
    ADD CONSTRAINT app01_campaigntype_pkey PRIMARY KEY (id);


--
-- Name: app01_card app01_card_card_no_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_card
    ADD CONSTRAINT app01_card_card_no_key UNIQUE (card_no);


--
-- Name: app01_card app01_card_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_card
    ADD CONSTRAINT app01_card_pkey PRIMARY KEY (id);


--
-- Name: app01_cart app01_cart_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_cart
    ADD CONSTRAINT app01_cart_pkey PRIMARY KEY (id);


--
-- Name: app01_category app01_category_category_code_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_category
    ADD CONSTRAINT app01_category_category_code_key UNIQUE (category_code);


--
-- Name: app01_category app01_category_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_category
    ADD CONSTRAINT app01_category_pkey PRIMARY KEY (id);


--
-- Name: app01_evaluation app01_evaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_evaluation
    ADD CONSTRAINT app01_evaluation_pkey PRIMARY KEY (id);


--
-- Name: app01_interestgroup app01_interestgroup_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_interestgroup
    ADD CONSTRAINT app01_interestgroup_name_key UNIQUE (name);


--
-- Name: app01_interestgroup app01_interestgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_interestgroup
    ADD CONSTRAINT app01_interestgroup_pkey PRIMARY KEY (id);


--
-- Name: app01_member_campaigntype app01_member_campaigntype_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member_campaigntype
    ADD CONSTRAINT app01_member_campaigntype_pkey PRIMARY KEY (id);


--
-- Name: app01_member_interestGroups app01_member_interestGroups_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public."app01_member_interestGroups"
    ADD CONSTRAINT "app01_member_interestGroups_pkey" PRIMARY KEY (id);


--
-- Name: app01_member_interestGroups app01_member_interestgro_member_id_interestgroup__6afbf61f_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public."app01_member_interestGroups"
    ADD CONSTRAINT app01_member_interestgro_member_id_interestgroup__6afbf61f_uniq UNIQUE (member_id, interestgroup_id);


--
-- Name: app01_member app01_member_mobile_no_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member
    ADD CONSTRAINT app01_member_mobile_no_key UNIQUE (mobile_no);


--
-- Name: app01_member app01_member_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member
    ADD CONSTRAINT app01_member_pkey PRIMARY KEY (id);


--
-- Name: app01_member app01_member_username_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member
    ADD CONSTRAINT app01_member_username_key UNIQUE (username);


--
-- Name: app01_membership_birthday_vouchers app01_membership_birthda_membership_id_voucher_id_fb351e92_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_birthday_vouchers
    ADD CONSTRAINT app01_membership_birthda_membership_id_voucher_id_fb351e92_uniq UNIQUE (membership_id, voucher_id);


--
-- Name: app01_membership_birthday_vouchers app01_membership_birthday_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_birthday_vouchers
    ADD CONSTRAINT app01_membership_birthday_vouchers_pkey PRIMARY KEY (id);


--
-- Name: app01_membership_complimentary_vouchers app01_membership_complim_membership_id_voucher_id_aea11cf1_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_complimentary_vouchers
    ADD CONSTRAINT app01_membership_complim_membership_id_voucher_id_aea11cf1_uniq UNIQUE (membership_id, voucher_id);


--
-- Name: app01_membership_complimentary_vouchers app01_membership_complimentary_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_complimentary_vouchers
    ADD CONSTRAINT app01_membership_complimentary_vouchers_pkey PRIMARY KEY (id);


--
-- Name: app01_membership_member app01_membership_member_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_member
    ADD CONSTRAINT app01_membership_member_pkey PRIMARY KEY (id);


--
-- Name: app01_membership app01_membership_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership
    ADD CONSTRAINT app01_membership_pkey PRIMARY KEY (id);


--
-- Name: app01_occupation app01_occupation_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_occupation
    ADD CONSTRAINT app01_occupation_name_key UNIQUE (name);


--
-- Name: app01_occupation app01_occupation_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_occupation
    ADD CONSTRAINT app01_occupation_pkey PRIMARY KEY (id);


--
-- Name: app01_outlet app01_outlet_outlet_code_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_outlet
    ADD CONSTRAINT app01_outlet_outlet_code_key UNIQUE (outlet_code);


--
-- Name: app01_outlet app01_outlet_outlet_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_outlet
    ADD CONSTRAINT app01_outlet_outlet_name_key UNIQUE (outlet_name);


--
-- Name: app01_outlet app01_outlet_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_outlet
    ADD CONSTRAINT app01_outlet_pkey PRIMARY KEY (id);


--
-- Name: app01_points_member app01_points_member_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_points_member
    ADD CONSTRAINT app01_points_member_pkey PRIMARY KEY (id);


--
-- Name: app01_product app01_product_item_code_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_product
    ADD CONSTRAINT app01_product_item_code_key UNIQUE (item_code);


--
-- Name: app01_product app01_product_name_f8e76520_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_product
    ADD CONSTRAINT app01_product_name_f8e76520_uniq UNIQUE (name);


--
-- Name: app01_product app01_product_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_product
    ADD CONSTRAINT app01_product_pkey PRIMARY KEY (id);


--
-- Name: app01_rechargerecord app01_rechargerecord_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_rechargerecord
    ADD CONSTRAINT app01_rechargerecord_pkey PRIMARY KEY (id);


--
-- Name: app01_role app01_role_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_role
    ADD CONSTRAINT app01_role_name_key UNIQUE (name);


--
-- Name: app01_role app01_role_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_role
    ADD CONSTRAINT app01_role_pkey PRIMARY KEY (id);


--
-- Name: app01_token app01_token_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_token
    ADD CONSTRAINT app01_token_pkey PRIMARY KEY (key);


--
-- Name: app01_token app01_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_token
    ADD CONSTRAINT app01_token_user_id_key UNIQUE (user_id);


--
-- Name: app01_toppings app01_toppings_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_toppings
    ADD CONSTRAINT app01_toppings_name_key UNIQUE (name);


--
-- Name: app01_toppings app01_toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_toppings
    ADD CONSTRAINT app01_toppings_pkey PRIMARY KEY (id);


--
-- Name: app01_transactdetails app01_transactdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transactdetails
    ADD CONSTRAINT app01_transactdetails_pkey PRIMARY KEY (id);


--
-- Name: app01_transaction_campaigns app01_transaction_campai_transaction_id_campaign__6bdadace_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigns
    ADD CONSTRAINT app01_transaction_campai_transaction_id_campaign__6bdadace_uniq UNIQUE (transaction_id, campaign_id);


--
-- Name: app01_transaction_campaigntypes app01_transaction_campai_transaction_id_campaignt_964a7fd6_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigntypes
    ADD CONSTRAINT app01_transaction_campai_transaction_id_campaignt_964a7fd6_uniq UNIQUE (transaction_id, campaigntype_id);


--
-- Name: app01_transaction_campaigns app01_transaction_campaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigns
    ADD CONSTRAINT app01_transaction_campaigns_pkey PRIMARY KEY (id);


--
-- Name: app01_transaction_campaigntypes app01_transaction_campaigntypes_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigntypes
    ADD CONSTRAINT app01_transaction_campaigntypes_pkey PRIMARY KEY (id);


--
-- Name: app01_transaction app01_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction
    ADD CONSTRAINT app01_transaction_pkey PRIMARY KEY (id);


--
-- Name: app01_transaction_redeemed_vouchers app01_transaction_redeem_transaction_id_voucher_i_cf83ad49_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_redeemed_vouchers
    ADD CONSTRAINT app01_transaction_redeem_transaction_id_voucher_i_cf83ad49_uniq UNIQUE (transaction_id, voucher_id);


--
-- Name: app01_transaction_redeemed_vouchers app01_transaction_redeemed_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_redeemed_vouchers
    ADD CONSTRAINT app01_transaction_redeemed_vouchers_pkey PRIMARY KEY (id);


--
-- Name: app01_transaction_reward_vouchers app01_transaction_reward_transaction_id_voucher_i_78f3c4b5_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_reward_vouchers
    ADD CONSTRAINT app01_transaction_reward_transaction_id_voucher_i_78f3c4b5_uniq UNIQUE (transaction_id, voucher_id);


--
-- Name: app01_transaction_reward_vouchers app01_transaction_reward_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_reward_vouchers
    ADD CONSTRAINT app01_transaction_reward_vouchers_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_discount_per_unparticipated_products app01_voucher_discount_p_voucher_id_product_id_53bd48ac_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_per_unparticipated_products
    ADD CONSTRAINT app01_voucher_discount_p_voucher_id_product_id_53bd48ac_uniq UNIQUE (voucher_id, product_id);


--
-- Name: app01_voucher_discount_price_unparticipated_products app01_voucher_discount_p_voucher_id_product_id_9b9e24ea_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_price_unparticipated_products
    ADD CONSTRAINT app01_voucher_discount_p_voucher_id_product_id_9b9e24ea_uniq UNIQUE (voucher_id, product_id);


--
-- Name: app01_voucher_discount_per_unparticipated_products app01_voucher_discount_per_unparticipated_products_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_per_unparticipated_products
    ADD CONSTRAINT app01_voucher_discount_per_unparticipated_products_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_discount_price_unparticipated_products app01_voucher_discount_price_unparticipated_products_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_price_unparticipated_products
    ADD CONSTRAINT app01_voucher_discount_price_unparticipated_products_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_limit_memberships app01_voucher_limit_memb_voucher_id_membership_id_d7f3f677_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_limit_memberships
    ADD CONSTRAINT app01_voucher_limit_memb_voucher_id_membership_id_d7f3f677_uniq UNIQUE (voucher_id, membership_id);


--
-- Name: app01_voucher_limit_memberships app01_voucher_limit_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_limit_memberships
    ADD CONSTRAINT app01_voucher_limit_memberships_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_member app01_voucher_member_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_member
    ADD CONSTRAINT app01_voucher_member_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher app01_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher
    ADD CONSTRAINT app01_voucher_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_redemption_products app01_voucher_redemption_products_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_products
    ADD CONSTRAINT app01_voucher_redemption_products_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_redemption_toppings app01_voucher_redemption_toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_toppings
    ADD CONSTRAINT app01_voucher_redemption_toppings_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_redemption_products app01_voucher_redemption_voucher_id_product_id_2a69d400_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_products
    ADD CONSTRAINT app01_voucher_redemption_voucher_id_product_id_2a69d400_uniq UNIQUE (voucher_id, product_id);


--
-- Name: app01_voucher_redemption_toppings app01_voucher_redemption_voucher_id_toppings_id_6d812274_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_toppings
    ADD CONSTRAINT app01_voucher_redemption_voucher_id_toppings_id_6d812274_uniq UNIQUE (voucher_id, toppings_id);


--
-- Name: app01_voucher_size_upgrade_unparticipated_products app01_voucher_size_upgra_voucher_id_product_id_c8e93778_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_size_upgrade_unparticipated_products
    ADD CONSTRAINT app01_voucher_size_upgra_voucher_id_product_id_c8e93778_uniq UNIQUE (voucher_id, product_id);


--
-- Name: app01_voucher_size_upgrade_unparticipated_products app01_voucher_size_upgrade_unparticipated_products_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_size_upgrade_unparticipated_products
    ADD CONSTRAINT app01_voucher_size_upgrade_unparticipated_products_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher_unparticipated_outlets app01_voucher_unparticip_voucher_id_outlet_id_1658769a_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_unparticipated_outlets
    ADD CONSTRAINT app01_voucher_unparticip_voucher_id_outlet_id_1658769a_uniq UNIQUE (voucher_id, outlet_id);


--
-- Name: app01_voucher_unparticipated_outlets app01_voucher_unparticipated_outlets_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_unparticipated_outlets
    ADD CONSTRAINT app01_voucher_unparticipated_outlets_pkey PRIMARY KEY (id);


--
-- Name: app01_voucher app01_voucher_voucher_code_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher
    ADD CONSTRAINT app01_voucher_voucher_code_key UNIQUE (voucher_code);


--
-- Name: app01_wallet app01_wallet_member_id_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_wallet
    ADD CONSTRAINT app01_wallet_member_id_key UNIQUE (member_id);


--
-- Name: app01_wallet app01_wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_wallet
    ADD CONSTRAINT app01_wallet_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: app01_campaign_memberships_campaign_id_c5f0b81b; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_memberships_campaign_id_c5f0b81b ON public.app01_campaign_memberships USING btree (campaign_id);


--
-- Name: app01_campaign_memberships_membership_id_4f4479e9; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_memberships_membership_id_4f4479e9 ON public.app01_campaign_memberships USING btree (membership_id);


--
-- Name: app01_campaign_occupations_campaign_id_e373a508; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_occupations_campaign_id_e373a508 ON public.app01_campaign_occupations USING btree (campaign_id);


--
-- Name: app01_campaign_occupations_occupation_id_bfd384a5; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_occupations_occupation_id_bfd384a5 ON public.app01_campaign_occupations USING btree (occupation_id);


--
-- Name: app01_campaign_outlets_campaign_id_3934336a; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_outlets_campaign_id_3934336a ON public.app01_campaign_outlets USING btree (campaign_id);


--
-- Name: app01_campaign_outlets_outlet_id_361767a4; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaign_outlets_outlet_id_361767a4 ON public.app01_campaign_outlets USING btree (outlet_id);


--
-- Name: app01_campaigncondition_campaign_id_bbbbba79; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_campaign_id_bbbbba79 ON public.app01_campaigncondition USING btree (campaign_id);


--
-- Name: app01_campaigncondition_ev_campaigncondition_id_3c0ed59f; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_campaigncondition_id_3c0ed59f ON public.app01_campaigncondition_every_purchase_products USING btree (campaigncondition_id);


--
-- Name: app01_campaigncondition_ev_campaigncondition_id_5db74679; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_campaigncondition_id_5db74679 ON public.app01_campaigncondition_every_purchase_l_drinks_flavors USING btree (campaigncondition_id);


--
-- Name: app01_campaigncondition_ev_campaigncondition_id_c30c8b88; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_campaigncondition_id_c30c8b88 ON public.app01_campaigncondition_every_purchase_m_drinks_flavors USING btree (campaigncondition_id);


--
-- Name: app01_campaigncondition_ev_product_id_1401ae63; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_product_id_1401ae63 ON public.app01_campaigncondition_every_purchase_l_drinks_flavors USING btree (product_id);


--
-- Name: app01_campaigncondition_ev_product_id_7895a45a; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_product_id_7895a45a ON public.app01_campaigncondition_every_purchase_m_drinks_flavors USING btree (product_id);


--
-- Name: app01_campaigncondition_ev_product_id_c2eaa50e; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigncondition_ev_product_id_c2eaa50e ON public.app01_campaigncondition_every_purchase_products USING btree (product_id);


--
-- Name: app01_campaigntype_campaign_id_3c8b7cfe; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigntype_campaign_id_3c8b7cfe ON public.app01_campaigntype USING btree (campaign_id);


--
-- Name: app01_campaigntype_free_vouchers_campaigntype_id_1e42e6e1; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigntype_free_vouchers_campaigntype_id_1e42e6e1 ON public.app01_campaigntype_free_vouchers USING btree (campaigntype_id);


--
-- Name: app01_campaigntype_free_vouchers_voucher_id_df0cd070; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigntype_free_vouchers_voucher_id_df0cd070 ON public.app01_campaigntype_free_vouchers USING btree (voucher_id);


--
-- Name: app01_campaigntype_upgrade_membership_id_41945661; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_campaigntype_upgrade_membership_id_41945661 ON public.app01_campaigntype USING btree (upgrade_membership_id);


--
-- Name: app01_card_card_no_7f431ef9_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_card_card_no_7f431ef9_like ON public.app01_card USING btree (card_no varchar_pattern_ops);


--
-- Name: app01_card_member_id_230780be; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_card_member_id_230780be ON public.app01_card USING btree (member_id);


--
-- Name: app01_cart_member_id_357e42fa; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_cart_member_id_357e42fa ON public.app01_cart USING btree (member_id);


--
-- Name: app01_cart_product_id_d5274713; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_cart_product_id_d5274713 ON public.app01_cart USING btree (product_id);


--
-- Name: app01_category_category_code_769f08bc_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_category_category_code_769f08bc_like ON public.app01_category USING btree (category_code varchar_pattern_ops);


--
-- Name: app01_evaluation_transaction_id_911f3e74; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_evaluation_transaction_id_911f3e74 ON public.app01_evaluation USING btree (transaction_id);


--
-- Name: app01_interestgroup_name_5940208a_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_interestgroup_name_5940208a_like ON public.app01_interestgroup USING btree (name varchar_pattern_ops);


--
-- Name: app01_member_campaigntype_campaign_type_id_39ba65cd; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_campaigntype_campaign_type_id_39ba65cd ON public.app01_member_campaigntype USING btree (campaign_type_id);


--
-- Name: app01_member_campaigntype_member_id_184cb185; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_campaigntype_member_id_184cb185 ON public.app01_member_campaigntype USING btree (member_id);


--
-- Name: app01_member_interestGroups_interestgroup_id_5245dd12; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX "app01_member_interestGroups_interestgroup_id_5245dd12" ON public."app01_member_interestGroups" USING btree (interestgroup_id);


--
-- Name: app01_member_interestGroups_member_id_8a7dab2a; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX "app01_member_interestGroups_member_id_8a7dab2a" ON public."app01_member_interestGroups" USING btree (member_id);


--
-- Name: app01_member_membership_id_fae4c9da; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_membership_id_fae4c9da ON public.app01_member USING btree (membership_id);


--
-- Name: app01_member_mobile_no_0c0e16b3_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_mobile_no_0c0e16b3_like ON public.app01_member USING btree (mobile_no varchar_pattern_ops);


--
-- Name: app01_member_role_id_d90d6d32; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_role_id_d90d6d32 ON public.app01_member USING btree (role_id);


--
-- Name: app01_member_username_706b6788_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_member_username_706b6788_like ON public.app01_member USING btree (username varchar_pattern_ops);


--
-- Name: app01_membership_birthday_vouchers_membership_id_88656816; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_birthday_vouchers_membership_id_88656816 ON public.app01_membership_birthday_vouchers USING btree (membership_id);


--
-- Name: app01_membership_birthday_vouchers_voucher_id_bbe048a0; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_birthday_vouchers_voucher_id_bbe048a0 ON public.app01_membership_birthday_vouchers USING btree (voucher_id);


--
-- Name: app01_membership_complimentary_vouchers_membership_id_fb294b4a; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_complimentary_vouchers_membership_id_fb294b4a ON public.app01_membership_complimentary_vouchers USING btree (membership_id);


--
-- Name: app01_membership_complimentary_vouchers_voucher_id_f9e95d38; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_complimentary_vouchers_voucher_id_f9e95d38 ON public.app01_membership_complimentary_vouchers USING btree (voucher_id);


--
-- Name: app01_membership_member_member_id_02ddd66d; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_member_member_id_02ddd66d ON public.app01_membership_member USING btree (member_id);


--
-- Name: app01_membership_member_membership_id_45fbc0f6; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_membership_member_membership_id_45fbc0f6 ON public.app01_membership_member USING btree (membership_id);


--
-- Name: app01_occupation_name_90c3088b_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_occupation_name_90c3088b_like ON public.app01_occupation USING btree (name varchar_pattern_ops);


--
-- Name: app01_outlet_outlet_code_ad1a8d57_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_outlet_outlet_code_ad1a8d57_like ON public.app01_outlet USING btree (outlet_code varchar_pattern_ops);


--
-- Name: app01_outlet_outlet_name_c065608c_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_outlet_outlet_name_c065608c_like ON public.app01_outlet USING btree (outlet_name varchar_pattern_ops);


--
-- Name: app01_points_member_campaigntype_id_5c9fe2c7; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_points_member_campaigntype_id_5c9fe2c7 ON public.app01_points_member USING btree (campaigntype_id);


--
-- Name: app01_points_member_member_id_c8727528; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_points_member_member_id_c8727528 ON public.app01_points_member USING btree (member_id);


--
-- Name: app01_product_category_id_30912f63; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_product_category_id_30912f63 ON public.app01_product USING btree (category_id);


--
-- Name: app01_product_item_code_81d3d113_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_product_item_code_81d3d113_like ON public.app01_product USING btree (item_code varchar_pattern_ops);


--
-- Name: app01_product_name_f8e76520_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_product_name_f8e76520_like ON public.app01_product USING btree (name varchar_pattern_ops);


--
-- Name: app01_rechargerecord_wallet_id_8515421b; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_rechargerecord_wallet_id_8515421b ON public.app01_rechargerecord USING btree (wallet_id);


--
-- Name: app01_token_key_b555bf03_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_token_key_b555bf03_like ON public.app01_token USING btree (key varchar_pattern_ops);


--
-- Name: app01_toppings_name_a7ff11b9_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_toppings_name_a7ff11b9_like ON public.app01_toppings USING btree (name varchar_pattern_ops);


--
-- Name: app01_transactdetails_product_id_fb223760; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transactdetails_product_id_fb223760 ON public.app01_transactdetails USING btree (product_id);


--
-- Name: app01_transactdetails_toppings_id_cea14cf0; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transactdetails_toppings_id_cea14cf0 ON public.app01_transactdetails USING btree (toppings_id);


--
-- Name: app01_transactdetails_transaction_id_ccbc88e2; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transactdetails_transaction_id_ccbc88e2 ON public.app01_transactdetails USING btree (transaction_id);


--
-- Name: app01_transaction_campaigns_campaign_id_1887ece7; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_campaigns_campaign_id_1887ece7 ON public.app01_transaction_campaigns USING btree (campaign_id);


--
-- Name: app01_transaction_campaigns_transaction_id_6aec8df6; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_campaigns_transaction_id_6aec8df6 ON public.app01_transaction_campaigns USING btree (transaction_id);


--
-- Name: app01_transaction_campaigntypes_campaigntype_id_4ac56a10; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_campaigntypes_campaigntype_id_4ac56a10 ON public.app01_transaction_campaigntypes USING btree (campaigntype_id);


--
-- Name: app01_transaction_campaigntypes_transaction_id_4f95f849; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_campaigntypes_transaction_id_4f95f849 ON public.app01_transaction_campaigntypes USING btree (transaction_id);


--
-- Name: app01_transaction_member_id_ee5dc035; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_member_id_ee5dc035 ON public.app01_transaction USING btree (member_id);


--
-- Name: app01_transaction_outlet_id_4f0f1e90; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_outlet_id_4f0f1e90 ON public.app01_transaction USING btree (outlet_id);


--
-- Name: app01_transaction_redeemed_vouchers_transaction_id_37a3c931; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_redeemed_vouchers_transaction_id_37a3c931 ON public.app01_transaction_redeemed_vouchers USING btree (transaction_id);


--
-- Name: app01_transaction_redeemed_vouchers_voucher_id_6953c223; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_redeemed_vouchers_voucher_id_6953c223 ON public.app01_transaction_redeemed_vouchers USING btree (voucher_id);


--
-- Name: app01_transaction_reward_vouchers_transaction_id_3491c9b0; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_reward_vouchers_transaction_id_3491c9b0 ON public.app01_transaction_reward_vouchers USING btree (transaction_id);


--
-- Name: app01_transaction_reward_vouchers_voucher_id_d4ff3588; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_transaction_reward_vouchers_voucher_id_d4ff3588 ON public.app01_transaction_reward_vouchers USING btree (voucher_id);


--
-- Name: app01_voucher_discount_per_product_id_20ecc357; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_discount_per_product_id_20ecc357 ON public.app01_voucher_discount_per_unparticipated_products USING btree (product_id);


--
-- Name: app01_voucher_discount_per_voucher_id_d26e7905; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_discount_per_voucher_id_d26e7905 ON public.app01_voucher_discount_per_unparticipated_products USING btree (voucher_id);


--
-- Name: app01_voucher_discount_pri_product_id_67632f07; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_discount_pri_product_id_67632f07 ON public.app01_voucher_discount_price_unparticipated_products USING btree (product_id);


--
-- Name: app01_voucher_discount_pri_voucher_id_ab8784cf; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_discount_pri_voucher_id_ab8784cf ON public.app01_voucher_discount_price_unparticipated_products USING btree (voucher_id);


--
-- Name: app01_voucher_limit_memberships_membership_id_6a4cf00b; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_limit_memberships_membership_id_6a4cf00b ON public.app01_voucher_limit_memberships USING btree (membership_id);


--
-- Name: app01_voucher_limit_memberships_voucher_id_fb67583e; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_limit_memberships_voucher_id_fb67583e ON public.app01_voucher_limit_memberships USING btree (voucher_id);


--
-- Name: app01_voucher_member_member_id_831e1abe; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_member_member_id_831e1abe ON public.app01_voucher_member USING btree (member_id);


--
-- Name: app01_voucher_member_voucher_id_e362fe63; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_member_voucher_id_e362fe63 ON public.app01_voucher_member USING btree (voucher_id);


--
-- Name: app01_voucher_redemption_products_product_id_1fa3c6e0; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_redemption_products_product_id_1fa3c6e0 ON public.app01_voucher_redemption_products USING btree (product_id);


--
-- Name: app01_voucher_redemption_products_voucher_id_5410f3f0; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_redemption_products_voucher_id_5410f3f0 ON public.app01_voucher_redemption_products USING btree (voucher_id);


--
-- Name: app01_voucher_redemption_toppings_toppings_id_016c6b96; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_redemption_toppings_toppings_id_016c6b96 ON public.app01_voucher_redemption_toppings USING btree (toppings_id);


--
-- Name: app01_voucher_redemption_toppings_voucher_id_586c2bdf; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_redemption_toppings_voucher_id_586c2bdf ON public.app01_voucher_redemption_toppings USING btree (voucher_id);


--
-- Name: app01_voucher_size_upgrade_product_id_97107a4b; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_size_upgrade_product_id_97107a4b ON public.app01_voucher_size_upgrade_unparticipated_products USING btree (product_id);


--
-- Name: app01_voucher_size_upgrade_voucher_id_cd222dfe; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_size_upgrade_voucher_id_cd222dfe ON public.app01_voucher_size_upgrade_unparticipated_products USING btree (voucher_id);


--
-- Name: app01_voucher_unparticipated_outlets_outlet_id_56c8eff7; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_unparticipated_outlets_outlet_id_56c8eff7 ON public.app01_voucher_unparticipated_outlets USING btree (outlet_id);


--
-- Name: app01_voucher_unparticipated_outlets_voucher_id_8ee9a683; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_unparticipated_outlets_voucher_id_8ee9a683 ON public.app01_voucher_unparticipated_outlets USING btree (voucher_id);


--
-- Name: app01_voucher_voucher_code_9c465062_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX app01_voucher_voucher_code_9c465062_like ON public.app01_voucher USING btree (voucher_code varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: mobile_no_idx; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX mobile_no_idx ON public.app01_member USING btree (mobile_no);


--
-- Name: username_idx; Type: INDEX; Schema: public; Owner: cobra_user
--

CREATE INDEX username_idx ON public.app01_member USING btree (username);


--
-- Name: app01_campaign_memberships app01_campaign_membe_campaign_id_c5f0b81b_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_memberships
    ADD CONSTRAINT app01_campaign_membe_campaign_id_c5f0b81b_fk_app01_cam FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaign_memberships app01_campaign_membe_membership_id_4f4479e9_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_memberships
    ADD CONSTRAINT app01_campaign_membe_membership_id_4f4479e9_fk_app01_mem FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaign_occupations app01_campaign_occup_campaign_id_e373a508_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_occupations
    ADD CONSTRAINT app01_campaign_occup_campaign_id_e373a508_fk_app01_cam FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaign_occupations app01_campaign_occup_occupation_id_bfd384a5_fk_app01_occ; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_occupations
    ADD CONSTRAINT app01_campaign_occup_occupation_id_bfd384a5_fk_app01_occ FOREIGN KEY (occupation_id) REFERENCES public.app01_occupation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaign_outlets app01_campaign_outle_campaign_id_3934336a_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_outlets
    ADD CONSTRAINT app01_campaign_outle_campaign_id_3934336a_fk_app01_cam FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaign_outlets app01_campaign_outlets_outlet_id_361767a4_fk_app01_outlet_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaign_outlets
    ADD CONSTRAINT app01_campaign_outlets_outlet_id_361767a4_fk_app01_outlet_id FOREIGN KEY (outlet_id) REFERENCES public.app01_outlet(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition app01_campaigncondit_campaign_id_bbbbba79_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition
    ADD CONSTRAINT app01_campaigncondit_campaign_id_bbbbba79_fk_app01_cam FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_products app01_campaigncondit_campaigncondition_id_3c0ed59f_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_products
    ADD CONSTRAINT app01_campaigncondit_campaigncondition_id_3c0ed59f_fk_app01_cam FOREIGN KEY (campaigncondition_id) REFERENCES public.app01_campaigncondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors app01_campaigncondit_campaigncondition_id_5db74679_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_l_drinks_flavors
    ADD CONSTRAINT app01_campaigncondit_campaigncondition_id_5db74679_fk_app01_cam FOREIGN KEY (campaigncondition_id) REFERENCES public.app01_campaigncondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors app01_campaigncondit_campaigncondition_id_c30c8b88_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_m_drinks_flavors
    ADD CONSTRAINT app01_campaigncondit_campaigncondition_id_c30c8b88_fk_app01_cam FOREIGN KEY (campaigncondition_id) REFERENCES public.app01_campaigncondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_l_drinks_flavors app01_campaigncondit_product_id_1401ae63_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_l_drinks_flavors
    ADD CONSTRAINT app01_campaigncondit_product_id_1401ae63_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_m_drinks_flavors app01_campaigncondit_product_id_7895a45a_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_m_drinks_flavors
    ADD CONSTRAINT app01_campaigncondit_product_id_7895a45a_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigncondition_every_purchase_products app01_campaigncondit_product_id_c2eaa50e_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigncondition_every_purchase_products
    ADD CONSTRAINT app01_campaigncondit_product_id_c2eaa50e_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigntype app01_campaigntype_campaign_condition_i_e37c533d_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype
    ADD CONSTRAINT app01_campaigntype_campaign_condition_i_e37c533d_fk_app01_cam FOREIGN KEY (campaign_condition_id) REFERENCES public.app01_campaigncondition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigntype app01_campaigntype_campaign_id_3c8b7cfe_fk_app01_campaign_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype
    ADD CONSTRAINT app01_campaigntype_campaign_id_3c8b7cfe_fk_app01_campaign_id FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigntype_free_vouchers app01_campaigntype_f_campaigntype_id_1e42e6e1_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype_free_vouchers
    ADD CONSTRAINT app01_campaigntype_f_campaigntype_id_1e42e6e1_fk_app01_cam FOREIGN KEY (campaigntype_id) REFERENCES public.app01_campaigntype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigntype_free_vouchers app01_campaigntype_f_voucher_id_df0cd070_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype_free_vouchers
    ADD CONSTRAINT app01_campaigntype_f_voucher_id_df0cd070_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_campaigntype app01_campaigntype_upgrade_membership_i_41945661_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_campaigntype
    ADD CONSTRAINT app01_campaigntype_upgrade_membership_i_41945661_fk_app01_mem FOREIGN KEY (upgrade_membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_card app01_card_member_id_230780be_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_card
    ADD CONSTRAINT app01_card_member_id_230780be_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_cart app01_cart_member_id_357e42fa_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_cart
    ADD CONSTRAINT app01_cart_member_id_357e42fa_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_cart app01_cart_product_id_d5274713_fk_app01_product_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_cart
    ADD CONSTRAINT app01_cart_product_id_d5274713_fk_app01_product_id FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_evaluation app01_evaluation_transaction_id_911f3e74_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_evaluation
    ADD CONSTRAINT app01_evaluation_transaction_id_911f3e74_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member_campaigntype app01_member_campaig_campaign_type_id_39ba65cd_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member_campaigntype
    ADD CONSTRAINT app01_member_campaig_campaign_type_id_39ba65cd_fk_app01_cam FOREIGN KEY (campaign_type_id) REFERENCES public.app01_campaigntype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member_campaigntype app01_member_campaigntype_member_id_184cb185_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member_campaigntype
    ADD CONSTRAINT app01_member_campaigntype_member_id_184cb185_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member_interestGroups app01_member_interes_interestgroup_id_5245dd12_fk_app01_int; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public."app01_member_interestGroups"
    ADD CONSTRAINT app01_member_interes_interestgroup_id_5245dd12_fk_app01_int FOREIGN KEY (interestgroup_id) REFERENCES public.app01_interestgroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member_interestGroups app01_member_interes_member_id_8a7dab2a_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public."app01_member_interestGroups"
    ADD CONSTRAINT app01_member_interes_member_id_8a7dab2a_fk_app01_mem FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member app01_member_membership_id_fae4c9da_fk_app01_membership_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member
    ADD CONSTRAINT app01_member_membership_id_fae4c9da_fk_app01_membership_id FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_member app01_member_role_id_d90d6d32_fk_app01_role_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_member
    ADD CONSTRAINT app01_member_role_id_d90d6d32_fk_app01_role_id FOREIGN KEY (role_id) REFERENCES public.app01_role(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_birthday_vouchers app01_membership_bir_membership_id_88656816_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_birthday_vouchers
    ADD CONSTRAINT app01_membership_bir_membership_id_88656816_fk_app01_mem FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_birthday_vouchers app01_membership_bir_voucher_id_bbe048a0_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_birthday_vouchers
    ADD CONSTRAINT app01_membership_bir_voucher_id_bbe048a0_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_complimentary_vouchers app01_membership_com_membership_id_fb294b4a_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_complimentary_vouchers
    ADD CONSTRAINT app01_membership_com_membership_id_fb294b4a_fk_app01_mem FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_complimentary_vouchers app01_membership_com_voucher_id_f9e95d38_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_complimentary_vouchers
    ADD CONSTRAINT app01_membership_com_voucher_id_f9e95d38_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_member app01_membership_mem_membership_id_45fbc0f6_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_member
    ADD CONSTRAINT app01_membership_mem_membership_id_45fbc0f6_fk_app01_mem FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_membership_member app01_membership_member_member_id_02ddd66d_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_membership_member
    ADD CONSTRAINT app01_membership_member_member_id_02ddd66d_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_points_member app01_points_member_campaigntype_id_5c9fe2c7_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_points_member
    ADD CONSTRAINT app01_points_member_campaigntype_id_5c9fe2c7_fk_app01_cam FOREIGN KEY (campaigntype_id) REFERENCES public.app01_campaigntype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_points_member app01_points_member_member_id_c8727528_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_points_member
    ADD CONSTRAINT app01_points_member_member_id_c8727528_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_product app01_product_category_id_30912f63_fk_app01_category_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_product
    ADD CONSTRAINT app01_product_category_id_30912f63_fk_app01_category_id FOREIGN KEY (category_id) REFERENCES public.app01_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_rechargerecord app01_rechargerecord_wallet_id_8515421b_fk_app01_wallet_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_rechargerecord
    ADD CONSTRAINT app01_rechargerecord_wallet_id_8515421b_fk_app01_wallet_id FOREIGN KEY (wallet_id) REFERENCES public.app01_wallet(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_token app01_token_user_id_b14b11c1_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_token
    ADD CONSTRAINT app01_token_user_id_b14b11c1_fk_app01_member_id FOREIGN KEY (user_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transactdetails app01_transactdetail_transaction_id_ccbc88e2_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transactdetails
    ADD CONSTRAINT app01_transactdetail_transaction_id_ccbc88e2_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transactdetails app01_transactdetails_product_id_fb223760_fk_app01_product_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transactdetails
    ADD CONSTRAINT app01_transactdetails_product_id_fb223760_fk_app01_product_id FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transactdetails app01_transactdetails_toppings_id_cea14cf0_fk_app01_toppings_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transactdetails
    ADD CONSTRAINT app01_transactdetails_toppings_id_cea14cf0_fk_app01_toppings_id FOREIGN KEY (toppings_id) REFERENCES public.app01_toppings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_campaigns app01_transaction_ca_campaign_id_1887ece7_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigns
    ADD CONSTRAINT app01_transaction_ca_campaign_id_1887ece7_fk_app01_cam FOREIGN KEY (campaign_id) REFERENCES public.app01_campaign(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_campaigntypes app01_transaction_ca_campaigntype_id_4ac56a10_fk_app01_cam; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigntypes
    ADD CONSTRAINT app01_transaction_ca_campaigntype_id_4ac56a10_fk_app01_cam FOREIGN KEY (campaigntype_id) REFERENCES public.app01_campaigntype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_campaigntypes app01_transaction_ca_transaction_id_4f95f849_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigntypes
    ADD CONSTRAINT app01_transaction_ca_transaction_id_4f95f849_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_campaigns app01_transaction_ca_transaction_id_6aec8df6_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_campaigns
    ADD CONSTRAINT app01_transaction_ca_transaction_id_6aec8df6_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction app01_transaction_member_id_ee5dc035_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction
    ADD CONSTRAINT app01_transaction_member_id_ee5dc035_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction app01_transaction_outlet_id_4f0f1e90_fk_app01_outlet_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction
    ADD CONSTRAINT app01_transaction_outlet_id_4f0f1e90_fk_app01_outlet_id FOREIGN KEY (outlet_id) REFERENCES public.app01_outlet(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_reward_vouchers app01_transaction_re_transaction_id_3491c9b0_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_reward_vouchers
    ADD CONSTRAINT app01_transaction_re_transaction_id_3491c9b0_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_redeemed_vouchers app01_transaction_re_transaction_id_37a3c931_fk_app01_tra; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_redeemed_vouchers
    ADD CONSTRAINT app01_transaction_re_transaction_id_37a3c931_fk_app01_tra FOREIGN KEY (transaction_id) REFERENCES public.app01_transaction(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_redeemed_vouchers app01_transaction_re_voucher_id_6953c223_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_redeemed_vouchers
    ADD CONSTRAINT app01_transaction_re_voucher_id_6953c223_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_transaction_reward_vouchers app01_transaction_re_voucher_id_d4ff3588_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_transaction_reward_vouchers
    ADD CONSTRAINT app01_transaction_re_voucher_id_d4ff3588_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_discount_per_unparticipated_products app01_voucher_discou_product_id_20ecc357_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_per_unparticipated_products
    ADD CONSTRAINT app01_voucher_discou_product_id_20ecc357_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_discount_price_unparticipated_products app01_voucher_discou_product_id_67632f07_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_price_unparticipated_products
    ADD CONSTRAINT app01_voucher_discou_product_id_67632f07_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_discount_price_unparticipated_products app01_voucher_discou_voucher_id_ab8784cf_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_price_unparticipated_products
    ADD CONSTRAINT app01_voucher_discou_voucher_id_ab8784cf_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_discount_per_unparticipated_products app01_voucher_discou_voucher_id_d26e7905_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_discount_per_unparticipated_products
    ADD CONSTRAINT app01_voucher_discou_voucher_id_d26e7905_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_limit_memberships app01_voucher_limit__membership_id_6a4cf00b_fk_app01_mem; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_limit_memberships
    ADD CONSTRAINT app01_voucher_limit__membership_id_6a4cf00b_fk_app01_mem FOREIGN KEY (membership_id) REFERENCES public.app01_membership(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_limit_memberships app01_voucher_limit__voucher_id_fb67583e_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_limit_memberships
    ADD CONSTRAINT app01_voucher_limit__voucher_id_fb67583e_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_member app01_voucher_member_member_id_831e1abe_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_member
    ADD CONSTRAINT app01_voucher_member_member_id_831e1abe_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_member app01_voucher_member_voucher_id_e362fe63_fk_app01_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_member
    ADD CONSTRAINT app01_voucher_member_voucher_id_e362fe63_fk_app01_voucher_id FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_redemption_products app01_voucher_redemp_product_id_1fa3c6e0_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_products
    ADD CONSTRAINT app01_voucher_redemp_product_id_1fa3c6e0_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_redemption_toppings app01_voucher_redemp_toppings_id_016c6b96_fk_app01_top; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_toppings
    ADD CONSTRAINT app01_voucher_redemp_toppings_id_016c6b96_fk_app01_top FOREIGN KEY (toppings_id) REFERENCES public.app01_toppings(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_redemption_products app01_voucher_redemp_voucher_id_5410f3f0_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_products
    ADD CONSTRAINT app01_voucher_redemp_voucher_id_5410f3f0_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_redemption_toppings app01_voucher_redemp_voucher_id_586c2bdf_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_redemption_toppings
    ADD CONSTRAINT app01_voucher_redemp_voucher_id_586c2bdf_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_size_upgrade_unparticipated_products app01_voucher_size_u_product_id_97107a4b_fk_app01_pro; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_size_upgrade_unparticipated_products
    ADD CONSTRAINT app01_voucher_size_u_product_id_97107a4b_fk_app01_pro FOREIGN KEY (product_id) REFERENCES public.app01_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_size_upgrade_unparticipated_products app01_voucher_size_u_voucher_id_cd222dfe_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_size_upgrade_unparticipated_products
    ADD CONSTRAINT app01_voucher_size_u_voucher_id_cd222dfe_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_unparticipated_outlets app01_voucher_unpart_outlet_id_56c8eff7_fk_app01_out; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_unparticipated_outlets
    ADD CONSTRAINT app01_voucher_unpart_outlet_id_56c8eff7_fk_app01_out FOREIGN KEY (outlet_id) REFERENCES public.app01_outlet(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_voucher_unparticipated_outlets app01_voucher_unpart_voucher_id_8ee9a683_fk_app01_vou; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_voucher_unparticipated_outlets
    ADD CONSTRAINT app01_voucher_unpart_voucher_id_8ee9a683_fk_app01_vou FOREIGN KEY (voucher_id) REFERENCES public.app01_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app01_wallet app01_wallet_member_id_38d7902e_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.app01_wallet
    ADD CONSTRAINT app01_wallet_member_id_38d7902e_fk_app01_member_id FOREIGN KEY (member_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_app01_member_id; Type: FK CONSTRAINT; Schema: public; Owner: cobra_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_app01_member_id FOREIGN KEY (user_id) REFERENCES public.app01_member(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--


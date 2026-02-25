--
-- PostgreSQL database dump
--

\restrict alsBfpzpHVoMceBO7yD5dkjwhEiP5nJEuVqvMjwxNThMYiIOVfJD8A33IgaXPap

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-02-26 00:25:10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 10 (class 2615 OID 21045)
-- Name: check-in; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "check-in";


ALTER SCHEMA "check-in" OWNER TO postgres;

--
-- TOC entry 11 (class 2615 OID 21046)
-- Name: deployment; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA deployment;


ALTER SCHEMA deployment OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 21044)
-- Name: location; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA location;


ALTER SCHEMA location OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 21043)
-- Name: system_agency; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA system_agency;


ALTER SCHEMA system_agency OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 21042)
-- Name: user; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "user";


ALTER SCHEMA "user" OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 19954)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 6106 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 252 (class 1259 OID 21328)
-- Name: check_in_agency; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_agency (
    ciag_id integer NOT NULL,
    ciag_name character varying NOT NULL,
    ciag_leader character varying NOT NULL,
    ciag_contact_number character varying NOT NULL,
    ciag_email character varying NOT NULL,
    ciag_status character varying NOT NULL,
    cipo_id integer NOT NULL,
    dep_id integer NOT NULL
);


ALTER TABLE "check-in".check_in_agency OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 21203)
-- Name: check_in_equipment; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_equipment (
    cie_id integer NOT NULL,
    cie_operator_name character varying NOT NULL,
    cie_kind character varying NOT NULL,
    cie_type character varying NOT NULL,
    cie_source_of_power character varying NOT NULL,
    cie_fuel_type character varying NOT NULL,
    cie_weight character varying NOT NULL,
    cie_contact_or_details character varying NOT NULL,
    cie_capabilities_or_specialization character varying NOT NULL,
    cie_others character varying NOT NULL,
    cie_status character varying NOT NULL,
    nhr_id integer NOT NULL
);


ALTER TABLE "check-in".check_in_equipment OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 21343)
-- Name: check_in_human_resource; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_human_resource (
    cihr_id integer NOT NULL,
    cihr_fullname character varying NOT NULL,
    cihr_age character varying NOT NULL,
    cihr_gender character varying NOT NULL,
    cihr_weight character varying NOT NULL,
    cihr_contact character varying NOT NULL,
    cihr_capabilities character varying NOT NULL,
    cihr_status character varying NOT NULL,
    ciag_id integer NOT NULL,
    imt_id integer NOT NULL
);


ALTER TABLE "check-in".check_in_human_resource OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 21360)
-- Name: check_in_non_human_resource; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_non_human_resource (
    cinhr_id integer NOT NULL,
    cinhr_name character varying NOT NULL,
    cinhr_type character varying NOT NULL,
    ciag_id integer NOT NULL
);


ALTER TABLE "check-in".check_in_non_human_resource OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 21315)
-- Name: check_in_portal; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_portal (
    cipo_id integer NOT NULL,
    ir_id integer NOT NULL,
    cipo_status character varying NOT NULL,
    cipo_duration character varying NOT NULL,
    cipo_check_in_count integer NOT NULL,
    cipo_last_update timestamp with time zone NOT NULL
);


ALTER TABLE "check-in".check_in_portal OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 21184)
-- Name: check_in_vehicle; Type: TABLE; Schema: check-in; Owner: postgres
--

CREATE TABLE "check-in".check_in_vehicle (
    civ_id integer NOT NULL,
    civ_operator_name character varying NOT NULL,
    civ_kind character varying NOT NULL,
    civ_type character varying NOT NULL,
    civ_plate_number character varying NOT NULL,
    civ_fuel_type character varying NOT NULL,
    civ_weight character varying NOT NULL,
    civ_contact_or_details character varying NOT NULL,
    civ_capabilities_or_specialization character varying NOT NULL,
    civ_others character varying NOT NULL,
    civ_status character varying NOT NULL,
    nhr_id integer NOT NULL
);


ALTER TABLE "check-in".check_in_vehicle OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 21282)
-- Name: deployment; Type: TABLE; Schema: deployment; Owner: postgres
--

CREATE TABLE deployment.deployment (
    dep_id integer NOT NULL,
    dep_status character varying NOT NULL,
    dep_geolocation public.geography NOT NULL,
    ir_id integer NOT NULL,
    deparea_id integer NOT NULL
);


ALTER TABLE deployment.deployment OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 21294)
-- Name: deployment_area; Type: TABLE; Schema: deployment; Owner: postgres
--

CREATE TABLE deployment.deployment_area (
    deparea_id integer NOT NULL,
    deparea_name character varying NOT NULL,
    deparea_description character varying NOT NULL,
    prov_id integer NOT NULL
);


ALTER TABLE deployment.deployment_area OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 21305)
-- Name: deployment_area_geolocation; Type: TABLE; Schema: deployment; Owner: postgres
--

CREATE TABLE deployment.deployment_area_geolocation (
    deparea_geo_id integer NOT NULL,
    deparea_geo_geolocation public.geography NOT NULL,
    deparea_id integer NOT NULL
);


ALTER TABLE deployment.deployment_area_geolocation OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 21261)
-- Name: barangay; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.barangay (
    brgy_id integer NOT NULL,
    brgy_name character varying NOT NULL,
    muni_id integer NOT NULL
);


ALTER TABLE location.barangay OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 21271)
-- Name: barangay_geolocation; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.barangay_geolocation (
    brgy_geo_id integer NOT NULL,
    brgy_geo_geolocation public.geography NOT NULL,
    brgy_id integer NOT NULL
);


ALTER TABLE location.barangay_geolocation OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 21241)
-- Name: municipality; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.municipality (
    muni_id integer NOT NULL,
    muni_name character varying NOT NULL,
    prov_id integer NOT NULL
);


ALTER TABLE location.municipality OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 21251)
-- Name: municipality_geolocation; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.municipality_geolocation (
    muni_geo_id integer NOT NULL,
    muni_geo_geolocation public.geography NOT NULL,
    muni_id integer NOT NULL
);


ALTER TABLE location.municipality_geolocation OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 21222)
-- Name: province; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.province (
    prov_id integer NOT NULL,
    prov_name character varying NOT NULL
);


ALTER TABLE location.province OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 21231)
-- Name: province_geolocation; Type: TABLE; Schema: location; Owner: postgres
--

CREATE TABLE location.province_geolocation (
    prov_geo_id integer NOT NULL,
    prov_geo_geolocation public.geography NOT NULL,
    prov_id integer NOT NULL
);


ALTER TABLE location.province_geolocation OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 21165)
-- Name: equipment; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.equipment (
    e_id integer NOT NULL,
    e_operator_name character varying NOT NULL,
    e_kind character varying NOT NULL,
    e_type character varying NOT NULL,
    e_source_of_power character varying NOT NULL,
    e_fuel_type character varying NOT NULL,
    e_weight character varying NOT NULL,
    e_contact_or_details character varying NOT NULL,
    e_capabilities_or_specialization character varying NOT NULL,
    e_others character varying NOT NULL,
    e_status character varying NOT NULL,
    nhr_id integer NOT NULL
);


ALTER TABLE system_agency.equipment OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 21119)
-- Name: human_resource; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.human_resource (
    hr_id integer NOT NULL,
    hr_fullname character varying NOT NULL,
    hr_age character varying NOT NULL,
    hr_gender character varying NOT NULL,
    hr_weight character varying NOT NULL,
    hr_contact character varying NOT NULL,
    hr_capabilities character varying NOT NULL,
    hr_status character varying NOT NULL,
    res_id integer NOT NULL
);


ALTER TABLE system_agency.human_resource OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 21094)
-- Name: incident_report; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.incident_report (
    ir_id integer NOT NULL,
    ir_title character varying NOT NULL,
    ir_type character varying NOT NULL,
    ir_severity character varying NOT NULL,
    ir_source character varying NOT NULL,
    prov_id integer NOT NULL,
    muni_id integer NOT NULL,
    brgy_id integer NOT NULL,
    ir_status character varying NOT NULL,
    syag_id integer NOT NULL,
    ir_date_reported timestamp with time zone NOT NULL
);


ALTER TABLE system_agency.incident_report OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 21135)
-- Name: non_human_resource; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.non_human_resource (
    nhr_id integer NOT NULL,
    nhr_name character varying NOT NULL,
    nhr_type character varying NOT NULL,
    res_id integer NOT NULL
);


ALTER TABLE system_agency.non_human_resource OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 21112)
-- Name: resource; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.resource (
    res_id integer NOT NULL,
    syag_id integer NOT NULL
);


ALTER TABLE system_agency.resource OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 21079)
-- Name: system_agency; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.system_agency (
    syag_id integer NOT NULL,
    syag_name character varying NOT NULL,
    muni_id integer NOT NULL,
    brgy_id integer NOT NULL,
    ir_id integer NOT NULL,
    syag_contact_number character varying NOT NULL,
    syag_email character varying NOT NULL,
    syag_status character varying NOT NULL
);


ALTER TABLE system_agency.system_agency OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 21146)
-- Name: vehicle; Type: TABLE; Schema: system_agency; Owner: postgres
--

CREATE TABLE system_agency.vehicle (
    v_id integer NOT NULL,
    v_operator_name character varying NOT NULL,
    v_kind character varying NOT NULL,
    v_type character varying NOT NULL,
    v_plate_number character varying NOT NULL,
    v_fuel_type character varying NOT NULL,
    v_weight character varying NOT NULL,
    v_contact_or_details character varying NOT NULL,
    v_capabilities_or_specialization character varying NOT NULL,
    v_others character varying NOT NULL,
    v_status character varying NOT NULL,
    nhr_id integer NOT NULL
);


ALTER TABLE system_agency.vehicle OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 21070)
-- Name: incident_management_team; Type: TABLE; Schema: user; Owner: postgres
--

CREATE TABLE "user".incident_management_team (
    imt_id integer NOT NULL,
    imt_name character varying NOT NULL
);


ALTER TABLE "user".incident_management_team OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 21061)
-- Name: role; Type: TABLE; Schema: user; Owner: postgres
--

CREATE TABLE "user".role (
    role_id integer NOT NULL,
    role_name character varying NOT NULL
);


ALTER TABLE "user".role OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 21047)
-- Name: user; Type: TABLE; Schema: user; Owner: postgres
--

CREATE TABLE "user"."user" (
    u_id integer NOT NULL,
    u_fullname character varying NOT NULL,
    u_password character varying NOT NULL,
    syag_id integer CONSTRAINT user_sys_ag_id_not_null NOT NULL,
    role_id integer NOT NULL,
    u_status character varying NOT NULL,
    u_created_at timestamp with time zone NOT NULL
);


ALTER TABLE "user"."user" OWNER TO postgres;

--
-- TOC entry 6098 (class 0 OID 21328)
-- Dependencies: 252
-- Data for Name: check_in_agency; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_agency (ciag_id, ciag_name, ciag_leader, ciag_contact_number, ciag_email, ciag_status, cipo_id, dep_id) FROM stdin;
\.


--
-- TOC entry 6087 (class 0 OID 21203)
-- Dependencies: 241
-- Data for Name: check_in_equipment; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_equipment (cie_id, cie_operator_name, cie_kind, cie_type, cie_source_of_power, cie_fuel_type, cie_weight, cie_contact_or_details, cie_capabilities_or_specialization, cie_others, cie_status, nhr_id) FROM stdin;
\.


--
-- TOC entry 6099 (class 0 OID 21343)
-- Dependencies: 253
-- Data for Name: check_in_human_resource; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_human_resource (cihr_id, cihr_fullname, cihr_age, cihr_gender, cihr_weight, cihr_contact, cihr_capabilities, cihr_status, ciag_id, imt_id) FROM stdin;
\.


--
-- TOC entry 6100 (class 0 OID 21360)
-- Dependencies: 254
-- Data for Name: check_in_non_human_resource; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_non_human_resource (cinhr_id, cinhr_name, cinhr_type, ciag_id) FROM stdin;
\.


--
-- TOC entry 6097 (class 0 OID 21315)
-- Dependencies: 251
-- Data for Name: check_in_portal; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_portal (cipo_id, ir_id, cipo_status, cipo_duration, cipo_check_in_count, cipo_last_update) FROM stdin;
\.


--
-- TOC entry 6086 (class 0 OID 21184)
-- Dependencies: 240
-- Data for Name: check_in_vehicle; Type: TABLE DATA; Schema: check-in; Owner: postgres
--

COPY "check-in".check_in_vehicle (civ_id, civ_operator_name, civ_kind, civ_type, civ_plate_number, civ_fuel_type, civ_weight, civ_contact_or_details, civ_capabilities_or_specialization, civ_others, civ_status, nhr_id) FROM stdin;
\.


--
-- TOC entry 6094 (class 0 OID 21282)
-- Dependencies: 248
-- Data for Name: deployment; Type: TABLE DATA; Schema: deployment; Owner: postgres
--

COPY deployment.deployment (dep_id, dep_status, dep_geolocation, ir_id, deparea_id) FROM stdin;
\.


--
-- TOC entry 6095 (class 0 OID 21294)
-- Dependencies: 249
-- Data for Name: deployment_area; Type: TABLE DATA; Schema: deployment; Owner: postgres
--

COPY deployment.deployment_area (deparea_id, deparea_name, deparea_description, prov_id) FROM stdin;
\.


--
-- TOC entry 6096 (class 0 OID 21305)
-- Dependencies: 250
-- Data for Name: deployment_area_geolocation; Type: TABLE DATA; Schema: deployment; Owner: postgres
--

COPY deployment.deployment_area_geolocation (deparea_geo_id, deparea_geo_geolocation, deparea_id) FROM stdin;
\.


--
-- TOC entry 6092 (class 0 OID 21261)
-- Dependencies: 246
-- Data for Name: barangay; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.barangay (brgy_id, brgy_name, muni_id) FROM stdin;
\.


--
-- TOC entry 6093 (class 0 OID 21271)
-- Dependencies: 247
-- Data for Name: barangay_geolocation; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.barangay_geolocation (brgy_geo_id, brgy_geo_geolocation, brgy_id) FROM stdin;
\.


--
-- TOC entry 6090 (class 0 OID 21241)
-- Dependencies: 244
-- Data for Name: municipality; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.municipality (muni_id, muni_name, prov_id) FROM stdin;
\.


--
-- TOC entry 6091 (class 0 OID 21251)
-- Dependencies: 245
-- Data for Name: municipality_geolocation; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.municipality_geolocation (muni_geo_id, muni_geo_geolocation, muni_id) FROM stdin;
\.


--
-- TOC entry 6088 (class 0 OID 21222)
-- Dependencies: 242
-- Data for Name: province; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.province (prov_id, prov_name) FROM stdin;
\.


--
-- TOC entry 6089 (class 0 OID 21231)
-- Dependencies: 243
-- Data for Name: province_geolocation; Type: TABLE DATA; Schema: location; Owner: postgres
--

COPY location.province_geolocation (prov_geo_id, prov_geo_geolocation, prov_id) FROM stdin;
\.


--
-- TOC entry 5868 (class 0 OID 20273)
-- Dependencies: 226
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 6085 (class 0 OID 21165)
-- Dependencies: 239
-- Data for Name: equipment; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.equipment (e_id, e_operator_name, e_kind, e_type, e_source_of_power, e_fuel_type, e_weight, e_contact_or_details, e_capabilities_or_specialization, e_others, e_status, nhr_id) FROM stdin;
\.


--
-- TOC entry 6082 (class 0 OID 21119)
-- Dependencies: 236
-- Data for Name: human_resource; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.human_resource (hr_id, hr_fullname, hr_age, hr_gender, hr_weight, hr_contact, hr_capabilities, hr_status, res_id) FROM stdin;
\.


--
-- TOC entry 6080 (class 0 OID 21094)
-- Dependencies: 234
-- Data for Name: incident_report; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.incident_report (ir_id, ir_title, ir_type, ir_severity, ir_source, prov_id, muni_id, brgy_id, ir_status, syag_id, ir_date_reported) FROM stdin;
\.


--
-- TOC entry 6083 (class 0 OID 21135)
-- Dependencies: 237
-- Data for Name: non_human_resource; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.non_human_resource (nhr_id, nhr_name, nhr_type, res_id) FROM stdin;
\.


--
-- TOC entry 6081 (class 0 OID 21112)
-- Dependencies: 235
-- Data for Name: resource; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.resource (res_id, syag_id) FROM stdin;
\.


--
-- TOC entry 6079 (class 0 OID 21079)
-- Dependencies: 233
-- Data for Name: system_agency; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.system_agency (syag_id, syag_name, muni_id, brgy_id, ir_id, syag_contact_number, syag_email, syag_status) FROM stdin;
\.


--
-- TOC entry 6084 (class 0 OID 21146)
-- Dependencies: 238
-- Data for Name: vehicle; Type: TABLE DATA; Schema: system_agency; Owner: postgres
--

COPY system_agency.vehicle (v_id, v_operator_name, v_kind, v_type, v_plate_number, v_fuel_type, v_weight, v_contact_or_details, v_capabilities_or_specialization, v_others, v_status, nhr_id) FROM stdin;
\.


--
-- TOC entry 6078 (class 0 OID 21070)
-- Dependencies: 232
-- Data for Name: incident_management_team; Type: TABLE DATA; Schema: user; Owner: postgres
--

COPY "user".incident_management_team (imt_id, imt_name) FROM stdin;
\.


--
-- TOC entry 6077 (class 0 OID 21061)
-- Dependencies: 231
-- Data for Name: role; Type: TABLE DATA; Schema: user; Owner: postgres
--

COPY "user".role (role_id, role_name) FROM stdin;
\.


--
-- TOC entry 6076 (class 0 OID 21047)
-- Dependencies: 230
-- Data for Name: user; Type: TABLE DATA; Schema: user; Owner: postgres
--

COPY "user"."user" (u_id, u_fullname, u_password, syag_id, role_id, u_status, u_created_at) FROM stdin;
\.


--
-- TOC entry 5917 (class 2606 OID 21342)
-- Name: check_in_agency check_in_agency_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_agency
    ADD CONSTRAINT check_in_agency_pkey PRIMARY KEY (ciag_id);


--
-- TOC entry 5895 (class 2606 OID 21221)
-- Name: check_in_equipment check_in_equipment_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_equipment
    ADD CONSTRAINT check_in_equipment_pkey PRIMARY KEY (cie_id);


--
-- TOC entry 5919 (class 2606 OID 21359)
-- Name: check_in_human_resource check_in_human_resource_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_human_resource
    ADD CONSTRAINT check_in_human_resource_pkey PRIMARY KEY (cihr_id);


--
-- TOC entry 5921 (class 2606 OID 21370)
-- Name: check_in_non_human_resource check_in_non_human_resource_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_non_human_resource
    ADD CONSTRAINT check_in_non_human_resource_pkey PRIMARY KEY (cinhr_id);


--
-- TOC entry 5915 (class 2606 OID 21327)
-- Name: check_in_portal check_in_portal_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_portal
    ADD CONSTRAINT check_in_portal_pkey PRIMARY KEY (cipo_id);


--
-- TOC entry 5893 (class 2606 OID 21202)
-- Name: check_in_vehicle check_in_vehicle_pkey; Type: CONSTRAINT; Schema: check-in; Owner: postgres
--

ALTER TABLE ONLY "check-in".check_in_vehicle
    ADD CONSTRAINT check_in_vehicle_pkey PRIMARY KEY (civ_id);


--
-- TOC entry 5913 (class 2606 OID 21314)
-- Name: deployment_area_geolocation deployment_area_geolocation_pkey; Type: CONSTRAINT; Schema: deployment; Owner: postgres
--

ALTER TABLE ONLY deployment.deployment_area_geolocation
    ADD CONSTRAINT deployment_area_geolocation_pkey PRIMARY KEY (deparea_geo_id);


--
-- TOC entry 5911 (class 2606 OID 21304)
-- Name: deployment_area deployment_area_pkey; Type: CONSTRAINT; Schema: deployment; Owner: postgres
--

ALTER TABLE ONLY deployment.deployment_area
    ADD CONSTRAINT deployment_area_pkey PRIMARY KEY (deparea_id);


--
-- TOC entry 5909 (class 2606 OID 21293)
-- Name: deployment deployment_pkey; Type: CONSTRAINT; Schema: deployment; Owner: postgres
--

ALTER TABLE ONLY deployment.deployment
    ADD CONSTRAINT deployment_pkey PRIMARY KEY (dep_id);


--
-- TOC entry 5907 (class 2606 OID 21280)
-- Name: barangay_geolocation barangay_geolocation_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.barangay_geolocation
    ADD CONSTRAINT barangay_geolocation_pkey PRIMARY KEY (brgy_geo_id);


--
-- TOC entry 5905 (class 2606 OID 21270)
-- Name: barangay barangay_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.barangay
    ADD CONSTRAINT barangay_pkey PRIMARY KEY (brgy_id);


--
-- TOC entry 5903 (class 2606 OID 21260)
-- Name: municipality_geolocation municipality_geolocation_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.municipality_geolocation
    ADD CONSTRAINT municipality_geolocation_pkey PRIMARY KEY (muni_geo_id);


--
-- TOC entry 5901 (class 2606 OID 21250)
-- Name: municipality municipality_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.municipality
    ADD CONSTRAINT municipality_pkey PRIMARY KEY (muni_id);


--
-- TOC entry 5899 (class 2606 OID 21240)
-- Name: province_geolocation province_geolocation_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.province_geolocation
    ADD CONSTRAINT province_geolocation_pkey PRIMARY KEY (prov_geo_id);


--
-- TOC entry 5897 (class 2606 OID 21230)
-- Name: province province_pkey; Type: CONSTRAINT; Schema: location; Owner: postgres
--

ALTER TABLE ONLY location.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (prov_id);


--
-- TOC entry 5891 (class 2606 OID 21183)
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (e_id);


--
-- TOC entry 5885 (class 2606 OID 21134)
-- Name: human_resource human_resource_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.human_resource
    ADD CONSTRAINT human_resource_pkey PRIMARY KEY (hr_id);


--
-- TOC entry 5881 (class 2606 OID 21111)
-- Name: incident_report incident_report_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.incident_report
    ADD CONSTRAINT incident_report_pkey PRIMARY KEY (ir_id);


--
-- TOC entry 5887 (class 2606 OID 21145)
-- Name: non_human_resource non_human_resource_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.non_human_resource
    ADD CONSTRAINT non_human_resource_pkey PRIMARY KEY (nhr_id);


--
-- TOC entry 5883 (class 2606 OID 21118)
-- Name: resource resource_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.resource
    ADD CONSTRAINT resource_pkey PRIMARY KEY (res_id);


--
-- TOC entry 5879 (class 2606 OID 21093)
-- Name: system_agency system_agency_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.system_agency
    ADD CONSTRAINT system_agency_pkey PRIMARY KEY (syag_id);


--
-- TOC entry 5889 (class 2606 OID 21164)
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: system_agency; Owner: postgres
--

ALTER TABLE ONLY system_agency.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (v_id);


--
-- TOC entry 5877 (class 2606 OID 21078)
-- Name: incident_management_team incident_management_team_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user".incident_management_team
    ADD CONSTRAINT incident_management_team_pkey PRIMARY KEY (imt_id);


--
-- TOC entry 5875 (class 2606 OID 21069)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 5873 (class 2606 OID 21060)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (u_id);


--
-- TOC entry 5922 (class 2606 OID 21376)
-- Name: user role; Type: FK CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT role FOREIGN KEY (role_id) REFERENCES "user".role(role_id) NOT VALID;


--
-- TOC entry 5923 (class 2606 OID 21371)
-- Name: user system_agency; Type: FK CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT system_agency FOREIGN KEY (syag_id) REFERENCES system_agency.system_agency(syag_id) NOT VALID;


-- Completed on 2026-02-26 00:25:11

--
-- PostgreSQL database dump complete
--

\unrestrict alsBfpzpHVoMceBO7yD5dkjwhEiP5nJEuVqvMjwxNThMYiIOVfJD8A33IgaXPap


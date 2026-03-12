--
-- PostgreSQL database dump
--

\restrict SOmmZEbnThzn7bNmyCATc1Zji8bAXwOd6woEcMYGqGEX9sIuMmVaf5qItCIjCLd

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-03-12 10:43:04

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
-- TOC entry 6024 (class 1262 OID 19953)
-- Name: pinakabago_DB; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "pinakabago_DB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';


ALTER DATABASE "pinakabago_DB" OWNER TO postgres;

\unrestrict SOmmZEbnThzn7bNmyCATc1Zji8bAXwOd6woEcMYGqGEX9sIuMmVaf5qItCIjCLd
\connect "pinakabago_DB"
\restrict SOmmZEbnThzn7bNmyCATc1Zji8bAXwOd6woEcMYGqGEX9sIuMmVaf5qItCIjCLd

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
-- TOC entry 7 (class 2615 OID 21042)
-- Name: user; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "user";


ALTER SCHEMA "user" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

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
-- TOC entry 256 (class 1259 OID 21397)
-- Name: view_profile; Type: VIEW; Schema: user; Owner: postgres
--

CREATE VIEW "user".view_profile AS
 SELECT u_id,
    u_fullname,
    u_password,
    syag_id,
    role_id,
    u_status,
    u_created_at
   FROM "user"."user"
  WHERE ((u_fullname)::text = CURRENT_USER);


ALTER VIEW "user".view_profile OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 21393)
-- Name: view_user; Type: VIEW; Schema: user; Owner: postgres
--

CREATE VIEW "user".view_user AS
 SELECT u_id,
    u_fullname,
    syag_id,
    role_id,
    u_status,
    u_created_at
   FROM "user"."user";


ALTER VIEW "user".view_user OWNER TO postgres;

--
-- TOC entry 6018 (class 0 OID 21070)
-- Dependencies: 232
-- Data for Name: incident_management_team; Type: TABLE DATA; Schema: user; Owner: postgres
--



--
-- TOC entry 6017 (class 0 OID 21061)
-- Dependencies: 231
-- Data for Name: role; Type: TABLE DATA; Schema: user; Owner: postgres
--

INSERT INTO "user".role VALUES (1, 'PDRRMO_ADMIN');


--
-- TOC entry 6016 (class 0 OID 21047)
-- Dependencies: 230
-- Data for Name: user; Type: TABLE DATA; Schema: user; Owner: postgres
--



--
-- TOC entry 5859 (class 2606 OID 21078)
-- Name: incident_management_team incident_management_team_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user".incident_management_team
    ADD CONSTRAINT incident_management_team_pkey PRIMARY KEY (imt_id);


--
-- TOC entry 5857 (class 2606 OID 21069)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 5855 (class 2606 OID 21060)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (u_id);


--
-- TOC entry 5860 (class 2606 OID 21376)
-- Name: user role; Type: FK CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT role FOREIGN KEY (role_id) REFERENCES "user".role(role_id) NOT VALID;


--
-- TOC entry 5861 (class 2606 OID 21371)
-- Name: user system_agency; Type: FK CONSTRAINT; Schema: user; Owner: postgres
--

ALTER TABLE ONLY "user"."user"
    ADD CONSTRAINT system_agency FOREIGN KEY (syag_id) REFERENCES system_agency.system_agency(syag_id) NOT VALID;


--
-- TOC entry 6025 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE view_profile; Type: ACL; Schema: user; Owner: postgres
--

GRANT SELECT ON TABLE "user".view_profile TO "PDRRMO Staff";
GRANT SELECT ON TABLE "user".view_profile TO "LGU";
GRANT SELECT ON TABLE "user".view_profile TO "Check-In Agency";


--
-- TOC entry 6026 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE view_user; Type: ACL; Schema: user; Owner: postgres
--

GRANT SELECT ON TABLE "user".view_user TO "PDRRMO Admin";


-- Completed on 2026-03-12 10:43:04

--
-- PostgreSQL database dump complete
--

\unrestrict SOmmZEbnThzn7bNmyCATc1Zji8bAXwOd6woEcMYGqGEX9sIuMmVaf5qItCIjCLd


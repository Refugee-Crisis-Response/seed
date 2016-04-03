--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;


--
-- Name: country_id; Type: SEQUENCE; Schema: public; Owner: refugeuser
--

CREATE SEQUENCE country_id
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    MAXVALUE 10000000000
    CACHE 1;


ALTER TABLE country_id OWNER TO refugeuser;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: refugeuser; Tablespace:
--

CREATE TABLE countries (
    id integer DEFAULT nextval('country_id'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(2) NOT NULL
);

ALTER TABLE countries OWNER TO refugeuser;
--
-- Name: countries_pkey; Type: CONSTRAINT; Schema: public; Owner: refugeuser; Tablespace:
--
ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);

-- seed countries
INSERT INTO countries (name, slug) VALUES ('Slovenia', 'si');
INSERT INTO countries (name, slug) VALUES ('Croatia', 'hr');
INSERT INTO countries (name, slug) VALUES ('Serbia', 'rs');
INSERT INTO countries (name, slug) VALUES ('Macedonia', 'mk');
INSERT INTO countries (name, slug) VALUES ('Greece', 'gr');

--
-- Name: city_id; Type: SEQUENCE; Schema: public; Owner: refugeuser
--

CREATE SEQUENCE city_id
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 10000000000
    CACHE 1;


ALTER TABLE city_id OWNER TO refugeuser;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: refugeuser; Tablespace:
--

CREATE TABLE cities (
    id integer DEFAULT nextval('city_id'::regclass) NOT NULL,
    country_id integer NOT NULL,
    data jsonb NOT NULL,
    lat float NOT NULL,
    lng float NOT NULL,
    geo geometry(Point,4326) NOT NULL
    --CONSTRAINT enforce_dims_geom CHECK ((st_ndims(geo) = 2)),
    --CONSTRAINT enforce_srid_geom CHECK ((st_srid(point) = 4326))
);
--
-- Name: fk_countrycity; Type: FK CONSTRAINT; Schema: public; Owner: refugeuser
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT fk_countrycity FOREIGN KEY (country_id) REFERENCES countries(id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Name: idx_cities_geo; Type: INDEX; Schema: public; Owner: refugeuser; Tablespace:
--

CREATE INDEX idx_cities_geo ON cities USING gist (geo);


ALTER TABLE cities OWNER TO refugeuser;

--
-- Name: cities_pkey; Type: CONSTRAINT; Schema: public; Owner: refugeuser; Tablespace:
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);

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
-- Name: airports; Type: TABLE; Schema: public; Owner: rsuser; Tablespace: 
--

CREATE TABLE airports (
    airport character varying(35),
    iata character varying(3),
    latitude double precision,
    longitude double precision,
    gid integer NOT NULL,
    geom geometry(Point,4326)
);


ALTER TABLE airports OWNER TO rsuser;

--
-- Name: airports_gid_seq; Type: SEQUENCE; Schema: public; Owner: rsuser
--

CREATE SEQUENCE airports_gid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE airports_gid_seq OWNER TO rsuser;

--
-- Name: airports_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rsuser
--

ALTER SEQUENCE airports_gid_seq OWNED BY airports.gid;


--
-- Name: city_id; Type: SEQUENCE; Schema: public; Owner: rsuser
--

CREATE SEQUENCE city_id
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 10000000000
    CACHE 1;


ALTER TABLE city_id OWNER TO rsuser;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: rsuser; Tablespace: 
--

CREATE TABLE cities (
    id integer DEFAULT nextval('city_id'::regclass) NOT NULL,
    country_id integer NOT NULL,
    data jsonb NOT NULL,
    point geometry,
    location geometry(Point,4326),
    CONSTRAINT enforce_dims_geom CHECK ((st_ndims(point) = 2)),
    CONSTRAINT enforce_srid_geom CHECK ((st_srid(point) = 4326))
);


ALTER TABLE cities OWNER TO rsuser;

--
-- Name: citypoints; Type: VIEW; Schema: public; Owner: rsuser
--

CREATE VIEW citypoints AS
 SELECT cities.id,
    ((cities.data -> 'location'::text) ->> 'coordinates'::text) AS point
   FROM cities;


ALTER TABLE citypoints OWNER TO rsuser;

--
-- Name: country_id; Type: SEQUENCE; Schema: public; Owner: rsuser
--

CREATE SEQUENCE country_id
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    MAXVALUE 10000000000
    CACHE 1;


ALTER TABLE country_id OWNER TO rsuser;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: rsuser; Tablespace: 
--

CREATE TABLE countries (
    id integer DEFAULT nextval('country_id'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(2) NOT NULL
);


ALTER TABLE countries OWNER TO rsuser;

--
-- Name: mytable; Type: TABLE; Schema: public; Owner: rsuser; Tablespace: 
--

CREATE TABLE mytable (
    id integer NOT NULL,
    geom geometry(Point,26910),
    name character varying(128)
);


ALTER TABLE mytable OWNER TO rsuser;

--
-- Name: mytable_id_seq; Type: SEQUENCE; Schema: public; Owner: rsuser
--

CREATE SEQUENCE mytable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mytable_id_seq OWNER TO rsuser;

--
-- Name: mytable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: rsuser
--

ALTER SEQUENCE mytable_id_seq OWNED BY mytable.id;


--
-- Name: gid; Type: DEFAULT; Schema: public; Owner: rsuser
--

ALTER TABLE ONLY airports ALTER COLUMN gid SET DEFAULT nextval('airports_gid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: rsuser
--

ALTER TABLE ONLY mytable ALTER COLUMN id SET DEFAULT nextval('mytable_id_seq'::regclass);


--
-- Data for Name: airports; Type: TABLE DATA; Schema: public; Owner: rsuser
--

COPY airports (airport, iata, latitude, longitude, gid, geom) FROM stdin;
Amsterdam Airport Schiphol	AMS	52.3083329999999975	4.76083299999999987	1	0101000020E6100000CADE52CE170B134087A3AB7477274A40
Rotterdam The Hague Airport	RTM	51.9500000000000028	4.43333300000000019	2	0101000020E61000003B1C5DA5BBBB11409A99999999F94940
Groningen Airport Eelde	GRQ	53.125	6.58333299999999966	3	0101000020E6100000D4B5F63E55551A400000000000904A40
Eindhoven Airport	EIN	51.4502779999999973	5.37444400000000044	4	0101000020E6100000D4BB783F6E7F1540DC0DA2B5A2B94940
Maastricht Aachen Airport	MST	50.9158329999999992	5.7769440000000003	5	0101000020E6100000304B3B35971B17407DCC07043A754940
Slavonski Brod	SLV	45.1214862497281572	18.1827459876625959	6	0101000020E61000006F7CE870C82E324081BF86DC8C8F4640
\.


--
-- Name: airports_gid_seq; Type: SEQUENCE SET; Schema: public; Owner: rsuser
--

SELECT pg_catalog.setval('airports_gid_seq', 6, true);


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: rsuser
--

COPY cities (id, country_id, data, point, location) FROM stdin;
1023	10009	{"name": "Gevgelija", "slug": "gevgelija", "location": {"type": "Point", "coordinates": [22.559117385137807, 41.185201896245005]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}, {"name": "ελληνικά", "iso_code": "el"}]}	0101000020E6100000C6C31BB2B4974440BBCA2351228F3640	0101000020E6100000BBCA2351228F3640C6C31BB2B4974440
1024	10009	{"name": "Tabanovce", "slug": "tabanovce", "location": {"type": "Point", "coordinates": [21.370073048295453, 42.19233883966582]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000C20E218F9E1845405C8F771BBD5E3540	0101000020E61000005C8F771BBD5E3540C20E218F9E184540
1025	10008	{"name": "Šid", "slug": "sid", "location": {"type": "Point", "coordinates": [19.24062981831459, 45.05329417972237]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000C47CFB57D2864640851A70EA993D3340	0101000020E6100000851A70EA993D3340C47CFB57D2864640
1026	10008	{"name": "Dimitrovgrad", "slug": "dimitrovgrad", "location": {"type": "Point", "coordinates": [22.789617148636175, 43.03797535823633]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000E7D66460DC844540CEC0755924CA3640	0101000020E6100000CEC0755924CA3640E7D66460DC844540
1027	10008	{"name": "Belgrade", "slug": "belgrade", "location": {"type": "Point", "coordinates": [20.417387225801477, 44.64665540113782]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E610000098D5AB9AC5524640E495A4E3D96A3440	0101000020E6100000E495A4E3D96A344098D5AB9AC5524640
1028	10008	{"name": "Preševo", "slug": "presevo", "location": {"type": "Point", "coordinates": [21.5478518125, 42.551891396484]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000D96B9560A4464540E8BD3104408C3540	0101000020E6100000E8BD3104408C3540D96B9560A4464540
1029	10010	{"name": "Kos", "slug": "kos", "location": {"type": "Point", "coordinates": [27.138771209742593, 36.805099224266016]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000F620CB7D0D67424086788F8286233B40	0101000020E610000086788F8286233B40F620CB7D0D674240
1030	10010	{"name": "Lesvos", "slug": "lesvos", "location": {"type": "Point", "coordinates": [26.242763215497117, 39.172495700881015]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "ελληνικά", "iso_code": "el"}, {"name": "فارسی", "iso_code": "fa"}, {"name": "العَرَبِية‎", "iso_code": "ar"}]}	0101000020E610000006FED056149643405F3BE7BA253E3A40	0101000020E61000005F3BE7BA253E3A4006FED05614964340
1031	10010	{"name": "Athens", "slug": "athens", "location": {"type": "Point", "coordinates": [23.731520963059328, 37.97212495658848]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}, {"name": "ελληνικά", "iso_code": "el"}]}	0101000020E6100000231630976EFC4240A1AD34F544BB3740	0101000020E6100000A1AD34F544BB3740231630976EFC4240
1032	10010	{"name": "Chios", "slug": "chios", "location": {"type": "Point", "coordinates": [26.03028640606146, 38.40350034870331]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}, {"name": "ελληνικά", "iso_code": "el"}]}	0101000020E61000007BCD40E6A53343401F8C93D9C0073A40	0101000020E61000001F8C93D9C0073A407BCD40E6A5334340
1033	10010	{"name": "Leros", "slug": "leros", "location": {"type": "Point", "coordinates": [26.816105144646993, 37.15716967523022]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000B484CB221E9442402F5B4A44ECD03A40	0101000020E61000002F5B4A44ECD03A40B484CB221E944240
1034	10010	{"name": "Idomeni", "slug": "idomeni", "location": {"type": "Point", "coordinates": [22.51733676365528, 41.07339151067995]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E610000053169DE464894440FCEAA02E70843640	0101000020E6100000FCEAA02E7084364053169DE464894440
1035	10010	{"name": "Samos", "slug": "samos", "location": {"type": "Point", "coordinates": [26.824817547562535, 37.733387891251844]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000C31A88A7DFDD4240B1F2273E27D33A40	0101000020E6100000B1F2273E27D33A40C31A88A7DFDD4240
1020	10007	{"name": "Slavonski Brod", "slug": "slavonski-brod", "location": {"type": "Point", "coordinates": [18.182745987662596, 45.12148624972816]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E610000081BF86DC8C8F46406F7CE870C82E3240	0101000020E61000006F7CE870C82E324081BF86DC8C8F4640
1021	10006	{"name": "Dobova", "slug": "dobova", "location": {"type": "Point", "coordinates": [15.620330028544704, 45.931486874245195]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E6100000A8C43EF63AF746400AA7C2E59B3D2F40	0101000020E61000000AA7C2E59B3D2F40A8C43EF63AF74640
1022	10006	{"name": "Sentilj", "slug": "sentilj", "location": {"type": "Point", "coordinates": [15.720744877744817, 46.67735038546273]}, "languages": [{"name": "English", "iso_code": "en"}, {"name": "العَرَبِية‎", "iso_code": "ar"}, {"name": "فارسی", "iso_code": "fa"}]}	0101000020E61000006ABFDC6AB3564740D658FD7805712F40	0101000020E6100000D658FD7805712F406ABFDC6AB3564740
\.


--
-- Name: city_id; Type: SEQUENCE SET; Schema: public; Owner: rsuser
--

SELECT pg_catalog.setval('city_id', 1035, true);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: rsuser
--

COPY countries (id, name, slug) FROM stdin;
10006	Slovenia	si
10007	Croatia	hr
10008	Serbia	rs
10009	Macedonia	mk
10010	Greece	gr
\.


--
-- Name: country_id; Type: SEQUENCE SET; Schema: public; Owner: rsuser
--

SELECT pg_catalog.setval('country_id', 10010, true);


--
-- Data for Name: mytable; Type: TABLE DATA; Schema: public; Owner: rsuser
--

COPY mytable (id, geom, name) FROM stdin;
1	01010000201E69000000000000000000000000000000000000	scheiner
\.


--
-- Name: mytable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: rsuser
--

SELECT pg_catalog.setval('mytable_id_seq', 1, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY spatial_ref_sys  FROM stdin;
\.


SET search_path = topology, pg_catalog;

--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology  FROM stdin;

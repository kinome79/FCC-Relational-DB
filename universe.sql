--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: function; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.function (
    function_id integer NOT NULL,
    function character varying(15) NOT NULL,
    account_code character varying(15) NOT NULL,
    name character varying(20)
);


ALTER TABLE public.function OWNER TO freecodecamp;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    diameter_in_ly integer,
    type character varying(20) NOT NULL,
    addn_info text,
    designation character varying(15)
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    radius_in_mi integer,
    planet_id integer,
    tidally_locked boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    radius_in_mi integer,
    has_water boolean DEFAULT false NOT NULL,
    oxy_ratio numeric(4,3),
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: purpose_purpose_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.purpose_purpose_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purpose_purpose_id_seq OWNER TO freecodecamp;

--
-- Name: purpose_purpose_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.purpose_purpose_id_seq OWNED BY public.function.function_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    mass_in_mo numeric(5,4),
    radius_in_mi integer,
    type character varying(15) NOT NULL,
    temp_in_k integer,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: station; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.station (
    station_id integer NOT NULL,
    name character varying(30) NOT NULL,
    type character varying(15) NOT NULL,
    planet_id integer,
    moon_id integer,
    function_id integer NOT NULL,
    CONSTRAINT planet_or_moon CHECK (((planet_id IS NULL) <> (moon_id IS NULL))),
    CONSTRAINT station_type_check CHECK ((((type)::text = 'ORBITAL'::text) OR ((type)::text = 'TERRESTRIAL'::text)))
);


ALTER TABLE public.station OWNER TO freecodecamp;

--
-- Name: station_station_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.station_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.station_station_id_seq OWNER TO freecodecamp;

--
-- Name: station_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.station_station_id_seq OWNED BY public.station.station_id;


--
-- Name: function function_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.function ALTER COLUMN function_id SET DEFAULT nextval('public.purpose_purpose_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: station station_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station ALTER COLUMN station_id SET DEFAULT nextval('public.station_station_id_seq'::regclass);


--
-- Data for Name: function; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.function VALUES (1, 'Military', 'MIL-2839A-2BB', 'MilSpec Corp');
INSERT INTO public.function VALUES (2, 'Storage', 'STR-889B-C84', 'Warhouse Association');
INSERT INTO public.function VALUES (3, 'Residential', 'RES-BB42-866', 'Space Living Fnd');
INSERT INTO public.function VALUES (4, 'Manufacturing', 'MFG-2100-AB3', 'Mfg Build Corp');
INSERT INTO public.function VALUES (5, 'Communication', 'COM-CRR8-CCD', 'Interplanet Web Inc');
INSERT INTO public.function VALUES (6, 'Research', 'RCH-89LK-FAR', 'Space Discoveries');
INSERT INTO public.function VALUES (7, 'Medical', 'MED-5TE3-SDL', 'SpaceMed Care Inc');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (2, 'Andromeda', 152000, 'Barred Spiral', 'Nearest to the Milky Way, extremely large with redshift of -0.001004', 'NGC 224');
INSERT INTO public.galaxy VALUES (1, 'Milky Way', 87400, 'Barred Spiral', 'A thin disk-like galaxy with a thickness of 1000ly, with a dark matter area.', 'MWG');
INSERT INTO public.galaxy VALUES (3, 'Canis Major Dwarf', 10000, 'Dward Irregular', 'Small galaxy with high percentage of Red Giants, about 25,000 from MWG.', 'PGC 5065047');
INSERT INTO public.galaxy VALUES (4, 'Segue 1', 400, 'Dwarf Spheroidal', 'Slightly elongated shape due to MWG tidal forces, about 75000 ly from Sun', 'PGC 4713559');
INSERT INTO public.galaxy VALUES (5, 'Sagittarius', 10000, 'Dwarf Spheroidal', 'Has four globular clusters in its main body, and headed for MWG', 'SGR DSPH');
INSERT INTO public.galaxy VALUES (6, 'Draco Dwarf', 1195, 'Spheroidal', 'Has large amounts of dark matter, one of the faintest in appearance', 'PGC 60095');


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (5, 'Phobos', 7, 5, true);
INSERT INTO public.moon VALUES (6, 'Phoebe', 106, 2, false);
INSERT INTO public.moon VALUES (7, 'Rhea', 474, 2, true);
INSERT INTO public.moon VALUES (1, 'Luna(Moon)', 1080, 1, true);
INSERT INTO public.moon VALUES (2, 'Titan', 1599, 2, true);
INSERT INTO public.moon VALUES (3, 'Urictus', 985, 4, false);
INSERT INTO public.moon VALUES (4, 'Nikan', 2388, 6, false);
INSERT INTO public.moon VALUES (8, 'Procta', 1282, 3, false);
INSERT INTO public.moon VALUES (9, 'M-82-E5X', 829, 10, false);
INSERT INTO public.moon VALUES (10, 'Xena', 233, 12, true);
INSERT INTO public.moon VALUES (11, 'Cat-Tail', 917, 7, true);
INSERT INTO public.moon VALUES (12, 'Mikan', 3813, 6, false);
INSERT INTO public.moon VALUES (13, 'Incan', 1122, 8, true);
INSERT INTO public.moon VALUES (14, 'Boda', 655, 9, true);
INSERT INTO public.moon VALUES (15, 'Oriathan', 1878, 11, false);
INSERT INTO public.moon VALUES (16, 'Athena', 382, 12, true);
INSERT INTO public.moon VALUES (17, 'Kitera', 588, 7, true);
INSERT INTO public.moon VALUES (18, 'Bagoda', 892, 8, false);
INSERT INTO public.moon VALUES (19, 'Jinks', 712, 4, true);
INSERT INTO public.moon VALUES (20, 'Satos', 481, 3, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Earth', 3959, true, 0.210, 6);
INSERT INTO public.planet VALUES (2, 'Saturn', 36184, false, 0.000, 6);
INSERT INTO public.planet VALUES (4, 'Ilus', 2932, true, 0.300, 3);
INSERT INTO public.planet VALUES (6, 'Tarterus', 12839, false, 0.121, 1);
INSERT INTO public.planet VALUES (5, 'Mars', 2106, false, 0.001, 6);
INSERT INTO public.planet VALUES (3, 'Ceres', 4899, true, 0.293, 7);
INSERT INTO public.planet VALUES (7, 'Pathos', 6218, false, 0.428, 2);
INSERT INTO public.planet VALUES (8, 'Trigon', 4128, true, 0.224, 4);
INSERT INTO public.planet VALUES (9, 'Patheos', 3142, false, 0.112, 2);
INSERT INTO public.planet VALUES (10, 'G-5829', 2218, false, 0.093, 5);
INSERT INTO public.planet VALUES (11, 'Galos', 3829, true, 0.281, 7);
INSERT INTO public.planet VALUES (12, 'Zeta Prime', 5182, false, 0.098, 1);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Proxima Centauri', 0.1221, 66659, 'Red Dwarf', 2992, 1);
INSERT INTO public.star VALUES (2, 'Polaris', 5.4000, 16217788, 'Supergiant', 6015, 1);
INSERT INTO public.star VALUES (3, 'Alpheratz', 3.8000, 1167177, 'Spectroscopic', 8500, 2);
INSERT INTO public.star VALUES (4, 'Zeta Sagittarii', 5.2600, 432350, 'Spectral', 8799, 5);
INSERT INTO public.star VALUES (5, 'Sirius', 2.0630, 739644, 'White Main-Sequ', 9940, 3);
INSERT INTO public.star VALUES (6, 'Sol(Sun)', 1.0000, 432686, 'Yellow Dwarf', 5772, 1);
INSERT INTO public.star VALUES (7, 'Kepler-90', 1.2000, 518746, 'G-Type', 6080, 1);


--
-- Data for Name: station; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.station VALUES (1, 'Titan Depot', 'TERRESTRIAL', NULL, 2, 2);
INSERT INTO public.station VALUES (4, 'Mil Post 82', 'TERRESTRIAL', 5, NULL, 1);
INSERT INTO public.station VALUES (5, 'Mil Post 11', 'ORBITAL', 1, NULL, 1);
INSERT INTO public.station VALUES (6, 'Mars Prime', 'TERRESTRIAL', 5, NULL, 3);
INSERT INTO public.station VALUES (7, 'Urgent Care Sat', 'ORBITAL', 2, NULL, 7);
INSERT INTO public.station VALUES (8, 'Deep Space Discovery', 'ORBITAL', NULL, 12, 6);
INSERT INTO public.station VALUES (9, 'Zeta Station Builders', 'TERRESTRIAL', NULL, 14, 4);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: purpose_purpose_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.purpose_purpose_id_seq', 7, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 7, true);


--
-- Name: station_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.station_station_id_seq', 9, true);


--
-- Name: function function_function_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.function
    ADD CONSTRAINT function_function_key UNIQUE (function);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: function purpose_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.function
    ADD CONSTRAINT purpose_pkey PRIMARY KEY (function_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: station station_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_name_key UNIQUE (name);


--
-- Name: station station_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: station station_function_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_function_fkey FOREIGN KEY (function_id) REFERENCES public.function(function_id);


--
-- Name: station station_moon_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_moon_id_fkey FOREIGN KEY (moon_id) REFERENCES public.moon(moon_id);


--
-- Name: station station_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.station
    ADD CONSTRAINT station_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- PostgreSQL database dump complete
--


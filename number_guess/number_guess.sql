--
-- PostgreSQL database dump
--

-- Dumped from database version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22),
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (70, 'user_1678374296960', 2, 719);
INSERT INTO public.users VALUES (69, 'user_1678374296961', 5, 185);
INSERT INTO public.users VALUES (1, 'Jackerackerrukiwakitai', 2, 10);
INSERT INTO public.users VALUES (3, 'BillyBob', 1, 9);
INSERT INTO public.users VALUES (72, 'user_1678374329409', 2, 190);
INSERT INTO public.users VALUES (71, 'user_1678374329410', 5, 26);
INSERT INTO public.users VALUES (2, 'kinome79', 6, 11);
INSERT INTO public.users VALUES (74, 'user_1678374401871', 2, 731);
INSERT INTO public.users VALUES (73, 'user_1678374401872', 5, 269);
INSERT INTO public.users VALUES (54, 'user_1678374062063', 2, 527);
INSERT INTO public.users VALUES (53, 'user_1678374062064', 5, 302);
INSERT INTO public.users VALUES (76, 'user_1678374439528', 2, 144);
INSERT INTO public.users VALUES (56, 'user_1678374068168', 2, 526);
INSERT INTO public.users VALUES (75, 'user_1678374439529', 5, 221);
INSERT INTO public.users VALUES (55, 'user_1678374068169', 5, 254);
INSERT INTO public.users VALUES (58, 'user_1678374144252', 2, 218);
INSERT INTO public.users VALUES (78, 'user_1678374534770', 2, 24);
INSERT INTO public.users VALUES (57, 'user_1678374144253', 5, 112);
INSERT INTO public.users VALUES (77, 'user_1678374534771', 5, 140);
INSERT INTO public.users VALUES (60, 'user_1678374177017', 2, 397);
INSERT INTO public.users VALUES (59, 'user_1678374177018', 5, 165);
INSERT INTO public.users VALUES (62, 'user_1678374193708', 2, 267);
INSERT INTO public.users VALUES (80, 'user_1678374546361', 2, 255);
INSERT INTO public.users VALUES (61, 'user_1678374193709', 5, 122);
INSERT INTO public.users VALUES (79, 'user_1678374546362', 5, 242);
INSERT INTO public.users VALUES (64, 'user_1678374219611', 2, 66);
INSERT INTO public.users VALUES (63, 'user_1678374219612', 5, 152);
INSERT INTO public.users VALUES (66, 'user_1678374228273', 2, 205);
INSERT INTO public.users VALUES (65, 'user_1678374228274', 5, 323);
INSERT INTO public.users VALUES (68, 'user_1678374287765', 2, 639);
INSERT INTO public.users VALUES (67, 'user_1678374287766', 5, 276);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 80, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--


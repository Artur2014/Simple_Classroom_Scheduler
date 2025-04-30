--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.17 (Homebrew)

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
-- Name: classes; Type: TABLE; Schema: public; Owner: arturtorosyan
--

CREATE TABLE public.classes (
    id integer NOT NULL,
    class_name character varying(255),
    start_time time without time zone,
    end_time time without time zone
);


ALTER TABLE public.classes OWNER TO arturtorosyan;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: arturtorosyan
--

CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.classes_id_seq OWNER TO arturtorosyan;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arturtorosyan
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- Name: rooms; Type: TABLE; Schema: public; Owner: arturtorosyan
--

CREATE TABLE public.rooms (
    id integer NOT NULL,
    room_name character varying(255),
    capacity integer
);


ALTER TABLE public.rooms OWNER TO arturtorosyan;

--
-- Name: rooms_id_seq; Type: SEQUENCE; Schema: public; Owner: arturtorosyan
--

CREATE SEQUENCE public.rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rooms_id_seq OWNER TO arturtorosyan;

--
-- Name: rooms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arturtorosyan
--

ALTER SEQUENCE public.rooms_id_seq OWNED BY public.rooms.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: arturtorosyan
--

CREATE TABLE public.schedules (
    id integer NOT NULL,
    class_id integer,
    room_id integer,
    schedule_time timestamp without time zone
);


ALTER TABLE public.schedules OWNER TO arturtorosyan;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: arturtorosyan
--

CREATE SEQUENCE public.schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.schedules_id_seq OWNER TO arturtorosyan;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arturtorosyan
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- Name: rooms id; Type: DEFAULT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.rooms ALTER COLUMN id SET DEFAULT nextval('public.rooms_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: arturtorosyan
--

COPY public.classes (id, class_name, start_time, end_time) FROM stdin;
1	Math 101	09:00:00	10:30:00
2	Physics 101	11:00:00	12:30:00
3	Chemistry 101	13:00:00	14:30:00
4	Math 101	09:00:00	10:30:00
5	Physics 101	11:00:00	12:30:00
6	Chemistry 101	13:00:00	14:30:00
7	Math 101	09:00:00	10:30:00
8	Physics 101	11:00:00	12:30:00
9	Chemistry 101	13:00:00	14:30:00
10	Math 101	09:00:00	10:30:00
11	Physics 101	11:00:00	12:30:00
12	Chemistry 101	13:00:00	14:30:00
13	Math 101	09:00:00	10:30:00
14	Physics 101	11:00:00	12:30:00
15	Chemistry 101	13:00:00	14:30:00
16	Math 101	09:00:00	10:30:00
17	Physics 101	11:00:00	12:30:00
18	Chemistry 101	13:00:00	14:30:00
19	Math 101	09:00:00	10:30:00
20	Physics 101	11:00:00	12:30:00
21	Chemistry 101	13:00:00	14:30:00
22	Math 101	09:00:00	10:30:00
23	Physics 101	11:00:00	12:30:00
24	Chemistry 101	13:00:00	14:30:00
25	Math 101	09:00:00	10:30:00
26	Physics 101	11:00:00	12:30:00
27	Chemistry 101	13:00:00	14:30:00
28	Math 101	09:00:00	10:30:00
29	Physics 101	11:00:00	12:30:00
30	Chemistry 101	13:00:00	14:30:00
\.


--
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: arturtorosyan
--

COPY public.rooms (id, room_name, capacity) FROM stdin;
1	Room A	30
2	Room B	25
3	Room C	40
4	Room A	30
5	Room B	25
6	Room C	40
7	Room A	30
8	Room B	25
9	Room C	40
10	Room A	30
11	Room B	25
12	Room C	40
13	Room A	30
14	Room B	25
15	Room C	40
16	Room A	30
17	Room B	25
18	Room C	40
19	Room A	30
20	Room B	25
21	Room C	40
22	Room A	30
23	Room B	25
24	Room C	40
25	Room A	30
26	Room B	25
27	Room C	40
28	Room A	30
29	Room B	25
30	Room C	40
\.


--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: arturtorosyan
--

COPY public.schedules (id, class_id, room_id, schedule_time) FROM stdin;
2	2	2	2025-04-27 11:00:00
4	1	2	2025-04-27 14:00:00
5	1	1	2025-04-27 09:00:00
6	2	2	2025-04-27 11:00:00
7	3	3	2025-04-27 13:00:00
8	1	2	2025-04-27 14:00:00
9	1	1	2025-04-27 09:00:00
10	2	2	2025-04-27 11:00:00
11	3	3	2025-04-27 13:00:00
12	1	2	2025-04-27 14:00:00
13	1	1	2025-04-27 09:00:00
14	2	2	2025-04-27 11:00:00
15	3	3	2025-04-27 13:00:00
16	1	2	2025-04-27 14:00:00
17	1	1	2025-04-27 09:00:00
18	2	2	2025-04-27 11:00:00
19	3	3	2025-04-27 13:00:00
20	1	2	2025-04-27 14:00:00
21	1	1	2025-04-27 09:00:00
22	2	2	2025-04-27 11:00:00
23	3	3	2025-04-27 13:00:00
24	1	2	2025-04-27 14:00:00
25	1	1	2025-04-27 09:00:00
26	2	2	2025-04-27 11:00:00
27	3	3	2025-04-27 13:00:00
28	1	2	2025-04-27 14:00:00
29	1	1	2025-04-27 09:00:00
30	2	2	2025-04-27 11:00:00
31	3	3	2025-04-27 13:00:00
32	1	2	2025-04-27 14:00:00
33	1	1	2025-04-27 09:00:00
34	2	2	2025-04-27 11:00:00
35	3	3	2025-04-27 13:00:00
36	1	2	2025-04-27 14:00:00
37	1	1	2025-04-27 09:00:00
38	2	2	2025-04-27 11:00:00
39	3	3	2025-04-27 13:00:00
40	1	2	2025-04-27 14:00:00
1	1	1	2025-04-27 10:00:00
\.


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arturtorosyan
--

SELECT pg_catalog.setval('public.classes_id_seq', 30, true);


--
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arturtorosyan
--

SELECT pg_catalog.setval('public.rooms_id_seq', 30, true);


--
-- Name: schedules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arturtorosyan
--

SELECT pg_catalog.setval('public.schedules_id_seq', 40, true);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: rooms rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- Name: schedules schedules_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arturtorosyan
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.rooms(id);


--
-- PostgreSQL database dump complete
--


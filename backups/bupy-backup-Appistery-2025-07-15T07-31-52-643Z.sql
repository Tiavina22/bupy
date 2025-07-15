--
-- PostgreSQL database dump
--

-- Dumped from database version 12.19
-- Dumped by pg_dump version 12.19

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

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: APPISTERY_abonnement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_abonnement" (
    id integer NOT NULL,
    "usersId" uuid NOT NULL,
    "idPaiement" character varying(50) NOT NULL,
    etat character varying(50) NOT NULL,
    "dateCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "dateFin" timestamp without time zone
);


ALTER TABLE public."APPISTERY_abonnement" OWNER TO postgres;

--
-- Name: APPISTERY_abonnement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_abonnement_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_abonnement_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_abonnement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_abonnement_id_seq" OWNED BY public."APPISTERY_abonnement".id;


--
-- Name: APPISTERY_ads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_ads" (
    id integer NOT NULL,
    title character varying(200),
    content text,
    image character varying(250),
    etat integer DEFAULT 0 NOT NULL,
    price bigint,
    "order" bigint,
    type character varying(200),
    link character varying(200),
    facebook character varying(200)
);


ALTER TABLE public."APPISTERY_ads" OWNER TO postgres;

--
-- Name: APPISTERY_ads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_ads_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_ads_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_ads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_ads_id_seq" OWNED BY public."APPISTERY_ads".id;


--
-- Name: APPISTERY_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_authors" (
    email text NOT NULL,
    "phoneNumber" text,
    password text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status boolean DEFAULT true,
    "resetPasswordToken" text,
    biography text,
    speciality text,
    avatar text,
    "cguAccepted" boolean DEFAULT false,
    username character varying(255),
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    id uuid DEFAULT public.gen_random_uuid() NOT NULL
);


ALTER TABLE public."APPISTERY_authors" OWNER TO postgres;

--
-- Name: APPISTERY_cgu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_cgu" (
    id integer NOT NULL,
    etat integer,
    "dateCreation" timestamp without time zone NOT NULL,
    "dateFin" timestamp without time zone,
    contenu text,
    CONSTRAINT "APPISTERY_cgu_etat_check" CHECK ((etat = ANY (ARRAY[0, 1])))
);


ALTER TABLE public."APPISTERY_cgu" OWNER TO postgres;

--
-- Name: APPISTERY_cgu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_cgu_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_cgu_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_cgu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_cgu_id_seq" OWNED BY public."APPISTERY_cgu".id;


--
-- Name: APPISTERY_chapters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_chapters" (
    id integer NOT NULL,
    "storyId" integer NOT NULL,
    title text NOT NULL,
    content text,
    "chapterNumber" integer,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status boolean DEFAULT true,
    "titleFr" text,
    "titleEng" text,
    "contentFr" text,
    "contentEng" text
);


ALTER TABLE public."APPISTERY_chapters" OWNER TO postgres;

--
-- Name: APPISTERY_chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_chapters_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_chapters_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_chapters_id_seq" OWNED BY public."APPISTERY_chapters".id;


--
-- Name: APPISTERY_choiceSubscription; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_choiceSubscription" (
    id integer NOT NULL,
    identifiant character varying(20) NOT NULL,
    number character varying(14) NOT NULL,
    "dateCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    appartenance character varying(50) NOT NULL,
    etat character varying(2),
    ussd character varying(255)
);


ALTER TABLE public."APPISTERY_choiceSubscription" OWNER TO postgres;

--
-- Name: APPISTERY_choiceSubscription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_choiceSubscription_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_choiceSubscription_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_choiceSubscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_choiceSubscription_id_seq" OWNED BY public."APPISTERY_choiceSubscription".id;


--
-- Name: APPISTERY_connect; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_connect" (
    id integer NOT NULL,
    "userId" uuid NOT NULL,
    "connectedAt" timestamp without time zone NOT NULL,
    "ipAddress" character varying(30),
    "connectionStatus" character varying(20),
    CONSTRAINT "APPISTERY_connect_connectionStatus_check" CHECK ((("connectionStatus")::text = ANY (ARRAY[('connected'::character varying)::text, ('disconnected'::character varying)::text])))
);


ALTER TABLE public."APPISTERY_connect" OWNER TO postgres;

--
-- Name: APPISTERY_connect_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_connect_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_connect_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_connect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_connect_id_seq" OWNED BY public."APPISTERY_connect".id;


--
-- Name: APPISTERY_devices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_devices" (
    id integer NOT NULL,
    "usersId" uuid NOT NULL,
    "deviceId" text NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."APPISTERY_devices" OWNER TO postgres;

--
-- Name: APPISTERY_devices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_devices_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_devices_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_devices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_devices_id_seq" OWNED BY public."APPISTERY_devices".id;


--
-- Name: APPISTERY_favorites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_favorites" (
    id integer NOT NULL,
    "usersId" uuid NOT NULL,
    "storieId" integer NOT NULL,
    "isFavorite" boolean DEFAULT true,
    "dateCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."APPISTERY_favorites" OWNER TO postgres;

--
-- Name: APPISTERY_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_favorites_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_favorites_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_favorites_id_seq" OWNED BY public."APPISTERY_favorites".id;


--
-- Name: APPISTERY_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_genres" (
    id integer NOT NULL,
    title text NOT NULL,
    status boolean DEFAULT true
);


ALTER TABLE public."APPISTERY_genres" OWNER TO postgres;

--
-- Name: APPISTERY_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_genres_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_genres_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_genres_id_seq" OWNED BY public."APPISTERY_genres".id;


--
-- Name: APPISTERY_ip_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_ip_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_ip_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_ip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_ip" (
    id integer DEFAULT nextval('public."APPISTERY_ip_id_seq"'::regclass) NOT NULL,
    "ipValue" character varying(45) NOT NULL,
    "typeCompte" character varying(20) NOT NULL,
    "profileId" uuid,
    "authorId" uuid,
    CONSTRAINT check_type_compte CHECK ((("typeCompte")::text = ANY (ARRAY['profile'::text, 'author'::text])))
);


ALTER TABLE public."APPISTERY_ip" OWNER TO postgres;

--
-- Name: APPISTERY_markAsRead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_markAsRead" (
    id integer NOT NULL,
    "userId" uuid NOT NULL,
    "storyId" integer NOT NULL,
    "readAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "isRead" boolean
);


ALTER TABLE public."APPISTERY_markAsRead" OWNER TO postgres;

--
-- Name: APPISTERY_markAsRead_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_markAsRead_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_markAsRead_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_markAsRead_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_markAsRead_id_seq" OWNED BY public."APPISTERY_markAsRead".id;


--
-- Name: APPISTERY_offres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_offres" (
    id integer NOT NULL,
    nom text NOT NULL,
    "dateDebut" date DEFAULT now() NOT NULL,
    "dateFin" date,
    etat integer DEFAULT 1,
    avantages text,
    montant numeric(10,2) NOT NULL,
    "parMois" integer DEFAULT 1,
    devise text DEFAULT 'MGA'::text
);


ALTER TABLE public."APPISTERY_offres" OWNER TO postgres;

--
-- Name: APPISTERY_offres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_offres_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_offres_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_offres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_offres_id_seq" OWNED BY public."APPISTERY_offres".id;


--
-- Name: APPISTERY_paiement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_paiement" (
    id integer NOT NULL,
    "idProfiles" uuid,
    montant numeric(10,2) NOT NULL,
    "datePaiement" date NOT NULL,
    "dateFin" date,
    "etatPaiement" text,
    "dateCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "mobileMoneyChoice" text,
    "dateValidation" date,
    "idPaiement" character varying(10) NOT NULL,
    "references" character varying(30)
);


ALTER TABLE public."APPISTERY_paiement" OWNER TO postgres;

--
-- Name: APPISTERY_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_profiles" (
    id uuid NOT NULL,
    username text NOT NULL,
    email text,
    telephone text,
    "choiceOffre" text,
    "typeCompte" text,
    premium boolean DEFAULT false,
    "dateDebut" date,
    "dateFin" date,
    "dateCreation" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    avatar text,
    password text,
    "resetPassword" text,
    etat integer DEFAULT 1,
    "cguAccepted" boolean DEFAULT false
);


ALTER TABLE public."APPISTERY_profiles" OWNER TO postgres;

--
-- Name: APPISTERY_stories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_stories" (
    id integer NOT NULL,
    title text NOT NULL,
    "genreId" integer NOT NULL,
    synopsis text,
    "isPremium" boolean DEFAULT false,
    "coverImage" text,
    "publishedDate" date,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "chaptersCount" integer DEFAULT 0,
    status boolean DEFAULT true,
    "authorId" uuid,
    "synopsisFr" text,
    "synopsisEng" text
);


ALTER TABLE public."APPISTERY_stories" OWNER TO postgres;

--
-- Name: APPISTERY_stories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."APPISTERY_stories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."APPISTERY_stories_id_seq" OWNER TO postgres;

--
-- Name: APPISTERY_stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."APPISTERY_stories_id_seq" OWNED BY public."APPISTERY_stories".id;


--
-- Name: APPISTERY_versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_versions" (
    id integer NOT NULL,
    name text NOT NULL,
    version text NOT NULL,
    begin date NOT NULL,
    "end" date
);


ALTER TABLE public."APPISTERY_versions" OWNER TO postgres;

--
-- Name: APPISTERY_videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."APPISTERY_videos" (
    id text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    vimeo_url text NOT NULL,
    thumbnail_url text NOT NULL,
    duration text NOT NULL,
    category text NOT NULL,
    published_date timestamp without time zone NOT NULL,
    is_premium boolean DEFAULT false NOT NULL
);


ALTER TABLE public."APPISTERY_videos" OWNER TO postgres;

--
-- Name: appistery_paiement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appistery_paiement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appistery_paiement_id_seq OWNER TO postgres;

--
-- Name: appistery_paiement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appistery_paiement_id_seq OWNED BY public."APPISTERY_paiement".id;


--
-- Name: appistery_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appistery_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appistery_versions_id_seq OWNER TO postgres;

--
-- Name: appistery_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appistery_versions_id_seq OWNED BY public."APPISTERY_versions".id;


--
-- Name: APPISTERY_abonnement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_abonnement" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_abonnement_id_seq"'::regclass);


--
-- Name: APPISTERY_ads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_ads" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_ads_id_seq"'::regclass);


--
-- Name: APPISTERY_cgu id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_cgu" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_cgu_id_seq"'::regclass);


--
-- Name: APPISTERY_chapters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_chapters" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_chapters_id_seq"'::regclass);


--
-- Name: APPISTERY_choiceSubscription id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_choiceSubscription" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_choiceSubscription_id_seq"'::regclass);


--
-- Name: APPISTERY_connect id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_connect" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_connect_id_seq"'::regclass);


--
-- Name: APPISTERY_devices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_devices" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_devices_id_seq"'::regclass);


--
-- Name: APPISTERY_favorites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_favorites" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_favorites_id_seq"'::regclass);


--
-- Name: APPISTERY_genres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_genres" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_genres_id_seq"'::regclass);


--
-- Name: APPISTERY_markAsRead id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_markAsRead" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_markAsRead_id_seq"'::regclass);


--
-- Name: APPISTERY_offres id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_offres" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_offres_id_seq"'::regclass);


--
-- Name: APPISTERY_paiement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_paiement" ALTER COLUMN id SET DEFAULT nextval('public.appistery_paiement_id_seq'::regclass);


--
-- Name: APPISTERY_stories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_stories" ALTER COLUMN id SET DEFAULT nextval('public."APPISTERY_stories_id_seq"'::regclass);


--
-- Name: APPISTERY_versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_versions" ALTER COLUMN id SET DEFAULT nextval('public.appistery_versions_id_seq'::regclass);


--
-- Data for Name: APPISTERY_abonnement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_abonnement" (id, "usersId", "idPaiement", etat, "dateCreation", "dateFin") FROM stdin;
14	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	M79jiNQ46h	active	2025-06-23 11:00:10.083	2025-07-23 11:00:10.083
\.


--
-- Data for Name: APPISTERY_ads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_ads" (id, title, content, image, etat, price, "order", type, link, facebook) FROM stdin;
\.


--
-- Data for Name: APPISTERY_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_authors" (email, "phoneNumber", password, "createdAt", status, "resetPasswordToken", biography, speciality, avatar, "cguAccepted", username, "updatedAt", id) FROM stdin;
fitia@gmail.com	+26133222222	$2b$10$5I.Mb276cK78dzoDCWQzqecZ3t.tXpAWR2QvIH0inJEbAeap.j942	2025-06-08 18:12:34.981	t	\N	Brief description about the author	Author's main writing genre	https://th.bing.com/th/id/OIP.AWJeJd3YobOu_bvpvDVAgQHaHa?w=172&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7	t	Fitia	2025-06-08 18:12:34.981+03	60ce060e-2c44-432f-b7c1-5807f447ee23
\.


--
-- Data for Name: APPISTERY_cgu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_cgu" (id, etat, "dateCreation", "dateFin", contenu) FROM stdin;
1	1	2025-06-04 00:00:00	\N	Bienvenue sur Appistery, une plateforme de streaming de lecture vous permettant de découvrir des histoires vraies, mystérieuses, paranormales ou dramatiques, inspirées de la société malgache.\n\nEn créant un compte et/ou en effectuant un paiement sur Appistery, vous acceptez pleinement et sans réserve les présentes Conditions Générales d’Utilisation.\n\n1. Objet de l’application\nAppistery est une application de lecture numérique proposant un accès à des récits captivants, classés selon différents genres. L’accès à certaines histoires et fonctionnalités est réservé aux abonnés Premium.\n\n2. Création de compte\nLa création d’un compte est obligatoire pour utiliser l’application.\n\nUn compte est strictement lié à un seul appareil (téléphone). Toute tentative d’accès simultané ou répété à partir de plusieurs appareils peut entraîner la suspension automatique du compte.\n\nVous êtes responsable de vos identifiants de connexion. Toute utilisation frauduleuse de votre compte est sous votre responsabilité.\n\n3. Abonnement Premium\nL’abonnement Premium donne accès à des contenus exclusifs et des fonctionnalités supplémentaires.\n\nLe paiement de l’abonnement se fait uniquement via MVola (Mobile Money).\n\nLes tarifs et durées des abonnements sont clairement indiqués avant tout paiement.\n\nUne fois le paiement validé, l’abonnement est immédiatement activé. Aucun remboursement n’est prévu, sauf en cas d’erreur technique avérée de la part d’Appistery.\n\n4. Paiement via MVola\nEn procédant au paiement par MVola, vous vous engagez à suivre correctement les instructions de paiement indiquées dans l’application.\n\nAppistery ne peut être tenu responsable d'une erreur dans le numéro ou le montant saisi par l'utilisateur.\n\nEn cas de doute ou de problème lors du paiement, veuillez contacter notre support avant de renouveler ou répéter l’opération.\n\n5. Limitation d’accès\nUn compte est réservé à un seul utilisateur sur un seul téléphone.\n\nIl est strictement interdit de partager un compte avec d'autres personnes ou d'accéder à un même compte depuis plusieurs appareils.\n\nToute violation de cette règle pourra entraîner la désactivation temporaire ou définitive du compte, sans droit à remboursement.\n\n6. Propriété intellectuelle\nLe contenu proposé sur Appistery (textes, images, synopsis, etc.) est protégé par le droit d’auteur.\n\nIl est interdit de copier, capturer, enregistrer ou diffuser les histoires sans autorisation écrite préalable.\n\n7. Données personnelles\nVos données sont utilisées uniquement pour améliorer votre expérience utilisateur et assurer le bon fonctionnement de l’application.\n\nAucune donnée personnelle ne sera partagée avec des tiers sans votre consentement.\n\n8. Responsabilité\nAppistery n’est pas responsable des interruptions de service liées à des problèmes techniques, de réseau ou de maintenance.\n\nEn cas de perte d’accès à votre compte liée à une infraction aux CGU, aucun remboursement ne sera effectué.\n\n9. Résiliation\nVous pouvez à tout moment supprimer votre compte via l’application.\n\nAppistery peut suspendre ou supprimer un compte en cas de violation des présentes CGU, sans préavis ni remboursement.\n\n10. Modification des CGU\nLes présentes CGU peuvent être modifiées à tout moment. Toute modification vous sera notifiée via l’application.\n\nVotre utilisation continue de l’application après modification vaut acceptation des nouvelles conditions.\n\n11. Contact\nPour toute question ou réclamation :\n📧 appistery@gmail.mg\n\nEn cochant la case "J'accepte les CGU" lors de l'inscription ou du paiement, vous confirmez avoir lu et accepté l'ensemble de ces conditions.
\.


--
-- Data for Name: APPISTERY_chapters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_chapters" (id, "storyId", title, content, "chapterNumber", "createdAt", status, "titleFr", "titleEng", "contentFr", "contentEng") FROM stdin;
14	12	Hifanjevona	Efa niasa sy niampitapita tamina karazan-jotram-pitaterana maro ny tena, nanomboka \ntamin’ny fiara madinika ka hatramin’ny taxi-be, ary nifanehitra tamin’ny mpitandro \nfilaminana matetika. Tsy dia mahagaga loatra izany, satria ao anatin’ity sehatra ity dia tsy \nmaintsy misy fotoana hifanjevoana amin’izy ireo, indrindra rehefa misy fanitsakitsahana kely \namin’ny lalànan'ny fitnaterana. Ao ny fanasaziana samihafa rehefa misy fahadisoana kely \nataon’ny mpamily iny, toy ny tsy fanaovana akanjo madio fotsiny ohatra, na tsy fananana \ntaratasy feno, na koa tsy fahatomombanana amin'ny fiara izay mbola mitaky fanamboarana.\nNamana iray efa ela tsy nihaona tamiko no sendra nifankahita tamiko tamin’ny \ntambazotran-tserasera, tao amin'ny Facebook. Tsy nampoiziko moa, fa rehefa nahita ny \nsariny aho dia tsy nisalasala nanao commentaire kely, dia lasa tafaresaka. I D no anarany, \nolona efa niaraka niasa tamiko tany aloha tany ihany izy, mbola tao anatin’ilay sehatra \nfitaterana ihany koa. Izaho tenako moa i H no fiantson'iizay efa niara-niasa tamiko \nhatramin'ny ela.\n— Manao inona lesy ialahy amin'izao ? hoy izy tamiko, rehefa avy nifampiarahaba sy \nnifampizara vaovao kely.\n— Manao receveur lesy fa izay no misy aloha, tsy maintsy miary amin’ny misy aloha hatreto.\n— Izany ve ? Ary mety tsara izany raha miara-miasa isika roa lahy ? hoy izy sady nihomehy, \nohatran'ny tsy dia matotra tamin’ny voalohany, fa sady manovanova resaka ihany koa.\n— Fa ahoana ? Misy mety amiko angaha any ? hoy aho, sady faly ihany raha sanatria misy \ntokoa hirika, satria tamin’izay fotoana izay efa nanify ihany ny teo an-tanana.\n— Izaho io koa manao taxi-be anie e, hoy izy, ary ahy ihany ny fiara ampiasaiko sady izaho \nihany no mpitondra azy. Raha mazoto ialahy dia ialahy no goal.\n— Mety izany, hoy aho, fa ahoana ny goal an’ialahy any izany ? (ilay receveur miasa miaraka \naminy io, ho an'izay tsy mahalala).\n— Afindrako amina fiara hafa lesy izy fa ialahy no tiko hiara-hiasa amiko raha mety a.\nRaikitra izany, hoy aho taminy, satria ilay fiara iasako koa manko mbola simba ka mety \nmaharitra ny fanamboarana azy. Raha ny zava-misy, dia tsy mbola nisy antoka mazava hoe \nrahoviana no ho afaka hiasa amin’ilay fiara taloha, ka tsara raha misy zavatra atao haingana. \nDia nanaiky ny hiara-hiasa amin'i D aho, andro sabotsy izahay no niresaka ary nifanaraka fa \natomboka alatsinainy avy hatrany ny asa. Tsy niandry ela fa dia tonga dia miditra amin’ny \nfiainana vaovao indray amin’ny fiara vaovao sy mpiara-miasa vaovao, na dia olona efa \nnifankahitàna taloha aza.	1	2025-06-13 16:23:35.991956	t	\N	\N	\N	\N
15	12	Hifanitsaka	Tonga ny alatsinainy, raikitra ny asa. Tonga ara-potoana aho,maraindraina mihitsy, i D \nkoa efa teo. Niditra avy hatrany tamin’ny fiadivana ny andavanandro izahay. Tena nilamina \nkosa aloha ny zava-drehetra, mizotra tsara antsakany sy andavany. Na ny fitohanan’ny fiara, \nna ny fanomezan-dàlan'ny mpitandro filaminana, na ny fitondrana mpandeha dia niatsara \ntsikelikely amin’ny laoniny. Izahay koa miray loha tsara ka tsy mananosarotra ny fiarahana. \nSamy mifanaja sy mifampiresaka tsara, samy miezaka tsy hifanitsaka andraikitra.\nToy ny mahazatra moa, eny an-dàlana dia tsy mety tapaka ny fisian’ny mpitandro filaminana \nmanapaka. Na dia tsy nisy fahadisoana aza indraindray, dia mbola tapaka foana. Fomba \nfanao efa nahazo vahana moa ilay manolotra kely dia avela mandeha, efa lasa anisan'ny \nadidt tsy maintsy ataon'ny mpamily sy ny receveur toa anay izany.\nIndray andro àry, sendran’ny mpitandro filaminana masiaka sady mibontsimbontsina izay \nizahay. Vao mainka aza, raha jerena ny endriny sy ny fihetsiny, dia hita hoe efa nisafidy \nhaneho herisetra sy fanaparam-pahefana tsotr'izao. Avy hatrany moa dia nalainy ny papier, \ntsy nisy fika ho amin’ny fifampiresahana.\n– Fa misy inona lesy ? Hoy aho nanontany an’i D, sady niezaka nanafina fikoropahana.\n– Manana olana amiko iny ranamana iny. Hoy i D somary tsy taitra, toy ny efa nampoiziny \nizany ilay fihetsika, sady niala teo izahay. Efa nikôty ny ankiziko iny dia tsy zakany, ary rehefa \nfantany hoe izaho no niaraka tamin’ilay sipa noeritreretiny ho kotiana, dia tezitra izy.\nNangina vetivety izy, avy eo nanohy tamim-pitoniana, saingy hita sosotra ihany.\n– Aza gaga ialahy, fa vao mahita ahy iny dia rombotra be ohatr'izao foana, dia mila vaniny \namin’ny tsy antony.\nNiherika tany aminy moa aho, nijery farany somary gaga ihany. Ary noteneniko tamin’i D \nhoe olona fantatro ilay mpitandro filaminana teo, sady mpiray tanàna aminay mihitsy aza. \nTsy nampoiziko loatra satria raha tany an-tanàna, tsy dia hitako hoe toy izany ny fitondrany \ntena.\n– Izany ve lesy, hoy izy somary nandinika. Mahagaga mihitsy ilay toetran’olona sasany \namin'ity fananam-pahefana kely ity a, indrindra fa amin'ny madinika. Dia najanony any an-\ntanànanareo any angamba ny maha izy azy, fa rehefa mahazo galona kely sy kiririoka \narafesina, avy hatrany dia mampiasa izany ho fitaovana hitangosana ny tsy nafafy. Mbola ho \nazoko ireo, hoy izy namarana.	2	2025-06-13 16:23:36.023376	t	\N	\N	\N	\N
16	12	Rasefo	Dia toy ny mahazatra moa, isaky ny alahady tsy miasa fa repos. Andro iray isan-\nkerinandro ahafahana makamaka aina kely, miala sasatra amin’ny havizanana sy \nrotoroton'asa. Ka rehefa tsy miasa, hoe eny an-tanàna eny, dia fanaoko ny miaraka amin’ny \nnamana, manala azy, misotrosotro kely, milalao daomy, mifampizara vazivazy sy tantara \nmampihomehy… fotoana hialana voly sady hanadinoana ny zava-manahirana e.\nSendra teo am-pilalaovana daomy izahay tamin’izany, nilamina tsara, mihomehy sy \nnifandrangitra teo. Dia iny tampoka teo no nandalo rasefo. Vao nahita azy ny bandy \nmpilalao dia niarahaba azy avy hatrany, ho fanajana sy hoe fomba fataonay.\n– Salama, rasefo ! Hoy izahay niredona fa tsy novaliany akory. \nTsy nasiany sira mihitsy na kely aza nefa dia elakelatrano kely izany fa tsy arabe mikodana \nakory. Izy moa nitondra moto, dia ohatran'ny saika nianjera kely izy ka voadonany ilay \nlatabatra fialaovana daomy. Raraka daholo ny daomy, niparitaka tamin’ny tany, nipitika \nlavitra mihitsy ny sasany fa tsy mba nisy fialantsiny akory. Tsy nisy “azafady”, tsy nijery izay \nolona nanodidina azy izy fa ny lalany no nizorany.\n– Mba tsy rariny koa rangahy ilay toetran’ny olona ka… Hoy fotsiny aho.\nNy rehetra nanodidina moa nangina daholo fa hay tsy nisy nahasahy niteny na iray aza. Izay \nry zareo va nitantara tamiko fa misy fotoana mitaraina ny bandy eo an-tanàna, hoe misy \nmpitandro filaminana tonga tampotampoka dia mifaoka an’dry zalahy, lazainy fa mifoka \nrongony, nefa rehefa jerena dia tsy misy mifoka zava-mahadomelina akory na iray aza. Ary \nrehefa voasambotra any, dia tsy tafavoaka izany raha tsy mandoa vola.\nMatetika no misy io zavatra io ary efa tsy zoviana intsony amin'ny samy bandy eo an-tanàna, \nizaho tsy dia naharaka. Fantatra mihitsy fa ingahy mpitandro ny filaminana ihany no \nmamporisika ireo namany hisambotra ny bandy amin’ny fitadiavana vola sy filam-baniny. Ny \nmandreraka ary tena mahatsiravina dia olona tsy manan-tsiny foana no lasibatra.\nNandeha teny ihany ny fotoana ary sendra tafihaona tamina toeram-pisotroana iray tsy \nlavitra ny tanàna nipetrahanay izaho sy ilay mpitandro filaminana io. Tonga dia nentin’ny \nfitiavan-draha moa dia nangtaka fanazavana aho.\n– Fa maninona rasefo dia toa izahay no sazianareo matetika ? Samy mpiray tanàna ihany \nisika, tsy tokony hisy fankahalàna.\n– Ialahy tsy mandidy ahy, hoy izy hentitra. Mbola aiza no hanaovako an’ialahy isany, \nindrindra iny D iny !\nTampoka be ilay izy ka somary taitra aho ary tsy notohizako intsony ny resaka fa najanoko \nteo.	3	2025-06-13 16:23:36.062372	t	\N	\N	\N	\N
17	12	Rangit	Tonga ny alatsinainy dia nitohy toy ny mahazatra ny asa, nilona amin’ny fanao \nandavanandro fa ny andro sabotsy dia tafiaraka taminay tao anaty taxi-be ny anabavin’i D. \nBikana sady tsara tarehy tokoa ilay zazavavy, sady manintona tena, oy. I S no fiantsoana azy.\nNipetraka teo amin’ny devant moa aho tamin’izay, ka teo indrindra no nifanojo \ntamin’ingahy mpitandro ny filaminana indray. Toy ny mahazatra, nasainy naka sisiny indray \nny fiara.\n– Papier azafady, hoy izy, sady niteny mafy no niseho tezitra be ny anao lahy.\nNohamarininy teo moa ny taratasy, nosavainy ambony ambany, saingy rehefa hitany fa \nnilamina tsara dia nijery nivilana izy ka navelany nandeha ihany izahay.\n– Efa nosakanan’iny koa izaho sy ny sipako, hoy i S, dia nilany vaniny be mihitsy izahay \ntamin’izay. DiaeEfa nihaona taminy koa aho teny By Pass, teny amin'iny toeram-pirevena \niny, dia nilany vaniny ny sipako rehefa tsy nanaiky nokotiany aho.\n– Efa sangy mihoatra ny loha kosa ny ataon’iny izany. Hoy i D tena tezitra, aleo hifampitady \nkely fa efa matetika loatra ity. Tsy rariny intsony.\nDia nandeha teny ihany ny fiainana ka nisy fotoana aho nananihany an’i D :\n– Tiako lesy raha mba izaho no valilahin’ialahy.\nNihomehy fotsiny moa izy tamin’izay, dia hoy izy :\n– Reseho lahatra bavy fa izaho ve hanakana izay tiany e.\n– Kanto loatra ilay bavin’ialahy isany ka mahasarika olona be. \n– Anjaran’ialahy no miady koa. Fa ny olana izao, hoy hatrany i D, izy manana ny olon-tiany \niny ka sarotra vinavinaina ny fanirian’ialahy. \n– Marina lesy izany, hoy aho taminy. Ary dia nionona tamin’izay.\nMbola nisy fotoana iray indray izahay niara-taxi-be tamin’ilay anabaviny. Tamin’izay izy no \nnanontany ahy:\n– Ary mba aiza ny ankizin’i H ity e ? \n– Njy koa izany, hoy aho menatra azy… Any izy any e.\n– Mba ento aty hojerena e, izaho mbola tsy nahita, hoy hatrany izy. Ento izy amin’ny \nmanaraka dia mba mihaona eo isika.\nRaha mba fantatrao mantsy, hoy aho nitsiky maivana.\nTsy ela taorian’izay moa dia reko fa ho atao raharaha izy, nalahelo kely ny tenako satria \nnijanona ho nofinofy ihany ilay tantara. Nivady soa aman-tsara i S sy ny olon-tiany rehefa \nnitoe-jaza izy. Tsy nanjary ny taminay, dia navela teo fotsiny.\nI D moa, mpananihany hatrany, dia hoy izy nanatsafa ahy :\n– Fa naninona no navela lasan’olona ny entana e ?\n– Izaho lesy aza rangitina a, ialahy ity dia mahita hanalana ahy foana, hoy aho namaly azy.\nIzahay dia tena mpifananihany tsy misy ohatr’izany, efa samy mifampazaka tanteraka. Ary \nanisan’ny tsy nahafoizan’i D ahy koa io toetrako be sangisangy sy tsy mora maka lagy io.	4	2025-06-13 16:23:36.098064	t	\N	\N	\N	\N
18	14	fff	ttt	1	2025-06-23 12:19:37.427607	t	\N	\N	\N	\N
\.


--
-- Data for Name: APPISTERY_choiceSubscription; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_choiceSubscription" (id, identifiant, number, "dateCreation", appartenance, etat, ussd) FROM stdin;
1	Mvola	0345939753	2025-06-11 09:34:15.444922	Tiavina	1	#111*1*2*cleanNumber*montant*2#
2	Orange Money	0329317364	2025-06-11 09:34:40.782551	Malala	1	#144*1*1*cleanNumber*cleanNumber*montant*2#
\.


--
-- Data for Name: APPISTERY_connect; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_connect" (id, "userId", "connectedAt", "ipAddress", "connectionStatus") FROM stdin;
94	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	2025-06-23 10:59:55.209	::ffff:192.168.1.165	\N
96	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	2025-06-23 11:22:17.052	::ffff:192.168.1.165	disconnected
97	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	2025-07-08 13:33:50.175	::ffff:192.168.1.165	connected
98	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	2025-07-08 13:34:01.383	::ffff:192.168.1.165	disconnected
99	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:35:09.756	::ffff:192.168.1.165	\N
100	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:36:10.839	::ffff:192.168.1.165	\N
101	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:37:01.399	::ffff:192.168.1.165	\N
102	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:39:43.139	::ffff:192.168.1.165	connected
103	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:39:48.789	::ffff:192.168.1.165	disconnected
104	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:40:06.206	::ffff:192.168.1.165	connected
105	9db3a26d-9cf4-4165-a1cf-ad7058629db1	2025-07-08 13:47:16.44	::ffff:192.168.1.165	disconnected
\.


--
-- Data for Name: APPISTERY_devices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_devices" (id, "usersId", "deviceId", "createdAt", "updatedAt") FROM stdin;
57	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	RKQ1.201217.002	2025-06-23 10:59:55.203	2025-06-23 10:59:55.203
58	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	RKQ1.201217.002	2025-07-08 13:33:50.222	2025-07-08 13:33:50.222
59	9db3a26d-9cf4-4165-a1cf-ad7058629db1	RKQ1.201217.002	2025-07-08 13:39:43.169	2025-07-08 13:39:43.169
60	9db3a26d-9cf4-4165-a1cf-ad7058629db1	RKQ1.201217.002	2025-07-08 13:40:06.223	2025-07-08 13:40:06.223
\.


--
-- Data for Name: APPISTERY_favorites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_favorites" (id, "usersId", "storieId", "isFavorite", "dateCreation") FROM stdin;
18	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	12	t	2025-06-23 11:25:32.75621
\.


--
-- Data for Name: APPISTERY_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_genres" (id, title, status) FROM stdin;
1	Mistère	t
2	Romance	t
3	Paranormal	t
4	Drame	t
5	Sorcellerie	t
6	Démoniaque	t
\.


--
-- Data for Name: APPISTERY_ip; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_ip" (id, "ipValue", "typeCompte", "profileId", "authorId") FROM stdin;
1	::ffff:192.168.1.165	profile	9db3a26d-9cf4-4165-a1cf-ad7058629db1	\N
\.


--
-- Data for Name: APPISTERY_markAsRead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_markAsRead" (id, "userId", "storyId", "readAt", "isRead") FROM stdin;
\.


--
-- Data for Name: APPISTERY_offres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_offres" (id, nom, "dateDebut", "dateFin", etat, avantages, montant, "parMois", devise) FROM stdin;
6	Free Ghost	2025-06-04	\N	1	Histoires limittées; 1 mois de validité; Lecture online uniquement; Publicités incluses; Accès limité aux histoires; Pas de téléchargement	0.00	1	MGA
5	Three Ghost	2025-06-04	\N	0	Histoires illimitées; 3 mois de validité; Téléchargement illimité; Lecture offline; Pas de publicité; Accès à toutes les histoires	15000.00	3	MGA
3	Premium Ghost	2025-06-04	\N	1	Histoires illimitées; 1 mois de validité; Téléchargement illimité; Lecture offline; Pas de publicité; Accès à toutes les histoires	4000.00	1	MGA
\.


--
-- Data for Name: APPISTERY_paiement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_paiement" (id, "idProfiles", montant, "datePaiement", "dateFin", "etatPaiement", "dateCreation", "mobileMoneyChoice", "dateValidation", "idPaiement", "references") FROM stdin;
50	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	0.00	2025-06-23	\N	pending	2025-06-23 10:59:25.382288	Mvola	\N	M46hbKQ08h	\N
51	313bc1eb-1954-49b7-a5fc-d0a0feef9f36	4000.00	2025-06-23	\N	validate	2025-06-23 10:59:25.391102	Mvola	2025-06-23	M79jiNQ46h	\N
52	9db3a26d-9cf4-4165-a1cf-ad7058629db1	0.00	2025-07-08	\N	pending	2025-07-08 13:34:44.85788	Mvola	\N	M12ofTN31a	\N
53	9db3a26d-9cf4-4165-a1cf-ad7058629db1	4000.00	2025-07-08	\N	pending	2025-07-08 13:34:44.871	Mvola	\N	M66zrAO73c	\N
\.


--
-- Data for Name: APPISTERY_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_profiles" (id, username, email, telephone, "choiceOffre", "typeCompte", premium, "dateDebut", "dateFin", "dateCreation", avatar, password, "resetPassword", etat, "cguAccepted") FROM stdin;
313bc1eb-1954-49b7-a5fc-d0a0feef9f36	Tiavina	tiavinaramilison22@gmail.com	+2610345939753	Premium Ghost	Admin	t	\N	\N	2025-06-23 10:59:25.354	/assets/avatars/image_cropper_1750666129652.jpg	$2b$10$tBluomvzQQqRk8IRG7n7C.D25jpRm/we9jkaeccLJc/U4CF71XLH.	\N	1	t
9db3a26d-9cf4-4165-a1cf-ad7058629db1	Test test	testtest@yopmail.com	+2616565656565	Premium Ghost	Users	f	\N	\N	2025-07-08 13:34:44.815	https://th.bing.com/th/id/OIP.AWJeJd3YobOu_bvpvDVAgQHaHa?w=172&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7	$2b$10$pCXviwqyzNii/qSvRwokuO8Nle7wBvZm9fXHRIeXAqhP.2gVJr3tG	\N	1	t
\.


--
-- Data for Name: APPISTERY_stories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_stories" (id, title, "genreId", synopsis, "isPremium", "coverImage", "publishedDate", "createdAt", "chaptersCount", status, "authorId", "synopsisFr", "synopsisEng") FROM stdin;
12	Vola Mafana	4	Tranga iray mahakasika ny resaka vola mafana ity hozaraiko ity, taona maromaro lasa izay. Mpiasa tamina zotra fitaterana teto andrenivohitra ny tenako tamin'izany, ireny receveur amin’ny taxibe ireny raha tsorina.	t	/assets/stories/illustrations/1749821015815-1000103556.jpg	2025-06-13	2025-06-13 16:23:35.944882	4	t	60ce060e-2c44-432f-b7c1-5807f447ee23	\N	\N
14	tes	1	ff	t	/assets/stories/illustrations/1750670376978-1000105542.jpg	2025-06-23	2025-06-23 12:19:37.249204	1	t	60ce060e-2c44-432f-b7c1-5807f447ee23	\N	\N
\.


--
-- Data for Name: APPISTERY_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_versions" (id, name, version, begin, "end") FROM stdin;
\.


--
-- Data for Name: APPISTERY_videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."APPISTERY_videos" (id, title, description, vimeo_url, thumbnail_url, duration, category, published_date, is_premium) FROM stdin;
1	Test	Test test test	/assets/videos/fady.mp4	/assets/illustrations/fady.png	180	Horreur	2025-05-05 00:00:00	f
\.


--
-- Name: APPISTERY_abonnement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_abonnement_id_seq"', 14, true);


--
-- Name: APPISTERY_ads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_ads_id_seq"', 1, false);


--
-- Name: APPISTERY_cgu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_cgu_id_seq"', 1, true);


--
-- Name: APPISTERY_chapters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_chapters_id_seq"', 18, true);


--
-- Name: APPISTERY_choiceSubscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_choiceSubscription_id_seq"', 2, true);


--
-- Name: APPISTERY_connect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_connect_id_seq"', 105, true);


--
-- Name: APPISTERY_devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_devices_id_seq"', 60, true);


--
-- Name: APPISTERY_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_favorites_id_seq"', 18, true);


--
-- Name: APPISTERY_genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_genres_id_seq"', 6, true);


--
-- Name: APPISTERY_ip_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_ip_id_seq"', 1, true);


--
-- Name: APPISTERY_markAsRead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_markAsRead_id_seq"', 3, true);


--
-- Name: APPISTERY_offres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_offres_id_seq"', 6, true);


--
-- Name: APPISTERY_stories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."APPISTERY_stories_id_seq"', 14, true);


--
-- Name: appistery_paiement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appistery_paiement_id_seq', 53, true);


--
-- Name: appistery_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appistery_versions_id_seq', 1, false);


--
-- Name: APPISTERY_abonnement APPISTERY_abonnement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_abonnement"
    ADD CONSTRAINT "APPISTERY_abonnement_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_ads APPISTERY_ads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_ads"
    ADD CONSTRAINT "APPISTERY_ads_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_authors APPISTERY_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_authors"
    ADD CONSTRAINT "APPISTERY_authors_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_cgu APPISTERY_cgu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_cgu"
    ADD CONSTRAINT "APPISTERY_cgu_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_chapters APPISTERY_chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_chapters"
    ADD CONSTRAINT "APPISTERY_chapters_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_choiceSubscription APPISTERY_choiceSubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_choiceSubscription"
    ADD CONSTRAINT "APPISTERY_choiceSubscription_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_connect APPISTERY_connect_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_connect"
    ADD CONSTRAINT "APPISTERY_connect_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_devices APPISTERY_devices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_devices"
    ADD CONSTRAINT "APPISTERY_devices_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_favorites APPISTERY_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_favorites"
    ADD CONSTRAINT "APPISTERY_favorites_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_genres APPISTERY_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_genres"
    ADD CONSTRAINT "APPISTERY_genres_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_ip APPISTERY_ip_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_ip"
    ADD CONSTRAINT "APPISTERY_ip_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_markAsRead APPISTERY_markAsRead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_markAsRead"
    ADD CONSTRAINT "APPISTERY_markAsRead_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_offres APPISTERY_offres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_offres"
    ADD CONSTRAINT "APPISTERY_offres_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_paiement APPISTERY_paiement_idPaiement_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_paiement"
    ADD CONSTRAINT "APPISTERY_paiement_idPaiement_key" UNIQUE ("idPaiement");


--
-- Name: APPISTERY_paiement APPISTERY_paiement_references_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_paiement"
    ADD CONSTRAINT "APPISTERY_paiement_references_key" UNIQUE ("references");


--
-- Name: APPISTERY_stories APPISTERY_stories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_stories"
    ADD CONSTRAINT "APPISTERY_stories_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_videos APPISTERY_videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_videos"
    ADD CONSTRAINT "APPISTERY_videos_pkey" PRIMARY KEY (id);


--
-- Name: APPISTERY_paiement appistery_paiement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_paiement"
    ADD CONSTRAINT appistery_paiement_pkey PRIMARY KEY (id);


--
-- Name: APPISTERY_profiles appistery_profiles_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_profiles"
    ADD CONSTRAINT appistery_profiles_email_unique UNIQUE (email);


--
-- Name: APPISTERY_profiles appistery_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_profiles"
    ADD CONSTRAINT appistery_profiles_pkey PRIMARY KEY (id);


--
-- Name: APPISTERY_profiles appistery_profiles_telephone_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_profiles"
    ADD CONSTRAINT appistery_profiles_telephone_unique UNIQUE (telephone);


--
-- Name: APPISTERY_versions appistery_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_versions"
    ADD CONSTRAINT appistery_versions_pkey PRIMARY KEY (id);


--
-- Name: APPISTERY_markAsRead unique_user_story; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_markAsRead"
    ADD CONSTRAINT unique_user_story UNIQUE ("userId", "storyId");


--
-- Name: APPISTERY_chapters APPISTERY_chapters_storyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_chapters"
    ADD CONSTRAINT "APPISTERY_chapters_storyId_fkey" FOREIGN KEY ("storyId") REFERENCES public."APPISTERY_stories"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_connect APPISTERY_connect_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_connect"
    ADD CONSTRAINT "APPISTERY_connect_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_stories APPISTERY_stories_authorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_stories"
    ADD CONSTRAINT "APPISTERY_stories_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES public."APPISTERY_authors"(id);


--
-- Name: APPISTERY_stories APPISTERY_stories_genreId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_stories"
    ADD CONSTRAINT "APPISTERY_stories_genreId_fkey" FOREIGN KEY ("genreId") REFERENCES public."APPISTERY_genres"(id);


--
-- Name: APPISTERY_paiement appistery_paiement_idprofiles_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_paiement"
    ADD CONSTRAINT appistery_paiement_idprofiles_fkey FOREIGN KEY ("idProfiles") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_ip fk_author; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_ip"
    ADD CONSTRAINT fk_author FOREIGN KEY ("authorId") REFERENCES public."APPISTERY_authors"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_abonnement fk_paiement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_abonnement"
    ADD CONSTRAINT fk_paiement FOREIGN KEY ("idPaiement") REFERENCES public."APPISTERY_paiement"("idPaiement") ON DELETE CASCADE;


--
-- Name: APPISTERY_abonnement fk_profile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_abonnement"
    ADD CONSTRAINT fk_profile FOREIGN KEY ("usersId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_ip fk_profile; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_ip"
    ADD CONSTRAINT fk_profile FOREIGN KEY ("profileId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_favorites fk_storie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_favorites"
    ADD CONSTRAINT fk_storie FOREIGN KEY ("storieId") REFERENCES public."APPISTERY_stories"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_markAsRead fk_story; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_markAsRead"
    ADD CONSTRAINT fk_story FOREIGN KEY ("storyId") REFERENCES public."APPISTERY_stories"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_favorites fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_favorites"
    ADD CONSTRAINT fk_user FOREIGN KEY ("usersId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_markAsRead fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_markAsRead"
    ADD CONSTRAINT fk_user FOREIGN KEY ("userId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- Name: APPISTERY_devices fk_users; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."APPISTERY_devices"
    ADD CONSTRAINT fk_users FOREIGN KEY ("usersId") REFERENCES public."APPISTERY_profiles"(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


-- Table: public.institutions

-- DROP TABLE IF EXISTS public.institutions;

CREATE TABLE IF NOT EXISTS public.institutions
(
    institution_id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    institution_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    ward_number character varying(16) COLLATE pg_catalog."default" NOT NULL,
    tole_address character varying(250) COLLATE pg_catalog."default" NOT NULL,
    district_address character varying(250) COLLATE pg_catalog."default" NOT NULL,
    is_active boolean DEFAULT true,
    CONSTRAINT institutions_pkey PRIMARY KEY (institution_id),
    CONSTRAINT institutions_institution_name_ward_number_tole_address_dist_key UNIQUE (institution_name, ward_number, tole_address, district_address, is_active)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.institutions
    OWNER to postgres;



-- Table: public.blocks

-- DROP TABLE IF EXISTS public.blocks;

CREATE TABLE IF NOT EXISTS public.blocks
(
    block_number integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    previous_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    nonce character varying(255) COLLATE pg_catalog."default" NOT NULL,
    current_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    merkle_root character varying(255) COLLATE pg_catalog."default" NOT NULL,
    status character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT blocks_pkey PRIMARY KEY (block_number),
    CONSTRAINT blocks_current_hash_key UNIQUE (current_hash)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.blocks
    OWNER to postgres;


-- Table: public.institution_user

-- DROP TABLE IF EXISTS public.institution_user;

CREATE TABLE IF NOT EXISTS public.institution_user
(
    institution_id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    user_id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    public_key text COLLATE pg_catalog."default",
    institution_logo_base64 text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT institution_user_pkey PRIMARY KEY (institution_id, user_id),
    CONSTRAINT institution_user_institution_id_key UNIQUE (institution_id),
    CONSTRAINT institution_user_institution_id_fkey FOREIGN KEY (institution_id)
        REFERENCES public.institutions (institution_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT institution_user_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.user_accounts (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.institution_user
    OWNER to postgres;


    -- Table: public.user_accounts

-- DROP TABLE IF EXISTS public.user_accounts;

CREATE TABLE IF NOT EXISTS public.user_accounts
(
    id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    role character varying(16) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_accounts_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_accounts
    OWNER to postgres;

    -- Table: public.institution_faculty

-- DROP TABLE IF EXISTS public.institution_faculty;

CREATE TABLE IF NOT EXISTS public.institution_faculty
(
    institution_faculty_id character varying(16) COLLATE pg_catalog."default" NOT NULL,
    institution_id character varying(16) COLLATE pg_catalog."default",
    faculty character varying(200) COLLATE pg_catalog."default" NOT NULL,
    principal_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    principal_signature_base64 text COLLATE pg_catalog."default" NOT NULL,
    faculty_hod_name character varying(300) COLLATE pg_catalog."default" NOT NULL,
    university_affiliation character varying(100) COLLATE pg_catalog."default" NOT NULL,
    university_college_code character varying(20) COLLATE pg_catalog."default" NOT NULL,
    faculty_hod_signature_base64 text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT institution_faculty_pkey PRIMARY KEY (institution_faculty_id),
    CONSTRAINT institution_faculty_institution_id_fkey FOREIGN KEY (institution_id)
        REFERENCES public.institutions (institution_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.institution_faculty
    OWNER to postgres;

    -- Table: public.certificates

-- DROP TABLE IF EXISTS public.certificates;

CREATE TABLE IF NOT EXISTS public.certificates
(
    id integer NOT NULL DEFAULT nextval('certificates_id_seq'::regclass),
    certificate_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    block_number integer NOT NULL,
    "position" integer NOT NULL,
    student_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    student_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    university_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    degree character varying(100) COLLATE pg_catalog."default" NOT NULL,
    college character varying(255) COLLATE pg_catalog."default" NOT NULL,
    major character varying(255) COLLATE pg_catalog."default" NOT NULL,
    gpa character varying(10) COLLATE pg_catalog."default",
    percentage numeric(5,2),
    division character varying(50) COLLATE pg_catalog."default" NOT NULL,
    issue_date timestamp without time zone NOT NULL,
    enrollment_date timestamp without time zone NOT NULL,
    completion_date timestamp without time zone NOT NULL,
    principal_signature character varying(255) COLLATE pg_catalog."default" NOT NULL,
    data_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    issuer_public_key character varying(255) COLLATE pg_catalog."default" NOT NULL,
    certificate_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT certificates_pkey PRIMARY KEY (id),
    CONSTRAINT certificates_block_number_position_key UNIQUE (block_number, "position"),
    CONSTRAINT certificates_block_number_fkey FOREIGN KEY (block_number)
        REFERENCES public.blocks (block_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT certificates_position_check CHECK ("position" >= 1 AND "position" <= 4)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.certificates
    OWNER to postgres;
PGDMP              	        |         
   codeforces    16.1    16.1 h    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            J           1262    24613 
   codeforces    DATABASE     �   CREATE DATABASE codeforces WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE codeforces;
                postgres    false            �            1255    90152    check_registration_input()    FUNCTION     V  CREATE FUNCTION public.check_registration_input() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.user_name IS NULL OR NEW.password IS NULL OR NEW.email IS NULL OR NEW.country IS NULL OR NEW.institution IS NULL THEN
        RAISE EXCEPTION 'All fields are required for registration';
    END IF;
    
    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.check_registration_input();
       public          postgres    false            �            1255    98346 "   generate_multiline_string(integer)    FUNCTION     �  CREATE FUNCTION public.generate_multiline_string(length integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    result TEXT := '';
    i INTEGER := 0;
BEGIN
    FOR i IN 1..length LOOP
        result := result || chr(trunc(random() * 26)::INTEGER + 65); -- Cast random() to integer
        IF i % 30 = 0 THEN
            result := result || E'\n'; -- Add a newline character every 30 characters
        END IF;
    END LOOP;
    RETURN result;
END;
$$;
 @   DROP FUNCTION public.generate_multiline_string(length integer);
       public          postgres    false            �            1255    98343    update_all_users_admin_status() 	   PROCEDURE     �   CREATE PROCEDURE public.update_all_users_admin_status()
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE users
    SET is_admin = 'no';
END;
$$;
 7   DROP PROCEDURE public.update_all_users_admin_status();
       public          postgres    false            �            1255    90154    update_user_rating()    FUNCTION     J  CREATE FUNCTION public.update_user_rating() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    problem_rating INTEGER;
    user_rating INTEGER;
BEGIN
    -- Get the rating of the submitted problem
    SELECT rating INTO problem_rating FROM problems WHERE problem_id = NEW.problem_id;
    
    -- Get the current rating of the user
    SELECT current_rating INTO user_rating FROM users WHERE user_id = NEW.user_id;

    -- Update the user's rating
    UPDATE users SET current_rating = user_rating + (problem_rating * 0.01) WHERE user_id = NEW.user_id;

    RETURN NEW;
END;
$$;
 +   DROP FUNCTION public.update_user_rating();
       public          postgres    false            �            1259    32818    blogs    TABLE     �   CREATE TABLE public.blogs (
    blog_id integer NOT NULL,
    user_id integer,
    blog_title character varying,
    description character varying
);
    DROP TABLE public.blogs;
       public         heap    postgres    false            �            1259    32817    Blog_blog_id_seq    SEQUENCE     �   ALTER TABLE public.blogs ALTER COLUMN blog_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Blog_blog_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    234            �            1259    24644 
   contesttag    TABLE     t   CREATE TABLE public.contesttag (
    contest_tag_id integer NOT NULL,
    contest_id integer,
    tag_id integer
);
    DROP TABLE public.contesttag;
       public         heap    postgres    false            �            1259    24666    ContestTag_contest_tag_id_seq    SEQUENCE     �   ALTER TABLE public.contesttag ALTER COLUMN contest_tag_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ContestTag_contest_tag_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    24639    contests    TABLE     �   CREATE TABLE public.contests (
    contest_id integer NOT NULL,
    contest_title character varying(255),
    contest_description text
);
    DROP TABLE public.contests;
       public         heap    postgres    false            �            1259    24665    Contest_contest_id_seq    SEQUENCE     �   ALTER TABLE public.contests ALTER COLUMN contest_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Contest_contest_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    24649 
   problemtag    TABLE     t   CREATE TABLE public.problemtag (
    problem_tag_id integer NOT NULL,
    problem_id integer,
    tag_id integer
);
    DROP TABLE public.problemtag;
       public         heap    postgres    false            �            1259    24668    ProblemTag_problem_tag_id_seq    SEQUENCE     �   ALTER TABLE public.problemtag ALTER COLUMN problem_tag_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ProblemTag_problem_tag_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            �            1259    24622    problems    TABLE     �   CREATE TABLE public.problems (
    problem_id integer NOT NULL,
    problem_title character varying(255),
    problem_description text,
    contest_id integer,
    rating integer,
    input_case text,
    output_case text
);
    DROP TABLE public.problems;
       public         heap    postgres    false            �            1259    24667    Problem_problem_id_seq    SEQUENCE     �   ALTER TABLE public.problems ALTER COLUMN problem_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Problem_problem_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    24634    submissions    TABLE     �   CREATE TABLE public.submissions (
    submission_id integer NOT NULL,
    submission_time time(6) with time zone,
    user_id integer,
    contest_id integer,
    problem_id integer,
    solve text,
    is_correct character varying(5)
);
    DROP TABLE public.submissions;
       public         heap    postgres    false            �            1259    24669    Submission_submission_id_seq    SEQUENCE     �   ALTER TABLE public.submissions ALTER COLUMN submission_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Submission_submission_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    24629    tags    TABLE     _   CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    tag_name character varying(255)
);
    DROP TABLE public.tags;
       public         heap    postgres    false            �            1259    24670    Tag_tag_id_seq    SEQUENCE     �   ALTER TABLE public.tags ALTER COLUMN tag_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Tag_tag_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    24655    usercontest    TABLE     w   CREATE TABLE public.usercontest (
    user_contest_id integer NOT NULL,
    user_id integer,
    contest_id integer
);
    DROP TABLE public.usercontest;
       public         heap    postgres    false            �            1259    24654    UserContest_user_contest_id_seq    SEQUENCE     �   ALTER TABLE public.usercontest ALTER COLUMN user_contest_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."UserContest_user_contest_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    224            �            1259    24660    userproblem    TABLE     w   CREATE TABLE public.userproblem (
    user_problem_id integer NOT NULL,
    user_id integer,
    problem_id integer
);
    DROP TABLE public.userproblem;
       public         heap    postgres    false            �            1259    24671    UserProblem_user_problem_id_seq    SEQUENCE     �   ALTER TABLE public.userproblem ALTER COLUMN user_problem_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."UserProblem_user_problem_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    225            �            1259    24615    users    TABLE     �  CREATE TABLE public.users (
    user_id integer NOT NULL,
    user_name character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255),
    color character varying(50),
    current_rating integer,
    max_rating integer,
    country character varying(255),
    institution character varying(255),
    registration_date date,
    contribution integer,
    problems_solved integer,
    is_admin character varying(5)
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    24614    User_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    49189    comments    TABLE     �   CREATE TABLE public.comments (
    comment_id integer NOT NULL,
    text text,
    comment_time time without time zone,
    contest_id integer,
    problem_id integer
);
    DROP TABLE public.comments;
       public         heap    postgres    false            �            1259    57391    comments_comment_id_seq    SEQUENCE     �   ALTER TABLE public.comments ALTER COLUMN comment_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    235            �            1259    49218 
   editorials    TABLE     �   CREATE TABLE public.editorials (
    editorial_id integer NOT NULL,
    hints text,
    solution text,
    problem_id integer,
    user_id integer
);
    DROP TABLE public.editorials;
       public         heap    postgres    false            �            1259    57392    editorials_editorial_id_seq    SEQUENCE     �   ALTER TABLE public.editorials ALTER COLUMN editorial_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.editorials_editorial_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    237            �            1259    49206    gym    TABLE     �   CREATE TABLE public.gym (
    gym_id integer NOT NULL,
    hints text,
    solution text,
    gym_title character varying(255),
    gym_description text
);
    DROP TABLE public.gym;
       public         heap    postgres    false            �            1259    81959    gym_gym_id_seq    SEQUENCE     �   ALTER TABLE public.gym ALTER COLUMN gym_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.gym_gym_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    236            �            1259    49240 
   gymproblem    TABLE     t   CREATE TABLE public.gymproblem (
    gym_problem_id integer NOT NULL,
    problem_id integer,
    gym_id integer
);
    DROP TABLE public.gymproblem;
       public         heap    postgres    false            �            1259    81960    gymproblem_gym_problem_id_seq    SEQUENCE     �   ALTER TABLE public.gymproblem ALTER COLUMN gym_problem_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.gymproblem_gym_problem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    238            �            1259    49255    usercomment    TABLE     w   CREATE TABLE public.usercomment (
    user_comment_id integer NOT NULL,
    user_id integer,
    comment_id integer
);
    DROP TABLE public.usercomment;
       public         heap    postgres    false            ;          0    32818    blogs 
   TABLE DATA           J   COPY public.blogs (blog_id, user_id, blog_title, description) FROM stdin;
    public          postgres    false    234   ��       <          0    49189    comments 
   TABLE DATA           Z   COPY public.comments (comment_id, text, comment_time, contest_id, problem_id) FROM stdin;
    public          postgres    false    235   {�       -          0    24639    contests 
   TABLE DATA           R   COPY public.contests (contest_id, contest_title, contest_description) FROM stdin;
    public          postgres    false    220   {�       .          0    24644 
   contesttag 
   TABLE DATA           H   COPY public.contesttag (contest_tag_id, contest_id, tag_id) FROM stdin;
    public          postgres    false    221   r�       >          0    49218 
   editorials 
   TABLE DATA           X   COPY public.editorials (editorial_id, hints, solution, problem_id, user_id) FROM stdin;
    public          postgres    false    237   ��       =          0    49206    gym 
   TABLE DATA           R   COPY public.gym (gym_id, hints, solution, gym_title, gym_description) FROM stdin;
    public          postgres    false    236   ٢       ?          0    49240 
   gymproblem 
   TABLE DATA           H   COPY public.gymproblem (gym_problem_id, problem_id, gym_id) FROM stdin;
    public          postgres    false    238   ģ       *          0    24622    problems 
   TABLE DATA              COPY public.problems (problem_id, problem_title, problem_description, contest_id, rating, input_case, output_case) FROM stdin;
    public          postgres    false    217   \�       /          0    24649 
   problemtag 
   TABLE DATA           H   COPY public.problemtag (problem_tag_id, problem_id, tag_id) FROM stdin;
    public          postgres    false    222   ��       ,          0    24634    submissions 
   TABLE DATA           y   COPY public.submissions (submission_id, submission_time, user_id, contest_id, problem_id, solve, is_correct) FROM stdin;
    public          postgres    false    219   ��       +          0    24629    tags 
   TABLE DATA           0   COPY public.tags (tag_id, tag_name) FROM stdin;
    public          postgres    false    218   ��       @          0    49255    usercomment 
   TABLE DATA           K   COPY public.usercomment (user_comment_id, user_id, comment_id) FROM stdin;
    public          postgres    false    239   ��       1          0    24655    usercontest 
   TABLE DATA           K   COPY public.usercontest (user_contest_id, user_id, contest_id) FROM stdin;
    public          postgres    false    224   ��       2          0    24660    userproblem 
   TABLE DATA           K   COPY public.userproblem (user_problem_id, user_id, problem_id) FROM stdin;
    public          postgres    false    225   �       )          0    24615    users 
   TABLE DATA           �   COPY public.users (user_id, user_name, password, email, color, current_rating, max_rating, country, institution, registration_date, contribution, problems_solved, is_admin) FROM stdin;
    public          postgres    false    216   /�       K           0    0    Blog_blog_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Blog_blog_id_seq"', 73, true);
          public          postgres    false    233            L           0    0    ContestTag_contest_tag_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."ContestTag_contest_tag_id_seq"', 10, true);
          public          postgres    false    227            M           0    0    Contest_contest_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Contest_contest_id_seq"', 29, true);
          public          postgres    false    226            N           0    0    ProblemTag_problem_tag_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public."ProblemTag_problem_tag_id_seq"', 10, true);
          public          postgres    false    229            O           0    0    Problem_problem_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public."Problem_problem_id_seq"', 36, true);
          public          postgres    false    228            P           0    0    Submission_submission_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public."Submission_submission_id_seq"', 10, true);
          public          postgres    false    230            Q           0    0    Tag_tag_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Tag_tag_id_seq"', 224, true);
          public          postgres    false    231            R           0    0    UserContest_user_contest_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public."UserContest_user_contest_id_seq"', 10, true);
          public          postgres    false    223            S           0    0    UserProblem_user_problem_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public."UserProblem_user_problem_id_seq"', 10, true);
          public          postgres    false    232            T           0    0    User_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."User_id_seq"', 243, true);
          public          postgres    false    215            U           0    0    comments_comment_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.comments_comment_id_seq', 161, true);
          public          postgres    false    240            V           0    0    editorials_editorial_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.editorials_editorial_id_seq', 31, true);
          public          postgres    false    241            W           0    0    gym_gym_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.gym_gym_id_seq', 15, true);
          public          postgres    false    242            X           0    0    gymproblem_gym_problem_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.gymproblem_gym_problem_id_seq', 31, true);
          public          postgres    false    243            x           2606    32824    blogs Blog_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT "Blog_pkey" PRIMARY KEY (blog_id);
 ;   ALTER TABLE ONLY public.blogs DROP CONSTRAINT "Blog_pkey";
       public            postgres    false    234            p           2606    24648    contesttag ContestTag_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.contesttag
    ADD CONSTRAINT "ContestTag_pkey" PRIMARY KEY (contest_tag_id);
 F   ALTER TABLE ONLY public.contesttag DROP CONSTRAINT "ContestTag_pkey";
       public            postgres    false    221            n           2606    24643    contests Contest_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.contests
    ADD CONSTRAINT "Contest_pkey" PRIMARY KEY (contest_id);
 A   ALTER TABLE ONLY public.contests DROP CONSTRAINT "Contest_pkey";
       public            postgres    false    220            r           2606    24653    problemtag ProblemTag_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.problemtag
    ADD CONSTRAINT "ProblemTag_pkey" PRIMARY KEY (problem_tag_id);
 F   ALTER TABLE ONLY public.problemtag DROP CONSTRAINT "ProblemTag_pkey";
       public            postgres    false    222            h           2606    24628    problems Problem_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.problems
    ADD CONSTRAINT "Problem_pkey" PRIMARY KEY (problem_id);
 A   ALTER TABLE ONLY public.problems DROP CONSTRAINT "Problem_pkey";
       public            postgres    false    217            l           2606    24638    submissions Submission_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT "Submission_pkey" PRIMARY KEY (submission_id);
 G   ALTER TABLE ONLY public.submissions DROP CONSTRAINT "Submission_pkey";
       public            postgres    false    219            j           2606    24633    tags Tag_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.tags
    ADD CONSTRAINT "Tag_pkey" PRIMARY KEY (tag_id);
 9   ALTER TABLE ONLY public.tags DROP CONSTRAINT "Tag_pkey";
       public            postgres    false    218            t           2606    24659    usercontest UserContest_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.usercontest
    ADD CONSTRAINT "UserContest_pkey" PRIMARY KEY (user_contest_id);
 H   ALTER TABLE ONLY public.usercontest DROP CONSTRAINT "UserContest_pkey";
       public            postgres    false    224            v           2606    24664    userproblem UserProblem_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.userproblem
    ADD CONSTRAINT "UserProblem_pkey" PRIMARY KEY (user_problem_id);
 H   ALTER TABLE ONLY public.userproblem DROP CONSTRAINT "UserProblem_pkey";
       public            postgres    false    225            d           2606    24619    users User_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (user_id);
 ;   ALTER TABLE ONLY public.users DROP CONSTRAINT "User_pkey";
       public            postgres    false    216            z           2606    49195    comments comments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public            postgres    false    235            ~           2606    49224    editorials editorials_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.editorials
    ADD CONSTRAINT editorials_pkey PRIMARY KEY (editorial_id);
 D   ALTER TABLE ONLY public.editorials DROP CONSTRAINT editorials_pkey;
       public            postgres    false    237            |           2606    49212    gym gym_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.gym
    ADD CONSTRAINT gym_pkey PRIMARY KEY (gym_id);
 6   ALTER TABLE ONLY public.gym DROP CONSTRAINT gym_pkey;
       public            postgres    false    236            �           2606    49244    gymproblem gymproblem_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.gymproblem
    ADD CONSTRAINT gymproblem_pkey PRIMARY KEY (gym_problem_id);
 D   ALTER TABLE ONLY public.gymproblem DROP CONSTRAINT gymproblem_pkey;
       public            postgres    false    238            f           2606    65585    users unique_user_name 
   CONSTRAINT     V   ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_user_name UNIQUE (user_name);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT unique_user_name;
       public            postgres    false    216            �           2606    49259    usercomment usercomment_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.usercomment
    ADD CONSTRAINT usercomment_pkey PRIMARY KEY (user_comment_id);
 F   ALTER TABLE ONLY public.usercomment DROP CONSTRAINT usercomment_pkey;
       public            postgres    false    239            �           2620    90153    users registration_input_check    TRIGGER     �   CREATE TRIGGER registration_input_check BEFORE INSERT ON public.users FOR EACH ROW EXECUTE FUNCTION public.check_registration_input();
 7   DROP TRIGGER registration_input_check ON public.users;
       public          postgres    false    216    244            �           2620    90155 &   submissions update_user_rating_trigger    TRIGGER     �   CREATE TRIGGER update_user_rating_trigger AFTER INSERT ON public.submissions FOR EACH ROW EXECUTE FUNCTION public.update_user_rating();
 ?   DROP TRIGGER update_user_rating_trigger ON public.submissions;
       public          postgres    false    245    219            �           2606    49265    usercomment comment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usercomment
    ADD CONSTRAINT comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(comment_id);
 E   ALTER TABLE ONLY public.usercomment DROP CONSTRAINT comment_id_fkey;
       public          postgres    false    4730    235    239            �           2606    24672    contesttag contest_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contesttag
    ADD CONSTRAINT contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.contests(contest_id) NOT VALID;
 D   ALTER TABLE ONLY public.contesttag DROP CONSTRAINT contest_id_fkey;
       public          postgres    false    221    4718    220            �           2606    24702    submissions contest_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.contests(contest_id) NOT VALID;
 E   ALTER TABLE ONLY public.submissions DROP CONSTRAINT contest_id_fkey;
       public          postgres    false    219    4718    220            �           2606    24712    usercontest contest_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usercontest
    ADD CONSTRAINT contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.contests(contest_id) NOT VALID;
 E   ALTER TABLE ONLY public.usercontest DROP CONSTRAINT contest_id_fkey;
       public          postgres    false    220    4718    224            �           2606    49196    comments contest_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT contest_id_fkey FOREIGN KEY (contest_id) REFERENCES public.contests(contest_id);
 B   ALTER TABLE ONLY public.comments DROP CONSTRAINT contest_id_fkey;
       public          postgres    false    4718    220    235            �           2606    49250    gymproblem gym_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.gymproblem
    ADD CONSTRAINT gym_id_fkey FOREIGN KEY (gym_id) REFERENCES public.gym(gym_id);
 @   ALTER TABLE ONLY public.gymproblem DROP CONSTRAINT gym_id_fkey;
       public          postgres    false    236    4732    238            �           2606    24682    problemtag problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.problemtag
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id) NOT VALID;
 D   ALTER TABLE ONLY public.problemtag DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    222    4712    217            �           2606    24697    submissions problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id) NOT VALID;
 E   ALTER TABLE ONLY public.submissions DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    217    219    4712            �           2606    24722    userproblem problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.userproblem
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id) NOT VALID;
 E   ALTER TABLE ONLY public.userproblem DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    217    4712    225            �           2606    49201    comments problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id);
 B   ALTER TABLE ONLY public.comments DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    217    4712    235            �           2606    49245    gymproblem problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.gymproblem
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id);
 D   ALTER TABLE ONLY public.gymproblem DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    217    4712    238            �           2606    57381    editorials problem_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.editorials
    ADD CONSTRAINT problem_id_fkey FOREIGN KEY (problem_id) REFERENCES public.problems(problem_id) NOT VALID;
 D   ALTER TABLE ONLY public.editorials DROP CONSTRAINT problem_id_fkey;
       public          postgres    false    4712    217    237            �           2606    24677    contesttag tag_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.contesttag
    ADD CONSTRAINT tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id) NOT VALID;
 @   ALTER TABLE ONLY public.contesttag DROP CONSTRAINT tag_id_fkey;
       public          postgres    false    218    221    4714            �           2606    24687    problemtag tag_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.problemtag
    ADD CONSTRAINT tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id) NOT VALID;
 @   ALTER TABLE ONLY public.problemtag DROP CONSTRAINT tag_id_fkey;
       public          postgres    false    218    222    4714            �           2606    24692    submissions user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 B   ALTER TABLE ONLY public.submissions DROP CONSTRAINT user_id_fkey;
       public          postgres    false    219    216    4708            �           2606    24707    usercontest user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usercontest
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 B   ALTER TABLE ONLY public.usercontest DROP CONSTRAINT user_id_fkey;
       public          postgres    false    224    4708    216            �           2606    24717    userproblem user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.userproblem
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 B   ALTER TABLE ONLY public.userproblem DROP CONSTRAINT user_id_fkey;
       public          postgres    false    225    216    4708            �           2606    32825    blogs user_id_fkey    FK CONSTRAINT     v   ALTER TABLE ONLY public.blogs
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 <   ALTER TABLE ONLY public.blogs DROP CONSTRAINT user_id_fkey;
       public          postgres    false    216    234    4708            �           2606    49260    usercomment user_id_fkey    FK CONSTRAINT     |   ALTER TABLE ONLY public.usercomment
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 B   ALTER TABLE ONLY public.usercomment DROP CONSTRAINT user_id_fkey;
       public          postgres    false    216    239    4708            �           2606    57386    editorials user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.editorials
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 A   ALTER TABLE ONLY public.editorials DROP CONSTRAINT user_id_fkey;
       public          postgres    false    4708    216    237            ;   �
  x��Y[s�8}v~���*�HH��-7�RL��}�ز��-y%{����tK��I����L2�Q�/�OkO�gǯ^d��Ӧ����捸ӝ����|�Ei��V[��N9��M�Љ�\�$:g+'ۖp�F7���E_k/r�vN��x�U�t���k�s�UN�b+M�
ѫ�6��A�C�V���{���dN��BQ*�Ny`��4�h�F�9B&�<;8=Ύ_�f��z��U�߭)p�7��G�X�z_+����;�L�U/w@��-y ܑ��fK[�k
����O7�-��(p��{m�'��Y��d������|�����Vz��j���>6*�X:%|-���BW���h���S��Iv��Uve%��^�k����t G��Q�Pp�MY�\�h�,�a|�z�fN`n�g�25���9%�֍�w�����h7�
�r���?��Wc�a��,;�m���W���1�j�U����J�bs�Ȁ����U�t׋0Ĩ��Inu%�ыo9678��l��v-݆�&�}؃u�U��(���t�|�3Bk���<IV+Z��L{�����~Գ{\\E��9��v.���v�������7?E
gײ�b�qP�
�� ��'�z��-C��!�V͘�������F6I#�����l�d�¿��>�Z%J*b�{|�C��73,�F�W�u�N$p��ҹF���B�t*��,;>;�� s��Z���z���HM��;y��RvD�LK�Q(�kz�W�n��*����&���2�^��\�Mi�V�� ��^���J�C דs��b�gǯ_go��9��~5���U�F\:]�Qs	�%�~�����NF�����=C/��&I߼�M�L�|���t 2��J��ov�h
݃kq�fZ�n��(^��ZqS��S��(fd�u2k̄����7�� �3����\��t�A�|7P�PyyB-+a����fGi�ď�v�Ϛ{服X�ۦ�kK.�򡛲��
i��@&PS' 0R3�1��Bzp���_"�sЫ'W���)����Wh:�����b���#I�VA��4�V�-ym;� 1��	��9>yx-Fq��|r8Ls4���t��ã���r �&NWQ��>x~x�]���W��0�{�e����"I��#�r�>�3��Cm�P%z��ղ0�҃6i�cr4�3BG�YQ��䗉9���)}G1%��h�NlOK!$l-$����s��yv�[#B*u��!+Y*���:�&M91˝(����
�] ��]�ٙ� �Ws�.���F
[e�O-���^�+��BAL�^A!��H<��BS^0��b pÕ�%��7�zt5�G:�<k�D+aþ'<R��f�����u�Z!/������^�q�,�ՔW��(����Q���'�����gT˵�vQp?$F�\��#���qPL��!��d+�V��~�c��A�_ܝT��~�����4@���4X��Z�
�A�g���F��64��C'v|�z��<��}����h��
ڃ&�3,{eT.��,}4(�.�r������X�u��'�Xh��B��,Y���$���}�(�3�8��#�iv�؁���>"Ց�����b�����'4�D�h���u$�J�|��	o��shOnȉԉ0"GW�g'm߯���k�	���#��H�FE��1��(�U��$������
��y"~J�OR����u^���v����y~T���24uĊ�7�Ĵɧ�Զ��B���Z%+��_1p.��ȈK�!s���%�UI�������Uv����I�o�*"Z�R�,1Ț���g�+��$d�#L��#B7b��� ����]��?x:YqH,���a���Yb�u�Y����Yt�(R�>|4+\�2��.��5B6=6��v�"�zN��K�URZ�'/�M;R����xkƛJa�b���hz[+�J``��7�%�2�ʑe��i��>����|�}�k�}`�E#�)�(8o� |_(I��+H��N���O4�6���,95(�B�7�� ��zR�jo�&�����y�16*�IYE�J|=ې�D������y@c�xڢ7��Q؄W������-A*.��� ��>E����V����~O{���C&D�TA�ׯ�>�D�ȐY��!���?>�;�]��Ş�c����.�ޫ�F����N�T��'/SC�F�&�"�`�5���;���N�����*���܏FR���$��e��ܔ#�AZ�<[�]����$v�^;��L��H�Ґ�}�:�#�nB	oqI�6_�/;+-#�XPԓ�����J�d�6���w���t<IL]V�9	����4�6���0�m��l�{�:boQ�� mX��#K��+y���u;4��O�\.�G�FO�l���N�(�	� �sR2�x�ՒC��+�TP�<���^���u��⽹���0�(�ɍ}��Y�J T,f�0���+�~wT8�L�{�2?ْmb�-&�CC���=�oH2�␹?���G"��i�G��b�=ͨ���1���q�����S@I�?����S��/M-|<�ƛ<~�:���)�����|�)�{�V��P�^>��������?YQV>�� S���1����0vS�W5~o,V��>[�/�k_�u����4���w_nxWv7��~b?�<������g^��      <   �  x���K��6������3�HI~ݒ,6Y`�=�B˴�X��$eG�>Ňd{ǋ��G����5�s��ѳ����^�<�eY������u��t��Ot?8�Jat���ݒ�|W�Q�9t�CU�V�h[�kI�����{�\�Q�]3X%���;jnH�k��K#imĹ��Wa��Ni��5E�2�
�V�èE�*/����UE�b��8h�V;D[�K����'L�*tB+��^RgTu��:y��Ooȇ�oTug4��S��ٮ�]�A6����-�EiaFj�V��N$��
�k�_���e�z�`yF>�4�����p��/�E��@����6�)���'���_�p����8�tsxv�b�0�ɦ��C����~D��o/^f:��aӢ�M�mwe�� $/�|��ȋ4�&�c�lq��.�������O�:I���!���y��V�<A�&[J| \����Go�A�X8���㟭��ڟ�	{�q����]  �%� Z�`gD0��̈́S�< ���v�u�'�_oZz�#������i fF�I�=��'O=1�sb����R�M�<���\�k��%� ����'#.����"�I�H��q�{�!�U/;EA�
��
6Pd�M:��0q���$�6�:E���	�}��h����u)V�-'��xT�B*�����.RH�� ��.A	�;�CLFy���G�'l��$>��e�H,[���(U���� ��$�� R����Ǩ������D�:�T�H
5��U���R'�F�����D��C��N��4��jd��s��t��J�ʜ|�Ea�{#���T�ʐ>�� S���Pz|�nH�+T>^!4���^Z6�Rx�D���`��K�Vz��I�m�����KxK#!?	�ul��i�#�]�fӗ!MӺ���|
�Dx3���!LlژϬ�`�x�܀P���p�-p[�?\���:��:�s��Uu�p����J�-�^.�� ���J      -   �  x��X�r�]�_��R*K�_+�m�tS�8֭x�8Ӝ��L i��s��y����p�7�B%�~�>}���W�\I;�
���R��zu��=y�>�,�kI��╪ɓ:���~�7O��\�>xM�ڨ�T���Z�.���7A�&U��l��QTQT���4�F<�VY�<��[�������F��)U����J�Et~��ْw��^3\���W���a6�j��z��-��3W1���|p��ao���;�a�5 ��)< �ˍ�ф1*W����-���9�lO��wȫ��Kv)�����7����Yۛ�I�	bt�����	vqL=pC��[��A�d-�}(Lgp%��H��Λ�2@e��#
� ���"��2�G�{�R�
N A6��~B�8`�/z�u�~3{�$��qe��Ju��ۡd�&]�OYS�W��
�@h�i@; �Y���d�H)y�7�E$�[@�V
ă�{ �2q�����4�ꠄ������&_����0Gf>�%���=Y`Q!'���u/��h���m�͐B�]�'����C��\(�`�4�a�d�hK�ץ�Zt3�����9�9���� �.��Zl}�t�?<��7���%��Y�� Yɺ̈́�;��������Q]����_���j����?BPJt����5��S�&�xH�K#� �<`'N�R|��B|h��RYAP�� �GU��(���j�"j�RCD<�F;o�>!T��"� �j�/S »�f��U��3�Y�9�(��˃��v�5��68Sؾd�l)��C�e��K�c�j{Lx�Ļ>�%m+����I�F��Reڋ��O�5��2vG9V� �K�s���[	Aԑ��s�����8p����Ø�6�C�����՛!:S�w��Տ�V#!�aӣ*��gT�%�U�M%�P�)M�k;7���3Űe���	��Z�7��4Z��)�*%e�G,N�'jF��;��\g�|<S�q+P�h���+��'��<�k3�LX���}�~���Q���y�x8���P���B�%�H<��߼�1����(&������[�Ҩn���g
4|Jz%�BT!��Zc*�	������Yu�;�3�r٘R�5A}�~im�"l:~����<������������j.7��4\	��鸓jӭ޳[(�Ě+jG)�j�i蠤q�� �`�V��՝񲃧�`����ʶ���L�,p96����"�i]j*&�)�K�3=�G�ґV�����2�tuk��z��!'Y-�2��4��o'�|�1�FX~���K0�I���p�l�.,'��H�8���d��r�ϧ�p��=�>��F��`4�����@��&a�w/T-`�������#���ܙ'Dܘ@li��}+ћ��%�1̯C��Z���CN�w?��);��g#
�J�LI�M�K��fL������"�s�ˍ'\C��.bc's���zi�y��H��?��>��8��ވ.���c��r�k5f�e�h��&u�[�׌c�,ӊ��;�O��~ �h���k'���ꀨR�#�3�NDZzxh'lv��5n�g�=�)��s�T7%Dz�6�
�[���O�P�����󛧪cMc������;-�rf���&0�@J-�$?�<��x ��6��a�a��i� �xD~{��z#�b�nlW܊L&K_�S���o@5V�WE2�x��;j�8�r
���L�oK�pDzib1 y� ��s���aX25��P��1 �|6A16�6���0,-y���xv]al�$-��=�m�l*C���4�g(��Z3IÎ[�L��ȈQ|)�I�=of/�yu�%@���(���ƍ���.��`$�Ҽ',��۫FÆ/e@,M��y��.]��9~ux��ot�K�p�XU�L�9=���ҋ��om�Ϸ6K�|��w�����>~����r_�d���/���W�K���(�E.�F�͓G��Fr���z��^͟�      .      x������ � �      >   :	  x��X]o�F}Š�b�$R,ٖd����i�q��ݗ}�#q�!�m�E���{g�!YI[��$��~�s�p:��VB
cm%��+'�>w�����]��V�2�4ic�}%ꦘ�t��x#ʦ����1{-��ګbb?�dLy��ף�t4=?Kf�[��n-So���hz��l��+�e1�_)W�������e�{�L_��u∮��[��G|>~,~H?{#�k��!�;!r|�ϓ���)Js� K~�uH����/�J�W�K��=䔰.Sn2Z�x5���}��=tM�*7>?:��?߈|��L��� L�\�#}���Zy
�a͓�ѻ\�w"����+m�߆�(�їF:%���2Ԃ2��]*��h����
5��5J�B�7t�xר� g�<������G%5K[+���o$���Z�o-M�+���{0�(N�!�Er΍_[�Lf�:�����wJ|itzG7Q%Q(�Q����v*&�K��'t����~�6�ɕs�]$��Ǣ2�PȆ���ht�5��e�	Ks!k�O�]z���Q�y'���LF/_�O��)I��k���O6Cy�Wuk����s��*Y��T���Z;h��t������q�0�`�fv�d��H���h��h��'����J��m[˽6h�\	�*���e���ڧɫ�eEH�mKY�]j�GQPpuͽ��+<[��6���KBͪ��F]7]P���`w�LOF��>p��a�rY�$
H �܆��}��0�}zH�b�?D�Q��/�z-+��/y/G�xp� x��u��k��Z�&Ӏ��B��:m������K-Y}RL�m�*��H��6�����?m�G��Jlm�D��-5�Q)�OFU�2�`h���%��M�|6���D�^��G3��Yt�o���<T�.^�>�m���뭰�A������]Ǟ�u`k��Ʃ��V�տG(�rE��~�@�W9㔩�Z��ڹm
�M��J�l)�T�H��H���h�6� �i~� �?�H�̮Q���Q9�Z7MTf���	�i�J�C=b��0ٓ�o�.�g�,��}̶���!D�/1Tl��<����P;Y���*#��ަ	\j,@��=n��J��6oqKS���7���|'?z�����n����'���ك]�%5_$X�I���T� ���o�����E���0�\�{�3(˚2Cl�uCm߆J�!�T[�t?ҫ�Iq��������RO��c�؋���g��:F`Vs`�_@_�ԴV�6Y���������ć�k/�u(��(�n��)�B�d-d�!b�jz�B��O�W��lQ�r	�k���k��e�6�	��Š����B�����������o�5^I��7�DD<cr#oC�z"��¨4��h��K-Ѳ�!5���i�mNp��.�Ir�{��rh�sr�;} ��kL(��$�n_�.n�4F�ڦR�)���(ߥ3 Á��K�|�#�x"�9ۤ�YyK����
��Ȯ$��n{�뛏ݓ�w>}\Ƭ��,�	��O����G��79�&�JH�A�۔�9 �������������2 |j�p"ȉ�!�
�=���� fh����;q'ր�l���Ǽ,����o_�%a�%*\1=2R��%`F}��q��o�)����Dy@�xà�m����q@�c
@�Nt��sI�q���N;��EZR����"i���XZ��S��h�,C��Q��NA�	�����֤�Y/{$YI#˔n�rszA��t�Z���������XE;l��Y�Cnq��k>���%�sg/����a�(
<�R�8K����`�'"��ӜN�oi~,p�k뜮�7���я�7�{Թ力��+c�g vS-��RUה��	��g.;�Ov}�����4�G.�p��T�u2K�#��b�$������C��{F:�F����|>`bg�x٨1�)�r���!x��!����!9`��yb�s�8�q���N����C�UTL�7h�l�II臽[�QBW>�m�h:?avqrq�v
�	�E~��sH����O	�Z���}S���(�u�Hf�=
E�VS�r���vX	�`t<%��*�FrP|��dyK�Zv�b�hw�:��s�
'uN	N(J�.����r���]�� e]\$����J�5ȸr��r����u����L�K9��tO�თ,� � �vذ���n_������M��{t��� ]�J@�.�Lւ5 \|=�п�^�$�*�D�X'�����%z�z1M���?�DՆ�FL��,�^�,-��X���ˡs/N���ژ�U}hg��aϪvo������$I���,�      =   �   x�u�;nA���{kk��-���i%`-��o�7��"����/�i����w���}�]:�~=�>������y�n���) ���* ! �@6_d� �(櫀����|P1`h��|0`����*`���&�U��9 s�櫀�cI�H���1� ���܊|�$�%E��,��dc�i�ۤ���yR�I��P06J)�R�LY�����?�      ?   �   x���1�P�)؉�����q8��� A�aB'4\�2
*$7��L^���EKB�@��D6��l�j�phU��A\Z״,4h[�@z�'&2_�H/ژ�z/�v���Lڪ����!���|?���#�      *      x��zY����s�Wԣ!+Dқ�KHl�Ē@"��"Kd��ݼ�X����P�\dKq�BRt%��s�� /^�����>��W��W���y�����
����x��}<�;�?|s�����������������������䟮ߟo��ߝ1���c�������y������~{<�?\����a��<�|�o//^~�ݡ)�EX�B��u5��T�lj���׷�,��i-t
\Y��jV�{)F���m�u閈D��5S1�.9�۪;��o���6�Դ�����5�5_v��ڜ�&F����춽�������A�\VfJ�d�6)�~��z��o}��H���R�Jo3���:LV����:m��qY��zP����Hw���\�5�d{���7��B$��}������k�Ms�,L.�%jCt��Nׯo����!=�_߾;���O�w����ǛӇ�-"q�pz|���?�����p�����"u���˴���8r	����9n����������W�Wo�$���Ϻ����ծ��wH�W77�{��$g��_�������{|�������^^�BVX��Tu���L�HE�r7S���[%q���ꍮ5i��EIÚJ}}[We	I&3F�"E1�ʅM��׷�4�ŷ�K��˺,!�H��O<����3[�fy�s��MA=$A�����\؞�T|J�"Z�=�׷��mI�L��[��u2!�C�x�F��J��ɐV���rޜ/��x�56�V�m�g"�'K���ed]�IG�n�<-J���M���GV�:������91~yssB)"��="\�����C��~<���O�8	�$y{�w��=��:��4�ݘs��������R�WǇ��w�'���yBp�?�_�=n���4�����/����o�M�����Z�fI9�* �{Oe�-g]4��펵�§����W3Q�%�Y
Q���ڳ	!'�*B�֩�Z�,�V��w��X0�Moɴ���Z��l�e�x�Ue�zN>G6�9�W�腕(�m\M�EI�:-�y�t�W��>����f�.4�5�$yZ6?��oF�׷i�x�u6Ԋuc� ��,�������^�*Ixa�̖ܜ�g,����ݞq9\� {��>����;�O�~�|�ǯN{�t�%Uޝ9�2�G����rx�W�UJ�b�Ӯd\�&P��ƮKAHG��V�S�ǅ�&��ܦf6ՙf�1ƅ��h�q��n��b2�I���b_�ZY%)�U\��%����݊$��]�E9oQC�=��于����N�Y.��hֲ�J�����!��ͩP[M6ժ:Q䆝�"q߽�آ/�-$��SIzYIvscHܭ!��>O�0�kC��tB��NP�{�Ҷ;`^���0�����q�������,}�����O�j�~.��O�� �Ǆ���o�>~�D�y���<������
�|z�����ᯇC�i5|Y���]���)쌮9;���Qm(�b�q�V

_�����<U�"S�䙷Q٥eÊV��
"������֖�M��kI� ��]��Mf����iv3>�,��"k���Uh���t���y�tk�&�p�݅��� u�����'E0`��9�d^ev�$���&�^S�)[�k\NMm��ԭRtGiiuߦ�iQQn m�;N��G�v0PN�Y5M��|}adH�/��O��I^�~u������@⋈:~���ӏ?^��>��yf}|��\�W �_��t�x��B�7���!��vx�w��A��`�m��9�H.Z/��8���y�z�TK���W�v|��:�.s��x��Ɓa)d5����1��m;�x���� �,ު`�����M�)��V�?̻`[�h�#h3H?�Y��x@l��C aNԗ�C��PT&���x�R�F�� 2%%�	@�%I�F �#�\U'�{�,G�2<mB����gi�����1��������1���߼�\�/�񇻫���H�)�@H����x}��q�h< <�Yt���1}���p��@֧3��>ޜ���p��'��������}�f$�����Ë �f�e�k�V��BwV8�p�"1C!Or�!ʆ��K��8q�QH*�lb]�h�&ٛ���"SP�a3��L����k�;`�N��n�/hƴ]q��R��@<0{�ڲ3�Y��9�0ȫ�e��<� �ީ���J	/�YkV}�p�,��* ( 5��6�� �z�zFL�������N�����DR��{D:O�0�,ȼ�#��8���t�׷�D,����p���`���p���܂Br�����a�z��y �pqX��?ޠn�G�=����{�O'��<�h��K�V�9gہ�(Fϑ��>�|�f�\9̨[H~D��EHbA�.�4h�M��+�y%�%�7��B|gPV���"4p@�8�V&�?x梧<ۆ{���p�EW�G�
�w�o
d`�MS�3����0kaq�~�����R+1��1M�8A�g�9�ߵ���(��UQ��2ʭzӒ2isI��F��?l<o���Q�O�/L�������C�^l�g�s��a�?\ߞ>U��-��+��q�o�`p�;�J�_B�UAϖ��0�e��6#�<�k]w�L��Tp��4�`�8�^9��+�������<�
��h���T5:M�j$�ͮa"���[����rr{'�Xj��P'��9��J��E��vdA�Y��4���l�x��R�����,bOd��n)d���Xi6Jv��%G ��0M?��g�&kx��_����:hQ�Ko����y�W^�ŪHDF����w�|��h����r���K�n�n�|�����jh|e8�y�p�����B����T��.�=������p)<�ֹ�"����$F6����Z(P%U�8��[yr
���U�P��⻆X�Z�`sEֆ��t�w�ۼԁ�5I�yK�b؞mMC��s̠�$���
W�ծ�NL�Ff1�&���C�(��Lg�y�$�S�I�6�@�9����x�{[������ث׍�e�s�^y6v���X?�� V�̍���¦{�'/s�q���/����c�?���T�
�7�S��Ї瑏c��}�������\��C
��o/����-�	���	��	_N���pwznV�tw�;;��<����U��%'#!��n����tF�PH�]���uꐚ�I��Nx*dtr�kf$1�2�Ո��=�"�J�i�|�ܩ�TF4P"�'�L�	x6���-���0�oQ�ź�8;�&��%�zD`IW��~�}u!�iyZ�9Ԑ�K��n��1�^6<?˰"�A1�Z?ͫ�ZY�)#��H���K�a�"[��<R��t�d5��/_������h��6���G��|�s�B�|.�O��r�H��˕��N��V�_��o�鋗����D'�$�C�D.k�ܼ��0O�@Ax"�2q�7욃5ė�Y5Ĉ�|;չyF�a6�ẖz��_�@rlv�n�^̒��B�̆�0�V�i�6Esx�	�$>�6������S��b箖y_����a��z+�[���g��I��$��X�&R:����i�1����>2�γu���>��Y�	ʧD�n�9��B8��NS�t�T.��q����rdWг~z�~w{��|�q���
�OC�B����?A�b޷�iD�Y���z<�04���E"�}<���>�����:�M�i���Ͳ�w(�@��%��@�p�c�Ų� ��C��I�����;�,���|@�R����h���%�<�iCN�c���m��~6�i�z�E��h
���l�ē m����`C�;j�`p�J�*'&�S$i�ʉ.k+F�Q��<���E!»�5�fa���ƥ�ߗZ�"X�;U�:�9�����*؛�S�4��m.8;�5�0���� �{wr���,:=^���=��A�<��bi�Q�WF�����v��ۧ? K���p�=��>C��?Oǧ�u��#�9�=#W
Tbȵ�vt����Г�Ùkv}�#1).�J�хKX2��^�R+j��6�δAS(�m��&��޷�hU��4 %  ��%l~-�;��u��IFE�*;�U�iY��~���,]����ͣ��	%�L��T�f��-�ۤgjP�]��S_+0wZ	�t��i�F�Ij��J�N���b�ڵ2#iBu/+�y\dLK�Հk؀��_V|�!J����WKo>݄o����
\�_?����}��>�)���[	#>�l����⯇��m4S`	��TW��TKS,@�M���B����-�ҭ���!���	��R���꾸�:�;O�M�O$���ڶ�"�K���),�iF"@*)p�_g�/��\����lQ�C*Q:E�︲�;����'j��F1nx��/P�Y���+-RY��B\."����p��剐) �lB?3�zr<@��	�I�����l��Faӌ\Xջ�#��� ��������~:�r�����D�`�����(��L���M�|��R�������[C%]߾�yB�~���}�����Jr�/��E�a�'W�,�B*��j�1��Xu]�S*�Z�4Ԓ ��ą�7��4��
�s[5��
X�SQa�8��:�Pk,��h�r.�.B�iV�c�]�z�UA�ځ&o�2>�R�� 1���Gjc�k��pH<yJ~V&��0��ia��U���a�*��lfI����hX!�4��g�m ~o���f�a�
X���JPm�ԗ��şo�܃;�5��������ޜn�A=+�O���/�~�r���0O��d� D��ڰ/���Z�Q�>�2��5���t,�޶���!�jeqnI���(���U@�q��V�� _¢�P/� f�D�8�H� 0A0�-�Q�PðTBA��>��,�������y�(?#̄ui��լ�2kZ@��
AA'�Th�̢a�r�<^ְ�fWO��ʎ�2Ie,�s�B#�y=�����}��׳��s3"=�����y��s_������?�<w?w΍�������kA�BL��~�����Ӈ�o.k4��s�o��_��j������>\���{8}�>?���s/���^��n<���=�����S1�a��$o��aj!���m,Gnp	`�\�0߮�-6��a�ǂ��y������y�Ŧ"2O'�3~��ֵ��e��բ�>���߯S�Ν�"��S�Vن�9 �!ÎmH�<!4�GK(�<oc���C��I��Ljk�v9�$��U@i;��8:M��u�7�UZ��}���/��
ks� ��W��eex�>Ō��/r$����+<W����*�����&�������)M��u7P]˾V��X�73K|��0"�ܗ��`�^㶓�"yncom��iN�!�lH�;�r[�M���u�|!�M�{%0�|�����X���b��*���pG"[1���5�զ��m��n�EO�@\nD�
#��|��)�I������p�
]��x�J��48ꕺ8�.0�U�B�4e��ޏIR��!�E�#�y���"Ėc��]����^}w���z��������"�G<	Jk,<���s=��u?�G+y�>��s�dT�y)��ϫ��9�������b��[&��8g�8/:<O<���3D�ξh��.wO���$���1�j������W���]���d�R��Ch7^�d^��Rf$�jS����eJ��&��
dA&�a�����lh��i��x��$+ۛ)��H�n ��7Ԗ��=�[�+'Z�Ot��m����G�n%g�򽸕c8��U�k�&]�Al+�R��e������=
�MIk��b���P�F#S��!�i�#�����$��Σ-�uW;؉��re�~���ɫ��� ��y>��ȇON�}��{��?b�����a�9A��t��Ǐ�(�����,?���u�z{Y�J��:���3Ư�D��p�\��|��M����s�O~^�:g�P���V����\�=�_>_��t����ëы�ƙ�E�J�Fb�n��-|�̩���HQ�lh.�}�Tuq5qb!?֞v&�!t��U�Mg�5�/&NU�L���-�j�ppil����k�[�<��p��T;ä�m����������j�<p������<73�mKz3;�Q^łԙ��0yi�lJ�ϋ�]Q=�f�"
U�ͽ�%D�Q�,�5R�b�=�N��$]s�s@$١ܘ����e�ȿ-��g(z���d :�d~�F}�"�m5G����9.��"���j4]Mk"���)l��o����6��Ǻ.[y,��ޓ�E���"�J�����k<,)mY�J}ͦ��2Y�r;EYF�IT��`ε8A�P�J�GbV����U.i�L!V��b[��.}�*���X��xLz_HV���g�L�,(�7��&�FR�S�9Xg�d�U��:��	,̤Iz]�-%j��T�'��<!I��6�⡧��V�����:��^�_����8�G ?���ͭA�%��]?�7f�W/_^�^�\��@9-�3O.�zh�޼��[��<i ����tQ/	���ыEu&��
b*�g!
�q̂�1f�Ⱥ�iϐu(5Z�P�5`<,Ӣ�D6�	��ln%�4����A�P:�YY;ZJ����F[7����]�I�tOI[�\F/��y��	�p�}�nd��8�$i�
_Ae���漭�KEnqfu���P��̹�L��"'�k��h�=�E�����-���O��v��[������p�4�ޜ����������_Y�볖�}x����4��p���\^�:��Z7Qo@�Ő�"ۥ��jS�N!�>�X<�0�̍�[��P �R�ҶJ�n�L����~+�sئM&�x������jK�e�r��R�׈eI���η�����t0b���$J5�3Z]sV17�T��j[�>"����`��&HH;|��xh�}㱺�$�(�NA���Db�Ĭ�e;��*f1��lc�Mv&����Ϙ[�j�Kܥ�#����������/Kg��w���]��j�X}sn��!�������~�����_��c�w��#m~A|�Ax��ë���S +Gx�X!��:����EO�s��7Md���5���^�VA�,؝V`�ci�5��<t��s-Dγ����L%{�zfz�8�/��������mrd�[���
�����i�3$����v��"�y��s�Z3/��pH�9�\����FX�������p�̋�Ԯ-��� �S��c��ٙ;���fN[*�L�;����z:��N �x��ݹ"o�ޜ�m_]$����?ߜ~����R�W����; �՛��'sq�|����m>�osn��%�E��x���������y	Lqi;{��{?����W�q�4n��}���c[A�U�ݖ�g-99;>S���6���</�j�1��TLQ	$�T�����B������X�ڃ��5ZTk�\d�}醄�;b;m�&?,ǁJͺ�Q����IE�9�����Me��m[����F2��Ɋ��/5 �tg�7�%��fWd��u8�Zg�(����k ���b49 �#��Op=ku��'�ħɒa^��?����P      /      x������ � �      ,      x������ � �      +   �  x�mT�r�8<��G��-z�G[2�*[)m�T���#+`@0��~��I.�LјG���n�W�n��3ڨPs��.���.xm�	m�nX|�g�Ii�|@��Gm�\�G݅�ҽWm��j��I�X��2��ɪF�b�����Y�Qu�h/�3��ﴳ�2�1W'�9ݪ�<~�/�	���(��� �x`��Z�e+�r�[���1��䔞�
c�B�kN��Gɰja,��pAt2��4�Yrn��L��tϮ���n&�7�����!�S�A�wg3$��1�,������5\߅s��պ�}@pI��U�[�vg���c�&u���סn��Tw���(��ʘ�`�>�1��ׅ�ջPJ��ʼ��堉�z�Zg�A�ʈ�
�g��@���I>��ް�ʊ-T$ʡ�&8{F�B��I���6
.Ϡ��Y�e�8�u��� cg�����j�Z}��$�O^�?
t�@�!���h+V} (qQ��C෡�dJ+�y�+��2�wzТLf�q�M��ĶV!��56Fْ/�^aŞjvЎL�4n���~�:paGe��4g�������iB{�r����y��)��6w,>cۡ�wQ9N�O.�Ԣ��XK:�BAo��!Z��v{�qUOhb:�o�ׯ��u�V�s�zلtA�~�Ǘ��`I���O/��2Hͻ(�aYd���f{�"����� ���[�<�s.�:^4�O�)��U�^oT����3���һ}�~P������d2���J      @      x������ � �      1      x������ � �      2      x������ � �      )   $  x��Y�v�8}V}�j��^k��y�TB$�u���p0R�����������9��d�������FG��g�}���F��1��w��d�9��6�O�߱�:W㧇���5;z9:���/w�yq�9[�ݺ�(I�,C:?��pu|�B�lQ��|��Pt�2��X��q�$�E�f8��i�!q�[dt�{���u�mI�Űt���u�>ݳt7?�ޛ��O��([/;+#X�X�/����r}s�L���ںz>���� /����n�q��<�I¥�0��j�tRBbآ�i�M���,bsa�2��+�m���	H_Ǥ~<g��p�D��r.��a�(�b.�A��.v�0 ���'�G����aj�A�|�0�_	z�Yt\��b
� �D�,f4e��=�����p���M����|X>�
�Wx��1I$����\� x���-��ϬҦ� �3�l^ٴQ�F7!�H��48 )�����\�Ek=���zh�W������� ���`�ŀ)�`��	�&�8�Ѱz���Є(P� �p��^�3�����("qe�Ep�X0���6��>�3�n-�
:<�-m��>�&	I�(a�=�7K�(#����]t��P7	^�S��t��d���*Tz����-�r���Y�i�!��!�^���x�����>���!#���q2
���RFيe����F�]=�I,c���g>|5`&%�'NI�.q��q�/m/6z�1Vih��x)����)���f�P�<����@��x{MHe�D?��x\�O?K��7��m@��GD.�G�O��2f!��p�/�X�H� �?a��N�F36;�.$FݢK$��x��6)=X^̢KE�)�|�L~��O�M��8L�OX<c��6����J�\�8I>q������Z����͏��ݹ3~�y\<]�����p�1�����q��������{�?�{>�2�-$z��,V+04�����yJ�J�d����[�M�}�!���碿�����F�����giR!�����o�3�	�"\���h� �Rm@�4L��s8�e��m0����;N�G���+��!���|;���,&�X�xNV��-P��G�9��$�'1�(؄�|�=\',K�Lb4!,��=C�W���"�t��^ޝ=ٝ�h~���g�k�Y�GG�Wu6?���ӌݥyu�^>���S�!8�X�c���w:���]�萿�n�G��Ssy1>��Y�~����0�ܲy��l�_���v���5_���gO�tV��>��Μ���� K<��O�؋o1訨Q/�FNKY��=��Gdӓ��9�����#�$BҪn���Jv�e5RK�"rno&���K��v��#�;?$�i͞Q�0�QN<��|�o�%�)�&�9�l�p ݛm;c��E�f}
�AB4����V�RJ������զ�mq쓈��VJ�������^%�@:(΃�βx��,;��8�^8�f]My��O��0�$���g�Bj��/z�!��	�T֫�ܝ��]?�aZ�'���EK��[�28>��p����ٯ�Ѥ+��cE&t���2*s��u@~�@��,���G]�C]��ɳ"Hfo0�u&ߨ]�#�!D� i���{$�� �lF�qL�R�j�|X�G�����;d �S�̉v�(�U3?�ª����PXRʊV�������<��]4
�r�Z���n��=�!�@V��f�Y�E�bpzh��BA������p��З���+�хh��G[a��n�pb���7X>ހ/c��R��/��%ڦ���|Y�,�#%���t����~��S�j�CtW/:&JѽZǤ�P�[Q�5 'Ϟ�Ӝ*�ҲQ�M�RC���&j��ˊ��4�YvN���[�H�d*�!�����{8�٢Y1h߆��D掞�o�V�X�HP|JWe������D��r�M�����Qصw�Q�@
�wZr���7ܖ�U.!dh���
KN�lQ�m��f�Zd�*�
 _�����e����uw�Y�VC�E� N/�;�����+�4�F�/p���H
�㘗�r}8�s��&P�('��vK��MTQ�3��[�=��o�v�8�tՌ]�M��_�X�J!	���%�3�?}�[���S^yɠ?�N��u�Kh܂�ӑ�0�*����B�|�V3,mK��J����e�&�0v296zӂj2� (ʫc�B���D�䱩Y��Vъ�jHJMݨ��H���������آ2�ڼ#5Y�颊*�#�� v�*��OnX�>�م1��J�De�zR���e��� ׾�f��s�")�����Z�fߑ���6��K��X-�@9B�E[�G�Di{�7#���Ό�x�� �I]N�a�\�y�<P�����T�^��J�/73��4md�����ǀ#ʀ/��W�&�2��wBIB�k���YF�q~�4������땭rYm��V��p5��bHU_��G�-lNi�Kmk�b� pY���R^��
N.[�J̺�q����;S�����ë1��4e�:���(�n'mx����D��38u)������%�jڷ��k�4/�K��̂��|ۭ���A���,9Z���v�֞UP�ĝz��j���k�E�.���T%��i(TU����S�������:�&������%q$H$���2���eqĤ7iB��s�>�T�@Ү�����lM@˂�!`!�ͨ-#���=#�HU�F�w@��Q��V[H��f��[Hr�d:J���l�V�	t�ė�Y���/_��/bK     
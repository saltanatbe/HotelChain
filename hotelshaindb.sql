PGDMP     ;    /        	        y            postgres    14.0    14.0 5    B           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            C           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            D           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            E           1262    13754    postgres    DATABASE     e   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false            F           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3397                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            G           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            ?            1259    32855    billing    TABLE     ?   CREATE TABLE public.billing (
    hotelid integer NOT NULL,
    guestid integer NOT NULL,
    checkout date NOT NULL,
    price integer
);
    DROP TABLE public.billing;
       public         heap    postgres    false            ?            1259    32897    clean_schedule    TABLE     t   CREATE TABLE public.clean_schedule (
    hotelid integer NOT NULL,
    roomnumber integer NOT NULL,
    day date
);
 "   DROP TABLE public.clean_schedule;
       public         heap    postgres    false            ?            1259    32892    employee    TABLE     ?   CREATE TABLE public.employee (
    employee_name character varying(50) NOT NULL,
    day date NOT NULL,
    num_hours integer,
    hotel_name character varying(50)
);
    DROP TABLE public.employee;
       public         heap    postgres    false            ?            1259    32825    guest    TABLE     X  CREATE TABLE public.guest (
    guestid integer NOT NULL,
    identification character varying(20),
    name character varying(30),
    surname character varying(40),
    idnumber integer,
    address character varying(50),
    homenumber integer,
    email character varying(60),
    mobilenumber bigint,
    password character varying(20)
);
    DROP TABLE public.guest;
       public         heap    postgres    false            ?            1259    32795 
   hotelrooms    TABLE     ?   CREATE TABLE public.hotelrooms (
    hotelid integer NOT NULL,
    roomtype character varying(20) NOT NULL,
    size integer,
    capacity integer
);
    DROP TABLE public.hotelrooms;
       public         heap    postgres    false            ?            1259    32770    hotels    TABLE     ?   CREATE TABLE public.hotels (
    hotelid integer NOT NULL,
    hotelname character varying(40),
    adress character varying(50)
);
    DROP TABLE public.hotels;
       public         heap    postgres    false            ?            1259    32889    member    TABLE     ?   CREATE TABLE public.member (
    username character varying(40),
    password character varying(40),
    "position" character varying(40)
);
    DROP TABLE public.member;
       public         heap    postgres    false            ?            1259    32874    phonenumbers    TABLE     d   CREATE TABLE public.phonenumbers (
    hotelid integer NOT NULL,
    phonenumber bigint NOT NULL
);
     DROP TABLE public.phonenumbers;
       public         heap    postgres    false            ?            1259    32845    price    TABLE     ?   CREATE TABLE public.price (
    hotelid integer NOT NULL,
    roomtype character varying(20) NOT NULL,
    weekday character varying(10) NOT NULL,
    price integer
);
    DROP TABLE public.price;
       public         heap    postgres    false            ?            1259    32912    price_on_day    TABLE     ?   CREATE TABLE public.price_on_day (
    weekday integer NOT NULL,
    price integer,
    roomtype character varying(30) NOT NULL,
    hotelid integer NOT NULL
);
     DROP TABLE public.price_on_day;
       public         heap    postgres    false            ?            1259    32830    reservation    TABLE     ?   CREATE TABLE public.reservation (
    hotelid integer NOT NULL,
    roomnumber integer NOT NULL,
    guestid integer NOT NULL,
    roomtype character varying(20) NOT NULL,
    checkin date NOT NULL,
    checkout date,
    price integer
);
    DROP TABLE public.reservation;
       public         heap    postgres    false            ?            1259    32815    rooms    TABLE     ?   CREATE TABLE public.rooms (
    hotelid integer NOT NULL,
    roomnumber integer NOT NULL,
    floor integer,
    roomtype character varying(20)
);
    DROP TABLE public.rooms;
       public         heap    postgres    false            :          0    32855    billing 
   TABLE DATA           D   COPY public.billing (hotelid, guestid, checkout, price) FROM stdin;
    public          postgres    false    216   A       >          0    32897    clean_schedule 
   TABLE DATA           B   COPY public.clean_schedule (hotelid, roomnumber, day) FROM stdin;
    public          postgres    false    220   3A       =          0    32892    employee 
   TABLE DATA           M   COPY public.employee (employee_name, day, num_hours, hotel_name) FROM stdin;
    public          postgres    false    219   PA       7          0    32825    guest 
   TABLE DATA           ?   COPY public.guest (guestid, identification, name, surname, idnumber, address, homenumber, email, mobilenumber, password) FROM stdin;
    public          postgres    false    213   ?A       5          0    32795 
   hotelrooms 
   TABLE DATA           G   COPY public.hotelrooms (hotelid, roomtype, size, capacity) FROM stdin;
    public          postgres    false    211   ~B       4          0    32770    hotels 
   TABLE DATA           <   COPY public.hotels (hotelid, hotelname, adress) FROM stdin;
    public          postgres    false    210   ?B       <          0    32889    member 
   TABLE DATA           @   COPY public.member (username, password, "position") FROM stdin;
    public          postgres    false    218   RC       ;          0    32874    phonenumbers 
   TABLE DATA           <   COPY public.phonenumbers (hotelid, phonenumber) FROM stdin;
    public          postgres    false    217   ?C       9          0    32845    price 
   TABLE DATA           B   COPY public.price (hotelid, roomtype, weekday, price) FROM stdin;
    public          postgres    false    215   
D       ?          0    32912    price_on_day 
   TABLE DATA           I   COPY public.price_on_day (weekday, price, roomtype, hotelid) FROM stdin;
    public          postgres    false    221   ?D       8          0    32830    reservation 
   TABLE DATA           g   COPY public.reservation (hotelid, roomnumber, guestid, roomtype, checkin, checkout, price) FROM stdin;
    public          postgres    false    214   E       6          0    32815    rooms 
   TABLE DATA           E   COPY public.rooms (hotelid, roomnumber, floor, roomtype) FROM stdin;
    public          postgres    false    212   ?E       ?           2606    32859    billing billing_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_pkey PRIMARY KEY (hotelid, guestid, checkout);
 >   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_pkey;
       public            postgres    false    216    216    216            ?           2606    32901 "   clean_schedule clean_schedule_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.clean_schedule
    ADD CONSTRAINT clean_schedule_pkey PRIMARY KEY (hotelid, roomnumber);
 L   ALTER TABLE ONLY public.clean_schedule DROP CONSTRAINT clean_schedule_pkey;
       public            postgres    false    220    220            ?           2606    32896    employee employee_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_name, day);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    219    219            ?           2606    32829    guest guest_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (guestid);
 :   ALTER TABLE ONLY public.guest DROP CONSTRAINT guest_pkey;
       public            postgres    false    213            ?           2606    32799    hotelrooms hotelrooms_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.hotelrooms
    ADD CONSTRAINT hotelrooms_pkey PRIMARY KEY (hotelid, roomtype);
 D   ALTER TABLE ONLY public.hotelrooms DROP CONSTRAINT hotelrooms_pkey;
       public            postgres    false    211    211            ?           2606    32774    hotels hotels_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (hotelid);
 <   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_pkey;
       public            postgres    false    210            ?           2606    32878    phonenumbers phonenumbers_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.phonenumbers
    ADD CONSTRAINT phonenumbers_pkey PRIMARY KEY (hotelid, phonenumber);
 H   ALTER TABLE ONLY public.phonenumbers DROP CONSTRAINT phonenumbers_pkey;
       public            postgres    false    217    217            ?           2606    32916    price_on_day price_on_day_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.price_on_day
    ADD CONSTRAINT price_on_day_pkey PRIMARY KEY (weekday, hotelid, roomtype);
 H   ALTER TABLE ONLY public.price_on_day DROP CONSTRAINT price_on_day_pkey;
       public            postgres    false    221    221    221            ?           2606    32849    price price_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_pkey PRIMARY KEY (hotelid, roomtype, weekday);
 :   ALTER TABLE ONLY public.price DROP CONSTRAINT price_pkey;
       public            postgres    false    215    215    215            ?           2606    32834    reservation reservation_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (hotelid, roomtype, checkin);
 F   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_pkey;
       public            postgres    false    214    214    214            ?           2606    32819    rooms rooms_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (hotelid, roomnumber);
 :   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_pkey;
       public            postgres    false    212    212            ?           2606    32860    billing billing_guestid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_guestid_fkey FOREIGN KEY (guestid) REFERENCES public.guest(guestid) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.billing DROP CONSTRAINT billing_guestid_fkey;
       public          postgres    false    3215    216    213            ?           2606    32902 *   clean_schedule clean_schedule_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.clean_schedule
    ADD CONSTRAINT clean_schedule_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotels(hotelid);
 T   ALTER TABLE ONLY public.clean_schedule DROP CONSTRAINT clean_schedule_hotelid_fkey;
       public          postgres    false    220    210    3209            ?           2606    32907 5   clean_schedule clean_schedule_roomnumber_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.clean_schedule
    ADD CONSTRAINT clean_schedule_roomnumber_hotelid_fkey FOREIGN KEY (roomnumber, hotelid) REFERENCES public.rooms(roomnumber, hotelid);
 _   ALTER TABLE ONLY public.clean_schedule DROP CONSTRAINT clean_schedule_roomnumber_hotelid_fkey;
       public          postgres    false    220    3213    212    212    220            ?           2606    32800 "   hotelrooms hotelrooms_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.hotelrooms
    ADD CONSTRAINT hotelrooms_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotels(hotelid) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.hotelrooms DROP CONSTRAINT hotelrooms_hotelid_fkey;
       public          postgres    false    3209    210    211            ?           2606    32879 &   phonenumbers phonenumbers_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.phonenumbers
    ADD CONSTRAINT phonenumbers_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotels(hotelid) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.phonenumbers DROP CONSTRAINT phonenumbers_hotelid_fkey;
       public          postgres    false    210    3209    217            ?           2606    32850 !   price price_hotelid_roomtype_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.price
    ADD CONSTRAINT price_hotelid_roomtype_fkey FOREIGN KEY (hotelid, roomtype) REFERENCES public.hotelrooms(hotelid, roomtype) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.price DROP CONSTRAINT price_hotelid_roomtype_fkey;
       public          postgres    false    215    215    211    211    3211            ?           2606    32917 &   price_on_day price_on_day_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.price_on_day
    ADD CONSTRAINT price_on_day_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotels(hotelid);
 P   ALTER TABLE ONLY public.price_on_day DROP CONSTRAINT price_on_day_hotelid_fkey;
       public          postgres    false    3209    221    210            ?           2606    32922 /   price_on_day price_on_day_roomtype_hotelid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.price_on_day
    ADD CONSTRAINT price_on_day_roomtype_hotelid_fkey FOREIGN KEY (roomtype, hotelid) REFERENCES public.hotelrooms(roomtype, hotelid);
 Y   ALTER TABLE ONLY public.price_on_day DROP CONSTRAINT price_on_day_roomtype_hotelid_fkey;
       public          postgres    false    221    221    3211    211    211            ?           2606    32835 $   reservation reservation_guestid_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_guestid_fkey FOREIGN KEY (guestid) REFERENCES public.guest(guestid);
 N   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_guestid_fkey;
       public          postgres    false    3215    213    214            ?           2606    32840 /   reservation reservation_hotelid_roomnumber_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_hotelid_roomnumber_fkey FOREIGN KEY (hotelid, roomnumber) REFERENCES public.rooms(hotelid, roomnumber) ON UPDATE CASCADE ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.reservation DROP CONSTRAINT reservation_hotelid_roomnumber_fkey;
       public          postgres    false    212    214    3213    214    212            ?           2606    32820 !   rooms rooms_hotelid_roomtype_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_hotelid_roomtype_fkey FOREIGN KEY (hotelid, roomtype) REFERENCES public.hotelrooms(hotelid, roomtype) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.rooms DROP CONSTRAINT rooms_hotelid_roomtype_fkey;
       public          postgres    false    211    3211    212    212    211            :      x?????? ? ?      >      x?????? ? ?      =   O   x?K?-?ɯLM?7?4202?54?50?????/I͉7?J??!?b?#????ol?M??В?? ?F??fp?=... ?,6      7   ?   x?e??
?0???S?b?&?V???A?*6#??黩?A??23??fқ??ot?ڹ?̬?npz?=H?Ɖ???.?/?'a??@?ߺ?	?q )CƣX??CYx?%>?yA???q#G?B@>?????`Ă??PU??t¸b?EԌ0??B???:Q?%
??>5?Kq"?`??D?????,?"u&?/??>?4Y?      5   `   x?=?K? E???bPP?D#1D?????Yo{R?+????X??3|?p???q??Cm]??v?ig?*Z^*??2J??~D?9?ty?U"??^!      4   T   x?3??/?P?N?????IIL/??/KT05?2?t?/-RNM,??+?N,?L,?NT02?2?J?I??t?LLϯR06?????? ???      <   `   x?M?K
?0C?3???=? ??U?-????????? ?P?!{`?y??'?9?b??2AyX?3??????z̝??Ň??N?%???(?:?ڌ?o`*?      ;   8   x???  ?7ƴ?wq?9T~??l?<zȹ??	??/٠?Q?jPI????      9   n   x?=??@0??u?02???!Ć???q????jy??_?{ަՈ?? @*1?v????l?_0Fu?]0F,yy???s????U,?Ĳ????}?~?M???)??+?      ?   y   x?U?A
B1????0ҴI?wq%???????f?	?!?lxߟ??n???(D)?HRa?M'?U?7?*?B????+????{???9??ġe*'|?jn?:??(D)????EM???̾nDb?      8   ~   x?m?A
B1D??]*3ic??VD7?L?j?X?Ń<fB!(???y{\?`,???!????#?=?]?+?????B??l?n?خaZb???C<?{??&\?5????u?%Z?9q??z9??m@A?      6   v   x?M?K?0C??aP?\?MB ?????Avy??9,Y??O????gB?`?0|Ͼ ??3?ջ-?7???{)??\
?=????Qc5#?LQq?Yh>?䝙 ??yH?$?;?51???:     
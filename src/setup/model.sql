create database dtm;

\c dtm

create EXTENSION "uuid-ossp";
create type gender_type as enum('male', 'female');

drop table if exists regions;
create table regions(
    region_id uuid default uuid_generate_v4() primary key,
    region_name varchar(30) not null
);

drop table if exists users;
create table users(
    user_id uuid default uuid_generate_v4() primary key,
    fullname varchar(60) not null,
    contact text unique not null,
    region_id uuid references regions(region_id) not null,
    password varchar(20) not null,
    gender gender_type not null
);

drop table if exists subjects;
create table subjects(
    subject_id uuid default uuid_generate_v4() primary key,
    subject_name varchar(30) not null
);

drop table if exists universities;
create table universities(
    university_id uuid default uuid_generate_v4() primary key,
    university_name text not null,
    region_id uuid references regions(region_id) not null
);

drop table if exists faculties;
create table faculties(
    faculty_id uuid default uuid_generate_v4() primary key,
    faculty_name text not null,
    first_subject uuid references subjects(subject_id) not null,
    second_subject uuid references subjects(subject_id) not null,
    grant_count int not null,
    contract_count int not null,
    passing_score_grant decimal(4, 1) not null,
    passing_score_contract decimal(4, 1) not null,
    university_id uuid references universities(university_id) on delete cascade not null
);

drop table questions;
create table questions(
    question_id uuid default uuid_generate_v4(),
    question text not null,
    question_variants jsonb not null,
    subject_id uuid references subjects(subject_id) on delete cascade not null
);

drop table if exists results;
create table results(
    result_id uuid default uuid_generate_v4(),
    first_subject int not null,
    second_subject int not null,
    score_ball decimal(4,1) not null,
    date timestamp default current_timestamp,
    time int not null,
    user_id uuid references users(user_id) on delete cascade not null,
    faculty_id uuid references faculties(faculty_id) on delete cascade
);

insert into regions(region_id, region_name) values 
('a197837c-dc5c-4698-b1bf-85caf049b2ed','andijon viloyati'), 
('28bafdef-5a63-4355-b9c9-281045703868','buxoro viloyati'), 
('5bed5b1a-6381-450c-aeff-3a088c5c77b5','far''ona viloyati'), 
('f9f1597f-7070-4815-bf30-14f136fee858','jizzax viloyati'), 
('d2f00457-e6d7-40a0-b887-3adecc1501f1','xorazm viloyati'), 
('e1d82058-ba9c-4e43-9666-3ce5ca0b66a2','namangan viloyati'), 
('d23c43cb-430a-4dd1-b089-5d681537ffbc','navoi viloyati'), 
('f736af18-6c43-4cea-96ee-78c31f202c4f','qashqadaryo viloyati'), 
('a333094a-066c-41ca-a062-045f15adda82','qoraqalpog''iston respublikasi'), 
('f9ad394d-276b-4559-b0fd-03eb6ac1bfd3','samarqand viloyati'), 
('5814832e-f380-4a68-88be-34d7af035f57','sirdaryo viloyati'), 
('c45616c6-faa5-4665-938c-31d63fb24024','surxondaryo viloyati'), 
('c45616c6-faa5-4665-938c-31d63fb24024','toshkent viloyati'),
('1afee431-8e9c-4c3c-86ac-b597f12917d5','toshkent shaxri');

insert into subjects(subject_id, subject_name) values 
('80cee137-7945-45c7-8021-7f840e636006','Matematika'), 
('29f440aa-b4b9-4f64-a915-df1c966da8f7','Ingliz tili'), 
('9bdd04a7-29d0-4a71-8326-efc8d02051dc','Fizika'), 
('0efb69e2-d40d-4baa-af59-5883b6d7766c','Biologiya'), 
('c50a6720-c1da-4914-8f41-708f506bdc3a','Kimyo');

insert into users(user_id, fullname, contact, region_id, password, gender) values ('e42eed48-fcd7-4423-ada4-9ce051c0e663','Aziz', '998935852484', '1afee431-8e9c-4c3c-86ac-b597f12917d5', '12345678', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('c4a242e8-972c-4028-8281-56b4a12a3df1','Said', '998935853454', '1afee431-8e9c-4c3c-86ac-b597f12917d5', '12345678', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('3c4525c4-556f-4aa3-b361-cf8034d37e5f','Ali', '998901061016', '1afee431-8e9c-4c3c-86ac-b597f12917d5', '12345678', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('7073c34f-7b03-4078-b804-d155da61a24c','Diyor', '998997771524', '1afee431-8e9c-4c3c-86ac-b597f12917d5', '12345678', 'male');
insert into users(user_id, fullname, contact, region_id, password, gender) values ('a22d0f71-acc4-42ea-87ad-06faeb5d4bf7','Mavlon', '998951238456', '1afee431-8e9c-4c3c-86ac-b597f12917d5', '12345678', 'male');

insert into universities(university_id ,university_name, region_id) values 
('1edbde22-7ef4-415d-960c-1445a4743972', 'Toshkent axborot texnologiyala universiteti', '1afee431-8e9c-4c3c-86ac-b597f12917d5'),
('f6030c8a-c229-4edf-b178-f3ccd4660f5f', 'Toshkent tibbiyot akademiyasi', '1afee431-8e9c-4c3c-86ac-b597f12917d5'),
('df7cc24e-429c-4bda-bccf-ed1653b95560', 'Toshkent Moliya Instituti', '1afee431-8e9c-4c3c-86ac-b597f12917d5'),
('08963625-ab39-4982-bac5-f52dc94b9f54', 'Ozbekiston Milliy Universiteti', '1afee431-8e9c-4c3c-86ac-b597f12917d5'),
('212cc55c-efa3-4eac-a67f-e26be32ad5f1', 'Andijon mashinasozlik instituti', 'a197837c-dc5c-4698-b1bf-85caf049b2ed');

insert into faculties(faculty_id, grant_count, contract_count ,faculty_name, first_subject, second_subject, passing_score_grant, passing_score_contract, university_id) values 
('57fa6bd8-10ff-48ca-8ae2-8c0105318d5a', '25', '45', 'Axborot xavfsizligi (sohalar bo''yicha)', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '168.7', '125.7', '1edbde22-7ef4-415d-960c-1445a4743972'),
('b47f67ba-abd9-4e3e-8f2b-39e6b9ef1052','32', '56', 'Dasturiy injiniring', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '167.9', '116.5', '1edbde22-7ef4-415d-960c-1445a4743972'),
('f593b87e-91ce-4bbd-84b9-f5d57ac4147d','12','79','Kiberxavfsizlik injiniringi', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '169.1', '125.7', '1edbde22-7ef4-415d-960c-1445a4743972'),
('20094e6f-58ca-4fcb-9c27-5ef46f8c95a8','21','88','Sun''iy intellekt', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '161.8', '103.9', '1edbde22-7ef4-415d-960c-1445a4743972'),
('12927705-bb7c-448c-95a6-d2bee64f336d','22','97','Mexatronika va robototexnika', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '102.8', '67.3', '1edbde22-7ef4-415d-960c-1445a4743972'),

('2a1818df-4244-4a72-ad8a-b548954b0b68','4','72','Biotibbiyot muhandisligi', '0efb69e2-d40d-4baa-af59-5883b6d7766c', 'c50a6720-c1da-4914-8f41-708f506bdc3a', '107.3', '60.7', 'f6030c8a-c229-4edf-b178-f3ccd4660f5f'),
('1ad847dd-4101-4869-8ee8-983acb6ceb15','26','76','Davolash ishi', '0efb69e2-d40d-4baa-af59-5883b6d7766c', 'c50a6720-c1da-4914-8f41-708f506bdc3a', '123.5', '105.5', 'f6030c8a-c229-4edf-b178-f3ccd4660f5f'),
('b1c67f0b-6e6f-4b9f-8887-0d84ff7171e5','25','82','Pediatriya ishi', '0efb69e2-d40d-4baa-af59-5883b6d7766c', 'c50a6720-c1da-4914-8f41-708f506bdc3a', '154', '95.4', 'f6030c8a-c229-4edf-b178-f3ccd4660f5f'),
('e89c8907-0f57-4215-bc0b-5fe79d388c4b','20','99','Tibbiy-biologik ish', '0efb69e2-d40d-4baa-af59-5883b6d7766c', 'c50a6720-c1da-4914-8f41-708f506bdc3a', '147.2', '85.4', 'f6030c8a-c229-4edf-b178-f3ccd4660f5f'),
('d0707183-9478-4788-bdf9-3a24baac1021','24','94','Xalq tabobati', '0efb69e2-d40d-4baa-af59-5883b6d7766c', 'c50a6720-c1da-4914-8f41-708f506bdc3a', '154.1', '99', 'f6030c8a-c229-4edf-b178-f3ccd4660f5f'),

('7b077801-6b00-4719-a494-7e0e76e17ccf','12','53','Baholash ishi', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '166.5', '113.6', 'df7cc24e-429c-4bda-bccf-ed1653b95560'),
('7bc70c46-d655-4d02-83a6-38c89a5565df','5','57','Sug''urta ishi', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '167.8', '81.1', 'df7cc24e-429c-4bda-bccf-ed1653b95560'),
('692ad2dd-c900-47df-9bec-d5116b010c9a','16','54','Birja ishi', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '175.1', '115.7', 'df7cc24e-429c-4bda-bccf-ed1653b95560'),
('e99dbfb9-ac3c-4106-9bd1-a93fd9ec1c91','13','69','Iqtisodiy xavfsizlik', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '175.8', '126', 'df7cc24e-429c-4bda-bccf-ed1653b95560'),
('e3200cb6-2203-474e-a671-7414eae5946e','27','71','Biznes-tahlil', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '175.1', '107.2', 'df7cc24e-429c-4bda-bccf-ed1653b95560'),

('75cba594-657f-4c81-aa13-ad82ae6f6174','20','45','Amaliy matematika', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '165.7', '124.6', '08963625-ab39-4982-bac5-f52dc94b9f54'),
('3917bf9c-7d21-4755-96fc-df4b8c0a65e8','14','96','Bank ishi va auditi', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '161.3', '101.9', '08963625-ab39-4982-bac5-f52dc94b9f54'),
('41f21208-d4e7-4612-9d02-e0524f998daf','35','81','Iqtisodiyot (tarmoqlar va sohalar bo''yicha)', '80cee137-7945-45c7-8021-7f840e636006', '29f440aa-b4b9-4f64-a915-df1c966da8f7', '179.7', '129.5', '08963625-ab39-4982-bac5-f52dc94b9f54'),
('0181f96e-22ba-47d7-8415-0214b99c3f10','36','49','Biologiya (matematik biologiya)', '80cee137-7945-45c7-8021-7f840e636006', '0efb69e2-d40d-4baa-af59-5883b6d7766c', '68.8', '56.9', '08963625-ab39-4982-bac5-f52dc94b9f54'),
('93dee9d2-74b7-4728-9044-367a5b7a6b60','45','59','Biotexnologiya (tarmoqlar bo''yicha)', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '126.8', '111.1', '08963625-ab39-4982-bac5-f52dc94b9f54'),

('5bd1d681-15da-4a19-9af7-3777cd25a7ba','23','83','Avtomobil servisi', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '87.2', '66.2', '212cc55c-efa3-4eac-a67f-e26be32ad5f1'),
('f70315b2-00c1-417b-b9a6-550288e7807d','29','78','Avtomobilsozlik va traktorsozlik', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '73.6', '64.3', '212cc55c-efa3-4eac-a67f-e26be32ad5f1'),
('83b3c4c8-e829-4cad-adba-f5fc1d08e5af','22','70','Mashinasozlik texnologiyasi, mashinasozlik ishlab chiqarishini jihozlash va avtomatlashtirish', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '97.3', '70.2', '212cc55c-efa3-4eac-a67f-e26be32ad5f1'),
('333ab9a6-2414-47bc-be16-ac1b57a67128','27','58','Energiya tejamkorligi va energoaudit', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '90.7', '73.7', '212cc55c-efa3-4eac-a67f-e26be32ad5f1'),
('4588c813-b0f7-4c9d-9f2c-2d6899db3f76','16','45','Metallar texnologiyalari (jarayon turlari bo''yicha)', '80cee137-7945-45c7-8021-7f840e636006', '9bdd04a7-29d0-4a71-8326-efc8d02051dc', '70.6', '58.1', '212cc55c-efa3-4eac-a67f-e26be32ad5f1');

insert into questions(question, question_variants, subject_id) values 
('Quyidagi sonlardan qaysi biri 1515 ga qoldiqsiz bo''linmaydi?', '{
    "1": 6525,
    "2": 6145,
    "3": 4620,
    "4": 3105,
    "correct": 2
}', '80cee137-7945-45c7-8021-7f840e636006'),
('752752 sonining o''ng tomoniga qanday raqam yozilsa, hosil bo''lgan son 3636 ga qoldiqsiz bo''linadi?', '{
    "1": 6,
    "2": 4,
    "3": 7,
    "4": 2,
    "correct": 3
}', '80cee137-7945-45c7-8021-7f840e636006'),
('246*013579246*013579 soni 9 ga bo''linishi uchun yulduzchaning o''rniga qanday raqam qo''yilishi kerak?', '{
    "1": 4,
    "2": 7,
    "3": 8,
    "4": 0,
    "correct": 1
}', '80cee137-7945-45c7-8021-7f840e636006'),
('Berilgan p=10189144,p=10189144, q=396715256q=396715256 va r=78901644r=78901644 sonlardan qaysilari 88 ga qoldiqsiz bo''linadi?', '{
    "1": "p va q",
    "2": "p",
    "3": "r",
    "4": "p va r",
    "correct": 2
}', '80cee137-7945-45c7-8021-7f840e636006'),
('1782751617827516 quyidagi sonlardan qaysi biriga qoldiqsiz bo''linadi?', '{
    "1": 4,
    "2": 10,
    "3": 5,
    "4": 3,
    "correct": 1
}', '80cee137-7945-45c7-8021-7f840e636006'),
('3, 6, 73,6,7 va 99 raqamlaridan ularni takrorlamasdan mumkin bo''lgan barcha 44 xonali sonlar tuzilgan. Bu sonlar ichida nechtasi 44 ga qoldiqsiz bo''linadi?', '{
    "1": 6,
    "2": 2,
    "3": 8,
    "4": 4,
    "correct": 2
}', '80cee137-7945-45c7-8021-7f840e636006'),
('821 ga qanday eng kichik musbat sonni qo''shganda, yi''indi 66 ga qoldiqsiz bo''linadi?', '{
    "1": 4,
    "2": 5,
    "3": 1,
    "4": 7,
    "correct": 4
}', '80cee137-7945-45c7-8021-7f840e636006'),
('3030 dan kichik tub sonlar nechta?', '{
    "1": 11,
    "2": 12,
    "3": 9,
    "4": 10,
    "correct": 2
}', '80cee137-7945-45c7-8021-7f840e636006'),
('18 90 va 300 sonlarining eng kichik umumiy karralisini toping', '{
    "1": 18,
    "2": 80,
    "3": 900,
    "4": 10,
    "correct": 3
}', '80cee137-7945-45c7-8021-7f840e636006'),
('Quyidagi sonlardan qaysi biri 1212 ga qoldiqsiz bo''linmaydi?', '{
    "1": 12024,
    "2": 13620,
    "3": 18320,
    "4": 9216,
    "correct": 3
}', '80cee137-7945-45c7-8021-7f840e636006');

insert into questions(question, question_variants, subject_id) values 
('Choose the answer which correctly completes the sentence.
Internet news … you more information than TV news.', '{
    "1": "give",
    "2": "is given",
    "3": "gives",
    "4": "are giving",
    "correct": 4
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
Rabbits have large front …, short tails, and hind legs and feet adapted for running and jumping.', '{
    "1": "teeth''s",
    "2": "teeth",
    "3": "tooth",
    "4": "tooth''s",
    "correct": 2
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
There … much international news in the local papers.', '{
    "1": "hasn''t",
    "2": "isn''t",
    "3": "haven''t",
    "4": "aren''t",
    "correct": 1
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Hundreds of tigers are still being illegally killed throughout Asia. Every day two wild … die, frequently leaving behind young helpless baby tigers to starve.', '{
    "1": "tigers",
    "2": "tigers",
    "3": "tiger",
    "4": "tiger''s",
    "correct": 2
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
There are a lot of … in the street', '{
    "1": "trees''",
    "2": "trees",
    "3": "tree",
    "4": "tree''s",
    "correct": 3
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
The ode was originally a ceremonial… written to celebrate public occasions or exalted subjects.', '{
    "1": "poem",
    "2": "poems''",
    "3": "poems",
    "4": "poem''s",
    "correct": 3
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
Faced with petroleum shortages in the 1970''s, scientists and … in the United States stepped up their efforts to develop more efficient heating systems.', '{
    "1": "engineers",
    "2": "engineer",
    "3": "engineers''",
    "4": "engineer''s",
    "correct": 2
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the best answer.
On July 21, 1954, Walt Disney started building his dream park on 160 … in Anaheim, California, not far from Los Angeles', '{
    "1": "acres",
    "2": "acre''s",
    "3": "acre''",
    "4": "acre",
    "correct": 4
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('Choose the answer which correctly completes the sentence.
He has plenty of … in his library.', '{
    "1": "book''s",
    "2": "books",
    "3": "books''",
    "4": "book",
    "correct": 4
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7'),
('John Keynes used his … of economics to help his college and himself.', '{
    "1": "knowledges",
    "2": "knowledge''s",
    "3": "a knowledge",
    "4": "knowledge",
    "correct": 1
}', '29f440aa-b4b9-4f64-a915-df1c966da8f7');

insert into questions(question, question_variants, subject_id) values 
('Sportchilar bir xil 16.2km/soat tezlik bilan uzunligi 20 m20m bo''lgan kolonna tashkil qilib yugurmoqdalar. Ularga qarama-qarshi yo''nalishda murabbiy 3 m/s3m/s tezlik bilan yugurmoqda. Har bir sportchi murabbiy bilan tenglashgach. orqaga burilib yana avvalgi tezligi bilan yugurishni davom ettiriyapti. Hamma sportchilar burilgandan keyin kolonna uzunligi (m)(m) qancha bo''ladi?', '{
    "1": "10",
    "2": "3",
    "3": "4",
    "4": "20",
    "correct": 1
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Sharcha balandligi 10 mm bo''lgan qiya tekislikdan ishqalanishsiz. dumalab tushmoqda. Sharchaning qiya tekislik oxiridagi tezligini (m/s) aniqlang.', '{
    "1": "19.6",
    "2": "14.1",
    "3": "20",
    "4": "10",
    "correct": 2
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Uzunligi 480480 mm bo''lgan poyezd tekis harakatlanib, 720720 mm uzunlikdagi ko''prikdan 22 minutda o''tdi. Poyezdning tezligi qanday?', '{
    "1": "4 m/s",
    "2": "3636 km/soat",
    "3": "10 km/soat",
    "4": "6 m/s",
    "correct": 3
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Quyidagi jumlaning mazmuniga mos ravishda gapni davom ettiring. Notekis harakatda tezlanish vektori ...', '{
    "1": "a < 0 holda moduli va yo''nalishi o''zgarmaydi",
    "2": "moduli va yo''nalishi o''zgarib turadi",
    "3": "a > 0 holda moduli va yo''nalishi o''zgarmaydi",
    "4": "moduli ozgarmas bolib, yonalishi uzluksiz ozgarib turadi",
    "correct": 4
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Mashina ikki punkt orasini 40 km/soat40km/soat tezlik bilan o''tdi. So''ngra tezligini 65 km/soat65km/soat da oshirib yana shuncha yo''l o''tgan. Ikkala holda ham tekis harakat qilgan. O''rtacha tezlikni (km/soat)(km/soat)toping.', '{
    "1": "260",
    "2": "52.5",
    "3": "4.5",
    "4": "130",
    "correct": 3
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Suvi qirg''oqga nisbatan 10.8 km/soat tezlik bilan oqayotgan daryoning kengligi 240 m240m. Tinch suvga nisbatan 14.4km/soat tezlik bilan harakatlana oladigan qayiq qancha vaqtda (min)(min) bu daryoni kesib o''tadi?', '{
    "1": "1.5",
    "2": "2",
    "3": "60",
    "4": "1",
    "correct": 3
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Oqimga qarshi suzayotgan bolaning suvga nisbatan tezligi 1 m/s1m/s, suvning qirg''oqqa nisbatan tezligi 0.5 m/s0.5m/s bo''lsa, bolaning qirg''oqqa nisbatan tezligini aniqlang (km/soat)(km/soat)', '{
    "1": "1.5",
    "2": "1",
    "3": "0.5",
    "4": "1.8",
    "correct": 2
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Qayiq kengligi 240 m240m bo''lgan daryoni kesib suzib o''tmoqda. Agar oqimning tezligi 2 m/s2m/s, qayiqning suvga nisbatan tezligi 3 m/s3m/s bo''lsa, qayiq ikkinchi sohilga o''tishi uchun qanday minimal vaqt (s)(s) zarur bo''ladi?', '{
    "1": "48",
    "2": "40",
    "3": "80",
    "4": "120",
    "correct": 2
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Qandaydir balandlikdan tushayotgan po''lat jismning yerga urilishidagi tezligi 50 m/s50m/s. Agar bunda kinetik energiya to''liq ravishda jismning ichki energiyasiga aylansa, u necha gradusga isiydi? Polatning solishtirma issiqlik sig''imi 500 J/kg\cdot K500J/kg⋅K.', '{
    "1": "25",
    "2": "10",
    "3": "5",
    "4": "2.5",
    "correct": 3
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc'),
('Tosh tik yuqoriga v = 30 m/sv=30m/s tezlik bilan otildi. Qanday h (m)h(m) balandlikda uning kinetik energiyasi potensial energiyasining k = 3/5k=3/5 qismiga teng bo''ladi?', '{
    "1": "16",
    "2": "10",
    "3": "22",
    "4": "28",
    "correct": 3
}', '9bdd04a7-29d0-4a71-8326-efc8d02051dc');

insert into questions(question, question_variants, subject_id) values 
('Gingko biloba o''simliklarning qaysi bo''limiga mansub?', '{
    "1": "Ochiq urug''lilar",
    "2": "Tuban o''simliklar",
    "3": "Yuksak sporali o''simliklar",
    "4": "Yopiq urug''lilar",
    "correct": 1
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Qaysi o''simliklarning barglari ancha barvaqt to''kiladi?
1) na''matak; 2) nastarin;
3) zarang; 4) tikandaraxt;
5) shamshod; 6) terak.', '{
    "1": "1, 2, 5",
    "2": "4, 5, 6",
    "3": "2, 3, 4",
    "4": "3, 4, 6",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Qaysi o''simliklarning bargi va poyasi yo''q, lekin guli eng yirik gul hisoblanadi.', '{
    "1": "talipot palmasi",
    "2": "volfiya",
    "3": "sekvoyyadendron",
    "4": "raffleziya Arnoldi",
    "correct": 1
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Shakli o''zgargan barg (a) va shakli o''zgargan novda (b) ga ega bo''lgan o''simliklarni belgilang.
1) tokning gajaklari; 2) atirgulning tikani;
3) do''lananing tikani; 4) kaktus tikani;
5) zirkning tikani; 6) qulupnayning gajaklari;
7) no''xatning gajaklari; 8) piyozning seret bargi.', '{
    "1": "a-3, 4, 5; b-1,2, 6",
    "2": "a-2, 4, 7; b-3, 5, 6",
    "3": "a-4, 5, 7; b-1,3, 6",
    "4": "a-4, 5, 8; b-2, 3, 7",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Sanoatda tolalarni ajratishda qaysi organizmdan foydalaniladi?', '{
    "1": "bakteriyalardan",
    "2": "achitqi zamburug''laridan",
    "3": "xlorella suvo''tidan",
    "4": "sianobakteriyalardan",
    "correct": 4
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('O''simlik to''qimalari uchun xos ta''riflar to''g''ri berilgan javobni aniqlang.
a) asosiy to''qima; b) mexanik to''qima;
c) qoplovchi to''qima; d) o''tkazuvchi to''qima;
e) hosil qiluvchi to''qima;
1) hujayralari yupqa va elastik xususiyatga ega;
2) tirik zich joylashgan 1 qavat hujayralardan tashkil topgan;
3) qalin qobiqli cho''ziq, tirik hujayralardan tashkil topgan;
4) qalin cho''ziq, tik joylashgan hujayralardan iborat;
5) qalin qobiqli cho''ziq o''lik hujayralardan tashkil topgan.', '{
    "1": "a-1; b-4, 5; c-5; d-3",
    "2": "a-2, 5; b-3; c-4; d-1",
    "3": "b-3, 4; c-2; d-1 ; e-5",
    "4": "b-3, 5; c-2; d-4; e-1",
    "correct": 4
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Qaysi daraxtning shox-shabbasi g''uj bo''lib joylashgan?', '{
    "1": "olma",
    "2": "tol",
    "3": "qarag''ay",
    "4": "qayrag''och",
    "correct": 3
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Quruqlikda o''simliklar biomassasi umumiy biomassaning ... foizini tashkil etadi.', '{
    "1": "1",
    "2": "99",
    "3": "87",
    "4": "66",
    "correct": 3
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Harorati iliq kelgan kuz oylarida ham gullashda davom etadigan madaniy o''simliklarni aniqlang.', '{
    "1": "zubturum, xrizantema",
    "2": "xrizantema, kartoshkagul",
    "3": "kartoshkagul, boqila",
    "4": "moychechak, atirgul",
    "correct": 3
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Guli qulpoyaning uchidagi savatchada joylashgan o''simlikni belgilang.', '{
    "1": "lolaqizg''aldoq",
    "2": "makkajo''xori",
    "3": "zubturum",
    "4": "sabzi",
    "correct": 4
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c');


insert into questions(question, question_variants, subject_id) values 
('Oqsil gidrolizida qaysi modda hosil bo''lmaydi?', '{
    "1": "22- aminopropankislota",
    "2": "xlorsirka kislota",
    "3": "aminosirka kislota",
    "4": "22- amino - 33-metilbutankislota (valin)",
    "correct": 1
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Konsentrlangan nitrat kislota ta''sirida quyidagi amino kislotalardan qaysi biri jigar rangga bo''yaladi.', '{
    "1": "glikokol",
    "2": "alanin",
    "3": "valin",
    "4": "fenilalanin",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Organik birikmalar sinflari orasida katta ahamiyatga ega bo''lgan oqsillar qaysi sinf birikmalaridan tashkil topadi?', '{
    "1": "oksikislotalar va aminokislotalardan",
    "2": "aminokislotalardan",
    "3": "karbonkislotalar va diaminlardan",
    "4": "aminlar va oddiy efirlarban",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Gidrolizga uchraydigan kimyoviy birikmalar qatorini aniqlang.
1) tuzlar; 2) asoslar; 3) kislotalar; 4) monosaxaridlar;
5) oqsillar; 6) murakkab efirlar; 7) yog''lar', '{
    "1": "1, 2, 3, 41,2,3,4",
    "2": "2,3,6,7",
    "3": "1,5,6,7",
    "4": "2,4,5,6",
    "correct": 1
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Katta odamning sutkalik ratsionida 120120 gg oqsil bo''lishi kеrak. Sutkalik ratsiondagi oqsilning 35% ini tarkibida 21\%21% oqsil bo''lgan no''xatdan olish uchun 11 kunda nеcha gramm no''xat iste''mol qilish kеrak?', '{
    "1": "109",
    "2": "62",
    "3": "200",
    "4": "160",
    "correct": 3
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Laktoalbuminning nisbiy molеkulyar massasi 1630016300 ga tеng. Uning 1010 gg miqdori gidrolizga uchratilganda 11.77811.778 gg turli xil aminokislotalar olindi. Shunday oqsilning molеkulasi tarkibida nеchta aminokislota qoldig''i boladi?', '{
    "1": "140",
    "2": "120",
    "3": "162",
    "4": "161",
    "correct": 4
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Protеin molеkulasi tarkibida 22 atom tеmir bo''lib, uning massa ulushi 0.28% ga tеng. Protеin molеkulasining absolyut massasini (kg) toping.', '{
    "1": "100",
    "2": "40",
    "3": "40000",
    "4": "6.68*100",
    "correct": 4
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Agar oqsil molеkulasi tarkibida ikki atom oltingugurt bo''lib, uning miqdori 0.64% ga tеng bo''lsa, oqsilning molеkulyar massasi qancha?', '{
    "1": "100",
    "2": "5000",
    "3": "100000",
    "4": "10000",
    "correct": 3
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Qaysi moddalar yordamida Byurеt rеaksiyasini amalga oshirish mumkin?
1) oksid; 2) mis (IIII) sulfat; 3) natriy gidroksid;
4) etilspirt; 5) polistirol', '{
    "1": "1,3,4",
    "2": "2,3",
    "3": "2,5",
    "4": "2,4",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c'),
('Katta odamning sutkalik ratsionida 120g oqsil bo''lishi kerak. Go''shtda oqsilning massa ulushi 20% bo''lsa sutkalik oqsilning 50% ini go''shtdan olish uchun 11 kunda nеcha gramm go''sht istе''mol qilish kеrak?', '{
    "1": "60",
    "2": "300",
    "3": "250",
    "4": "200",
    "correct": 2
}', '0efb69e2-d40d-4baa-af59-5883b6d7766c');

insert into results(first_subject, second_subject, date, time, user_id, faculties_id) values 
('21', '24', '2022-03-04 17:30:43', '147', 'e42eed48-fcd7-4423-ada4-9ce051c0e663', '{"57fa6bd8-10ff-48ca-8ae2-8c0105318d5a"}'),
('26', '21', '2022-03-04 17:30:43', '136', 'c4a242e8-972c-4028-8281-56b4a12a3df1', '{"20094e6f-58ca-4fcb-9c27-5ef46f8c95a8"}'),
('25', '19', '2022-03-04 17:30:43', '100', '3c4525c4-556f-4aa3-b361-cf8034d37e5f', '{"e3200cb6-2203-474e-a671-7414eae5946e"}'),
('22', '18', '2022-03-04 17:30:43', '112', '7073c34f-7b03-4078-b804-d155da61a24c', '{"b1c67f0b-6e6f-4b9f-8887-0d84ff7171e5"}'),
('28', '25', '2022-03-04 17:30:43', '159', 'a22d0f71-acc4-42ea-87ad-06faeb5d4bf7', '{"e89c8907-0f57-4215-bc0b-5fe79d388c4b"}');
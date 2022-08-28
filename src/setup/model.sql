create database dtm;

create EXTENSION "uuid-ossp";
create type gender_type as enum('male', 'female');

create table users(
    user_id uuid default uuid_generate_v4() primary key,
    fullname varchar(60) not null,
    contact text,
    username varchar(30),
    region varchar(30) not null,
    password varchar(20) not null,
    gender gender_type not null
);

create table sciences(
    science_id uuid default uuid_generate_v4() primary key,
    science_name varchar(30) not null
);

create table variants(
    variant_id uuid default uuid_generate_v4() primary key,
    variant_body text not null,
    is_correct boolean default false,
    question_id uuid references questions(question_id) not null
);

create table questions(
    question_id uuid default uuid_generate_v4() primary key,
    question_title text,
    question_body text not null,
    correct_answer uuid references variants(variant_id),
    science_id uuid references sciences(science_id) not null
);


CREATE OR REPLACE FUNCTION insert_log () 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.logs ("action", "table", "primary", "log")
        VALUES (1, NEW.clientes, NEW.id, row_to_json(NEW);
    IF NEW.is_correct THEN 
     update questions set correct_answer = NEW.variant_id where question_id = NEW.question_id;
    ELSE
     RAISE NOTICE 'a is equal to b';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_clientes_insert
BEFORE INSERT ON variants
FOR EACH ROW
EXECUTE PROCEDURE insert_log();
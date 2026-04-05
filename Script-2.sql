create database hr_system;
create schema if not  exists app; 
create table if not exists app.users(
id serial primary key,
email text unique not null ,
name text not null ,
surname text not null, 
created_at timestamp default current_timestamp
);


insert into app.users (email,name,surname)
values ('development.user@iasismed.eu','Development', 'User');

--TRUNCATE TABLE app.users RESTART IDENTITY;


create table if not exists app.projects (
id serial primary key,
user_id integer not null ,
title text not null ,
created_at timestamp default current_timestamp,
constraint fk_user
foreign key (user_id)
references app.users (id)
on delete cascade
);

alter table app.projects 
add project_description text not null;


insert into app.projects (user_id,title,project_description)
Values
(1,'Clients Project','Fix Basic CRM Module'),
(1,'Medication Project', 'Central Stock remaining to be done');



--First Join Query
SELECT 
    u.name AS "User Name", 
    u.surname AS "User Surname", 
    u.email AS "User Email",
    p.title AS "Project Title", 
    p.project_description AS "Project Description"
FROM app.users u 
JOIN app.projects p 
    ON u.id = p.user_id;



-- Left Join Application 
insert into app.users(name,surname,email)
values
('Marketing','Team','marketing@iasismed.eu'),
('Operations','Team','operations@iasismed.eu');


SELECT 
    u.name AS "User Name", 
    u.surname AS "User Surname", 
    u.email AS "User Email",
    p.title AS "Project Title", 
    p.project_description AS "Project Description"
FROM app.users u 
left JOIN app.projects p 
    ON u.id = p.user_id
and p.title like '%Project%';

-- Mon 30.03- 05.04


create database hr_system;


create schema if not  exists app; 



create table if not exists app.users(
id serial primary key,
email text unique not null ,
name text not null ,
surname text not null, 
created_at timestamp default current_timestamp
);

set search_path to app;


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



--Group By
select user_id, count(*)
from app.projects
group by user_id ;

alter table app.projects
add budget numeric ;


select * from app.projects p ;

update app.projects p 
set budget=2000.5
where id=1;



update app.projects p 
set budget=3052
where id=2;

select u.name,
count(p.id) as "Total Projects",
avg(p.budget) as "Average Budget"
from app.users u left join app.projects p 
on u.id = p.user_id 
group by u.name ;




select u.name,
count(p.id) as "Total Projects",
coalesce(avg(p.budget),0) as "Average Budget"
from app.users u left join app.projects p 
on u.id = p.user_id 
group by u.name ;


-- Filter users with a budget >1000 
SELECT 
    u.name,
    COALESCE(SUM(p.budget), 0) AS total_budget
FROM app.users u
LEFT JOIN app.projects p ON u.id = p.user_id
GROUP BY u.id
HAVING COALESCE(SUM(p.budget), 0) > 1000;



-- Users without projects 
select u."name" as "Name",
u.surname as "Surname",
count(p.id ) as "Projects Count"
from  app.users u left join app.projects p 
on u.id =p.user_id 
group by u."name" ,u.surname 
having count(p.id)=0;



--Subqueries

select * 
from app.users u 
where id not in (
select p.user_id
from app.projects p
);


SELECT *
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM projects p
    where  p.user_id = u.id
);




-- Insert and Exercises
INSERT INTO app.users (name, surname, email, created_at)
VALUES
('John', 'Doe', 'john.doe@example.com', NOW()),
('Anna', 'Smith', 'anna.smith@example.com', NOW()),
('Nick', 'Brown', 'nick.brown@example.com', NOW()),
('Maria', 'Garcia', 'maria.garcia@example.com', NOW()),
('Chris', 'Johnson', 'chris.johnson@example.com', NOW());



INSERT INTO app.projects (title, project_description, budget, user_id, created_at)
VALUES
('Website', 'Company website', 1000, 1, NOW()),
('Mobile App', 'iOS App', 2000, 1, NOW()),
('Eshop', 'Online store', 1500, 2, NOW()),
('Dashboard', 'Analytics dashboard', 3000, 3, NOW()),
('API', 'Backend API', 500, 3, NOW()),
('Landing Page', 'Marketing page', 800, 3, NOW());



--Exercise 1
select u.name , u.surname, count(p.id)
from users u left join projects p 
on u.id=p.user_id
group by u.name, u.surname
having count(p.id)=0;


-- Exercise 2
select u.name , u.surname, count(p.id)
from users u left join projects p 
on u.id=p.user_id
group by u.name, u.surname
order by 3 desc;

--Exercise 3
select u.name , u.surname, case when sum(p.budget)>0 then sum(p.budget) else 0 end as "budget"
from users u left join projects p 
on u.id=p.user_id
group by u.name, u.surname
order by 3 desc;


-- Exercise 4
select u.name , u.surname, count(p.id)
from users u left join projects p 
on u.id=p.user_id
group by u.name, u.surname
having count(p.id)>1;


--Exercise 5
select max(total_budget) as "max budget"
from (
select u.name , u.surname,sum(budget) as "total_budget"
from users u join projects p 
on u.id=p.user_id
group by u.name, u.surname);



--Exercise 6
select  u.name,u.surname
from users u 
where exists (
select 1 from users u join projects p 
on u.id=p.user_id
where budget < 1000)


-- Exercise 1 

SELECT *
FROM users u
WHERE EXISTS (
    SELECT 1
    FROM projects p
    WHERE p.user_id = u.id
      AND p.budget <= 1000
);




-- Mon 06.04

-- Exercise 2 

select * 
from users u 
where exists (
select 1
from projects p where p.user_id=u.id
and p.budget>500
group by p.user_id
having count(*)>=2
);



-- Exercise 3 



select u.id,u.name,u.surname, sum(p.budget)
from users u 
join projects p on u.id=p.user_id 
group by  u.id 
having sum(p.budget)<2000



--Exercise 4 



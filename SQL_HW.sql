create database homework;
use homework;

-- 1A
CREATE VIEW HW1A AS
SELECT first_name, last_name
FROM actor;

select * from HW1A;

-- 1B
--  alter table actor drop column actor_name;
alter table actor add column actor_name varchar(100);
update actor set actor_name = concat(first_name, '  ', last_name);
select * from actor;

-- 2A
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';
select * from actor;

-- 2B
select * from actor
where last_name like '%GEN%';

-- 2C
select * from actor
where last_name like '%LI%'
order by last_name, first_name;

-- 2D
select * from country
where country = "Afghanistan" or "Bangladesh" or "China";

-- 3A
alter table actor add column middle_name varchar(100)
after first_name;
select * from actor;

-- 3B
alter table actor modify middle_name blob;

-- 3C
alter table actor drop column middle_name;

-- 4A
select last_name, count(*) from actor
group by last_name;

-- 4B
select last_name, count(*) from actor
group by last_name
having count(*) >1;

-- 4C
-- to see what Grouchos we have...
select * from actor
where first_name = "GROUCHO";
-- to change first name to Harpo
update actor
set first_name = REPLACE(first_name,'GROUCHO','HARPO') 
WHERE last_name = 'WILLIAMS';

-- 4D
-- to see what Harpos we have...
select * from actor
where first_name = "HARPO";
-- just the one we just changed... so this is asking to change it back? Q not worded clearly
update actor
set first_name = REPLACE(first_name,'HARPO','GROUCHO') 
WHERE last_name = 'WILLIAMS';

-- 5A
CREATE TABLE address1 SELECT * FROM sakila.address
-- working from a copy of sakila, so we can copy the orig table again

-- 6A
SELECT address.address_id, address.address, staff.first_name, staff.last_name
FROM address
INNER JOIN staff ON address.address_id=staff.address_id;

-- 6B
SELECT payment.payment_date, payment.amount, payment.staff_id, staff.first_name, staff.last_name
FROM payment
INNER JOIN staff ON payment.staff_id=staff.staff_id
where payment_date like '2005-08-%';

-- 6C
SELECT film.title, count(film_actor.actor_id)
FROM film_actor
INNER JOIN film ON film.film_id=film_actor.film_id
group by film.title;

-- 6D
select film.title, count(inventory.film_id)
from inventory
inner join film on film.film_id=inventory.film_id
where film.title='Hunchback Impossible';

-- 6E
select customer.last_name, sum(payment.amount)
from customer
inner join payment on customer.customer_id=payment.customer_id
group by customer.last_name
order by customer.last_name;

-- 7A
select title from film
where title like 'K%' or 'Q%'
and language_id in
(
	select language_id
    from language
    where language_id='English'
)
;

-- 7B

select actor_name from actor
where actor_id in
(	
	select actor_id
	from film_actor
    where film_id in
	(
		select film_id
		from film
		where title='ALONE TRIP'
	)
);

-- 7C

select  first_name, last_name, email from customer
where address_id in
(	
	select address_id
	from address
    where city_id in
	(
		select city_id
		from city
        where country_id in
        (
			select country_id
            from country
            where country.country='Canada'
		)
    )
);


-- 7D
select title from film
where film_id in
(	
	select film_id
	from film_category
    where category_id in
	(
		select category_id
		from category
		where name='Family'
	)
);

-- 7E
select film.title, count(rental.rental_id)
from rental
join inventory on rental.inventory_id=inventory.inventory_id
join film on inventory.film_id=film.film_id
group by film.title;


-- 7F

select store.store_id, sum(payment.amount)
from payment 
join staff on payment.staff_id=staff.staff_id
join store on staff.store_id=store.store_id
group by store.store_id;


-- 7G
select s.store_id, ci.city, co.country
from store as s
join address as a on s.address_id=a.address_id
join city as ci on a.city_id=ci.city_id
join country as co on ci.country_id=co.country_id;


-- 7H
select c.name, sum(p.amount) 

from payment as p
join rental as r on p.rental_id=r.rental_id
join inventory as i on r.inventory_id=i.inventory_id
join film_category as fc on i.film_id=fc.film_id
join category as c on fc.category_id=c.category_id
group by c.name, p.amount
order by p.amount;

-- this returns data of categories with $ amt, , but it is not grouping by category name, i.e. 'documentary' appears multiple times, 
-- not once with one total

-- 8A
create view HW8A as 
select c.name, sum(p.amount) 

from payment as p
join rental as r on p.rental_id=r.rental_id
join inventory as i on r.inventory_id=i.inventory_id
join film_category as fc on i.film_id=fc.film_id
join category as c on fc.category_id=c.category_id
group by c.name, p.amount
order by p.amount;

select * from HW8A;

-- 8B
-- run above code, including select * from HW8A

-- 8C
drop view HW8A;




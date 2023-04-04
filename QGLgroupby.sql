#In this lab, you will be using the Sakila database of movie rentals. You can follow the steps listed here to get the data locally: 
#Sakila sample database - installation. You can work with two sql query files - sakila-schema.sql (creates the schema) + sakila-data.sql which inserts the data.

USE sakila;
#1. Review the tables in the database

#2. Explore tables by selecting all columns from each table or using the in built review features for your client.
SELECT *
FROM actor,address,category,city,country;

#3. Select one column from a table. Get film titles.
SELECT category_id FROM category;
GROUP BY name;#16


#4. Select one column from a table and alias it. Get unique list of film languages under the alias language. Note that we are not asking
#you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
SELECT actor_id FROM actor ;
SELECT DISTINCT language_id FROM language;#6

#5.1 Find out how many stores does the company have?
SELECT store_id FROM store;#3

#5.2 Find out how many employees staff does the company have?
SELECT DISTINCT sum(staff_id) FROM staff;#2
GROUP BY staff_id

#5.3 Return a list of employee first names only?
SELECT first_name FROM staff;#Mike, Jon


#Lab | SQL basics (selection and aggregation)

#In this lab, you will be using the Bank database.

#Here, we will practice selecting and projecting data. You can finish all questions with only those clauses:

#SELECT
#SELECT DISTINCT
#FROM
#WHERE
#ORDER BY
#LIMIT
#You can save your solutions into a sql file that you can submit via Github Url.

USE bank;
#Query 1
#Get the id values of the first 5 clients from district_id with a value equals to 1.

SELECT client_id FROM client
WHERE district_id=1
ORDER BY district_id
LIMIT 5;#22  2  3  28  23

#Query 2
#In the client table, get an id value of the last client where the district_id equals to 72.
SELECT client_id  FROM bank.client
WHERE district_id = 72
ORDER BY client_id DESC
LIMIT 1;#13576

#Query 3
#Get the 3 lowest amounts in the loan table.
SELECT amount FROM loan
ORDER BY amount
LIMIT 3;#4980  5148  7656


#Query 4
#What are the possible values for status, ordered alphabetically in ascending order in the loan table?
SELECT DISTINCT status FROM loan
ORDER BY status;#A B C D

#Query 5
#What is the loan_id of the highest payment received in the loan table?
SELECT loan_id FROM loan
ORDER BY amount DESC
LIMIT 1;#6534


#Query 6
#What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT account_id, amount FROM loan
ORDER BY account_id
LIMIT 5; # 
#id     amount
#2	    80952
#19	    30276
#25	    30276
#37	    318480
#38	    110736

#Query 7
#What are the top 5 account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT account_id,amount FROM loan
WHERE duration IN (60)#
ORDER BY amount
LIMIT 5;
#10954
#938
#10711
#1766
#10799

#Query 8
#What are the unique values of k_symbol in the order table?
#Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.
SELECT DISTINCT k_symbol FROM bank.order
WHERE k_symbol <>"";#use back tick to escape
#SIPO
#UVER
#POJISTNE
#LEASING

#Query 9
#In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id FROM bank.order
WHERE account_id = 34;
#29445
#29446
#29447

#Query 10
#In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
SELECT DISTINCT account_id FROM bank.order
WHERE (order_id >=29540 AND order_id <= 29560);
#WHERE order_id BETWEEN 29540 AND 29560;


#Query 11
#In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
SELECT * FROM bank.order
WHERE account_to = 30067122;#29617

#Query 12
#In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
SELECT trans_id, `date`, `type`, amount FROM trans
WHERE account_id = 793
ORDER BY `date` DESC
LIMIT 10;
#3556468	981231	PRIJEM	78.6
#233254	981216	VYDAJ	600
#233104	981212	VYDAJ	1212
#233248	981211	VYDAJ	851
#233176	981207	VYDAJ	204
#3556467	981130	PRIJEM	75.1
#233395	981130	VYDAJ	14.6
#233103	981112	VYDAJ	1212
#233247	981111	VYDAJ	851
#233175	981107	VYDAJ	204

#Optional
#Query 13
#In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? 
#Show the results sorted by the district_id in ascending order.
SELECT district_id, count(client_id) FROM client
WHERE district_id <10
GROUP BY district_id
ORDER BY district_id;#
#1	663
#2	46
#3	63
#4	50
#5	71
#6	53
#7	45
#8	69
#9	60

#Query 14
#In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
SELECT `type`, count(`type`) FROM card
GROUP BY `type`; 
#classic	659
#junior	145
#gold	88


#Query 15
#Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
SELECT account_id, amount FROM loan
ORDER BY amount DESC
LIMIT 10;

#7542	590820
#8926	566640
#2335	541200
#817	538500
#2936	504000
#7049	495180
#10451	482940
#6950	475680
#7966	473280
#339	468060

#Query 16
#In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
SELECT `date`,loan_id FROM loan
WHERE `date` <930907
ORDER BY `date` DESC;
#930906	7240
#930803	5325
#930728	6863
#930711	5316
#930705	5314

#Query 17
#In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, 
#ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
SELECT date, duration, count(loan_id)
FROM loan
WHERE date LIKE "9712%"#WHERE `date` >=971201 and `date` <=971231
GROUP BY date, duration
ORDER BY date, duration;
#971206	24	1
#971206	36	1
#971208	12	3
#971209	12	1
#971209	24	1
#971210	12	1
#971211	24	1
#971211	48	1
#971213	24	1
#971220	36	1
#971221	36	1
#971224	60	1
#971225	24	1
#971225	60	1
SELECT account_id, type, sum(amount) AS total_amount
FROM trans
WHERE account_id=396
GROUP BY account_id, type;

#Query 18
#In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). 
#Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.
SELECT account_id,type, SUM(amount) AS total_amount  
FROM trans
WHERE account_id = 396# and type = VYDAJ and PRIJEM;
GROUP BY type;#GROUP BY account_id, type;
#396	PRIJEM	1028138.6999740601
#396	VYDAJ	1485814.400024414

#Query 19
#From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer
SELECT 
    account_id,
    CASE type
    WHEN 'PRIJEM' THEN 'INCOMING'
    WHEN 'VYDAJ' THEN 'OUTGOING'
    END AS transaction_type,
    floor(sum(amount)) as total_amount
FROM trans
WHERE account_id=396
GROUP BY account_id, type;
#396	INCOMING	1028138
#396	OUTGOING	148581

#Query 20
#From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.
SELECT
    account_id, 
    (SELECT floor(sum(amount)) FROM trans WHERE type = 'PRIJEM' AND account_id = 396) AS incoming_amount,
    (SELECT floor(sum(amount)) FROM trans WHERE type = 'VYDAJ' AND account_id = 396) AS outgoing_amount,
    (SELECT FLOOR(SUM(CASE type WHEN 'PRIJEM' THEN amount ELSE -amount END)) FROM trans WHERE account_id = 396) AS difference
FROM trans
WHERE account_id = 396
LIMIT 1;
#396	1028138	1485814	-457676


#Query 21
#Continuing with the previous example, rank the top 10 account_ids based on their difference.
SELECT account_id,
    FLOOR(SUM(CASE type WHEN 'PRIJEM' THEN amount ELSE -amount END)) AS difference
FROM trans
GROUP BY account_id
ORDER BY difference DESC
LIMIT 10;

#9707	869527
#3424	816372
#3260	803055
#2486	735219
#1801	725382
#4470	707243
#3674	703531
#9656	702786
#2227	696564
#6473	692580

#Lab | SQL Queries - Join Two Tables
USE sakila;
#Which actor has appeared in the most films?
#Hint:  group by actor_id
#GINA DEGENERES	42
SELECT actor.first_name, actor.last_name, COUNT(*) AS movie_count
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY movie_count DESC
LIMIT 1;

#2. Most active customer (the customer that has rented the most number of films)
#Expected output:
#ELEANOR HUNT	46
SELECT customer.first_name, customer.last_name, COUNT(*) AS active_customer
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY active_customer DESC
LIMIT 1;

#3. List number of films per category.
#Expected output:
#Action	64
#Animation	66
#Children	60
#Classics	57
#Comedy	58
#Documentary	68
#Drama	62
#Family	69
#Foreign73
#Games	61
#Horror	56
#Music	51
#New	63
#Sci-Fi	61
#Sports	74
#Travel	57
#3. List number of films per category.
SELECT  category.name, COUNT(category.name) AS category_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.category_id#
ORDER BY category.name;


#4. Display the first and last names, as well as the address, of each staff member.
#Expected output:
#Mike	Hillyer		23 Workhaven Lane
#Jon	Stephens	1411 Lillydale Drive
SELECT  staff.first_name, staff.last_name 
FROM staff
JOIN address ON staff.address_id = address.address_id
ORDER BY address.address_id;

#5. get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.

#Expected output: 71 rows including
#title,name
#"MYSTIC TRUMAN",English
#"MUSSOLINI SPOILERS",English
#"MUSKETEERS WAIT",English
#"MUSIC BOONDOCK",English
#"MUSCLE BRIGHT",English
#"MURDER ANTITRUST",English
#"MUPPET MILE",English
#"MUMMY CREATURES",English
#"MULHOLLAND BEAST",English
SELECT  film.title, film.language_id
FROM film
JOIN sakila.language ON film.language_id = language.language_id
WHERE 
language.name = "English" or language.name ="italian" AND film.title LIKE "M%"
#GROUP BY language.name
ORDER BY film.title DESC;
#SELECT  language.name
#FROM sakila.language
#JOIN film ON language.language_id = film.language_id
#WHERE 
#language.name = "English" or language.name ="italian" AND film.title LIKE "M%"
#GROUP BY language.language_id 
#ORDER BY film.title;
    
    
#6. Display the total amount rung up by each staff member in August of 2005.
#Expected output:
#Jon Stephens	12218.48
#Mike Hillyer	11853.65
SELECT  staff.first_name, staff.last_name, sum(amount)
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date BETWEEN "20050801" AND "20050831" 
#WHERE payment.payment_date LIKE "200508%" 
GROUP BY payment.staff_id;


#7. 
#Expected output: Top 10 out of 997 rows
#LAMBS CINCINATTI		15
#CHITTY LOCK			13
#CRAZY HOME			13
#RANDOM GO			13
#DRACULA CRYSTAL		13
#BOONDOCK BALLROOM	13
#MUMMY CREATURES		13
#HELLFIGHTERS SIERRA	12
#LONELY ELEPHANT		12
#ARABIA DOGMA		12
#List each film and the number of actors who are listed for that film.
SELECT  film.title, COUNT(actor_id) AS actor_count
FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
GROUP BY film.film_id;




#8. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
#Expected output: Top 10 out of 599 rows
#RAFAEL	ABNEY	97.79
#NATHANIEL	ADAM	133.72
#KATHLEEN	ADAMS	92.73
#DIANA	ALEXANDER	105.73
#GORDON	ALLARD	160.68
#SHIRLEY	ALLEN	126.69
#CHARLENE	ALVAREZ	114.73
#LISA	ANDERSON	106.76
#JOSE	ANDREW	96.75
#IDA	ANDREWS	76.77
#Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. List the customers alphabetically by last name.
SELECT customer.first_name, customer.last_name, sum(amount) AS paid_amount
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY customer.last_name;




#9. Write sql statement to check if you can find any actor who never particiapted 
#in any film.
#Expect output: no actor found.
SELECT actor.first_name, actor.last_name 
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE actor.actor_id IS NULL;


#10. get the addresses that have NO customers, and ends with the letter "e"
#address
#"47 MySakila Drive"
#"23 Workhaven Lane"
#"1411 Lillydale Drive"
SELECT address.address, address.address2#, COUNT(customer_id) AS total_customers
FROM address
JOIN customer ON address.address_id = customer.address_id
WHERE 
address.address LIKE "%e" AND address.address2 LIKE "%e" 
AND address  IS NULL 
AND address2 IS NULL#;
 #AND total_customers =0
#GROUP BY payment.address_id;
ORDER BY address.address_id;




#Optional: what is the most rented film?
#The answer is "Bucket Brotherhood" .
#This query might require using more than one join statement. Give it a try.

SELECT film.title
FROM  film
INNER JOIN inventory using (film_id)
INNER JOIN rental using (inventory_id)
GROUP BY film.title
ORDER BY COUNT(rental_rate) DESC;
17:44:47	SELECT film.title,film.rental_rate, COUNT(rental_rate) AS most_rented FROM  film INNER JOIN inventory ON film.film_id =  inventory.film_id INNER JOIN rental ON inventory.inventory_id = rental.inventory_id GROUP BY film.title ORDER BY COUNT(rental_rate) DESC LIMIT 0, 1000	Error Code: 1055. Expression #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'sakila.film.rental_rate' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by	0.0023 sec


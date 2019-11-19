#Find an authors who wrote more than one book
SELECT COUNT(ISBN) as num_books, name
FROM authors 
GROUP BY name 
HAVING COUNT(ISBN) > 1;


#Find books written by 2  authors
SELECT a.name,c.name, b.title 
FROM authors a, books b, authors c
WHERE a.name != c.name AND a.isbn = b.isbn AND a.isbn = c.isbn AND c.isbn = b.isbn   
GROUP BY a.isbn
HAVING COUNT(a.name) > 1;


#people who have had books overdue multiple times
SELECT  COUNT(b.dateBorrowed) as num_times,u.name as untimely_User
FROM borrows b,users u 
WHERE (CURDATE() > b.dueDate AND u.id = b.id AND b.dateReturned = 00-00-00) 
OR
 (CURDATE() > b.dueDate AND u.id = b.id AND b.dateReturned != 00-00-00)
GROUP BY u.id
HAVING COUNT(b.dateBorrowed) >1
ORDER BY COUNT(b.dateBorrowed) DESC;


#What is the name of a user who has never returned a book
SELECT u.name as Has_Never_Returned_Book 
FROM users u, borrows  b
WHERE b.dateReturned = 00-00-00 AND u.id = b.id AND u.id NOT IN (SELECT sub.id FROM users sub, borrows  q WHERE q.dateReturned != 00-00-00 AND sub.id = q.id);

#most requested book
SELECT COUNT(id) as num_times_requested,title 
FROM requested  
GROUP BY isbn
ORDER by COUNT(id) desc
LIMIT 1;

#never borrowed from horror 
SELECT distinct users.name as name_of_individual_never_borrowed_from_horror 
FROM users, borrows, books
WHERE users.id NOT IN
 (
SELECT u.id 
FROM borrows bor, books b, users as u
WHERE u.id = bor.id AND b.isbn = bor.isbn AND b.genre LIKE '%Horror%') ;

#titles/isbns of books written by at least one man below 50 
SELECT books.isbn, books.title
FROM books , authors 
WHERE books.isbn = authors.isbn AND authors.age < 50 AND authors.gender =  "male" AND authors.age != 0;

#most borrowed books (desc)
SELECT o.isbn,count(o.id) as NUM_TIMES_BORROWED, b.title
FROM books b, borrows o
WHERE o.isbn = b.isbn 
GROUP BY o.isbn
ORDER BY count(o.id) desc;

#users who request the most books
SELECT COUNT(r.isbn) as num_requested, u.name
FROM requested r, users u
WHERE r.id = u.id
GROUP BY r.id
ORDER by COUNT(r.id) desc;

#names and emails of users who have never requested a book
SELECT distinct u.name as Has_Never_Requested, u.email, u.address 
FROM users u, requested r
WHERE u.id NOT IN (SELECT distinct m.id FROM requested m);

#Users who have requested a book but never borrowed one
SELECT distinct  u.id,u.name, r.title
FROM borrows b, users u, requested r
WHERE  r.id = u.id AND u.id NOT IN (SELECT distinct borrows.id FROM borrows);
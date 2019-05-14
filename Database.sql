--Q1 Display the titles of all books on the subject "DataBases". Your result set should be sorted on the alphabetical order of the titles.
select title Databases_Book
from book b join subject s
on b.subjectid = s.subjectid
where lower(subjecttype) = 'databases'
order by title;


--Q2a Display a. the number of books on the subject "DataBases".
select count(*) No_Books_On_Databases
from book b join subject s
on b.subjectid = s.subjectid
where lower(subjecttype) = 'databases';


--Q2b the number of book copies on the subject "DataBases".
select count(a.bookdescid) BookCopieS_on_DatabaseS
from book a join book_copy b
on a.bookdescid = b.bookdescid
join
subject c
on a.subjectid = c.subjectid
where lower(subjecttype) = 'databases';


--Q3a Done Display the firstname and lastname of the authors who wrote books on the subject"DataBases" .a. Write your query without using NATURAL JOINs.

select c.firstname Given_Name,c.lastname Family_Name
from book a join written_by b
on a.bookdescid = b.bookdescid
join 
author c
on b.authorid = c.authorid
join
subject d
on a.subjectid = d.subjectid
where lower(subjecttype) = 'databases';

--Q3 b. Write your query using NATURAL JOINs.
select firstname Given_Name,lastname Family_Name
from book  natural join written_by 
natural join 
author 
natural join subject
where lower(subjecttype) = 'databases';


--Q4 Who translated the book "American Electrician's Handbook"? Display the firstname,middlenames, and lastname of the translator.
select c.firstname Name,c.middlename Middle_Int,c.lastname Family_Name
from book a join written_by b
on a.bookdescid = b.bookdescid
join
author c
on b.authorid = c.authorid
where title like  '%AMERICAN ELECTRICIAN''S HANDBOOK%'
AND
role like 'TRANSLATOR';


--Q5 Display the firstname and lastname of the people who returned books late.
select distinct a3.firstname Name,a3.lastname Family_Name
from person a3 join borrow a4
on a3.personid = a4.personid
where returndate > duedate;

--Q6 Display the firstname and lastname of the people who returned books more than 7 days late.
select distinct p.firstname Name,p.lastname Family_Name
from person p join borrow b
on p.personid = b.personid
where returndate - duedate > 7;


--Q7 Display the titles of books that haven't been borrowed.
select title Books_Not_Borrowed
from book 
where bookdescid not in (select  bc.bookdescid 
from book_copy bc 
join borrow_copy br 
on bc.bookid = br.bookid);


--Q8a Using partial matching of the book title -- note that the borrower is interested in a "DATABASE" book.
select title
from book
where title not in ('PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS') and title like '%Database%';


--Q8b By searching of other books written by the same author (i.e. the author of "PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS"
select b.title Other_Books_Written
from written_by wb join book b 
on b.BOOKDESCID = wb.BOOKDESCID
where b.title <> 'PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS'and wb.authorid
in (select a.authorid
from author a join written_by wb 
on a.authorID = wb.authorID
join book b 
on wb.bookdescID = b.bookdescID
where b.title = 'PRINCIPLES AND PRACTICE OF DATABASE SYSTEMS');


--Q9 Display the list of publishers who have published books on the subject "DataBases". Your query should display publisher's full name, along with "DataBases" book titles they published.
select publisherfullname DATABASE_PUBLISHERS_NAME,c.title DATABASES_BOOK
from publisher a join published_by b
on a.publisherid = b.publisherid
join book c
on b.bookdescid = c.bookdescid
join subject d
on c.subjectid = d.subjectid 
where subjecttype like 'DATABASES';


--Q10 List the full names of publishers who have not published books on “Databases"
select publisherfullname Publisher_Not_Publishing_DatabasesBook
from publisher
where publisherid not in ( select p.publisherid
from publisher p,published_by pb,book bk,subject s
where p.publisherid=pb.publisherid and bk.subjectid=s.subjectid and subjecttype = 'DataBases' and bk.bookdescid=pb.bookdescid);


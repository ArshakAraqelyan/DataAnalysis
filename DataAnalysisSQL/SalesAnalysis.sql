use sales

select * from sales

SELECT Segment, SUM([  Sales ]) AS total_sales
FROM Sales
where Segment <> 'Enterprise'
GROUP BY Segment
Having sum([  Sales ]) > 1800593.64



select Distinct Segment  from Sales


select Segment, [ Sale Price ], (select AVG([ Gross Sales ]) from Sales)as AVGGrossSales from Sales

select Segment, [ Sale Price ],  AVG([ Gross Sales ]) over() as AVGGrossSales from Sales




select * from Sales

select  max([ Gross Sales ]) from Sales


select * from Sales
where [ Gross Sales ] = 99375.00


select Segment, [ Gross Sales ]  from Sales where  [ Gross Sales ] = (select max([ Gross Sales ]) from Sales) 




Select Segment, [ Gross Sales ] from Sales where [ Gross Sales ] = (select max([ Gross Sales ]) from sales)


select * from Sales

select Distinct [ Product ] from Sales

select top(4) [ Product ], sum([ Profit ]) as 'Total Profit' from Sales
group by [ Product ]




select  [ Product ], sum([ Profit ]) as 'Total Profit' from Sales
group by [ Product ]
order by sum([ Profit ]) desc


Select Date,[ Product ], sum([ Profit ]) as 'Total Profit' from Sales
group by [ Product ], Date
order by Date asc



Select top(4) [ Product ], sum([ Profit ])  as 'Total Profit', Date from Sales
group by [ Product ], Date
order by sum([ Profit ]) desc


select Date, DATEPART(YEAR, Date) as 'y' from Sales

Select top(4) [ Product ], sum([ Profit ])  as 'Total Profit', DATEPART(YEAR, Date) as 'Year' from Sales
group by  [ Product ], Date
order by sum([ Profit ]) desc


SELECT TOP (4) [ Product ], SUM([ Profit ]) AS 'Total Profit', DATEPART(YEAR, MAX(Date)) AS 'Year'
FROM Sales
GROUP BY [ Product ]
ORDER BY SUM([ Profit ]) DESC;


select * from Sales


SELECT [ Product ], SUM([ Profit ]) AS 'Total Profit', DATEPART(YEAR, Date) AS 'Year'
FROM Sales
GROUP BY [ Product ], DATEPART(YEAR, [Date])
ORDER BY SUM([ Profit ]) DESC;








select * from Sales

Select [ Product ], sum([ Profit ]) as 'Total profit', Concat(Datepart(Year, Date),'-', Datepart(month,Date)) as 'Year-Month' from Sales
group by [ Product ], Concat(Datepart(Year, Date),'-', Datepart(month,Date))
order by sum([ Profit ]) desc



Select [ Product ], sum([ Profit ]) as 'Total profit', Concat(Datepart(Year, Date),'-', Datepart(month,Date)) as 'Year-Month' into totalprofitbyproduct from Sales
group by [ Product ], Concat(Datepart(Year, Date),'-', Datepart(month,Date))
order by sum([ Profit ]) desc

select  * from totalprofitbyproduct


select * from Sales

select Distinct [ Product ] from Sales

Select Segment, Country, [ Product ], [ Profit ] into  Amarilla  from sales
where [ Product ] = ' Amarilla '

select *  from Amarilla

Select Segment, Country, [ Product ], [ Profit ] into   Carretera   from sales
where [ Product ] = ' Carretera '

select * from Carretera


SELECT Segment, Country, [ Product ], [ Profit ]
INTO CombinedTable
FROM Amarilla
UNION ALL
SELECT Segment, Country, [ Product ], [ Profit ]
FROM Carretera;


Select * from CombinedTable

Select Segment, Country, [ Product ], [ Profit ] 
into combined
from Amarilla
Union All
SELECT Segment, Country, [ Product ], [ Profit ]
FROM Carretera;



Select Segment, Country, [ Product ] into combined1 from sales
Union all
Select Segment, Country, [ Product ] from Carretera


Drop Table combined1

Drop Table combined


select * from Sales

select [ Profit ] from Sales
where [ Profit ] is not null

update Sales
set [ Discount Band ] = '1'
where [ Product ] = 'Carretera'




Select * from CombinedTable

delete from CombinedTable where [ Profit ] is null


SELECT Segment FROM Sales
UNION All
SELECT Segment FROM CombinedTable
ORDER BY Segment;



IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Amarilla')
BEGIN
    SELECT * FROM Amarilla;
END

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Carretera')
BEGIN
    SELECT * FROM Carretera;
END




If exists (select 1 from sys.tables where name ='Amarilla') select * from Amarilla


SELECT Segment
FROM Sales
WHERE EXISTS (SELECT Segment FROM Carretera WHERE  Price < 20);




select Segment
from Sales
where exists (select 'Goverment')

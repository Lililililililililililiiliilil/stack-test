--Задание 1
CREATE FUNCTION stack.select_count_pok_by_service (@Month varchar(50), @Service varchar(50))
RETURNS TABLE
AS
RETURN
(
SELECT Accounts.number, Counters.service, COUNT(*) AS count  FROM Meter_Pok
JOIN Counters ON Meter_Pok.counter_id = Counters.row_id
JOIN Accounts ON Meter_Pok.acc_id = Accounts.row_id
WHERE (Meter_Pok.month = @month  AND Counters.service = @service)
GROUP BY Accounts.number, Counters.service
);


--Задание 3
CREATE FUNCTION stack.select_last_pok_by_acc (@acc_id int)
RETURNS TABLE
AS
RETURN
(

SELECT Accounts.number, Counters.service, Meter_Pok.date, Meter_Pok.tarif, Meter_Pok.value FROM Meter_Pok
JOIN Accounts ON Meter_Pok.acc_id = Accounts.row_id
JOIN Counters ON Meter_Pok.counter_id = Counters.row_id
INNER JOIN (
	SELECT Accounts.number, Counters.service, Max(Meter_Pok.date) as MaxDate, Meter_Pok.tarif FROM Meter_Pok
	JOIN Accounts ON Meter_Pok.acc_id = Accounts.row_id
	JOIN Counters ON Meter_Pok.counter_id = Counters.row_id
	GROUP BY Accounts.number, Counters.service, Meter_Pok.tarif
) x on Accounts.number = x.number and Meter_Pok.date = x.MaxDate
WHERE Accounts.number = @acc_id
GROUP BY  Accounts.number, Counters.service, Meter_Pok.date, Meter_Pok.tarif, Meter_Pok.value

);
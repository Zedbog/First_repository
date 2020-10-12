/*
USE moja_baza;
SELECT * FROM Produkt;
DELETE FROM Produkt WHERE Nazwa='Laptop';
ALTER TaBLE Produkt MODIFY COLUMN Id INTEGER PRIMARY KEY;
INSERT INTO Produkt (Id, Nazwa) VALUES (2, 'Laptop');
UPDATE Produkt SET Nazwa='DELL' WHERE Id=1;
*/

USE car_rental;
INSERT INTO Clients VALUES (1, 'Jan', 'Kowalski', 'ul. Florianska 12', 'Krakow');
INSERT INTO Clients VALUES (2, 'Andrzej', 'Nowak', 'ul. Saska 43', 'Wroclaw');
INSERT INTO Cars VALUES (1, 'Seat', 'Leon', 2016, 80, 200);
INSERT INTO Cars VALUES (2, 'Toyota', 'Avensis', 2014, 72, 100);
INSERT INTO Bookings (client_id, car_id, start_date, end_date, total_amount)
VALUES
(1, 2, '2020-07-05', '2020-07-06', 100),
(2, 2, '2020-07-10', '2020-07-12', 200);

SELECT producer AS prod, model AS mode FROM Cars WHERE year>2015;

INSERT INTO Clients (name, surname, address, city) VALUES
('Michal', 'Taki', 'os. Srodkowe 12', 'Poznan'),
('Pawel', 'Ktory', 'ul. Stara 11', 'Gdynia'),
('Anna', 'Inna', 'os. Srednie 1', 'Gniezno'),
('Alicja', 'Panna', 'os. Duze 33', 'Torun'),
('Damian', 'Papa', 'ul. Skosna 66', 'Warszawa'),
('Marek', 'Troska', 'os. Male 90', 'Radom'),
('Jakub', 'Klos', 'os. Polskie 19', 'Wadowice'),
('Lukasz', 'Lis', 'os. Podlaskie 90', 'Bialystok');
INSERT INTO Cars (producer, model, year, horse_power,
price_per_day) VALUES
('Mercedes', 'CLK', 2018, 190, 400),
('Hyundai', 'Coupe', 2014, 165, 300),
('Dacia', 'Logan', 2015, 103, 150),
('Saab', '95', 2012, 140, 140),
('BMW', 'E36', 2007, 110, 80),
('Fiat', 'Panda', 2016, 77, 190),
('Honda', 'Civic', 2019, 130, 360),
('Volvo', 'XC70', 2013, 180, 280);
INSERT INTO Bookings (client_id, car_id, start_date,
end_date, total_amount) VALUES
(3, 3, '2020-07-06', '2020-07-08', 400),
(6, 10, '2020-07-10', '2020-07-16', 1680),
(4, 5, '2020-07-11', '2020-07-14', 450),
(5, 4, '2020-07-11', '2020-07-13', 600),
(7, 3, '2020-07-12', '2020-07-14', 800),
(5, 7, '2020-07-14', '2020-07-17', 240),
(3, 8, '2020-07-14', '2020-07-16', 380),
(5, 9, '2020-07-15', '2020-07-18', 1080),
(6, 10, '2020-07-16', '2020-07-20', 1120),
(8, 1, '2020-07-16', '2020-07-19', 600),
(9, 2, '2020-07-16', '2020-07-21', 500),
(10, 6, '2020-07-17', '2020-07-19', 280),
(1, 9, '2020-07-17', '2020-07-19', 720),
(3, 7, '2020-07-18', '2020-07-21', 240),
(5, 4, '2020-07-18', '2020-07-22', 1200);

SELECT * FROM Cars WHERE year>2015;
SELECT * FROM Bookings WHERE total_amount BETWEEN 1000 AND 2555;
SELECT client_id FROM Clients WHERE surname LIKE 'N%' AND name LIKE '%ej';

SELECT c.car_id, c.producer, c.model, cl.name, cl.surname;

SELECT b.booking_id, c.producer, c.model, cl.name, cl.surname
FROM Bookings AS b
INNER JOIN Cars AS c ON c.car_id=b.car_id
INNER JOIN Clients AS cl ON cl.client_id=b.client_id
ORDER BY b.booking_id;

USE moja_baza;
SELECT * FROM Produkt;
SELECT COUNT(*) AS Liczba_produktow FROM Produkt WHERE Nazwa='DELL';

USE car_rental;
SELECT car_id,
AVG(total_amount) AS Srednia,
MIN(total_amount) AS Minimum,
Max(total_amount) AS Maximum,
COUNT(total_amount) AS Ilosc_wypozyczen,
SUM(total_amount) AS Suma
FROM Bookings
GROUP BY car_id HAVING SUM(total_amount)>500;

-- Zadanie 1
USE car_rental;
SELECT b.booking_id, cl.name, b.total_amount
FROM Bookings AS b
INNER JOIN Clients AS cl ON cl.client_id=b.client_id 
GROUP BY car_id HAVING SUM(total_amount)>1000;

-- Zadanie 2
SELECT cl.city, b.start_date, b.end_date, b.total_amount
FROM Clients cl
JOIN Bookings AS b ON cl.client_id = b.client_id
JOIN Cars AS c ON b.car_id = c.car_id
WHERE b.start_date >= '2020-07-12'
AND b.end_date <= '2020-07-20'
AND c.horse_power <= 120
ORDER BY b.total_amount DESC;

-- Zadanie 3
SELECT c.horse_power, COUNT(b.car_id) AS liczba_wypozyczonych_samochodow
FROM Bookings AS b
JOIN Cars AS c ON c.car_id=b.car_id
WHERE c.price_per_day >= 300
GROUP BY c.horse_power
ORDER BY c.horse_power;

-- Zadanie 4
SELECT SUM(b.total_amount) AS suma_kosztow_wszystkich_rezerwacji
FROM Bookings AS b
WHERE b.start_date >= '2020-07-14' AND b.end_date <= '2020-07-18';

-- Zadanie 5
SELECT cl.name AS Imie, cl.surname AS Nazwisko, 
AVG(b.total_amount) AS Srednia_wartosc_rezerwacji,
COUNT(b.car_id) AS Liczba_wypozyczonych_samochodow
FROM Bookings AS b
JOIN Cars AS c ON c.car_id=b.car_id
JOIN Clients AS cl ON cl.client_id=b.client_id
GROUP BY b.client_id
HAVING Liczba_wypozyczonych_samochodow >=2
ORDER BY Liczba_wypozyczonych_samochodow DESC;










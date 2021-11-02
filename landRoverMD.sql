-- TEMA: Evidenta automobilelor vanzatorului Land Rover Moldova

-- crearea bazei de date
create database Land_RoverMD;
-- folosirea bazei de date
use Land_RoverMD;

-- crearea tabelelor
create table automobile(
idAuto int PRIMARY KEY,
model varchar(40),
anProducere date,
putere int,
idTransmisie int,
idMotor int,
idCorp int,
pret decimal(10,2),
idAngajat int
);

create table motor(
idMotor int PRIMARY KEY,
tipMotor varchar(20),
volMotor DECIMAL(2,1)
);


create table corpAutomobil(
idCorp int PRIMARY KEY,
tipCorp varchar(20)
);

create table transmisie(
idTransmisie int PRIMARY KEY,
tipTransmisie varchar(20)
);

create table client(
idClient int PRIMARY KEY,
idAuto int,
numeClient varchar(20),
prenumeClient varchar(20),
sex char(1),
idnp varchar(13),
gsm varchar(11)
);


create table angajati(
idAngajat int PRIMARY KEY,
numeAngajat varchar(20),
prenumeAngajat varchar(20),
idnpAngajat varchar(13),
dataN date,
gsm varchar(9),
idFunctie int,
idClient int
);

create table functiiAngajati(
idFunctie int PRIMARY KEY,
numeFunctie varchar(20),
salariu decimal(8,2)
);

ALTER TABLE functiiAngajati
DROP COLUMN salariu

ALTER TABLE functiiAngajati
ADD salariu decimal(8,2) null

-- crearea relatiilor
ALTER TABLE client
   ADD CONSTRAINT FK_automobile_idAuto
      FOREIGN KEY (idAuto) REFERENCES automobile (idAuto)

ALTER TABLE automobile
    ADD CONSTRAINT FK_motor_idMotor
        FOREIGN KEY(idMotor) references motor(idMotor)

ALTER TABLE automobile
    ADD CONSTRAINT FK_transmisie_idTransmisie
        FOREIGN KEY(idTransmisie) references transmisie(idTransmisie)

ALTER TABLE automobile
    ADD CONSTRAINT FK_corpAutomobil_idCorp
        FOREIGN KEY(idCorp) references corpAutomobil(idCorp)

ALTER TABLE angajati
    ADD CONSTRAINT FK_functiiAngajati_idFunctie
        FOREIGN KEY(idFunctie) references functiiAngajati(idFunctie)

ALTER TABLE automobile
    ADD CONSTRAINT FK_automobile_idAutomobile
        FOREIGN KEY(idAngajat) references angajati(idAngajat)


-- inserarea datelor in tabele
insert into automobile(idAuto, model, anProducere, putere, idTransmisie, idMotor, idCorp, pret)
VALUES  (0,'RANGE ROVER SPORT', '2021-01-01', 404, 0, 2, 1, 95850.00),
        (1,'RANGE ROVER DISCOVERY', '2021-01-01', 250, 0, 1, 0, 74680.00),
        (2,'RANGE ROVER EVOQUE', '2021-01-01', 160, 0, 1, 1, 58890.00),
        (3,'LAND ROVER DISCOVERY', '2021-01-01', 250, 0, 1, 0, 85520.00),
        (4,'RANGE ROVER IV RESTYLING', '2021-01-01', 249, 0, 1, 0, 141203.00),
        (5,'RANGE ROVER IV RESTYLING', '2018-01-01', 339, 0, 3, 0, 96815.21);
        

insert into motor(idMotor, tipMotor, volMotor)
VALUES  
        (3,'Diesel', 4.4),
        (0,'Diesel', 2.0),
        (1,'Diesel', 3.0),
        (2,'Petrol', 2.0);

insert into transmisie(idTransmisie, tipTransmisie) 
VALUES (0, 'Automat'),
       (1, 'Manual');

insert into corpAutomobil(idCorp, tipCorp) VALUES
            (0, 'CROSSOVER'),
            (1, 'HATCHBACK');

insert into client(idClient, idAuto, numeClient, prenumeClient, sex, idnp) VALUES
(0, 3, 'Lana', 'Rhodes', 'F', '2222555599999'),
(1, 2, 'Dwayne', 'Johnson', 'M', '5555888877777'),
(2, 4, 'Lasai', 'Johnny', 'M', '9999888855553' )

insert into angajati(idAngajat, numeAngajat, prenumeAngajat, idnpAngajat, dataN, gsm, idFunctie, idClient) VALUES
            (0, 'Corneliu', 'Viorel', '111125456398', '2000-02-12', 068056999, 0, 0),
            (1, 'Munteanu', 'Alina', '221145656398', '2002-10-30', 069056999, 1, 1),
            (2, 'Aron', 'Khabib', '7584632185695', '1988-04-16', 067056999, 1, 2);

insert into functiiAngajati(idFunctie, numeFunctie, salariu) VALUES
            (0, 'Manager', 22000.15),
            (1, 'Consultant', 11250.00);
            
Update functiiAngajati set salariu = 11250.00 where idFunctie = 1

-- SELECTS
SELECT * FROM automobile
select * FROM angajati
SELECT * FROM client
SELECT * FROM functiiAngajati

SELECT idAuto, model, anProducere, pret
FROM automobile
WHERE pret > 60000.00

SELECT idAngajat, numeAngajat, prenumeAngajat, gsm
FROM angajati
WHERE idFunctie = 0

-- VIEWS
-- informatia totala despre automobile
CREATE VIEW vAutomobileFull AS
SELECT automobile.idAuto, automobile.model, motor.volMotor, transmisie.tipTransmisie, corpAutomobil.tipCorp, automobile.pret
FROM dbo.automobile, dbo.motor, dbo.transmisie, dbo.corpAutomobil
WHERE automobile.idMotor = motor.idMotor and automobile.idTransmisie = transmisie.idTransmisie and automobile.idCorp = corpAutomobil.idCorp 

-- crearea viziunii vAngajatFunctii pentru afisarea ANGAJAT + FUNCTIE + SALARIU
CREATE VIEW vAngajatiFunctii AS
SELECT angajati.idAngajat, angajati.numeAngajat, angajati.prenumeAngajat, functiiAngajati.numeFunctie, functiiAngajati.salariu
FROM angajati, functiiAngajati
WHERE angajati.idFunctie = functiiAngajati.idFunctie

-- viziune din viziune, informatia despre client si automobilul procurat
CREATE VIEW vClientAuto AS
SELECT client.idClient, client.numeClient, client.prenumeClient, client.gsm, vAutomobileFull.idAuto, vAutomobileFull.model, vAutomobileFull.pret
FROM client, vAutomobileFull
WHERE client.idAuto = vAutomobileFull.idAuto

drop VIEW vClientAuto
-- SELECT VIEWS
SELECT * from vAutomobileFull
SELECT * from vAngajatiFunctii
SELECT * FROM vClientAuto

-- afisarea informatiei despre un tabel
exec sp_help angajati

-- Update rows in table 'Automobile'
UPDATE automobile
SET
    idAngajat = 2
WHERE idAuto = 5
GO

-- stergerea relatiilor
-- ALTER TABLE CLIENT
-- DROP CONSTRAINT FK_automobile_idAuto

-- ALTER TABLE automobile
-- DROP CONSTRAINT FK_motor_idMotor

-- ALTER TABLE automobile
-- DROP CONSTRAINT FK_transmisie_idTransmisie

-- ALTER TABLE automobile
-- DROP CONSTRAINT FK_corpAutomobil_idCorp

-- ALTER TABLE angajati
-- DROP CONSTRAINT FK_functiiAngajati_idFunctie

-- ALTER TABLE angajati
-- DROP CONSTRAINT FK_client_idClient

-- automobile
-- 0,1,2,3 || https://land-rover.md/md/stock-actual
-- 4 || https://auto.ru/cars/new/group/land_rover/range_rover/21130587/23080716/1105642687-cd10255b/
-- 5 || https://auto.ru/cars/used/sale/land_rover/range_rover/1105507108-09e2177a/

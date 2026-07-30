CREATE DATABASE Pharmacy;
USE Pharmacy;
CREATE TABLE Tablets
(
    Tablet_ID INT PRIMARY KEY,
    Tablet_Name VARCHAR(40),
    Tablet_Weight DECIMAL(5,2),
    Disease VARCHAR(50),
    Symptom VARCHAR(50)
);
ALTER TABLE Tablets
ADD Cost DECIMAL(6,2);
ALTER TABLE Tablets
RENAME COLUMN Cost TO Tablet_Cost;
INSERT INTO Tablets VALUES
(501,'Aceclofenac',100,'Arthritis','Joint Pain',85),
(502,'Domperidone',10,'Vomiting','Nausea',35),
(503,'Levocet',5,'Allergy','Itching',18),
(504,'Ofloxacin',200,'Eye Infection','Red Eyes',120),
(505,'Metrogyl',400,'Stomach Infection','Loose Motion',75),
(506,'Rabeprazole',20,'Acidity','Gas Trouble',42),
(507,'Cetirizine',10,'Cold','Runny Nose',16),
(508,'Doxycycline',100,'Skin Infection','Skin Swelling',110),
(509,'Liv-52',250,'Liver Problem','Poor Appetite',95),
(510,'Thyronorm',50,'Thyroid','Weight Gain',140),
(511,'Atorvastatin',20,'Cholesterol','High Cholesterol',180),
(512,'Clavam',625,'Bacterial Infection','Tooth Pain',165),
(513,'PCM',650,'Viral Fever','Fever',28),
(514,'Moxikind',500,'Sinus Infection','Face Pain',155),
(515,'Becosules',100,'Vitamin Deficiency','Fatigue',65),
(516,'Ondansetron',4,'Vomiting','Vomiting',55),
(517,'Diclomol',325,'Body Pain','Back Pain',48),
(518,'Azee',500,'Throat Infection','Sore Throat',135),
(519,'Montelukast',10,'Asthma','Breathing Problem',105),
(520,'Benfotiamine',150,'Nerve Damage','Numbness',190);
SELECT*FROM Tablets;
UPDATE Tablets
SET Tablet_Cost = Tablet_Cost * 1.10;
ALTER TABLE Tablets
DROP COLUMN Disease;
ALTER TABLE Tablets
ADD Age_Group VARCHAR(20);
ALTER TABLE Tablets
ADD Qty INT;
UPDATE Tablets SET Age_Group='5-12 Years' WHERE Tablet_ID IN(503,507,513);
UPDATE Tablets SET Age_Group='13-40 Years' WHERE Tablet_ID IN(501,502,504,505,506,508,512,514,516,517);
UPDATE Tablets SET Age_Group='Above 40 Years' WHERE Tablet_ID IN(509,510,511,515,518,519,520);
UPDATE Tablets SET Qty=25 WHERE Tablet_ID=501;
UPDATE Tablets SET Qty=15 WHERE Tablet_ID=502;
UPDATE Tablets SET Qty=30 WHERE Tablet_ID=503;
UPDATE Tablets SET Qty=18 WHERE Tablet_ID=504;
UPDATE Tablets SET Qty=22 WHERE Tablet_ID=505;
UPDATE Tablets SET Qty=12 WHERE Tablet_ID=506;
UPDATE Tablets SET Qty=40 WHERE Tablet_ID=507;
UPDATE Tablets SET Qty=16 WHERE Tablet_ID=508;
UPDATE Tablets SET Qty=14 WHERE Tablet_ID=509;
UPDATE Tablets SET Qty=10 WHERE Tablet_ID=510;
UPDATE Tablets SET Qty=8 WHERE Tablet_ID=511;
UPDATE Tablets SET Qty=20 WHERE Tablet_ID=512;
UPDATE Tablets SET Qty=35 WHERE Tablet_ID=513;
UPDATE Tablets SET Qty=18 WHERE Tablet_ID=514;
UPDATE Tablets SET Qty=28 WHERE Tablet_ID=515;
UPDATE Tablets SET Qty=24 WHERE Tablet_ID=516;
UPDATE Tablets SET Qty=19 WHERE Tablet_ID=517;
UPDATE Tablets SET Qty=13 WHERE Tablet_ID=518;
UPDATE Tablets SET Qty=21 WHERE Tablet_ID=519;
UPDATE Tablets SET Qty=17 WHERE Tablet_ID=520;
SELECT * FROM Tablets;
SELECT
Age_Group,
COUNT(*) AS Total_Tablets
FROM Tablets
GROUP BY Age_Group;
SELECT
Symptom,
COUNT(*) AS Number_of_Tablets
FROM Tablets
GROUP BY Symptom
HAVING COUNT(*)>=2;
SELECT
MIN(Tablet_Weight) AS Lightest_Tablet,
MAX(Tablet_Weight) AS Heaviest_Tablet
FROM Tablets;
SELECT
Tablet_ID,
Tablet_Name,
Tablet_Weight,
Qty,
(Tablet_Weight*Qty) AS Total_Weight,
Symptom
FROM Tablets;
SELECT
Tablet_ID,
Tablet_Name,
Tablet_Weight,
Symptom
FROM Tablets
WHERE Tablet_Weight>=100
AND Age_Group='13-40 Years';
SELECT AVG(Tablet_Cost) AS Average_Cost
FROM Tablets;
SELECT Tablet_ID,Tablet_Name,Tablet_Cost
FROM Tablets
WHERE Tablet_Cost>100;
SELECT *
FROM Tablets
ORDER BY Tablet_Weight DESC;

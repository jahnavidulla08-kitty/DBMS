CREATE DATABASE GamesDB;

USE GamesDB;CREATE TABLE Players (
    Player_ID INT PRIMARY KEY,
    Player_Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(10)
);
CREATE TABLE Games (
    Game_ID INT PRIMARY KEY,
    Game_Name VARCHAR(50) NOT NULL,
    Min_Age INT NOT NULL,
    Max_Age INT NOT NULL
);
CREATE TABLE Teams (
    Team_ID INT PRIMARY KEY,
    Team_Name VARCHAR(50) NOT NULL,
    Game_ID INT,

    FOREIGN KEY (Game_ID)
    REFERENCES Games(Game_ID)
);
CREATE TABLE Coaches (
    Coach_ID INT PRIMARY KEY,
    Coach_Name VARCHAR(50) NOT NULL,
    Game_ID INT,
    Experience INT,

    FOREIGN KEY (Game_ID)
    REFERENCES Games(Game_ID)
);CREATE TABLE Tournaments (
    Tournament_ID INT PRIMARY KEY,
    Tournament_Name VARCHAR(100) NOT NULL,
    Game_ID INT,
    Location VARCHAR(50),
    Tournament_Date DATE,

    FOREIGN KEY (Game_ID)
    REFERENCES Games(Game_ID)
);
CREATE TABLE Participation (
    Participation_ID INT PRIMARY KEY,
    Player_ID INT,
    Game_ID INT,
    Tournament_ID INT,
    Score INT,

    FOREIGN KEY (Player_ID)
    REFERENCES Players(Player_ID),

    FOREIGN KEY (Game_ID)
    REFERENCES Games(Game_ID),

    FOREIGN KEY (Tournament_ID)
    REFERENCES Tournaments(Tournament_ID)
);
INSERT INTO Players
(Player_ID, Player_Name, Age, Gender)
VALUES
(1, 'Rahul', 18, 'Male'),
(2, 'Priya', 16, 'Female'),
(3, 'Arjun', 22, 'Male'),
(4, 'Sneha', 14, 'Female'),
(5, 'Kiran', 25, 'Male');
SELECT * FROM Players;
INSERT INTO Games
(Game_ID, Game_Name, Min_Age, Max_Age)
VALUES
(101, 'Cricket', 16, 35),
(102, 'Football', 14, 30),
(103, 'Basketball', 15, 28),
(104, 'Tennis', 12, 35);
SELECT * FROM Games;
INSERT INTO Teams
(Team_ID, Team_Name, Game_ID)
VALUES
(201, 'Warriors', 101),
(202, 'Strikers', 102),
(203, 'Hoopers', 103),
(204, 'Aces', 104);
SELECT * FROM Teams;
INSERT INTO Coaches
(Coach_ID, Coach_Name, Game_ID, Experience)
VALUES
(301, 'Ramesh', 101, 10),
(302, 'Suresh', 102, 8),
(303, 'Mahesh', 103, 12),
(304, 'Anil', 104, 7);
SELECT * FROM Coaches;
INSERT INTO Tournaments
(Tournament_ID, Tournament_Name, Game_ID, Location, Tournament_Date)
VALUES
(401, 'National Cricket Cup', 101, 'Hyderabad', '2026-10-10'),
(402, 'National Football Cup', 102, 'Chennai', '2026-11-15'),
(403, 'National Basketball Cup', 103, 'Bangalore', '2026-12-05'),
(404, 'National Tennis Cup', 104, 'Mumbai', '2026-12-20');
SELECT * FROM Tournaments;
INSERT INTO Participation
(Participation_ID, Player_ID, Game_ID, Tournament_ID, Score)
VALUES
(501, 1, 101, 401, 85),
(502, 2, 101, 401, 92),
(503, 3, 101, 401, 78),
(504, 5, 101, 401, 95),

(505, 1, 102, 402, 88),
(506, 2, 102, 402, 75),
(507, 3, 102, 402, 91),
(508, 4, 102, 402, 82),
(509, 5, 102, 402, 96),

(510, 1, 103, 403, 90),
(511, 3, 103, 403, 87),
(512, 5, 103, 403, 94),

(513, 2, 104, 404, 89),
(514, 3, 104, 404, 93),
(515, 5, 104, 404, 97);
SELECT * FROM Participation;
SELECT
    p.Player_ID,
    p.Player_Name,
    p.Age,
    g.Game_Name,
    pa.Score
FROM Players p
JOIN Participation pa
    ON p.Player_ID = pa.Player_ID
JOIN Games g
    ON pa.Game_ID = g.Game_ID;
    SELECT
    p.Player_Name,
    p.Age,
    g.Game_Name,
    t.Tournament_Name,
    pa.Score
FROM Players p
JOIN Participation pa
    ON p.Player_ID = pa.Player_ID
JOIN Games g
    ON pa.Game_ID = g.Game_ID
JOIN Tournaments t
    ON pa.Tournament_ID = t.Tournament_ID;
    SELECT
    p.Player_Name,
    g.Game_Name,
    tm.Team_Name,
    c.Coach_Name
FROM Players p
JOIN Participation pa
    ON p.Player_ID = pa.Player_ID
JOIN Games g
    ON pa.Game_ID = g.Game_ID
JOIN Teams tm
    ON g.Game_ID = tm.Game_ID
JOIN Coaches c
    ON g.Game_ID = c.Game_ID;
    SELECT
    p.Player_Name,
    p.Age,
    g.Game_Name,
    g.Min_Age,
    g.Max_Age
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age;
    SELECT
    p.Player_Name,
    p.Age,
    g.Game_Name,
    g.Min_Age,
    g.Max_Age,

    CASE
        WHEN p.Age BETWEEN g.Min_Age AND g.Max_Age
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility

FROM Players p
CROSS JOIN Games g;
SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Cricket'

UNION

SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Football';
SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Cricket'

UNION ALL

SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Football';
SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Cricket'

INTERSECT

SELECT p.Player_Name
FROM Players p
JOIN Games g
    ON p.Age BETWEEN g.Min_Age AND g.Max_Age
WHERE g.Game_Name = 'Football';
SELECT
    p.Player_Name,
    g.Game_Name,
    pa.Score
FROM Players p
JOIN Participation pa
    ON p.Player_ID = pa.Player_ID
JOIN Games g
    ON pa.Game_ID = g.Game_ID
ORDER BY pa.Score DESC
LIMIT 5;
CREATE VIEW Top_5_Players AS
SELECT
    p.Player_Name,
    g.Game_Name,
    pa.Score
FROM Players p
JOIN Participation pa
    ON p.Player_ID = pa.Player_ID
JOIN Games g
    ON pa.Game_ID = g.Game_ID
ORDER BY pa.Score DESC
LIMIT 5;
SELECT * FROM Top_5_Players;
CREATE VIEW Top_5_By_Age AS
SELECT
    Player_ID,
    Player_Name,
    Age,
    Gender
FROM Players
ORDER BY Age DESC
LIMIT 5;
SELECT * FROM Top_5_By_Age;
CREATE VIEW Player_Game_Eligibility AS
SELECT
    p.Player_ID,
    p.Player_Name,
    p.Age,
    g.Game_Name,
    
    CASE
        WHEN p.Age BETWEEN g.Min_Age AND g.Max_Age
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility

FROM Players p
CROSS JOIN Games g;
SELECT * FROM Player_Game_Eligibility;
SHOW TABLES;
DESC Players;

DESC Games;

DESC Teams;

DESC Coaches;

DESC Tournaments;

DESC Participation;
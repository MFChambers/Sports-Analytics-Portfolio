DROP DATABASE IF EXISTS project_sportanalytics_db;
CREATE DATABASE project_sportanalytics_db;
USE project_sportanalytics_db;
CREATE TABLE Teams (
    TeamID INT AUTO_INCREMENT PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL
);
CREATE TABLE Players (
    PlayerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(10),
    TeamID INT NOT NULL,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);
CREATE TABLE Games (
    GameID INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    Opponent VARCHAR(100),
    Location VARCHAR(50), -- 'Home' or 'Away'
    TeamScore INT,
    OpponentScore INT,
    Outcome VARCHAR(10) -- 'Win' or 'Loss'
);
CREATE TABLE GameHighlights (
    HighlightID INT AUTO_INCREMENT PRIMARY KEY,
    GameID INT NOT NULL,
    HighPointsPlayer VARCHAR(100),
    HighPoints INT,
    HighReboundsPlayer VARCHAR(100),
    HighRebounds INT,
    HighAssistsPlayer VARCHAR(100),
    HighAssists INT,
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

CREATE TABLE PlayerStats (
    PlayerStatID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL,
    GameID INT,
    GP INT, -- Games Played
    GS INT, -- Games Started
    MIN FLOAT, -- Minutes Played
    PTS FLOAT, -- Points
    OffReb FLOAT, -- Offensive Rebounds
    DR FLOAT, -- Defensive Rebounds
    REB FLOAT, -- Total Rebounds
    AST FLOAT, -- Assists
    STL FLOAT, -- Steals
    BLK FLOAT, -- Blocks
    Turnovers FLOAT, -- Turnovers
    PF FLOAT, -- Personal Fouls
    AST_TO FLOAT, -- Assist-to-Turnover Ratio,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE ShootingStats (
    ShootingStatID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL,
    GameID INT,
    FGM FLOAT, -- Field Goals Made
    FGA FLOAT, -- Field Goals Attempted
    FGPercent FLOAT, -- Field Goal Percentage
    TPM FLOAT, -- Three-Point Field Goals Made
    TPA FLOAT, -- Three-Point Field Goals Attempted
    TPPercent FLOAT, -- Three-Point Percentage
    FTM FLOAT, -- Free Throws Made
    FTA FLOAT, -- Free Throws Attempted
    FTPercent FLOAT, -- Free Throw Percentage
    TPM2 FLOAT, -- Two-Point Field Goals Made
    TPA2 FLOAT, -- Two-Point Field Goals Attempted
    TPPercent2 FLOAT, -- Two-Point Percentage
    SC_EFF FLOAT, -- Scoring Efficiency
    SH_EFF FLOAT, -- Shooting Efficiency,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

-- Step 7: Insert Data into Teams Table
INSERT INTO Teams (TeamName, City)
VALUES ('Indiana Fever', 'Indianapolis');

-- Step 8: Insert Data into Players Table
INSERT INTO Players (Name, Position, TeamID)
VALUES 
('Caitlin Clark', 'G', 1),
('Kelsey Mitchell', 'G', 1),
('Aliyah Boston', 'F', 1),
('NaLyssa Smith', 'F', 1),
('Temi Fagbenle', 'C', 1),
('Lexie Hull', 'G', 1),
('Kristy Wallace', 'G', 1),
('Damiris Dantas', 'F', 1),
('Katie Lou Samuelson', 'F', 1),
('Erica Wheeler', 'G', 1),
('Grace Berger', 'G', 1),
('Victaria Saxton', 'F', 1),
('Celeste Taylor', 'G', 1);
INSERT INTO Games (Date, Opponent, Location, TeamScore, OpponentScore, Outcome)
VALUES
('2024-09-22', 'Connecticut', 'Away', 69, 93, 'Loss'),
('2024-09-25', 'Connecticut', 'Away', 81, 87, 'Loss'),
('2024-05-14', 'Connecticut', 'Away', 71, 92, 'Loss'),
('2024-05-16', 'New York', 'Home', 66, 102, 'Loss'),
('2024-05-18', 'New York', 'Away', 80, 91, 'Loss'),
('2024-05-24', 'Los Angeles', 'Away', 78, 73, 'Win'),
('2024-06-01', 'Chicago', 'Home', 71, 70, 'Win');
INSERT INTO PlayerStats (PlayerID, GP, GS, MIN, PTS, OffReb, DR, REB, AST, STL, BLK, Turnovers, PF, AST_TO)
VALUES 
(1, 40, 40, 35.4, 19.2, 0.4, 5.3, 5.7, 8.4, 1.3, 0.7, 5.6, 2.8, 1.5),
(2, 40, 38, 32.0, 19.2, 0.7, 1.8, 2.5, 1.8, 0.7, 0.2, 1.6, 1.6, 1.1),
(3, 40, 40, 30.9, 14.0, 2.8, 6.1, 8.9, 3.2, 0.9, 1.2, 2.0, 3.3, 1.6),
(4, 40, 37, 24.8, 10.6, 1.8, 5.3, 7.1, 1.0, 0.8, 1.0, 1.3, 2.7, 0.8),
(5, 22, 2, 18.9, 6.4, 1.4, 3.3, 4.7, 0.9, 0.5, 0.7, 1.2, 3.0, 0.7);
INSERT INTO ShootingStats (PlayerID, FGM, FGA, FGPercent, TPM, TPA, TPPercent, FTM, FTA, FTPercent, TPM2, TPA2, TPPercent2, SC_EFF, SH_EFF)
VALUES 
(1, 6.1, 14.5, 41.7, 3.1, 8.9, 34.4, 4.1, 4.5, 90.6, 3.0, 5.6, 53.3, 1.326, 0.52),
(2, 7.1, 15.1, 46.8, 2.7, 6.8, 40.2, 2.4, 2.8, 83.2, 4.3, 8.3, 52.3, 1.274, 0.56),
(3, 5.9, 11.2, 52.9, 0.2, 0.7, 26.9, 2.0, 2.8, 73.6, 5.7, 10.5, 54.5, 1.256, 0.54);
INSERT INTO Teams (TeamName, City)
VALUES ('Indiana Fever', 'Indianapolis');
SELECT * FROM TableName;
SELECT p.Name, ps.PTS, g.Date, g.Opponent
FROM PlayerStats ps
JOIN Players p ON ps.PlayerID = p.PlayerID
JOIN Games g ON ps.GameID = g.GameID
WHERE g.Opponent = 'Connecticut';
SELECT g.Opponent, SUM(ps.PTS) AS TotalPoints
FROM PlayerStats ps
JOIN Games g ON ps.GameID = g.GameID
GROUP BY g.Opponent;
SELECT g.Date, g.Opponent, gh.HighPointsPlayer, gh.HighPoints
FROM GameHighlights gh
JOIN Games g ON gh.GameID = g.GameID;

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
CREATE TABLE PlayerStats (
    PlayerStatID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL,
    GameID INT NOT NULL,
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
    GameID INT NOT NULL,
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
CREATE TABLE Highlights (
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
INSERT INTO Highlights (GameID, HighPointsPlayer, HighPoints, HighReboundsPlayer, HighRebounds, HighAssistsPlayer, HighAssists)
VALUES
(1, 'Mitchell', 21, 'Boston', 11, 'Clark', 8),
(2, 'Clark', 25, 'Boston', 19, 'Clark', 9),
(3, 'Clark', 20, 'Smith', 9, 'Clark', 3),
(4, 'Boston', 12, 'Boston', 7, 'Clark', 6),
(5, 'Clark', 22, 'Smith', 8, 'Clark', 8),
(6, 'Clark', 17, 'Fagbenle', 10, 'Clark', 5),
(7, 'Clark', 21, 'Smith', 11, 'Clark', 7),
(8, 'Mitchell', 18, 'Clark', 10, 'Clark', 8),
(9, 'Mitchell', 16, 'Fagbenle', 8, 'Clark', 7),
(10, 'Clark', 30, 'Fagbenle', 7, 'Clark', 6),
(11, 'Smith', 23, 'Boston', 12, 'Clark', 9),
(12, 'Clark', 23, 'Boston', 14, 'Clark', 12),
(13, 'Clark', 29, 'Smith', 10, 'Clark', 6),
(14, 'Boston', 27, 'Boston', 13, 'Clark', 6),
(15, 'Clark', 31, 'Smith', 14, 'Clark', 12);
CREATE TABLE AdvancedPlayerMetrics (
    MetricID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL, -- Links to Players
    GameID INT, -- Links to Games
    PER FLOAT, -- Player Efficiency Rating
    TS_PERCENT FLOAT, -- True Shooting Percentage
    USAGE_RATE FLOAT, -- Usage Rate
    OFF_RATING FLOAT, -- Offensive Rating
    DEF_RATING FLOAT, -- Defensive Rating
    WIN_SHARES FLOAT, -- Win Shares
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE GameEvents (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    GameID INT NOT NULL, -- Links to Games
    PlayerID INT, -- Links to Players (optional, if applicable)
    EventType VARCHAR(50), -- 'Shot', 'Foul', 'Turnover', 'Substitution', etc.
    EventDetail VARCHAR(255), -- Additional details (e.g., '3PT Shot Missed')
    EventTime TIME, -- Time of the event
    FOREIGN KEY (GameID) REFERENCES Games(GameID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);
CREATE TABLE TeamMetrics (
    MetricID INT AUTO_INCREMENT PRIMARY KEY,
    TeamID INT NOT NULL, -- Links to Teams
    GameID INT, -- Links to Games
    PACE FLOAT, -- Possessions per 48 minutes
    OFF_RATING FLOAT, -- Offensive efficiency
    DEF_RATING FLOAT, -- Defensive efficiency
    NET_RATING FLOAT, -- Net efficiency (OFF_RATING - DEF_RATING)
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE Injuries (
    InjuryID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL, -- Links to Players
    InjuryType VARCHAR(100), -- Description of injury
    DateInjured DATE,
    DateRecovered DATE,
    GamesMissed INT, -- Number of games missed due to injury
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);
CREATE TABLE TrainingPerformance (
    TrainingID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT NOT NULL, -- Links to Players
    TrainingDate DATE NOT NULL,
    FocusArea VARCHAR(50), -- 'Strength', 'Cardio', 'Shooting', etc.
    Result FLOAT, -- Metric result (e.g., sprint time, bench press weight)
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);
CREATE TABLE OpponentScouting (
    ScoutingID INT AUTO_INCREMENT PRIMARY KEY,
    OpponentTeam VARCHAR(100),
    OpponentPlayer VARCHAR(100),
    Strengths VARCHAR(255), -- Key strengths (e.g., '3PT Shooting', 'Rebounding')
    Weaknesses VARCHAR(255), -- Key weaknesses (e.g., 'Turnovers', 'Defense')
    Notes TEXT -- Additional scouting notes
);
CREATE TABLE RefereeStats (
    RefereeID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    GameID INT, -- Links to Games
    FoulsCalled INT,
    TechnicalsCalled INT,
    Ejections INT,
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);
CREATE TABLE FanEngagement (
    EngagementID INT AUTO_INCREMENT PRIMARY KEY,
    GameID INT NOT NULL, -- Links to Games
    Attendance INT,
    SocialMediaMentions INT,
    MerchandiseSales FLOAT,
    FOREIGN KEY (GameID) REFERENCES Games(GameID)
);



SELECT * FROM Highlights;
SELECT 
    g.Date,
    g.Opponent,
    g.Outcome,
    h.HighPointsPlayer,
    h.HighPoints,
    h.HighReboundsPlayer,
    h.HighRebounds,
    h.HighAssistsPlayer,
    h.HighAssists
FROM Highlights h
JOIN Games g ON h.GameID = g.GameID;


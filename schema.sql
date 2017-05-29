DROP DATABASE IF EXISTS cs336g32;
CREATE DATABASE cs336g32;
USE cs336g32;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS cars;
DROP TABLE IF EXISTS rideRequests;
DROP TABLE IF EXISTS rides;
DROP TABLE IF EXISTS ridesRecurring;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS ads;
DROP TABLE IF EXISTS messages;

CREATE TABLE users(
	username	VARCHAR(20) UNIQUE NOT NULL,
    password	VARCHAR(50) NOT NULL,
    email 		VARCHAR(30) UNIQUE NOT NULL,
    name		VARCHAR(20),
    address		VARCHAR(50),
    phone		VARCHAR(16),
    isBanned	BOOL default "0",
    type		VARCHAR(5) DEFAULT "user",
    PRIMARY KEY (username)
);

CREATE TABLE cars(
	carId 		INT UNIQUE NOT NULL AUTO_INCREMENT,
    carDesc 	VARCHAR(20) NOT NULL,
	carNumPassengers	INT DEFAULT "0",
    isDefault	BOOL NOT NULL,
    owner 		VARCHAR(20) NOT NULL,
    PRIMARY KEY(carId),
    FOREIGN KEY(owner) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rideRequests(
	rideId INT UNIQUE NOT NULL AUTO_INCREMENT,
    rider VARCHAR(20) NOT NULL,
    departure VARCHAR(20) NOT NULL,
    destination VARCHAR(20) NOT NULL,
    timeWindow VARCHAR(20) NOT NULL,
    recurring BOOL NOT NULL DEFAULT "0",
    PRIMARY KEY(rideId),
	FOREIGN KEY(rider) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rides(
	rideId INT NOT NULL,
	driver VARCHAR(20) NOT NULL,
    carId INT NOT NULL,
    isComplete BOOL DEFAULT "0",
    date DATETIME NOT NULL DEFAULT current_timestamp, 
    PRIMARY KEY(rideId),
    FOREIGN KEY(rideId) REFERENCES rideRequests (rideId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(carId) REFERENCES cars (carId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(driver) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ridesRecurring(
	rideId INT NOT NULL,
    PRIMARY KEY(rideId),
    FOREIGN KEY(rideId) REFERENCES rideRequests (rideId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ratings(
	isPublic BOOL DEFAULT "0",
	userRated VARCHAR(20) NOT NULL, 
    userRater VARCHAR(20) NOT NULL,
	rideId INT NOT NULL,
	value INT NOT NULL,
    comment TEXT,
    PRIMARY KEY(rideId, userRated, userRater),
    FOREIGN KEY(rideId) REFERENCES rideRequests (rideId) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(userRated) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(userRater) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ads(
	adId INT UNIQUE NOT NULL AUTO_INCREMENT,
    advertiser VARCHAR(20) NOT NULL,
    content TEXT NOT NULL,
    views INT DEFAULT "0"
);

CREATE TABLE messages(
	mId INT UNIQUE NOT NULL AUTO_INCREMENT,
	toUser VARCHAR(20) NOT NULL,
    fromUser VARCHAR(20) NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY(toUser) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(fromUser) REFERENCES users (username) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(mId)
);

CREATE TRIGGER welcome
AFTER INSERT ON users
FOR EACH ROW 
	INSERT INTO messages(toUser,fromUser,body)
	VALUES (NEW.username, "admin", "Welcome!");

CREATE TRIGGER autoBan
AFTER INSERT ON ratings
FOR EACH ROW
	UPDATE users SET isBanned='1' WHERE
		(SELECT COUNT(*) FROM ratings WHERE userRated=username)>'4'
        AND (SELECT AVG(value) FROM ratings WHERE userRated=username)<'2'; 
    
CREATE TRIGGER censorMsg
BEFORE INSERT ON messages
FOR EACH ROW
	SET NEW.body = REPLACE(NEW.body, 'fuck', '****');
	

INSERT INTO users(username, password, email, name, address, phone, isBanned, type)
	VALUES ("admin", "password", "admin@rideme.com", "Administrator", "The Matrix", "1234567890", "0", "admin");
INSERT INTO users(username, password, email, name, address, phone, isBanned, type)
	VALUES ("support", "support", "support@hotmail.com", "Renard Tumbokon", "The Sub-Matrix", "9081234567", "0", "staff");
INSERT INTO users(username, password, email, name, address, phone, isBanned, type)
	VALUES ("renard", "renard", "renard@hotmail.com", "Renard Tumbokon", "302 Cranford Ave", "9081234567", "0", "user");
INSERT INTO users(username, password, email, name, address, phone, isBanned, type)
	VALUES ("nick", "nick", "nick@hotmail.com", "Nick Prezioso", "10 Concord Dr", "4165430986", "0", "user");
INSERT INTO users(username, password, email, name, address, phone, isBanned, type)
	VALUES ("aziz", "aziz", "aziz@hotmail.com", "Aziz Rahman", "32 Piscattaway Ln", "5673099321", "0", "user");

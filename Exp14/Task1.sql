# 请将你实现flight_booking数据库的语句写在下方：

# 创建数据库
DROP DATABASE IF EXISTS flight_booking;
CREATE DATABASE flight_booking;
USE flight_booking;


# 创建表
CREATE TABLE IF NOT EXISTS user(
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    sex CHAR(1) NOT NULL,
    email VARCHAR(50),
    phone VARCHAR(30),
    username VARCHAR(20) NOT NULL UNIQUE,
    password CHAR(32) NOT NULL,
    admin_tag TINYINT DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS passenger(
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    id CHAR(18) NOT NULL UNIQUE,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    mail VARCHAR(50),
    phone VARCHAR(20) NOT NULL,
    sex CHAR(1) NOT NULL,
    dob DATE
);

CREATE TABLE IF NOT EXISTS airport(
    airport_id INT AUTO_INCREMENT PRIMARY KEY,
    iata CHAR(3) NOT NULL UNIQUE,
    icao CHAR(4) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    latitude DECIMAL(11, 8),
    longitude DECIMAL(11, 8),

    INDEX (name)
);

CREATE TABLE IF NOT EXISTS airline(
    airline_id INT AUTO_INCREMENT PRIMARY KEY,
    airport_id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    iata CHAR(2) NOT NULL UNIQUE,

    FOREIGN KEY (airport_id) REFERENCES airport(airport_id)
);

CREATE TABLE IF NOT EXISTS airplane(
    airplane_id INT AUTO_INCREMENT PRIMARY KEY,
    airline_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    capacity SMALLINT NOT NULL,
    identifier VARCHAR(50) NOT NULL,

    FOREIGN KEY (airline_id) REFERENCES airline(airline_id)
);

CREATE TABLE IF NOT EXISTS flightschedule(
    flight_no CHAR(8) PRIMARY KEY,
    departure TIME NOT NULL,
    arrival TIME NOT NULL,
    duration SMALLINT NOT NULL,
    monday TINYINT DEFAULT 0,
    tuesday TINYINT DEFAULT 0,
    wednesday TINYINT DEFAULT 0,
    thursday TINYINT DEFAULT 0,
    friday TINYINT DEFAULT 0,
    saturday TINYINT DEFAULT 0,
    sunday TINYINT DEFAULT 0,
    `from` INT NOT NULL,
    `to` INT NOT NULL,
    airline_id INT NOT NULL,

    FOREIGN KEY (airline_id) REFERENCES airline(airline_id),
    FOREIGN KEY (`from`) REFERENCES airport(airport_id),
    FOREIGN KEY (`to`) REFERENCES airport(airport_id)
);

CREATE TABLE IF NOT EXISTS flight(
    flight_id INT AUTO_INCREMENT PRIMARY KEY,
    departure DATETIME NOT NULL,
    arrival DATETIME NOT NULL,
    duration SMALLINT NOT NULL,
    `from` INT NOT NULL,
    `to` INT NOT NULL,
    airline_id INT NOT NULL,
    flight_no CHAR(8) NOT NULL,
    airplane_id INT NOT NULL
                                 ,
    FOREIGN KEY (airline_id) REFERENCES airline(airline_id),
    FOREIGN KEY (flight_no) REFERENCES flightschedule(flight_no),
    FOREIGN KEY (airplane_id) REFERENCES airplane(airplane_id),
    FOREIGN KEY (`from`) REFERENCES airport(airport_id),
    FOREIGN KEY (`to`)  REFERENCES airport(airport_id)
);

CREATE TABLE IF NOT EXISTS ticket(
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    seat CHAR(4),
    price DECIMAL(10, 2) NOT NULL,
    passenger_id INT NOT NULL,
    user_id INT NOT NULL,
    flight_id INT NOT NULL,

    FOREIGN KEY (passenger_id) REFERENCES passenger(passenger_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (flight_id) REFERENCES flight(flight_id)
);
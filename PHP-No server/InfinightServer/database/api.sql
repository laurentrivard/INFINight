USE pushchat;

SET NAMES utf8;

DROP TABLE IF EXISTS active_users;

CREATE TABLE active_users
(
	udid varchar(40) NOT NULL PRIMARY KEY,
	device_token varchar(64) NOT NULL,
	nickname varchar(255) NOT NULL,
	secret_code varchar(255) NOT NULL,
	ip_address varchar(32) NOT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



//my code replacing the pushchat code
/*
USE infinight;

SET NAMES utf8;

CREATE TABLE active_users
(
	device_id varchar(40) NOT NULL PRIMARY KEY,
	device_token varchar(64) NOT NULL,
	name varchar(255) NOT NULL,
	matricule varchar(20) NOT NULL,
	groupe INT NOT NULL,
        grad_year INT NOT NULL
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;



*/
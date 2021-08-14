CREATE DATABASE wordpress;

CREATE USER 'wproot'@'%' IDENTIFIED BY 'pwd';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wproot'@'%';
CREATE USER IF NOT EXISTS 'impacta'@'%' IDENTIFIED BY 'impacta';

CREATE DATABASE IF NOT EXISTS impacta;

ALTER DATABASE impacta
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

GRANT ALL PRIVILEGES ON impacta.* TO 'impacta'@'%' IDENTIFIED BY 'impacta';

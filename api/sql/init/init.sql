-- Adminer 4.8.1 MySQL 5.5.5-10.4.33-MariaDB-1:10.4.33+maria~ubu2004 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `Etudiant`;
CREATE TABLE `Etudiant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mdp` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `Favoris`;
CREATE TABLE `Favoris` (
  `id_etudiant` int(11) DEFAULT NULL,
  `salle` varchar(255) DEFAULT NULL,
  KEY `id_etudiant` (`id_etudiant`),
  CONSTRAINT `favoris_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `Etudiant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


-- 2024-04-02 08:46:51



-- Adminer 4.8.1 MySQL 5.5.5-10.4.33-MariaDB-1:10.4.33+maria~ubu2004 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

INSERT INTO `Etudiant` (`id`, `nom`, `prenom`, `email`, `mdp`) VALUES
(1,	'Dupont',	'Jean',	'jean.dupont@email.com',	'password1'),
(2,	'Martin',	'Marie',	'marie.martin@email.com',	'password2'),
(3,	'Dubois',	'Pierre',	'pierre.dubois@email.com',	'password3');

INSERT INTO `Favoris` (`id_etudiant`, `salle`) VALUES
(1,	'Salle A'),
(1,	'Salle B'),
(2,	'Salle C'),
(3,	'Salle D'),
(3,	'Salle E');

-- 2024-04-02 08:47:17


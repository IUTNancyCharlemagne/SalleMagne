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

INSERT INTO `Etudiant` (`id`, `nom`, `prenom`, `email`, `mdp`) VALUES
(1,	'Dupont',	'Jean',	'user1',	'$2y$10$6Pffa.Qx5h6kxLg0gSlcYe65W0vxH/FDrNQFucJxJ1/hg/qD8dIaK'),
(2,	'Martin',	'Marie',	'user2',	'$2y$10$2A/LBYsjxgC4FIi2I9eBtO7Xgx7WC191KHIh2frqHkyVqUTUumRdO'),
(3,	'Dubois',	'Pierre',	'brozer',	'$2y$10$hwVQrS171GH4ThHbW9/NauSRvDW0NWavIJoKPbWY0odrNtS953zaK');

DROP TABLE IF EXISTS `Favoris`;
CREATE TABLE `Favoris` (
  `id_etudiant` int(11) NOT NULL,
  `salle` int(11) NOT NULL,
  PRIMARY KEY (`id_etudiant`,`salle`),
  KEY `id_etudiant` (`id_etudiant`),
  CONSTRAINT `favoris_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `Etudiant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `Favoris` (`id_etudiant`, `salle`) VALUES
(1,	503),
(1,	505),
(1,	506),
(2,	501),
(3,	500),
(3,	502);

-- 2024-04-03 09:54:12

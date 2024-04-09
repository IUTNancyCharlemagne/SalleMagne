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
(6,	'test',	'testp',	'test@mail.com',	'$2b$10$qnQX2kIx0xx/X.frr1MPButaKWKDbjPbFFeKsxW0pdb7pm.GGlktu'),
(10,	't',	't',	'test1@mail.com',	'$2b$10$ZjQdewugX3ssgtOaF.Vi4et7KDQKZs9kWcjQfSDkzg5elW6VrXDTW'),
(12,	'oui',	'oui',	'ouioui@gmail.com',	'$2b$10$ryabKK1CjiYsCBighFAM8O4IeX39OMi.y69wM2bhfj8LNDbTxYVxa'),
(13,	't',	't',	'test2@mail.com',	'$2b$10$6HMSuxIM4U157xicp6B5QeS817R3AbLewZgd73tmt9OTwU.Qk5myy'),
(14,	't',	't',	'test10@mail.com',	'$2b$10$WLyvu8wCDoq.NuSiqMMJYeMeq049zxrh/wg3SMXbXcdhJ5b/ZG7k6'),
(15,	'waltispurger',	'Julie',	'julie@gmail.com',	'$2b$10$N8zV7SUZG4bhXvTIAyMao.TF/asDr.G6ygZYhLLsyza4u94vXotuK'),
(16,	'test',	'test',	'test@test.com',	'$2b$10$xR8He6gOKf1DqLKVu2oBb.L.U0v.u1ioa1y7kFZpgaRnon2fbbPsW'),
(17,	'vincent ',	'vincent',	'vincent@gmail.com',	'$2b$10$FnaUbmlwcpVKUKyVOrsD0uL92zFdtkD.PTKfZW.WToEHUI7NUOZZW'),
(18,	'aria',	'aria',	'aria@mail.com',	'$2b$10$OZ2q1ay2nOqi9gtD0yDw7e/GnUX1lKpyzfa6w7.JVHMQ52HNVD3e2');

DROP TABLE IF EXISTS `Favoris`;
CREATE TABLE `Favoris` (
  `id_etudiant` int(11) NOT NULL,
  `salle` int(11) NOT NULL,
  PRIMARY KEY (`id_etudiant`,`salle`),
  KEY `id_etudiant` (`id_etudiant`),
  CONSTRAINT `favoris_ibfk_1` FOREIGN KEY (`id_etudiant`) REFERENCES `Etudiant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `Favoris` (`id_etudiant`, `salle`) VALUES
(6,	8),
(6,	10),
(6,	505),
(18,	505);

-- 2024-04-09 11:00:58


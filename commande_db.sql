-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 17 août 2022 à 17:00
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `commande_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `idClient` int(11) NOT NULL AUTO_INCREMENT,
  `nomClient` varchar(100) NOT NULL,
  PRIMARY KEY (`idClient`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`idClient`, `nomClient`) VALUES
(2, 'Adele'),
(3, 'Ewa'),
(4, 'Wesh'),
(6, 'Zedd'),
(18, 'Landers'),
(23, 'Rem'),
(24, 'Gui'),
(25, 'Marron');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande` (
  `idCommande` int(100) NOT NULL AUTO_INCREMENT,
  `idClient` int(100) NOT NULL,
  `idProduit` int(100) NOT NULL,
  `quantite` int(255) NOT NULL,
  `dateCommande` date NOT NULL,
  PRIMARY KEY (`idCommande`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`idCommande`, `idClient`, `idProduit`, `quantite`, `dateCommande`) VALUES
(1, 7, 4, 1, '2022-08-04'),
(4, 23, 5, 2, '2022-08-11'),
(5, 2, 3, 3, '2022-08-12'),
(6, 25, 6, 3, '2022-08-15'),
(7, 25, 3, 1, '2022-08-15'),
(8, 6, 6, 3, '2022-08-15'),
(9, 3, 7, 4, '2022-08-15'),
(10, 4, 3, 3, '2022-08-15'),
(11, 2, 7, 2, '2022-08-16');

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

DROP TABLE IF EXISTS `produit`;
CREATE TABLE IF NOT EXISTS `produit` (
  `idProduit` int(11) NOT NULL AUTO_INCREMENT,
  `designProduit` varchar(255) NOT NULL,
  `prixUniProduit` int(11) NOT NULL,
  `stockProduit` int(11) NOT NULL,
  PRIMARY KEY (`idProduit`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`idProduit`, `designProduit`, `prixUniProduit`, `stockProduit`) VALUES
(1, 'Pomme de Terre', 507, 4),
(3, 'Thon', 20250, 7),
(4, 'Oignon', 120, 3),
(6, 'Tomate', 5150, 13),
(7, 'Huile', 15300, 6);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(100) NOT NULL,
  `userPassword` varchar(255) NOT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`idUser`, `userName`, `userPassword`) VALUES
(1, 'admin', 'admin'),
(2, 'Mahefa', 'nando');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

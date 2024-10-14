-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 11 oct. 2024 à 06:28
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `journal_de_caisse`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add beneficiaire', 6, 'add_beneficiaire'),
(22, 'Can change beneficiaire', 6, 'change_beneficiaire'),
(23, 'Can delete beneficiaire', 6, 'delete_beneficiaire'),
(24, 'Can view beneficiaire', 6, 'view_beneficiaire'),
(25, 'Can add caisse', 7, 'add_caisse'),
(26, 'Can change caisse', 7, 'change_caisse'),
(27, 'Can delete caisse', 7, 'delete_caisse'),
(28, 'Can view caisse', 7, 'view_caisse'),
(29, 'Can add categorie', 8, 'add_categorie'),
(30, 'Can change categorie', 8, 'change_categorie'),
(31, 'Can delete categorie', 8, 'delete_categorie'),
(32, 'Can view categorie', 8, 'view_categorie'),
(33, 'Can add fournisseur', 9, 'add_fournisseur'),
(34, 'Can change fournisseur', 9, 'change_fournisseur'),
(35, 'Can delete fournisseur', 9, 'delete_fournisseur'),
(36, 'Can view fournisseur', 9, 'view_fournisseur'),
(37, 'Can add personnel', 10, 'add_personnel'),
(38, 'Can change personnel', 10, 'change_personnel'),
(39, 'Can delete personnel', 10, 'delete_personnel'),
(40, 'Can view personnel', 10, 'view_personnel'),
(41, 'Can add user', 11, 'add_customuser'),
(42, 'Can change user', 11, 'change_customuser'),
(43, 'Can delete user', 11, 'delete_customuser'),
(44, 'Can view user', 11, 'view_customuser'),
(45, 'Can add operation entrer', 12, 'add_operationentrer'),
(46, 'Can change operation entrer', 12, 'change_operationentrer'),
(47, 'Can delete operation entrer', 12, 'delete_operationentrer'),
(48, 'Can view operation entrer', 12, 'view_operationentrer'),
(49, 'Can add operation sortir', 13, 'add_operationsortir'),
(50, 'Can change operation sortir', 13, 'change_operationsortir'),
(51, 'Can delete operation sortir', 13, 'delete_operationsortir'),
(52, 'Can view operation sortir', 13, 'view_operationsortir'),
(53, 'Can add historical beneficiaire', 14, 'add_historicalbeneficiaire'),
(54, 'Can change historical beneficiaire', 14, 'change_historicalbeneficiaire'),
(55, 'Can delete historical beneficiaire', 14, 'delete_historicalbeneficiaire'),
(56, 'Can view historical beneficiaire', 14, 'view_historicalbeneficiaire'),
(57, 'Can add historical user', 15, 'add_historicalcustomuser'),
(58, 'Can change historical user', 15, 'change_historicalcustomuser'),
(59, 'Can delete historical user', 15, 'delete_historicalcustomuser'),
(60, 'Can view historical user', 15, 'view_historicalcustomuser'),
(61, 'Can add historical fournisseur', 16, 'add_historicalfournisseur'),
(62, 'Can change historical fournisseur', 16, 'change_historicalfournisseur'),
(63, 'Can delete historical fournisseur', 16, 'delete_historicalfournisseur'),
(64, 'Can view historical fournisseur', 16, 'view_historicalfournisseur'),
(65, 'Can add historical personnel', 17, 'add_historicalpersonnel'),
(66, 'Can change historical personnel', 17, 'change_historicalpersonnel'),
(67, 'Can delete historical personnel', 17, 'delete_historicalpersonnel'),
(68, 'Can view historical personnel', 17, 'view_historicalpersonnel'),
(69, 'Can add historical operation entrer', 18, 'add_historicaloperationentrer'),
(70, 'Can change historical operation entrer', 18, 'change_historicaloperationentrer'),
(71, 'Can delete historical operation entrer', 18, 'delete_historicaloperationentrer'),
(72, 'Can view historical operation entrer', 18, 'view_historicaloperationentrer'),
(73, 'Can add historical caisse', 19, 'add_historicalcaisse'),
(74, 'Can change historical caisse', 19, 'change_historicalcaisse'),
(75, 'Can delete historical caisse', 19, 'delete_historicalcaisse'),
(76, 'Can view historical caisse', 19, 'view_historicalcaisse'),
(77, 'Can add historical categorie', 20, 'add_historicalcategorie'),
(78, 'Can change historical categorie', 20, 'change_historicalcategorie'),
(79, 'Can delete historical categorie', 20, 'delete_historicalcategorie'),
(80, 'Can view historical categorie', 20, 'view_historicalcategorie'),
(81, 'Can add historical operation sortir', 21, 'add_historicaloperationsortir'),
(82, 'Can change historical operation sortir', 21, 'change_historicaloperationsortir'),
(83, 'Can delete historical operation sortir', 21, 'delete_historicaloperationsortir'),
(84, 'Can view historical operation sortir', 21, 'view_historicaloperationsortir');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_beneficiaire`
--

DROP TABLE IF EXISTS `caisse_beneficiaire`;
CREATE TABLE IF NOT EXISTS `caisse_beneficiaire` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `personnel_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caisse_beneficiaire_personnel_id_8a428ece` (`personnel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_caisse`
--

DROP TABLE IF EXISTS `caisse_caisse`;
CREATE TABLE IF NOT EXISTS `caisse_caisse` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `montant` decimal(10,2) NOT NULL,
  `date_creation` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_categorie`
--

DROP TABLE IF EXISTS `caisse_categorie`;
CREATE TABLE IF NOT EXISTS `caisse_categorie` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_categorie`
--

INSERT INTO `caisse_categorie` (`id`, `name`, `description`) VALUES
(1, 'Mensuel', '');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_customuser`
--

DROP TABLE IF EXISTS `caisse_customuser`;
CREATE TABLE IF NOT EXISTS `caisse_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `photo_de_profil` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_customuser`
--

INSERT INTO `caisse_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `photo_de_profil`) VALUES
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:59:49.210922', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_customuser_groups`
--

DROP TABLE IF EXISTS `caisse_customuser_groups`;
CREATE TABLE IF NOT EXISTS `caisse_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `caisse_customuser_groups_customuser_id_group_id_f81af4ef_uniq` (`customuser_id`,`group_id`),
  KEY `caisse_customuser_groups_customuser_id_b0888793` (`customuser_id`),
  KEY `caisse_customuser_groups_group_id_927c1591` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_customuser_user_permissions`
--

DROP TABLE IF EXISTS `caisse_customuser_user_permissions`;
CREATE TABLE IF NOT EXISTS `caisse_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `caisse_customuser_user_p_customuser_id_permission_6a658c39_uniq` (`customuser_id`,`permission_id`),
  KEY `caisse_customuser_user_permissions_customuser_id_5dab64d1` (`customuser_id`),
  KEY `caisse_customuser_user_permissions_permission_id_68731bc2` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_fournisseur`
--

DROP TABLE IF EXISTS `caisse_fournisseur`;
CREATE TABLE IF NOT EXISTS `caisse_fournisseur` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `contact` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalbeneficiaire`
--

DROP TABLE IF EXISTS `caisse_historicalbeneficiaire`;
CREATE TABLE IF NOT EXISTS `caisse_historicalbeneficiaire` (
  `id` bigint NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  `personnel_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalbeneficiaire_id_77ee5022` (`id`),
  KEY `caisse_historicalbeneficiaire_history_date_2a0ac628` (`history_date`),
  KEY `caisse_historicalbeneficiaire_history_user_id_b4640c8c` (`history_user_id`),
  KEY `caisse_historicalbeneficiaire_personnel_id_d58e795f` (`personnel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalcaisse`
--

DROP TABLE IF EXISTS `caisse_historicalcaisse`;
CREATE TABLE IF NOT EXISTS `caisse_historicalcaisse` (
  `id` bigint NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_creation` date NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalcaisse_id_b5fb1711` (`id`),
  KEY `caisse_historicalcaisse_history_date_8515e9bd` (`history_date`),
  KEY `caisse_historicalcaisse_history_user_id_256381ca` (`history_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalcategorie`
--

DROP TABLE IF EXISTS `caisse_historicalcategorie`;
CREATE TABLE IF NOT EXISTS `caisse_historicalcategorie` (
  `id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` longtext,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalcategorie_id_65ed1d82` (`id`),
  KEY `caisse_historicalcategorie_name_d540acef` (`name`),
  KEY `caisse_historicalcategorie_history_date_340b904c` (`history_date`),
  KEY `caisse_historicalcategorie_history_user_id_941c72b0` (`history_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_historicalcategorie`
--

INSERT INTO `caisse_historicalcategorie` (`id`, `name`, `description`, `history_id`, `history_date`, `history_change_reason`, `history_type`, `history_user_id`) VALUES
(1, 'Mensuel', '', 1, '2024-10-09 14:02:12.347503', NULL, '+', 1);

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalcustomuser`
--

DROP TABLE IF EXISTS `caisse_historicalcustomuser`;
CREATE TABLE IF NOT EXISTS `caisse_historicalcustomuser` (
  `id` bigint NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `photo_de_profil` longtext NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalcustomuser_id_e46c96f2` (`id`),
  KEY `caisse_historicalcustomuser_username_9360204a` (`username`),
  KEY `caisse_historicalcustomuser_history_date_a37be0d5` (`history_date`),
  KEY `caisse_historicalcustomuser_history_user_id_fa0563a7` (`history_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_historicalcustomuser`
--

INSERT INTO `caisse_historicalcustomuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `photo_de_profil`, `history_id`, `history_date`, `history_change_reason`, `history_type`, `history_user_id`) VALUES
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', NULL, 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 1, '2024-10-09 13:14:12.962334', NULL, '+', NULL),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-09 13:14:32.204420', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 2, '2024-10-09 13:14:32.205458', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 11:53:36.014970', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 3, '2024-10-10 11:53:36.014970', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 11:57:58.664735', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 4, '2024-10-10 11:57:58.664735', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:09:28.417566', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 5, '2024-10-10 12:09:28.417566', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:24:02.513033', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 6, '2024-10-10 12:24:02.513033', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:28:30.197403', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 7, '2024-10-10 12:28:30.197403', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:29:57.150991', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 8, '2024-10-10 12:29:57.150991', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:45:13.832538', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 9, '2024-10-10 12:45:13.832538', NULL, '~', 1),
(1, 'pbkdf2_sha256$870000$kvR9mYUbv8KTIGowWRXvM2$QUtYCIV3DyMFjuXHXmeRWuz0KCtNc3hqIOpkocsjZr0=', '2024-10-10 12:59:49.210922', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-10-09 13:14:11.812020', 'photos/pdp_defaut.png', 10, '2024-10-10 12:59:49.211920', NULL, '~', 1);

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalfournisseur`
--

DROP TABLE IF EXISTS `caisse_historicalfournisseur`;
CREATE TABLE IF NOT EXISTS `caisse_historicalfournisseur` (
  `id` bigint NOT NULL,
  `name` varchar(50) NOT NULL,
  `contact` varchar(15) NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalfournisseur_id_b40ff689` (`id`),
  KEY `caisse_historicalfournisseur_history_date_c250a042` (`history_date`),
  KEY `caisse_historicalfournisseur_history_user_id_d21c1aad` (`history_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicaloperationentrer`
--

DROP TABLE IF EXISTS `caisse_historicaloperationentrer`;
CREATE TABLE IF NOT EXISTS `caisse_historicaloperationentrer` (
  `id` bigint NOT NULL,
  `description` varchar(255) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `date` date NOT NULL,
  `date_transaction` date NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `categorie_id` bigint DEFAULT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicaloperationentrer_id_6cdf4f7c` (`id`),
  KEY `caisse_historicaloperationentrer_history_date_71ff1ce1` (`history_date`),
  KEY `caisse_historicaloperationentrer_categorie_id_0bcb47f9` (`categorie_id`),
  KEY `caisse_historicaloperationentrer_history_user_id_a191bc0c` (`history_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_historicaloperationentrer`
--

INSERT INTO `caisse_historicaloperationentrer` (`id`, `description`, `montant`, `date`, `date_transaction`, `history_id`, `history_date`, `history_change_reason`, `history_type`, `categorie_id`, `history_user_id`) VALUES
(1, 'La somme verser par mois', '5000', '2024-10-09', '2024-10-09', 1, '2024-10-09 14:02:26.922582', NULL, '+', 1, 1),
(1, 'La somme verser par mois', '5000', '2024-10-09', '2024-10-09', 2, '2024-10-09 14:03:35.121952', NULL, '-', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicaloperationsortir`
--

DROP TABLE IF EXISTS `caisse_historicaloperationsortir`;
CREATE TABLE IF NOT EXISTS `caisse_historicaloperationsortir` (
  `id` bigint NOT NULL,
  `description` varchar(255) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `date` date NOT NULL,
  `date_de_sortie` date NOT NULL,
  `quantité` decimal(10,0) NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `beneficiaire_id` bigint DEFAULT NULL,
  `categorie_id` bigint DEFAULT NULL,
  `fournisseur_id` bigint DEFAULT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicaloperationsortir_id_4415aa99` (`id`),
  KEY `caisse_historicaloperationsortir_history_date_158d135b` (`history_date`),
  KEY `caisse_historicaloperationsortir_beneficiaire_id_ae330881` (`beneficiaire_id`),
  KEY `caisse_historicaloperationsortir_categorie_id_15dad94b` (`categorie_id`),
  KEY `caisse_historicaloperationsortir_fournisseur_id_3d6966be` (`fournisseur_id`),
  KEY `caisse_historicaloperationsortir_history_user_id_c51f64e6` (`history_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_historicalpersonnel`
--

DROP TABLE IF EXISTS `caisse_historicalpersonnel`;
CREATE TABLE IF NOT EXISTS `caisse_historicalpersonnel` (
  `id` bigint NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  `date_embauche` datetime(6) NOT NULL,
  `sexe` varchar(6) NOT NULL,
  `date_naissance` date NOT NULL,
  `photo` longtext NOT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `type_personnel` varchar(10) NOT NULL,
  `history_id` int NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `history_user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `caisse_historicalpersonnel_id_e3451a78` (`id`),
  KEY `caisse_historicalpersonnel_history_date_a3e73377` (`history_date`),
  KEY `caisse_historicalpersonnel_history_user_id_d0b72144` (`history_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_operationentrer`
--

DROP TABLE IF EXISTS `caisse_operationentrer`;
CREATE TABLE IF NOT EXISTS `caisse_operationentrer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `date` date NOT NULL,
  `date_transaction` date NOT NULL,
  `categorie_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `caisse_operationentrer_categorie_id_4f4798ce` (`categorie_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_operationsortir`
--

DROP TABLE IF EXISTS `caisse_operationsortir`;
CREATE TABLE IF NOT EXISTS `caisse_operationsortir` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `montant` decimal(10,0) NOT NULL,
  `date` date NOT NULL,
  `date_de_sortie` date NOT NULL,
  `quantité` decimal(10,0) NOT NULL,
  `beneficiaire_id` bigint NOT NULL,
  `categorie_id` bigint NOT NULL,
  `fournisseur_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caisse_operationsortir_beneficiaire_id_72d03fa4` (`beneficiaire_id`),
  KEY `caisse_operationsortir_categorie_id_4306e508` (`categorie_id`),
  KEY `caisse_operationsortir_fournisseur_id_85374a1a` (`fournisseur_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_personnel`
--

DROP TABLE IF EXISTS `caisse_personnel`;
CREATE TABLE IF NOT EXISTS `caisse_personnel` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `tel` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  `date_embauche` datetime(6) NOT NULL,
  `sexe` varchar(6) NOT NULL,
  `date_naissance` date NOT NULL,
  `photo` varchar(100) NOT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `type_personnel` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(6, 'caisse', 'beneficiaire'),
(7, 'caisse', 'caisse'),
(8, 'caisse', 'categorie'),
(9, 'caisse', 'fournisseur'),
(10, 'caisse', 'personnel'),
(11, 'caisse', 'customuser'),
(12, 'caisse', 'operationentrer'),
(13, 'caisse', 'operationsortir'),
(14, 'caisse', 'historicalbeneficiaire'),
(15, 'caisse', 'historicalcustomuser'),
(16, 'caisse', 'historicalfournisseur'),
(17, 'caisse', 'historicalpersonnel'),
(18, 'caisse', 'historicaloperationentrer'),
(19, 'caisse', 'historicalcaisse'),
(20, 'caisse', 'historicalcategorie'),
(21, 'caisse', 'historicaloperationsortir');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-10-08 13:59:16.521060'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-10-08 13:59:16.781858'),
(3, 'auth', '0001_initial', '2024-10-08 13:59:17.979935'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-10-08 13:59:18.184096'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-10-08 13:59:18.204734'),
(6, 'auth', '0004_alter_user_username_opts', '2024-10-08 13:59:18.230241'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-10-08 13:59:18.260438'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-10-08 13:59:18.264839'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-10-08 13:59:18.294917'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-10-08 13:59:18.320165'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-10-08 13:59:18.344564'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-10-08 13:59:18.520395'),
(13, 'auth', '0011_update_proxy_permissions', '2024-10-08 13:59:18.522426'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-10-08 13:59:18.552578'),
(15, 'caisse', '0001_initial', '2024-10-08 13:59:21.428604'),
(16, 'admin', '0001_initial', '2024-10-08 13:59:22.207212'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-10-08 13:59:22.235605'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-10-08 13:59:22.270923'),
(19, 'sessions', '0001_initial', '2024-10-08 13:59:22.456457'),
(20, 'caisse', '0002_historicalbeneficiaire_historicalcaisse_and_more', '2024-10-08 14:01:10.745133');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('oaa2ouwsf68e57np9qtj7qwg2433938f', '.eJxVjMsOwiAQRf-FtSG8YVy69xsIDINUDU1KuzL-uzbpQrf3nHNfLKZtbXEbtMSpsDOT7PS75YQP6jso99RvM8e5r8uU-a7wgw5-nQs9L4f7d9DSaN_aC1tJZYlQrfMqoAtOB42gg0ICCxmQpNO-GHBS2WBEMoTGgqgJS2XvD8Y-N2Y:1syWWO:paOuZelMrTXnvkLEHpJ-z2fp6h_qInhXGYZYaVMDwbg', '2024-10-23 13:14:32.267636'),
('73mdb2l399c70z2lz2xbkbwg1rw7v2wl', '.eJxVjMsOwiAQRf-FtSG8YVy69xsIDINUDU1KuzL-uzbpQrf3nHNfLKZtbXEbtMSpsDOT7PS75YQP6jso99RvM8e5r8uU-a7wgw5-nQs9L4f7d9DSaN_aC1tJZYlQrfMqoAtOB42gg0ICCxmQpNO-GHBS2WBEMoTGgqgJS2XvD8Y-N2Y:1sysIn:QTXNu0CLnw_mS-M990xFf6Anc0pPQiuupt22CtBAIdY', '2024-10-24 12:29:57.150991'),
('mpo12rlixib2te01ltvkto2rbx82ha61', '.eJxVjMsOwiAQRf-FtSG8YVy69xsIDINUDU1KuzL-uzbpQrf3nHNfLKZtbXEbtMSpsDOT7PS75YQP6jso99RvM8e5r8uU-a7wgw5-nQs9L4f7d9DSaN_aC1tJZYlQrfMqoAtOB42gg0ICCxmQpNO-GHBS2WBEMoTGgqgJS2XvD8Y-N2Y:1syslh:aRLFxE2_1Y3QIfRhJiIcnUGHOYezEknjuLGMXv8Ftoo', '2024-10-24 12:59:49.217573');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 25 sep. 2024 à 13:05
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
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add beneficiaire', 7, 'add_beneficiaire'),
(26, 'Can change beneficiaire', 7, 'change_beneficiaire'),
(27, 'Can delete beneficiaire', 7, 'delete_beneficiaire'),
(28, 'Can view beneficiaire', 7, 'view_beneficiaire'),
(29, 'Can add caisse', 8, 'add_caisse'),
(30, 'Can change caisse', 8, 'change_caisse'),
(31, 'Can delete caisse', 8, 'delete_caisse'),
(32, 'Can view caisse', 8, 'view_caisse'),
(33, 'Can add categorie', 9, 'add_categorie'),
(34, 'Can change categorie', 9, 'change_categorie'),
(35, 'Can delete categorie', 9, 'delete_categorie'),
(36, 'Can view categorie', 9, 'view_categorie'),
(37, 'Can add fournisseur', 10, 'add_fournisseur'),
(38, 'Can change fournisseur', 10, 'change_fournisseur'),
(39, 'Can delete fournisseur', 10, 'delete_fournisseur'),
(40, 'Can view fournisseur', 10, 'view_fournisseur'),
(41, 'Can add permission', 11, 'add_permission'),
(42, 'Can change permission', 11, 'change_permission'),
(43, 'Can delete permission', 11, 'delete_permission'),
(44, 'Can view permission', 11, 'view_permission'),
(45, 'Can add personnel', 12, 'add_personnel'),
(46, 'Can change personnel', 12, 'change_personnel'),
(47, 'Can delete personnel', 12, 'delete_personnel'),
(48, 'Can view personnel', 12, 'view_personnel'),
(49, 'Can add role', 13, 'add_role'),
(50, 'Can change role', 13, 'change_role'),
(51, 'Can delete role', 13, 'delete_role'),
(52, 'Can view role', 13, 'view_role'),
(53, 'Can add admin', 14, 'add_admin'),
(54, 'Can change admin', 14, 'change_admin'),
(55, 'Can delete admin', 14, 'delete_admin'),
(56, 'Can view admin', 14, 'view_admin'),
(57, 'Can add operation entrer', 15, 'add_operationentrer'),
(58, 'Can change operation entrer', 15, 'change_operationentrer'),
(59, 'Can delete operation entrer', 15, 'delete_operationentrer'),
(60, 'Can view operation entrer', 15, 'view_operationentrer'),
(61, 'Can add operation sortir', 16, 'add_operationsortir'),
(62, 'Can change operation sortir', 16, 'change_operationsortir'),
(63, 'Can delete operation sortir', 16, 'delete_operationsortir'),
(64, 'Can view operation sortir', 16, 'view_operationsortir');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$IZbgvDqoEBFjjOVi8qX1ge$gLXlC2GeGPU0L9qsUt6XeiLEkGPaFXRZBh50pW5gPZQ=', '2024-09-25 05:44:15.806981', 1, 'bezara', '', '', 'kemulebezara205@gmail.com', 1, 1, '2024-09-23 12:09:56.017963');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `caisse_admin`
--

DROP TABLE IF EXISTS `caisse_admin`;
CREATE TABLE IF NOT EXISTS `caisse_admin` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pdp` varchar(100) DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_beneficiaire`
--

INSERT INTO `caisse_beneficiaire` (`id`, `name`, `personnel_id`) VALUES
(1, 'Toilette', NULL);

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
  `name` varchar(100) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_categorie`
--

INSERT INTO `caisse_categorie` (`id`, `name`, `description`) VALUES
(1, 'Mensuel', ''),
(2, 'Exeption', 'Pour les exception dans les entrées');

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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_fournisseur`
--

INSERT INTO `caisse_fournisseur` (`id`, `name`, `contact`) VALUES
(1, 'USB', '0325007340');

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
  `categorie_id` bigint DEFAULT NULL,
  `date_transaction` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caisse_operationentrer_Categorie_id_7870ec59` (`categorie_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_operationentrer`
--

INSERT INTO `caisse_operationentrer` (`id`, `description`, `montant`, `date`, `categorie_id`, `date_transaction`) VALUES
(1, 'La somme verser par mois', '500000', '2024-09-23', 1, '2024-09-25'),
(2, 'La somme verser par mois', '50000', '2024-09-24', 1, '2024-09-25'),
(5, 'Pour une exception', '30000', '2024-09-24', 2, '2024-09-25');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_operationsortir`
--

DROP TABLE IF EXISTS `caisse_operationsortir`;
CREATE TABLE IF NOT EXISTS `caisse_operationsortir` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `date_de_sortie` date NOT NULL,
  `Categorie_id` bigint DEFAULT NULL,
  `beneficiaire_id` bigint DEFAULT NULL,
  `fournisseur_id` bigint DEFAULT NULL,
  `quantité` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caisse_operationsortir_Categorie_id_0714ab59` (`Categorie_id`),
  KEY `caisse_operationsortir_beneficiaire_id_72d03fa4` (`beneficiaire_id`),
  KEY `caisse_operationsortir_fournisseur_id_85374a1a` (`fournisseur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_operationsortir`
--

INSERT INTO `caisse_operationsortir` (`id`, `description`, `montant`, `date`, `date_de_sortie`, `Categorie_id`, `beneficiaire_id`, `fournisseur_id`, `quantité`) VALUES
(1, 'Un savon', '5000.00', '2024-09-25', '2024-09-25', 1, 1, 1, '50');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_permission`
--

DROP TABLE IF EXISTS `caisse_permission`;
CREATE TABLE IF NOT EXISTS `caisse_permission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
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
  `sexe` varchar(5) NOT NULL,
  `date_naissance` date NOT NULL,
  `photo` varchar(100) NOT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `type_personnel` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `caisse_personnel`
--

INSERT INTO `caisse_personnel` (`id`, `last_name`, `first_name`, `tel`, `email`, `date_embauche`, `sexe`, `date_naissance`, `photo`, `adresse`, `type_personnel`) VALUES
(8, 'BEZARA', 'Kemuel', '+261325007340', 'kemulebezara205@gmail.com', '2024-09-25 12:51:50.000000', 'Homme', '2005-08-17', 'photos/Photo_didentité_IqtGUrK.JPG', 'Diego', 'Stagiaire'),
(7, 'ZOUBERY', 'Donaldo', '+261325007340', 'dzoubery@gmail.com', '2024-09-24 07:32:23.000000', 'Homme', '2005-08-17', 'photos/pdp_defaut.png', 'Diego', 'Bénévole');

-- --------------------------------------------------------

--
-- Structure de la table `caisse_role`
--

DROP TABLE IF EXISTS `caisse_role`;
CREATE TABLE IF NOT EXISTS `caisse_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
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
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

--
-- Déchargement des données de la table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2024-09-25 11:28:33.902249', '1', 'Toilette', 1, '[{\"added\": {}}]', 7, 1),
(2, '2024-09-25 11:29:12.821225', '1', 'Un savon - 500', 1, '[{\"added\": {}}]', 16, 1),
(3, '2024-09-25 11:37:58.017024', '1', 'Kemuel BEZARA', 3, '', 12, 1),
(4, '2024-09-25 11:38:28.024487', '1', 'Un savon - 500', 2, '[]', 16, 1),
(5, '2024-09-25 11:38:38.731111', '1', 'Un savon - 5000', 2, '[{\"changed\": {\"fields\": [\"Montant\"]}}]', 16, 1);

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
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'caisse', 'beneficiaire'),
(8, 'caisse', 'caisse'),
(9, 'caisse', 'categorie'),
(10, 'caisse', 'fournisseur'),
(11, 'caisse', 'permission'),
(12, 'caisse', 'personnel'),
(13, 'caisse', 'role'),
(14, 'caisse', 'admin'),
(15, 'caisse', 'operationentrer'),
(16, 'caisse', 'operationsortir');

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
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-09-23 12:08:26.774206'),
(2, 'auth', '0001_initial', '2024-09-23 12:08:27.687239'),
(3, 'admin', '0001_initial', '2024-09-23 12:08:27.985469'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-09-23 12:08:27.985469'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-09-23 12:08:28.007576'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-09-23 12:08:28.129315'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-09-23 12:08:28.180751'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-09-23 12:08:28.263420'),
(9, 'auth', '0004_alter_user_username_opts', '2024-09-23 12:08:28.263420'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-09-23 12:08:28.339865'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-09-23 12:08:28.341861'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-09-23 12:08:28.349948'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-09-23 12:08:28.414368'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-09-23 12:08:28.480839'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-09-23 12:08:28.536888'),
(16, 'auth', '0011_update_proxy_permissions', '2024-09-23 12:08:28.547352'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-09-23 12:08:28.624403'),
(18, 'caisse', '0001_initial', '2024-09-23 12:08:28.902028'),
(19, 'caisse', '0002_alter_operationentrer_montant', '2024-09-23 12:08:28.902028'),
(20, 'sessions', '0001_initial', '2024-09-23 12:08:28.976934'),
(21, 'caisse', '0003_operationsortir', '2024-09-24 08:20:45.027190'),
(22, 'caisse', '0004_alter_categorie_name', '2024-09-24 10:51:56.108059'),
(23, 'caisse', '0005_remove_operationsortir_personnel_and_more', '2024-09-24 12:44:41.179862'),
(24, 'caisse', '0006_alter_operationentrer_montant', '2024-09-24 13:13:55.916363'),
(25, 'caisse', '0007_rename_categorie_operationentrer_categorie', '2024-09-24 13:31:39.306914'),
(26, 'caisse', '0008_alter_operationentrer_categorie', '2024-09-24 13:45:43.925470'),
(27, 'caisse', '0009_alter_operationentrer_categorie', '2024-09-24 13:50:05.969078'),
(28, 'caisse', '0010_alter_operationentrer_categorie', '2024-09-24 13:55:08.916761'),
(29, 'caisse', '0011_alter_operationentrer_categorie', '2024-09-24 14:09:59.533599'),
(30, 'caisse', '0012_operationentrer_date_transaction', '2024-09-25 06:24:26.294127'),
(31, 'caisse', '0013_rename_date_achat_operationsortir_date_de_sortie_and_more', '2024-09-25 06:55:56.391936');

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
('goibhq2xqs8n3sklxhgnhnr39bb9dwks', '.eJxVjEEOwiAQRe_C2hAGh8K4dN8zEGBQqgaS0q6MdzckXej2v_f-W_iwb8XvPa9-YXERIE6_WwzpmesA_Aj13mRqdVuXKIciD9rl3Di_rof7d1BCL6MmVJM17EgrYHaI6FLGpMEpRAtoDHI28UaGEENyRJaYwhkmINBafL6vbDZC:1stKox:Qr4t2gYs_C1L_4yBpntGQZNznApkgh5OL8LI_IVNHZ4', '2024-10-09 05:44:15.814817');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

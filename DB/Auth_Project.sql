-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2014 at 01:59 PM
-- Server version: 5.5.32
-- PHP Version: 5.5.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Auth_Project`
--
CREATE DATABASE IF NOT EXISTS `Auth_Project` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `Auth_Project`;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_consumer_registry`
--

CREATE TABLE IF NOT EXISTS `oauth_consumer_registry` (
  `ocr_id` int(11) NOT NULL AUTO_INCREMENT,
  `ocr_usa_id_ref` int(11) DEFAULT NULL,
  `ocr_consumer_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ocr_consumer_secret` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ocr_signature_methods` varchar(255) NOT NULL DEFAULT 'HMAC-SHA1,PLAINTEXT',
  `ocr_server_uri` varchar(255) NOT NULL,
  `ocr_server_uri_host` varchar(128) NOT NULL,
  `ocr_server_uri_path` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ocr_request_token_uri` varchar(255) NOT NULL,
  `ocr_authorize_uri` varchar(255) NOT NULL,
  `ocr_access_token_uri` varchar(255) NOT NULL,
  `ocr_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ocr_id`),
  UNIQUE KEY `ocr_consumer_key` (`ocr_consumer_key`,`ocr_usa_id_ref`,`ocr_server_uri`),
  KEY `ocr_server_uri` (`ocr_server_uri`),
  KEY `ocr_server_uri_host` (`ocr_server_uri_host`,`ocr_server_uri_path`),
  KEY `ocr_usa_id_ref` (`ocr_usa_id_ref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_consumer_token`
--

CREATE TABLE IF NOT EXISTS `oauth_consumer_token` (
  `oct_id` int(11) NOT NULL AUTO_INCREMENT,
  `oct_ocr_id_ref` int(11) NOT NULL,
  `oct_usa_id_ref` int(11) NOT NULL,
  `oct_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `oct_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `oct_token_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `oct_token_type` enum('request','authorized','access') DEFAULT NULL,
  `oct_token_ttl` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `oct_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`oct_id`),
  UNIQUE KEY `oct_ocr_id_ref` (`oct_ocr_id_ref`,`oct_token`),
  UNIQUE KEY `oct_usa_id_ref` (`oct_usa_id_ref`,`oct_ocr_id_ref`,`oct_token_type`,`oct_name`),
  KEY `oct_token_ttl` (`oct_token_ttl`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_log`
--

CREATE TABLE IF NOT EXISTS `oauth_log` (
  `olg_id` int(11) NOT NULL AUTO_INCREMENT,
  `olg_osr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_ost_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_ocr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_oct_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `olg_usa_id_ref` int(11) DEFAULT NULL,
  `olg_received` text NOT NULL,
  `olg_sent` text NOT NULL,
  `olg_base_string` text NOT NULL,
  `olg_notes` text NOT NULL,
  `olg_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `olg_remote_ip` bigint(20) NOT NULL,
  PRIMARY KEY (`olg_id`),
  KEY `olg_osr_consumer_key` (`olg_osr_consumer_key`,`olg_id`),
  KEY `olg_ost_token` (`olg_ost_token`,`olg_id`),
  KEY `olg_ocr_consumer_key` (`olg_ocr_consumer_key`,`olg_id`),
  KEY `olg_oct_token` (`olg_oct_token`,`olg_id`),
  KEY `olg_usa_id_ref` (`olg_usa_id_ref`,`olg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_server_nonce`
--

CREATE TABLE IF NOT EXISTS `oauth_server_nonce` (
  `osn_id` int(11) NOT NULL AUTO_INCREMENT,
  `osn_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osn_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osn_timestamp` bigint(20) NOT NULL,
  `osn_nonce` varchar(80) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`osn_id`),
  UNIQUE KEY `osn_consumer_key` (`osn_consumer_key`,`osn_token`,`osn_timestamp`,`osn_nonce`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `oauth_server_nonce`
--

INSERT INTO `oauth_server_nonce` (`osn_id`, `osn_consumer_key`, `osn_token`, `osn_timestamp`, `osn_nonce`) VALUES
(19, '057a2cef52b5b1924dcde988958a58cd0534d2acb', '0', 1397567558, '534d30466330c'),
(20, '057a2cef52b5b1924dcde988958a58cd0534d2acb', '7ee56035fcb4a492d099c1e912404e4e0534d3046', 1397567578, '534d305aa58f9'),
(18, '057a2cef52b5b1924dcde988958a58cd0534d2acb', 'de3abd8d4eb1ba8eba27734b75f70b150534d2af6', 1397566319, '534d2b6f01429'),
(3, '076e8429fbb8c3524089b4177753768a0534be056', '0', 1397481664, '534be0c0dbd95'),
(5, '076e8429fbb8c3524089b4177753768a0534be056', '0', 1397481792, '534be1408d7c1'),
(6, '076e8429fbb8c3524089b4177753768a0534be056', '6b3320c335befd9c2ea56fd499cfc0fa0534be140', 1397481880, '534be1987a5c1'),
(4, '076e8429fbb8c3524089b4177753768a0534be056', 'ae4da2a56696cc8c6fa924d4b03438db0534be0c0', 1397481694, '534be0de05f7f'),
(1, '4398c27826bdb7763e18eb37d21ea99a0534bc3e1', '0', 1397480031, '534bda5fa18c3'),
(2, '4398c27826bdb7763e18eb37d21ea99a0534bc3e1', '0', 1397480575, '534bdc7f9da80'),
(21, '8fe0607d23fb14b34796e53dba4409890534d3536', '0', 1397568871, '534d3567c80eb'),
(22, '8fe0607d23fb14b34796e53dba4409890534d3536', '65ed42d357bde8c57ccdb85dfe1bb9890534d3567', 1397568919, '534d35972d64d'),
(13, '9683f7463e5062c7f84e79cbd9c5e4020534be560', '0', 1397484927, '534bed7fb50a6'),
(15, '9683f7463e5062c7f84e79cbd9c5e4020534be560', '0', 1397485192, '534bee88e9571'),
(14, '9683f7463e5062c7f84e79cbd9c5e4020534be560', '007bea4e099030a721243323c886c34a0534bed7f', 1397484955, '534bed9b8259f'),
(12, '9683f7463e5062c7f84e79cbd9c5e4020534be560', '53b661fb11cb4aaec803d7bbfe0deec90534be880', 1397483710, '534be8be16522'),
(8, '9683f7463e5062c7f84e79cbd9c5e4020534be560', 'eabd245f8b71275c81e0dd4786861de90534be5af', 1397482943, '534be5bf1c52c'),
(16, '9683f7463e5062c7f84e79cbd9c5e4020534be560', 'f3a30b5bde404e1e09883e67e9fef00a0534bee89', 1397485207, '534bee97ec43b'),
(10, '9683f7463e5062c7f84e79cbd9c5e4020534be560', 'fce9808efde4e5dcbe7265067894305a0534be67b', 1397483186, '534be6b276d55');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_server_registry`
--

CREATE TABLE IF NOT EXISTS `oauth_server_registry` (
  `osr_id` int(11) NOT NULL AUTO_INCREMENT,
  `osr_usa_id_ref` int(11) DEFAULT NULL,
  `osr_consumer_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osr_consumer_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `osr_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `osr_status` varchar(16) NOT NULL,
  `osr_requester_name` varchar(64) NOT NULL,
  `osr_requester_email` varchar(64) NOT NULL,
  `osr_callback_uri` varchar(255) NOT NULL,
  `osr_application_uri` varchar(255) NOT NULL,
  `osr_application_title` varchar(80) NOT NULL,
  `osr_application_descr` text NOT NULL,
  `osr_application_notes` text NOT NULL,
  `osr_application_type` varchar(20) NOT NULL,
  `osr_application_commercial` tinyint(1) NOT NULL DEFAULT '0',
  `osr_issue_date` datetime NOT NULL,
  `osr_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`osr_id`),
  UNIQUE KEY `osr_consumer_key` (`osr_consumer_key`),
  KEY `osr_usa_id_ref` (`osr_usa_id_ref`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=80 ;

--
-- Dumping data for table `oauth_server_registry`
--

INSERT INTO `oauth_server_registry` (`osr_id`, `osr_usa_id_ref`, `osr_consumer_key`, `osr_consumer_secret`, `osr_enabled`, `osr_status`, `osr_requester_name`, `osr_requester_email`, `osr_callback_uri`, `osr_application_uri`, `osr_application_title`, `osr_application_descr`, `osr_application_notes`, `osr_application_type`, `osr_application_commercial`, `osr_issue_date`, `osr_timestamp`) VALUES
(57, 1, '14fe13edc1c52737b3e7d50607e0dda60534b9356', '92251405db31f29223d35657cd6e6697', 1, 'active', 'Syed Ammar Tariq', 'syed1@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 13:20:46', '2014-04-14 07:50:46'),
(60, 4, 'fecc80cb403a262dfa7fc950b9b0b7310534bb01c', '4fc2b4dc13adebda93f98f4d22a468f5', 1, 'active', 'syed', 'syed2@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 15:23:32', '2014-04-14 09:53:32'),
(61, 5, '4398c27826bdb7763e18eb37d21ea99a0534bc3e1', 'cb54a8a99677f074d375c86c4e001c67', 1, 'active', 'Syed Ammar', 'syed3@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 16:47:53', '2014-04-14 11:17:53'),
(63, 0, '996a557802ce9f9ff8d8e7fa6ba788540534bdfc9', '8ed17d03ba5ba0cb3f75d95213d10d90', 1, 'active', 'syed', 'syed4@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 18:46:57', '2014-04-14 13:16:57'),
(64, 0, '076e8429fbb8c3524089b4177753768a0534be056', '665cd6ee77c9604009509695cf0478ab', 1, 'active', 'syed', 'syed5@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 18:49:18', '2014-04-14 13:19:18'),
(65, 0, '9683f7463e5062c7f84e79cbd9c5e4020534be560', '6383852f02a42ff7f447e24ac0125cdf', 1, 'active', 'syed6', 'syed6@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 19:10:48', '2014-04-14 13:40:48'),
(66, 0, 'b345e3c9940c207fac52a49a9c51351d0534bf100', 'dc7209619740fe35d1f51478ccb9971a', 1, 'active', 'syed', 'syed7@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 20:00:24', '2014-04-14 14:30:24'),
(67, 0, 'c3637aa18275449a2529afffe0e59c550534bf249', '56134c5e4c19822ccbe9899e69f477a8', 1, 'active', 'syed8', 'syed8@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 20:05:53', '2014-04-14 14:35:53'),
(68, 14, '96038f0db3b5db6d4c93830d3463120c0534bfd0d', '1ae8e1f1a6bc46629f774e9c7dd703ec', 1, 'active', 'syed', 'syed11@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 20:51:49', '2014-04-14 15:21:49'),
(70, 16, '04f1d8c82b3f196f97c715e80e2069730534c00cd', 'fc33ce885484cd618dbbd2efd3ee3739', 1, 'active', 'syed', 'syed12@gmail.com', '', '', '', '', '', '', 0, '2014-04-14 21:07:49', '2014-04-14 15:37:49'),
(74, 0, '4f9e2db0eaffb6dd563aeca61e5632fb0534ce90a', 'a29b3441435a9b77b230033da2d5e447', 1, 'active', 'syed ammar', 'syed65@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 08:08:42', '2014-04-15 08:08:42'),
(75, 0, 'c6e8fbac750033835b37281467e0825b0534d10d5', '0563bf5a731f0956334a1043d41b75af', 1, 'active', 'syed', 'syed76@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 10:58:29', '2014-04-15 10:58:29'),
(76, 0, 'f72b6d27d3b27c3a0078eed7363c74810534d12c2', '6dda4990542bf3f3bb7cac9b16e562b8', 1, 'active', 'hdsvgvsdg', 'syed.ammar@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 11:06:42', '2014-04-15 11:06:42'),
(77, 23, '057a2cef52b5b1924dcde988958a58cd0534d2acb', '0c550c2a0a2f9748dd2a3b77f81d3aa7', 1, 'active', 'syed', 'syed399@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 12:49:15', '2014-04-15 12:49:15'),
(78, 24, '8fe0607d23fb14b34796e53dba4409890534d3536', '9403ee52837900072c142c78cb8295d8', 1, 'active', 'tinku', 'tinku88@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 13:33:42', '2014-04-15 13:33:42'),
(79, 0, '3c0a301c35e145ae48b4730668110a4f0534d354e', 'd5adc1e1e4bea4d60b7f4c69533dd438', 1, 'active', 'tinku', 'tinku88@gmail.com', '', '', '', '', '', '', 0, '2014-04-15 13:34:06', '2014-04-15 13:34:06');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_server_token`
--

CREATE TABLE IF NOT EXISTS `oauth_server_token` (
  `ost_id` int(11) NOT NULL AUTO_INCREMENT,
  `ost_osr_id_ref` int(11) NOT NULL,
  `ost_usa_id_ref` int(11) NOT NULL,
  `ost_token` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ost_token_secret` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `ost_token_type` enum('request','access') DEFAULT NULL,
  `ost_authorized` tinyint(1) NOT NULL DEFAULT '0',
  `ost_referrer_host` varchar(128) NOT NULL DEFAULT '',
  `ost_token_ttl` datetime NOT NULL DEFAULT '9999-12-31 00:00:00',
  `ost_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ost_verifier` char(10) DEFAULT NULL,
  `ost_callback_url` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`ost_id`),
  UNIQUE KEY `ost_token` (`ost_token`),
  KEY `ost_osr_id_ref` (`ost_osr_id_ref`),
  KEY `ost_token_ttl` (`ost_token_ttl`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `oauth_server_token`
--

INSERT INTO `oauth_server_token` (`ost_id`, `ost_osr_id_ref`, `ost_usa_id_ref`, `ost_token`, `ost_token_secret`, `ost_token_type`, `ost_authorized`, `ost_referrer_host`, `ost_token_ttl`, `ost_timestamp`, `ost_verifier`, `ost_callback_url`) VALUES
(1, 61, 0, 'c63dcc9a6eccd5601c75160e2149c66d0534bda5f', '4a4d9d5d0d3ba63251882b940d43f143', 'request', 1, 'localhost', '2014-04-14 19:23:51', '2014-04-14 13:01:03', 'cf63547fad', 'oob'),
(2, 61, 1, '90fdc9f72714060d7e9a0ae76ecb2f080534bdc7f', 'f352901cd02db626fad885ea9aec5be4', 'request', 0, '', '2014-04-14 19:32:55', '2014-04-14 13:02:55', NULL, 'oob'),
(3, 64, 0, '280eec9731004f7c5ee7f7a3cad31caf0534be0de', '27858e9cc716d58913ae7ce4ae3556e2', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 13:21:34', '559b4c29ff', 'oob'),
(4, 64, 0, 'e84aec995742b0f59319ed2e7e74a9a80534be198', '0db54fdb44c4a718f60eba321d133436', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 13:24:40', '0a78d9f8a1', 'oob'),
(5, 65, 0, '2f1d1621410033cf57c0c72cf1f3b1ad0534be5bf', 'c05ad07ce53d7e94a17bf52b8189b27c', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 13:42:23', '40d3009700', 'oob'),
(6, 65, 0, 'f50285952a63eb6fa47c695fc0b0724a0534be6b2', '62058612fadf24d4394bf376ecf7dff6', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 13:46:26', '0de705dc7d', 'oob'),
(7, 65, 0, '9a5516d66897bd84dc7966a5fe08241d0534be8be', '7213df1f2cba0c8da4d8775fe7626449', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 13:55:10', '89d4402dc0', 'oob'),
(8, 65, 0, '6ff7e68d46529248a0c61413afb5b2960534bed9b', 'c1e48527025693df1731c667d073c417', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 14:15:55', 'c45bec92e6', 'oob'),
(9, 65, 0, '1f00915c21e83d79f0aba11624ad70850534bee98', '113bffae35d6c6eb8b0fdff199003ef9', 'access', 1, 'localhost', '9999-12-31 00:00:00', '2014-04-14 14:20:08', '4342309e4b', 'oob'),
(10, 77, 0, 'd599214ab5f8b2a594e4575de011927a0534d2b6f', '8fd8477dfbf2aee1463efd489582547c', 'access', 1, 'authpro.softobiz.net', '2014-04-22 12:51:59', '2014-04-15 12:51:59', '88673372f8', 'oob'),
(11, 77, 0, '3da6840d59a54b2bf85256efe27e80440534d305a', 'c08c9b40744ce8d461325aee72746ad5', 'access', 1, 'authpro.softobiz.net', '2014-04-22 13:12:58', '2014-04-15 13:12:58', '1d35ac58c2', 'oob'),
(12, 78, 0, '99913374351e4a569472ca095d420d030534d3597', '6fa871165d665f08ee8e1db6b323c4b5', 'access', 1, 'authpro.softobiz.net', '2014-04-22 13:35:19', '2014-04-15 13:35:19', '8aebe22cfc', 'oob');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `phone` varchar(11) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `created` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `password`, `email`, `created`) VALUES
(0, 'saif', '1234', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'saif@gmail.com', '2014-04-15'),
(1, 'Syed Ammar Tariq', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed1@gmail.com', '0000-00-00'),
(4, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed2@gmail.com', '0000-00-00'),
(5, 'Syed Ammar', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed3@gmail.com', '0000-00-00'),
(7, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed4@gmail.com', '2014-04-14'),
(8, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed5@gmail.com', '2014-04-14'),
(9, 'syed6', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed6@gmail.com', '2014-04-14'),
(10, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed7@gmail.com', '2014-04-14'),
(11, 'syed8', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed8@gmail.com', '2014-04-14'),
(12, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed9@gmail.com', '2014-04-14'),
(13, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed10@gmail.com', '2014-04-14'),
(14, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed11@gmail.com', '2014-04-14'),
(16, 'syed', '12344', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed12@gmail.com', '2014-04-14'),
(17, 'syed', '12345', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed.ammar5@gmail.com', '2014-04-15'),
(18, 'syed', '1234', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'girish99@gmail.com', '2014-04-15'),
(21, 'weebjfbhwevb', '1234', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed32@gmail.com', '2014-04-15'),
(23, 'syed', '1234', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'syed399@gmail.com', '2014-04-15'),
(24, 'tinku', '1234567', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'tinku88@gmail.com', '2014-04-15');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `oauth_consumer_token`
--
ALTER TABLE `oauth_consumer_token`
  ADD CONSTRAINT `oauth_consumer_token_ibfk_1` FOREIGN KEY (`oct_ocr_id_ref`) REFERENCES `oauth_consumer_registry` (`ocr_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `oauth_server_token`
--
ALTER TABLE `oauth_server_token`
  ADD CONSTRAINT `oauth_server_token_ibfk_1` FOREIGN KEY (`ost_osr_id_ref`) REFERENCES `oauth_server_registry` (`osr_id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

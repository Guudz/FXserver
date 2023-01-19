-- --------------------------------------------------------
-- Hôte:                         164.132.58.177
-- Version du serveur:           10.3.31-MariaDB-0+deb10u1 - Debian 10
-- SE du serveur:                debian-linux-gnu
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Listage de la structure de la table lslife. gang
CREATE TABLE IF NOT EXISTS `gang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `infos` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `poscoffre` longtext DEFAULT NULL,
  `posgarage` longtext DEFAULT NULL,
  `posvestiaire` longtext DEFAULT NULL,
  `posgaragedelete` longtext DEFAULT NULL,
  `blips` longtext DEFAULT NULL,
  `garage` longtext DEFAULT NULL,
  `posgaragespawn` longtext DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table lslife.gang : ~1 rows (environ)
/*!40000 ALTER TABLE `gang` DISABLE KEYS */;
/*!40000 ALTER TABLE `gang` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

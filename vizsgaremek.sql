-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Már 09. 17:15
-- Kiszolgáló verziója: 10.4.24-MariaDB
-- PHP verzió: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsgaremek`
--
CREATE DATABASE IF NOT EXISTS `vizsgaremek` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `vizsgaremek`;

DELIMITER $$
--
-- Eljárások
--
DROP PROCEDURE IF EXISTS `add_new_address`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_address` (IN `id_in` INT(11), IN `county_in` VARCHAR(200), IN `city_in` VARCHAR(200), IN `zip_code_in` INT(11))   INSERT INTO address (address.id, address.county, address.city, address.zip_code) VALUES (id_in, county_in, city_in, zip_code_in)$$

DROP PROCEDURE IF EXISTS `add_password_replacement`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_password_replacement` (IN `email_in` VARCHAR(200), OUT `token_out` VARCHAR(256))   BEGIN

UPDATE password_replacement SET password_replacement.used = 1 WHERE password_replacement.email = email_in;
INSERT INTO password_replacement (password_replacement.email, password_replacement.token, password_replacement.token_expire) VALUES (email_in,uuid(),(DATE_ADD(NOW(),INTERVAL 10 MINUTE)));
SELECT password_replacement.token INTO token_out FROM password_replacement WHERE password_replacement.id = LAST_INSERT_ID();
END$$

DROP PROCEDURE IF EXISTS `add_picture`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_picture` (IN `ad_id_in` INT, IN `picture_url_in` VARCHAR(200) CHARSET utf8)   INSERT INTO picture (picture.ad_id, picture.picture_url) VALUES (ad_id_in, picture_url_in)$$

DROP PROCEDURE IF EXISTS `change_password`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_password` (IN `password_in` TEXT, IN `email_in` TEXT, IN `token_in` TEXT)   BEGIN

UPDATE user SET user.password = SHA1(password_in) WHERE user.email = email_in;

UPDATE password_replacement SET password_replacement.used = 1 WHERE password_replacement.token = token_in;

END$$

DROP PROCEDURE IF EXISTS `check_email_unique`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_email_unique` (OUT `result` INT, IN `email_in` VARCHAR(200))   SELECT COUNT(user.id) into result FROM user WHERE user.email = email_in$$

DROP PROCEDURE IF EXISTS `create_new_ad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_ad` (IN `user_id_in` INT(11), IN `species_of_animal_in` VARCHAR(200), IN `title_in` VARCHAR(200), IN `description_in` VARCHAR(2000), IN `date_in` DATE, IN `lost_or_fund_in` VARCHAR(200))   INSERT INTO animal_ad (animal_ad.user_id,animal_ad.species_of_animal,animal_ad.title,animal_ad.description,animal_ad.date,animal_ad.date_of_add,animal_ad.lost_or_fund) VALUES (user_id_in, species_of_animal_in, title_in, description_in, date_in, CURRENT_DATE(), lost_or_fund_in)$$

DROP PROCEDURE IF EXISTS `delete_ad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_ad` (IN `id_in` INT(11))   BEGIN
CALL delete_address(id_in);
DELETE FROM picture WHERE picture.ad_id = id_in;
DELETE FROM animal_ad WHERE animal_ad.id = id_in;
END$$

DROP PROCEDURE IF EXISTS `delete_address`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address` (IN `id_in` INT)   DELETE FROM address WHERE address.id = id_in$$

DROP PROCEDURE IF EXISTS `delete_picture`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_picture` (IN `id_in` INT)   delete FROM picture WHERE picture.id = id_in$$

DROP PROCEDURE IF EXISTS `delete_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `id_in` INT)   delete FROM user WHERE user.id = id_in$$

DROP PROCEDURE IF EXISTS `get_all_ads`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_ads` ()   SELECT * FROM animal_ad$$

DROP PROCEDURE IF EXISTS `get_all_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_user` ()   SELECT * FROM user$$

DROP PROCEDURE IF EXISTS `Registration`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Registration` (IN `first_name_in` VARCHAR(200), IN `last_name_in` VARCHAR(200), IN `email_in` VARCHAR(200), IN `username_in` VARCHAR(200), IN `password_in` VARCHAR(200), IN `phone_number_in` VARCHAR(20))   INSERT INTO user (user.`first_name`, user.`last_name`, user.`email`, user.`username`, user.`password`, user.`phone_number`,user.`date_of_registration`) VALUES (first_name_in, last_name_in, email_in, username_in, SHA1(password_in), phone_number_in, CURRENT_DATE())$$

DROP PROCEDURE IF EXISTS `search_ad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_ad` (IN `searched_word1` VARCHAR(200), IN `searched_word2` VARCHAR(200))   BEGIN
IF searched_word1 <> '' AND searched_word2 = '' THEN
SELECT animal_ad.id, user_id, species_of_animal, title, description, `date`, date_of_add, lost_or_fund, county, city, zip_code FROM animal_ad LEFT JOIN address ON animal_ad.id = address.id WHERE animal_ad.species_of_animal = searched_word1 OR animal_ad.title = searched_word1 OR animal_ad.date = searched_word1 OR animal_ad.date_of_add = searched_word1 OR animal_ad.lost_or_fund = searched_word1 OR address.county = searched_word1 OR address.city = searched_word1 OR address.zip_code = searched_word1;
ELSEIF searched_word1 <> '' AND searched_word2 <> '' THEN
SELECT animal_ad.id, user_id, species_of_animal, title, description, `date`, date_of_add, lost_or_fund, county, city, zip_code FROM animal_ad LEFT JOIN address ON animal_ad.id = address.id WHERE (animal_ad.species_of_animal = searched_word1 OR animal_ad.title = searched_word1 OR animal_ad.date = searched_word1 OR animal_ad.date_of_add = searched_word1 OR animal_ad.lost_or_fund = searched_word1 OR address.county = searched_word1 OR address.city = searched_word1 OR address.zip_code = searched_word1) AND (animal_ad.species_of_animal = searched_word2 OR animal_ad.title = searched_word2 OR animal_ad.date = searched_word2 OR animal_ad.date_of_add = searched_word2 OR animal_ad.lost_or_fund = searched_word2 OR address.county = searched_word2 OR address.city = searched_word2 OR address.zip_code = searched_word2);


END IF;
END$$

DROP PROCEDURE IF EXISTS `update_ad`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ad` (IN `id_in` INT(11), IN `title_in` VARCHAR(200), IN `description_in` VARCHAR(2000))   UPDATE animal_ad SET animal_ad.title = title_in, animal_ad.description = description_in WHERE animal_ad.id = id_in$$

DROP PROCEDURE IF EXISTS `update_address`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address` (IN `id_in` INT, IN `county_in` VARCHAR(200), IN `city_in` VARCHAR(200), IN `zip_code_in` INT)   UPDATE address SET address.county = county_in, address.city = city_in, address.zip_code = zip_code_in WHERE address.id = id_in$$

DROP PROCEDURE IF EXISTS `update_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (IN `id_in` INT(11), IN `email_in` VARCHAR(200), IN `username_in` VARCHAR(200), IN `password_in` VARCHAR(200), IN `phone_number_in` VARCHAR(200))   UPDATE user SET user.email = email_in, user.username=username_in, user.password = password_in, user.phone_number = phone_number_in WHERE user.id = id_in$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `county` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `city` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `zip_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `address`
--

INSERT INTO `address` (`id`, `county`, `city`, `zip_code`) VALUES
(1, 'Baranya', 'Pécs', 7622),
(2, 'Baranya', 'Nagyharsány', 7822);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animal_ad`
--

DROP TABLE IF EXISTS `animal_ad`;
CREATE TABLE `animal_ad` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `species_of_animal` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `title` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `description` varchar(2000) COLLATE utf8_hungarian_ci NOT NULL,
  `date` date NOT NULL,
  `date_of_add` date NOT NULL,
  `lost_or_fund` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `animal_ad`
--

INSERT INTO `animal_ad` (`id`, `user_id`, `species_of_animal`, `title`, `description`, `date`, `date_of_add`, `lost_or_fund`) VALUES
(1, 1, 'kutya', 'Elveszett a kutyám', 'A kutyám, Joe aki egy labrador elveszett Szészcheny utcában. Nagyon hiányzik. Kérlek, segítsetek. zett ', '2023-02-04', '2023-02-15', 'elveszett'),
(2, 1, 'cica', 'Elveszett cica', 'nagyon elveszett a cica', '2023-02-10', '2023-02-15', 'elveszett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `password_replacement`
--

DROP TABLE IF EXISTS `password_replacement`;
CREATE TABLE `password_replacement` (
  `id` int(11) NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `token` varchar(256) COLLATE utf8_hungarian_ci NOT NULL,
  `token_expire` datetime NOT NULL,
  `used` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `picture`
--

DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `picture_url` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `last_name` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `username` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `password` varchar(200) COLLATE utf8_hungarian_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8_hungarian_ci NOT NULL,
  `date_of_registration` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `phone_number`, `date_of_registration`) VALUES
(1, 'Tivadar', 'Teszt', 'tesztes@freemail.hu', 'teszttivi001', 'tivadar01', '+36 30 222 1111', '2023-02-02'),
(3, 'Joe', 'Mama', 'Mama', 'joe111', '9ee036287b4cfbcfa3b5bbfcf92d46eb5e75df96', '+36 70 111 0100 ', '2023-03-09');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `animal_ad`
--
ALTER TABLE `animal_ad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `password_replacement`
--
ALTER TABLE `password_replacement`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ad_id` (`ad_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `animal_ad`
--
ALTER TABLE `animal_ad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `password_replacement`
--
ALTER TABLE `password_replacement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id`) REFERENCES `animal_ad` (`id`);

--
-- Megkötések a táblához `animal_ad`
--
ALTER TABLE `animal_ad`
  ADD CONSTRAINT `animal_ad_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Megkötések a táblához `picture`
--
ALTER TABLE `picture`
  ADD CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `animal_ad` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

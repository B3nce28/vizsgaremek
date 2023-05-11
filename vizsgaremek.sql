-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Máj 11. 16:25
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_address` (IN `county_in` VARCHAR(200), IN `city_in` VARCHAR(200), IN `zip_code_in` INT(11))   INSERT INTO address ( address.county, address.city, address.zip_code) VALUES ( county_in, city_in, zip_code_in)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_password_replacement` (IN `email_in` VARCHAR(200), OUT `token_out` VARCHAR(256))   BEGIN

UPDATE password_replacement SET password_replacement.used = 1 WHERE password_replacement.email = email_in;
INSERT INTO password_replacement (password_replacement.email, password_replacement.token, password_replacement.token_expire) VALUES (email_in,uuid(),(DATE_ADD(NOW(),INTERVAL 10 MINUTE)));
SELECT password_replacement.token INTO token_out FROM password_replacement WHERE password_replacement.id = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `add_picture` (IN `ad_id_in` INT, IN `picture_url_in` VARCHAR(200) CHARSET utf8)   INSERT INTO picture (picture.ad_id, picture.picture_url) VALUES (ad_id_in, picture_url_in)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `change_password` (IN `password_in` TEXT, IN `email_in` TEXT, IN `token_in` TEXT)   BEGIN

UPDATE user SET user.password = SHA1(password_in) WHERE user.email = email_in;

UPDATE password_replacement SET password_replacement.used = 1 WHERE password_replacement.token = token_in;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_email_unique` (OUT `result` INT, IN `email_in` VARCHAR(200))   SELECT COUNT(user.id) into result FROM user WHERE user.email = email_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_ad` (IN `user_id_in` INT(11), IN `species_of_animal_in` VARCHAR(200), IN `title_in` VARCHAR(200), IN `description_in` VARCHAR(2000), IN `date_in` DATE, IN `lost_or_fund_in` VARCHAR(200), IN `county_in` VARCHAR(200), IN `city_in` VARCHAR(200), IN `zip_code_in` INT(11))   BEGIN
DECLARE addressId int(11);
CALL `add_new_address`(county_in,city_in,zip_code_in);
SELECT LAST_Insert_Id() INTO addressId;
INSERT INTO animal_ad (animal_ad.user_id,animal_ad.address_id,animal_ad.species_of_animal,animal_ad.title,animal_ad.description,animal_ad.date,animal_ad.date_of_add,animal_ad.lost_or_fund) VALUES (user_id_in,addressId ,species_of_animal_in, title_in, description_in, date_in, CURRENT_DATE(), lost_or_fund_in);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_ad` (IN `id_in` INT(11))   BEGIN
DELETE FROM picture WHERE picture.ad_id = id_in;
DELETE FROM animal_ad WHERE animal_ad.id = id_in;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_address` (IN `id_in` INT)   DELETE FROM address WHERE address.id = id_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_picture` (IN `id_in` INT)   delete FROM picture WHERE picture.id = id_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user` (IN `id_in` INT)   delete FROM user WHERE user.id = id_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_address` ()   SELECT * FROM address$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_ads` ()   SELECT animal_ad.*, address.county, address.city, address.zip_code, user.email, user.username FROM animal_ad LEFT JOIN address ON animal_ad.address_id = address.id LEFT JOIN user ON animal_ad.user_id = user.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_user` ()   SELECT * FROM user$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `email_in` VARCHAR(200), IN `password_in` VARCHAR(200))   BEGIN
 SELECT * FROM user WHERE user.email = email_in AND user.password = SHA1(password_in);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Registration` (IN `first_name_in` VARCHAR(200), IN `last_name_in` VARCHAR(200), IN `email_in` VARCHAR(200), IN `username_in` VARCHAR(200), IN `password_in` VARCHAR(200), IN `phone_number_in` VARCHAR(20))   INSERT INTO user (user.`first_name`, user.`last_name`, user.`email`, user.`username`, user.`password`, user.`phone_number`,user.`date_of_registration`) VALUES (first_name_in, last_name_in, email_in, username_in, SHA1(password_in), phone_number_in, CURRENT_DATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `search_ad` (IN `searched_word1` VARCHAR(200), IN `searched_word2` VARCHAR(200))   BEGIN
IF searched_word1 <> '' AND searched_word2 = '' THEN
SELECT animal_ad.*, address.county, address.city, address.zip_code, user.email, user.username FROM animal_ad LEFT JOIN address ON animal_ad.address_id = address.id LEFT JOIN user ON animal_ad.user_id = user.id WHERE animal_ad.species_of_animal = searched_word1 OR animal_ad.title = searched_word1 OR animal_ad.date = searched_word1 OR animal_ad.date_of_add = searched_word1 OR animal_ad.lost_or_fund = searched_word1 OR address.county = searched_word1 OR address.city = searched_word1 OR address.zip_code = searched_word1;
ELSEIF searched_word1 <> '' AND searched_word2 <> '' THEN
SELECT animal_ad.*, address.county, address.city, address.zip_code, user.email, user.username FROM animal_ad LEFT JOIN address ON animal_ad.address_id = address.id LEFT JOIN user ON animal_ad.user_id = user.id WHERE (animal_ad.species_of_animal = searched_word1 OR animal_ad.title = searched_word1 OR animal_ad.date = searched_word1 OR animal_ad.date_of_add = searched_word1 OR animal_ad.lost_or_fund = searched_word1 OR address.county = searched_word1 OR address.city = searched_word1 OR address.zip_code = searched_word1) AND (animal_ad.species_of_animal = searched_word2 OR animal_ad.title = searched_word2 OR animal_ad.date = searched_word2 OR animal_ad.date_of_add = searched_word2 OR animal_ad.lost_or_fund = searched_word2 OR address.county = searched_word2 OR address.city = searched_word2 OR address.zip_code = searched_word2);


END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_ad` (IN `id_in` INT(11), IN `title_in` VARCHAR(200), IN `description_in` VARCHAR(2000))   UPDATE animal_ad SET animal_ad.title = title_in, animal_ad.description = description_in WHERE animal_ad.id = id_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_address` (IN `id_in` INT, IN `county_in` VARCHAR(200), IN `city_in` VARCHAR(200), IN `zip_code_in` INT)   UPDATE address SET address.county = county_in, address.city = city_in, address.zip_code = zip_code_in WHERE address.id = id_in$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (IN `id_in` INT(11), IN `email_in` VARCHAR(200), IN `username_in` VARCHAR(200), IN `password_in` VARCHAR(200), IN `phone_number_in` VARCHAR(200))   UPDATE user SET user.email = email_in, user.username=username_in, user.password = password_in, user.phone_number = phone_number_in WHERE user.id = id_in$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `address`
--

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
(5, 'Baranya', 'Nagyharsány', 7822),
(7, 'Baranya', 'Mohács', 7700),
(8, 'Baranya', 'Kisharsány', 7800),
(9, 'Baranya', 'Mohács', 7700),
(10, 'Baranya', 'Mohács', 7700);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animal_ad`
--

CREATE TABLE `animal_ad` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
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

INSERT INTO `animal_ad` (`id`, `user_id`, `address_id`, `species_of_animal`, `title`, `description`, `date`, `date_of_add`, `lost_or_fund`) VALUES
(7, 3, 1, 'ló', 'Talált ló az utcán', 'A nyílt utcán találtam egy barna lovat.', '2023-03-28', '2023-03-28', 'talált'),
(8, 3, 1, 'ló', 'Talált Kanca', 'Találtam egy fehér kancát a járdán.', '2023-03-28', '2023-03-29', 'talált'),
(9, 11, 1, 'macska', 'Talált macska', 'Fajtiszta macskát találtam.', '2023-04-24', '2023-04-26', 'talált'),
(10, 11, 1, 'papagáj', 'Elveszett papagáj', 'Elveszett a papagájom tegnap este.', '2023-05-03', '2023-05-04', 'elveszett'),
(11, 11, 1, 'macska', 'Talált macska', 'Talált macska, egészséges.', '2023-05-01', '2023-05-04', 'talált'),
(12, 11, 7, 'macska', 'Elveszett Lujza macska', 'Elveszett lujza nevü cicám.', '2023-05-01', '2023-05-07', 'elveszett'),
(13, 10, 5, 'kutya', 'Elveszet kiskutya.', 'Elveszett Pötyi nevü kiskutyám.', '2023-05-06', '2023-05-07', 'elveszett'),
(14, 3, 9, 'kutya', 'Elveszett a kutyám nagyon', 'A kutyám, Joe aki egy labrador elveszett Szészcheny utcában. Nagyon hiányzik. Nagyon szereti a tejet. Kérlek, segítsetek aaaaa. ', '2023-05-03', '2023-05-11', 'elveszett'),
(15, 11, 10, 'macska', 'Talált macska', 'Talált macska, egészséges.', '2023-05-01', '2023-05-11', 'talált');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `password_replacement`
--

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

CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `picture_url` varchar(200) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

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
(3, 'Joe', 'Mama', 'Mama', 'joe111', '9ee036287b4cfbcfa3b5bbfcf92d46eb5e75df96', '+36 70 111 0100 ', '2023-03-09'),
(4, 'Béla', 'Kovács', 'Kovács', 'bela1', '2f712f2b4c17b108f5961465d36a19c98301c173', '123456789', '2023-03-10'),
(10, 'Anna', 'Példa', 'anna10@gmail.com', 'annapelda1', 'd6a9450dc08555d6ecfaf7162e5267f401e6dd9a', '+36 70 111 01111 ', '2023-04-23'),
(11, 'Alma', 'Alma', 'alma1@gmail.com', 'alma1', '89afb985f6b6d698a67d4531101b2c2daf0562a5', '+36 70 100 01111 ', '2023-04-26'),
(12, 'Körte', 'Körte', 'körte1@gmail.com', 'körte1', '0346d58200fc83420b9b3ced5a64c72fe703ecb5', '+36 30 222 1222', '2023-04-26');

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`address_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `animal_ad`
--
ALTER TABLE `animal_ad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT a táblához `password_replacement`
--
ALTER TABLE `password_replacement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `animal_ad`
--
ALTER TABLE `animal_ad`
  ADD CONSTRAINT `animal_ad_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `animal_ad_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`);

--
-- Megkötések a táblához `picture`
--
ALTER TABLE `picture`
  ADD CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `animal_ad` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

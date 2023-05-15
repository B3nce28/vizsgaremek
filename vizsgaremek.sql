-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Máj 15. 13:52
-- Kiszolgáló verziója: 10.4.27-MariaDB
-- PHP verzió: 8.1.12

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_user` (IN `id_in` INT(11), IN `email_in` VARCHAR(200), IN `username_in` VARCHAR(200), IN `password_in` VARCHAR(200), IN `phone_number_in` VARCHAR(200))   UPDATE user SET user.email = email_in, user.username=username_in, user.password = SHA1(password_in), user.phone_number = phone_number_in WHERE user.id = id_in$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `county` varchar(200) NOT NULL,
  `city` varchar(200) NOT NULL,
  `zip_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `address`
--

INSERT INTO `address` (`id`, `county`, `city`, `zip_code`) VALUES
(19, 'Baranya', 'Pécs', 7630),
(20, 'Baranya', 'Mohács', 7700),
(21, 'Baranya', 'Nagyharsány', 7822),
(22, 'Baranya', 'Kistapolca', 7823),
(23, 'Borsod-Abaúj-Zemplén', 'Miskolc', 3500),
(24, 'Pest', 'Budapest', 1011),
(25, 'Pest', 'Budapest', 1014);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `animal_ad`
--

CREATE TABLE `animal_ad` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `species_of_animal` varchar(200) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `date` date NOT NULL,
  `date_of_add` date NOT NULL,
  `lost_or_fund` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `animal_ad`
--

INSERT INTO `animal_ad` (`id`, `user_id`, `address_id`, `species_of_animal`, `title`, `description`, `date`, `date_of_add`, `lost_or_fund`) VALUES
(24, 1, 19, 'Kutya', 'Bandi kutya eltűnt', '2 éves kutyám Bandi pár napja elszökött miközben elmentünk sétálni. Egy fekete, kan, kevert kutyus.', '2023-05-11', '2023-05-15', 'elveszett'),
(25, 15, 20, 'Macska', 'Talált kiscica', 'Találtám egy tarka kiscicát a házam előtt, egészséges.', '2023-05-01', '2023-05-15', 'talált'),
(26, 15, 21, 'Macska', 'Eveszett a cicám', 'Eveszett a fajtiszta kandúr perzsa macskám, Fáraó. Szürke szinű és nagyon barátságos.', '2023-05-15', '2023-05-15', 'elveszett'),
(27, 16, 22, 'Tehén', 'Eveszett a tehenem borjával', 'Eltűnt tegnap este milka nevű tehenem kis borjával együtt. Neve ellenében nem lila színű hanem fekete fehér', '2023-05-15', '2023-05-15', 'elveszett'),
(28, 17, 23, 'Kutya', 'Sérült tacskó', 'Találtam egy fekete kis tacskót. Van rajta egy fehér nyakörv, de azonosító nem található rajta. A bal hátsó lábán egy kisebb vágott sebb van', '2023-05-13', '2023-05-15', 'talált'),
(29, 19, 24, 'Hörcsög', 'Öreg hörcsög elszökött', 'A már több éves hörcsögöm kimászott a véletlen nyitva hagyott ajtón. Barna színű, viszonylag nagy, de nagyon lomha teremtmény. Ha valaki látja kérem írjon.', '2023-05-14', '2023-05-15', 'elveszett'),
(30, 20, 25, 'Egér', 'Elveszett egérke', 'Elveszett az óriási kisegér. Hatalmas kisegér lába van, hatalmas kisegér arca van, hatalmas kisegér mája. Mármint óriási kisegér értelmezési tartományban hatalmas, tehát egy közepes gnú még mindig sokkal nagyobb.', '2023-05-14', '2023-05-15', 'elveszett');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `picture`
--

CREATE TABLE `picture` (
  `id` int(11) NOT NULL,
  `ad_id` int(11) NOT NULL,
  `picture_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `date_of_registration` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `phone_number`, `date_of_registration`) VALUES
(1, 'Tivadar', 'Teszt', 'tesztes@freemail.hu', 'Ttivadar5', '71931ce13d6cc32d0c82e16ab8c19eb196475801', '+36 70 111 0100 ', '2023-05-15'),
(15, 'Péter', 'Próba', 'petike@gmail.com', 'Petivagyok20', '0dbe5ab58ca87a4bcbfe7be2918ecdf1b22836b9', '+36 30 111 0100 ', '2023-05-15'),
(16, 'Sándor', 'Kiss', 'sanyika70@gmail.com', 'Smintsándor', 'aca0365afa91b0d4ce66434f863ee8045f8c2789', '+36 30 254 0100 ', '2023-05-15'),
(17, 'László', 'Kovács', 'kovácslaci05@gmail.com', 'lacika', '68b7a10b7500b4c41b5a35716daaa89a10c301e7', '+36 20 254 0100 ', '2023-05-15'),
(18, 'Judit', 'Nagy', 'jucuska@citromail.hu', 'jutka_néni', '4a752229d915f8c2c8f4d689d8efec5d1f13276c', '+36 20 254 3480 ', '2023-05-15'),
(19, 'Elek', 'Vicc', 'vicces@gmail.com', 'megviccellek', 'edb8411b326bfe8f3fdc894db3ec4062b937b3ef', '+36 30 554 3420 ', '2023-05-15'),
(20, 'Pál', 'Bekre', 'palivagyok@gmail.com', 'pali8', '695db044a416f8b1308701f3db8cd7015b605568', '+36 70 954 3420 ', '2023-05-15'),
(21, 'Márta', 'Szabó', 'mártika@gmail.com', 'mártuska', '355c9248fb6e18bd382f96e23ae076a24f7dc0c6', '+36 20 254 3720 ', '2023-05-15');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `animal_ad`
--
ALTER TABLE `animal_ad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `picture`
--
ALTER TABLE `picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-04-2026 a las 00:12:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbcs`
--
CREATE DATABASE IF NOT EXISTS `dbcs` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `dbcs`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `weapon` varchar(100) NOT NULL,
  `skin` varchar(100) NOT NULL,
  `rarity` varchar(100) NOT NULL,
  `floatt` varchar(100) NOT NULL,
  `price` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventory`
--

INSERT INTO `inventory` (`id`, `id_user`, `weapon`, `skin`, `rarity`, `floatt`, `price`) VALUES
(2, 4, 'AUG', 'Akihabara Accept', 'Covert', '0.101', '100.01'),
(7, 4, 'AK-47', 'Aquamarine Revenge', 'Covert', '0.001', '0.01'),
(10, 4, 'AK-47', 'Asiimov', 'Covert', '0.001', '0.01'),
(13, 4, 'AUG', 'Plague', 'Mil-Spec', '0.001', '0.06'),
(15, 14, 'AK-47', 'Asiimov', 'Covert', '1', '90');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(4, 'juan', 'juan@gmail.com', '$2b$10$t3RhyRKs2n2hO3vKXasni.S.Ge7exiWnG9kiClTTOUWaXN/2VZVKW'),
(7, 'as', 'as', '$2b$10$5qFyScAgc88BQmzAnlvX6./YfOD15eY5i.RAnl4ZZdzw6sSDnTdlu'),
(13, 'a', 'a', '$2b$10$MKswQgcm/FElGCnNkj/BCuQc54nDDp4d/cEjSwbgvD54cmwEGlTWK'),
(14, 'Juanito', 'juan', '$2b$10$JDdZGoGFk1omzVT2.rW0C.UJ35sQ5/hbrgf8dxVXeIYMXDAIYUfpK');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

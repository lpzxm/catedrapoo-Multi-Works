-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-05-2025 a las 00:51:28
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `multiworks_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion`
--

CREATE TABLE `asignacion` (
  `id` varchar(36) NOT NULL,
  `cotizacion_id` varchar(36) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `empleado_id` varchar(36) NOT NULL,
  `area_asignada` varchar(50) NOT NULL,
  `costo_por_hora` decimal(10,2) NOT NULL,
  `fecha_hora_inicio` datetime NOT NULL,
  `fecha_hora_fin` datetime NOT NULL,
  `horas_aproximadas` decimal(5,2) NOT NULL,
  `incremento_extra` decimal(5,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `tipo_persona` enum('Natural','Juridica') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `creado_por` varchar(50) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fecha_inactivacion` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombre`, `documento`, `tipo_persona`, `telefono`, `email`, `direccion`, `estado`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`, `fecha_inactivacion`) VALUES
('CLI-93BFF5A6', 'testeooooo', '23423423we', 'Natural', '7123-9800', 'testeo@gmail.comm', 'sdfdsfswerewr', 'Inactivo', NULL, '2025-05-12 01:40:07', '2025-05-12 02:52:32', '2025-05-12 02:52:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `id` varchar(36) NOT NULL,
  `cliente_id` varchar(36) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_tentativa_inicio` date NOT NULL,
  `fecha_tentativa_fin` date NOT NULL,
  `costos_adicionales` decimal(10,2) DEFAULT '0.00',
  `estado` enum('En proceso','Finalizada') DEFAULT 'En proceso'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`id`, `cliente_id`, `fecha_creacion`, `fecha_tentativa_inicio`, `fecha_tentativa_fin`, `costos_adicionales`, `estado`) VALUES
('CLI-099C601C', 'CLI-93BFF5A6', '2025-05-12 02:22:21', '2025-05-01', '2025-05-31', 320.00, 'En proceso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id` varchar(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `tipo_persona` enum('Natural','Juridica') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo_contratacion` enum('Permanente','Por Horas') NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `creado_por` varchar(50) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_actualizacion` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fecha_inactivacion` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id`, `nombre`, `documento`, `tipo_persona`, `tipo_contratacion`, `telefono`, `email`, `direccion`, `estado`, `creado_por`, `fecha_creacion`, `fecha_actualizacion`, `fecha_inactivacion`) VALUES
('CLI-FBA0119C', 'testeoooooew', '23423423wesadf', 'Juridica', 'Por Horas', '61031092', 'testeo@gmail.com', 'ewrewrdsf', 'Activo', NULL, '2025-05-12 02:10:53', '2025-05-12 02:12:44', '2025-05-12 02:12:41');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subtarea`
--

CREATE TABLE `subtarea` (
  `id` varchar(36) NOT NULL,
  `asignacion_id` varchar(36) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text,
  `completada` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cotizacion_id` (`cotizacion_id`),
  ADD KEY `empleado_id` (`empleado_id`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documento` (`documento`);

--
-- Indices de la tabla `subtarea`
--
ALTER TABLE `subtarea`
  ADD PRIMARY KEY (`id`),
  ADD KEY `asignacion_id` (`asignacion_id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignacion`
--
ALTER TABLE `asignacion`
  ADD CONSTRAINT `asignacion_ibfk_1` FOREIGN KEY (`cotizacion_id`) REFERENCES `cotizacion` (`id`),
  ADD CONSTRAINT `asignacion_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `empleado` (`id`);

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD CONSTRAINT `cotizacion_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`);

--
-- Filtros para la tabla `subtarea`
--
ALTER TABLE `subtarea`
  ADD CONSTRAINT `subtarea_ibfk_1` FOREIGN KEY (`asignacion_id`) REFERENCES `asignacion` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

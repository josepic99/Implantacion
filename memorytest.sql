-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-05-2021 a las 02:39:34
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `memorytest`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

CREATE TABLE `imagenes` (
  `idImagenes` int(11) UNSIGNED NOT NULL,
  `secuencias_idSecuencias` int(11) UNSIGNED NOT NULL,
  `ruta` varchar(45) DEFAULT NULL COMMENT 'donde está almacenada la imagen.',
  `resolucion` varchar(9) DEFAULT NULL COMMENT '999x999 resolucion maxima'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `investigador`
--

CREATE TABLE `investigador` (
  `ifk_idInvestigador_login` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `apellidoPaterno` varchar(40) DEFAULT NULL,
  `apellidoMaterno` varchar(40) DEFAULT NULL,
  `telefonoDeContacto` varchar(20) DEFAULT NULL COMMENT 'No el personal, el del trabajo\n+52 (646) 123 44 55\n19 caracteres contando espacios.',
  `institucion` varchar(145) NOT NULL COMMENT 'Debe comprobarse que exista',
  `direcciónDeInstitucion` varchar(125) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL COMMENT 'En donde trabaja',
  `especialidad` varchar(45) DEFAULT NULL COMMENT 'En donde trabaja',
  `correo` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `investigador`
--

INSERT INTO `investigador` (`ifk_idInvestigador_login`, `nombre`, `apellidoPaterno`, `apellidoMaterno`, `telefonoDeContacto`, `institucion`, `direcciónDeInstitucion`, `ciudad`, `especialidad`, `correo`) VALUES
(20, 'Oscar1', NULL, NULL, NULL, 'UABC1', NULL, NULL, NULL, 'prueba@prueba1.com'),
(21, 'Oscar2', NULL, NULL, NULL, 'UABC2', NULL, NULL, NULL, 'prueba@prueba2.com'),
(22, 'Picos1', NULL, NULL, NULL, 'UABC1', NULL, NULL, NULL, 'prueba@prueba3.com'),
(23, 'Alexander', NULL, NULL, NULL, 'UABC4', NULL, NULL, NULL, 'prueba@prueba4.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `investigador_login`
--

CREATE TABLE `investigador_login` (
  `idInvestigador_login` int(11) UNSIGNED NOT NULL,
  `pasword` blob NOT NULL COMMENT 'contraseña cifrada con AES',
  `correo` varchar(80) NOT NULL COMMENT 'correo electronico, obligatorio',
  `ultimaConexion` datetime DEFAULT NULL COMMENT 'para actualizar INSERT INTO investigador_login(ultimaConexion) VALUES (NOW());',
  `nombre` varchar(45) NOT NULL DEFAULT '.',
  `institucion` varchar(145) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `investigador_login`
--

INSERT INTO `investigador_login` (`idInvestigador_login`, `pasword`, `correo`, `ultimaConexion`, `nombre`, `institucion`) VALUES
(20, 0x3e3d5d07c896c4c982297e108c86a9c627142cf21c4f803e63ea84e1752f92979631391456d533fd0d227cf6643c592245930d659dd5e377bd7f20273b3d20c4, 'prueba@prueba1.com', '2021-05-09 17:36:29', 'Oscar1', 'UABC1'),
(21, 0x911a22a060f437247041fe9646e6292733ae6a2432aa389a923910b214844a07e715f869752b9b97a067d612618e4c952c9705e1556d01128583ba699f1b0dff, 'prueba@prueba2.com', '2021-05-09 17:36:55', 'Oscar2', 'UABC2'),
(22, 0xb11f447ccf52269e4dafe2fdb1eaca99844202e3bc9085a9313b31b11dfc7f5502b4abf0b0236eb204ccbe85048ac290cfafaa2c4864753ec104b9deb0fb39c0, 'prueba@prueba3.com', '2021-05-09 17:37:10', 'Picos1', 'UABC1'),
(23, 0xed8e17f6b13717fc5d64c264b181719e6cec960e90b3328e082c7515fad13fc9a9b83c76a469fba9ec30e42d1c376c8eeba70ee8e8fc4dc9a776e23a426170d5, 'prueba@prueba4.com', '2021-05-09 17:37:33', 'Alexander', 'UABC4');

--
-- Disparadores `investigador_login`
--
DELIMITER $$
CREATE TRIGGER `paseDatos` AFTER INSERT ON `investigador_login` FOR EACH ROW INSERT INTO investigador(
ifk_idInvestigador_login,
    nombre,
    institucion,
    correo)
VALUES(new.idInvestigador_login,
       new.nombre, 
       new.institucion, 
       new.correo)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `paciente_login_idPaciente_login` int(11) UNSIGNED NOT NULL,
  `investigador_ifk_idInvestigador_login` int(11) UNSIGNED NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidoPaterno` varchar(50) DEFAULT NULL,
  `apellidoMaterno` varchar(50) DEFAULT NULL,
  `correoE` varchar(80) NOT NULL,
  `telefonoDeContacto` varchar(20) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `investigador_idInvestigador` int(11) NOT NULL COMMENT 'El investigador asignado',
  `edad` tinyint(3) UNSIGNED DEFAULT 0,
  `sexo` char(1) DEFAULT NULL COMMENT 'M para mujer\nH para hombre',
  `fechaNacimiento` date DEFAULT NULL COMMENT 'Se puede llenar con INSERT INTO paciente (fechaNacimiento) VALUES (''03-05-21'') entre comillas, el año puede ponerse completo. el mes va en el medio.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente_login`
--

CREATE TABLE `paciente_login` (
  `idPaciente_login` int(11) UNSIGNED NOT NULL,
  `pasword` blob NOT NULL COMMENT 'contraseña cifrada con AES',
  `correo` varchar(80) NOT NULL COMMENT 'correo electronico, obligatorio',
  `ultimaConexion` datetime DEFAULT NULL COMMENT 'para actualizar INSERT INTO paciente_login(ultimaConexion) VALUES (NOW());'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Disparadores `paciente_login`
--
DELIMITER $$
CREATE TRIGGER `TriggerPasadatos` AFTER INSERT ON `paciente_login` FOR EACH ROW BEGIN
	INSERT INTO paciente(correoE, usuario) 
	VALUES (new.correo, new.usuario);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados`
--

CREATE TABLE `resultados` (
  `idResultados` int(11) UNSIGNED NOT NULL,
  `secuencias_idSecuencias` int(11) UNSIGNED NOT NULL,
  `paciente_login_idPaciente_login` int(11) UNSIGNED NOT NULL,
  `tiempoTotal` time NOT NULL,
  `cantidadAsiertos` tinyint(2) UNSIGNED NOT NULL COMMENT 'maximos asiertos 99 ',
  `detalles` varchar(480) NOT NULL COMMENT 'Aca va el id de la imagen, si ha acertado o fallado y cuanto tiempo tardo en contestar. sep, mucho espacio necesita.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secuencias`
--

CREATE TABLE `secuencias` (
  `idSecuencias` int(11) UNSIGNED NOT NULL,
  `investigador_login_idInvestigador_login` int(11) UNSIGNED NOT NULL,
  `nombreSecuencia` varchar(45) DEFAULT NULL,
  `fechaDeCreacion` datetime NOT NULL,
  `fechaUltimaModificacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD PRIMARY KEY (`idImagenes`),
  ADD KEY `fk_imagenes_secuencias1_idx` (`secuencias_idSecuencias`);

--
-- Indices de la tabla `investigador`
--
ALTER TABLE `investigador`
  ADD PRIMARY KEY (`ifk_idInvestigador_login`),
  ADD UNIQUE KEY `ifk_idInvestigador_login_UNIQUE` (`ifk_idInvestigador_login`),
  ADD UNIQUE KEY `correp_UNIQUE` (`correo`),
  ADD KEY `fk_investigador_investigador_login1_idx` (`ifk_idInvestigador_login`);

--
-- Indices de la tabla `investigador_login`
--
ALTER TABLE `investigador_login`
  ADD PRIMARY KEY (`idInvestigador_login`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`paciente_login_idPaciente_login`),
  ADD UNIQUE KEY `correoE_UNIQUE` (`correoE`),
  ADD UNIQUE KEY `paciente_login_idPaciente_login_UNIQUE` (`paciente_login_idPaciente_login`),
  ADD KEY `fk_paciente_paciente_login1_idx` (`paciente_login_idPaciente_login`),
  ADD KEY `fk_paciente_investigador1_idx` (`investigador_ifk_idInvestigador_login`);

--
-- Indices de la tabla `paciente_login`
--
ALTER TABLE `paciente_login`
  ADD PRIMARY KEY (`idPaciente_login`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`);

--
-- Indices de la tabla `resultados`
--
ALTER TABLE `resultados`
  ADD PRIMARY KEY (`idResultados`),
  ADD KEY `fk_resultados_secuencias1_idx` (`secuencias_idSecuencias`),
  ADD KEY `fk_resultados_paciente_login1_idx` (`paciente_login_idPaciente_login`);

--
-- Indices de la tabla `secuencias`
--
ALTER TABLE `secuencias`
  ADD PRIMARY KEY (`idSecuencias`),
  ADD KEY `fk_secuencias_investigador_login1_idx` (`investigador_login_idInvestigador_login`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `imagenes`
--
ALTER TABLE `imagenes`
  MODIFY `idImagenes` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `investigador`
--
ALTER TABLE `investigador`
  MODIFY `ifk_idInvestigador_login` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `investigador_login`
--
ALTER TABLE `investigador_login`
  MODIFY `idInvestigador_login` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `paciente_login`
--
ALTER TABLE `paciente_login`
  MODIFY `idPaciente_login` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `secuencias`
--
ALTER TABLE `secuencias`
  MODIFY `idSecuencias` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `fk_imagenes_secuencias1` FOREIGN KEY (`secuencias_idSecuencias`) REFERENCES `secuencias` (`idSecuencias`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `investigador`
--
ALTER TABLE `investigador`
  ADD CONSTRAINT `fk_investigador_investigador_login1` FOREIGN KEY (`ifk_idInvestigador_login`) REFERENCES `investigador_login` (`idInvestigador_login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `fk_paciente_investigador1` FOREIGN KEY (`investigador_ifk_idInvestigador_login`) REFERENCES `investigador` (`ifk_idInvestigador_login`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_paciente_paciente_login1` FOREIGN KEY (`paciente_login_idPaciente_login`) REFERENCES `paciente_login` (`idPaciente_login`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `resultados`
--
ALTER TABLE `resultados`
  ADD CONSTRAINT `fk_resultados_paciente_login1` FOREIGN KEY (`paciente_login_idPaciente_login`) REFERENCES `paciente_login` (`idPaciente_login`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_resultados_secuencias1` FOREIGN KEY (`secuencias_idSecuencias`) REFERENCES `secuencias` (`idSecuencias`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `secuencias`
--
ALTER TABLE `secuencias`
  ADD CONSTRAINT `fk_secuencias_investigador_login1` FOREIGN KEY (`investigador_login_idInvestigador_login`) REFERENCES `investigador_login` (`idInvestigador_login`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

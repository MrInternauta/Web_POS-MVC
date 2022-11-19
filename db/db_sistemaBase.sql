-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-11-2018 a las 01:16:05
-- Versión del servidor: 5.7.24-0ubuntu0.18.04.1
-- Versión de PHP: 7.0.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_sistema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `articulo`
--

-- INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
-- (1, 3, '750123456', 'MARTILLO', 27, 'MARTILLO TRUPPER', '1543257617.jfif', 1),
-- (2, 4, '12454', 'PINTURA BEREL 19 LTS', 14, 'PINTURA BLANCA BEREL 19 LTS.', '1543258419.jfif', 1),
-- (3, 3, '2160223', 'ROTOMARTILLO TE 30-AVR', 4, 'ROTOMARTILLO MARCA HILTI', '1543258725.jpg', 1),
-- (4, 2, '495472', 'DESBROZADORA', 6, 'DESBROZADORA PARA JARDÍN', '1543258919.jpg', 1),
-- (5, 7, '902853', 'ORGANIZADOR PARA HERRAMIENTAS', 18, 'ORGANIZADOR PARA HERRAMIENTAS MARCA TRUPER', '1543259224.jpg', 1),
-- (6, 7, '715503', 'PORTA HERRAMIENTA DE VAQUETA', 15, 'PORTA HERRAMIENTA MARCA MCGUIRE-NICHOLAS', '1543259449.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria`
--

-- INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
-- (1, 'CARPINTERIA', 'ARTICULOS DE CARPINTERIA', 1),
-- (2, 'JARDINERÍA', 'HERRAMIENTAS Y ARTÍCULOS DE LIMPIEZA PARA EL JARDÍN.', 1),
-- (3, 'MAQUINAS Y HERRAMIENTAS', 'MAQUINAS Y HERRAMIENTAS PARA EL HOGAR Y LA CONSTRUCCIÓN.', 1),
-- (4, 'PINTURA', 'PINTURAS PARA EL HOGAR Y LA CONSTRUCCIÓN.', 1),
-- (5, 'ELECTRICOS', 'ARTÍCULOS PARA LA INSTALACIÓN ELÉCTRICA EN EL HOGAR Y LA CONSTRUCCIÓN.', 1),
-- (6, 'GANADERÍA', 'ALIMENTO Y ARTÍCULOS RELACIONADOS A LA GANADERÍA.', 1),
-- (7, 'FERRETERÍA', 'ARTÍCULOS DE FERRETERÍA PARA EL HOGAR Y LA CONSTRUCCIÓN.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

-- INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
-- (1, 1, 1, 10, '65.00', '100.00');

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `detalle_venta`
--

-- INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
-- (1, 1, 1, 1, '100.00', '0.00'),
-- (2, 2, 1, 1, '100.00', '0.00'),
-- (3, 3, 1, 1, '100.00', '0.00'),
-- (4, 3, 2, 1, '10.00', '0.00'),
-- (5, 3, 3, 1, '10.00', '0.00');

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ingreso`
--

-- INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
-- (1, 3, 1, 'Factura', '', '001', '2018-10-29 00:00:00', '18.00', '650.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acceso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

-- INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
-- (1, 'Cliente', 'Pedro Pérez', 'INE', '', '', '9211485964', ''),
-- (2, 'Cliente', 'Visita', 'INE', '', '', '', ''),
-- (3, 'Proveedor', 'Trupper SA DE CV', 'RFC', 'TRU850601UX1', 'Complejo industrial Jilotepec Edo Mexico', '05585638012', 'contacto@truper.com'),
-- (4, 'Proveedor', 'Grupo Urrea SA DE CV.', 'RFC', 'GPU891225US2', 'Dr R. Michel No. 825  C.P. 44940 Zona Industrial, Guadalajara, Jal.', '018008732', 'atencionclientes@urrea.com.mx'),
-- (5, 'Cliente', 'Manuel Sanchez Muñoz', 'RFC', 'CUPU800825569', 'Vía Entestaren bàculs, 149B', '7837511492', 'sobreafegissin@encapritxesseu.gov'),
-- (6, 'Cliente', 'Joaquín Mas Flores', 'RFC', 'CEOM580813D88', 'Plaza Carejats engargamellareu refilaven remarcada, 144B 11ºA', '634243101', 'celessin@cupletistes.net'),
-- (7, 'Cliente', 'Óliver Caballero Hidalgo', 'RFC', 'CEPR600403LJ8', 'Glorieta Temporalitze ramejant, 96A 15ºG', '6974287562', 'enrinxolaveu@fresquivol.net'),
-- (8, 'Cliente', 'Yeray Vila Carmona', 'RFC', 'CERG540918652', 'Ronda Reviscolàreu besunyaries desclavara abrogarà, 183A 14ºA', '6792649561', 'desentrenes@esbotzaren.com'),
-- (9, 'Cliente', 'Rafael Muñoz Martin', 'RFC', 'CERJ611222BDA', 'Urbanización Tiratges esparpillat, 288B', '7663216954', 'manducavem@nuclearitzassiu.es'),
-- (10, 'Cliente', 'Pablo Puig Muñoz', 'RFC', 'CERR730124N94', 'Vía Escindesquin remunerem edícula tocoginecòleg, 54A 16ºG', '8541741056', 'encrestessin@camada.net'),
-- (11, 'Cliente', 'Pedro Ortiz Flores', 'RFC', 'CERV670826RG5', 'Alameda Capsotera, 17 20ºH', '8298341942', 'escardassaven@blatdemorera.gov'),
-- (12, 'Proveedor', 'Makita Mexico SA DE CV', 'RFC', 'MAM780325ZTY', 'Zona industrial de Vallejo Ciudad de Mexico', '722 385 88 00', 'contacto@makita.com.mx'),
-- (13, 'Proveedor', 'Grupo Austromex SA DE CV', 'RFC', 'GRA651218A78', '', '55 55 57 19 66', 'servicioaclientes@austromex.com.mx'),
-- (14, 'Proveedor', 'STANLEY Black&amp;amp;amp;Decker  SA de CV', 'RFC', 'SBD560731UU0', 'Avenida Antonio Dovali Jaime  # 70 Torre B Piso 9 CoL La Fe', '01 800 847 2312', 'ventas@blackdecker.com.mx'),
-- (15, 'Proveedor', 'Helvex SA de CV', 'RFC', 'HEL670525XU6', 'Complejo Industrial Vallejo Ciudad de Mexico', '01 800 909 2020', 'contacto@helvex.com.mx'),
-- (16, 'Cliente', 'Luis Vargas Ortega', 'RFC', 'CESC621216RS0', 'Callejón Espitllaríem, 220 20ºA', '7269325707', 'enclaustrava@desenselleu.com'),
-- (17, 'Cliente', 'Mohamed Hidalgo Sanz', 'RFC', 'CESI7204127P0', 'Pasadizo Moltonejaríem semals llambroixant, 62A 1ºA', '7698764403', 'vigoritzant@sumes.net'),
-- (18, 'Cliente', 'Asier Mora Duran', 'RFC', 'CESM781228G28', 'Acceso Enfaixareu discòrdies exàmens, 163B 3ºB', '615580249', 'batocromica@cartindran.org'),
-- (19, 'Cliente', 'Francisco Gomez Caballero', 'RFC', 'MESJ910610EE3', 'Rambla Traspunxaven, 130', '8571681528', 'desrenguis@emprenyarem.org'),
-- (20, 'Cliente', 'Rafael Garrido Guerrero', 'INE', 'METB780827527', 'Plaza Sinitzarien, 130', '8365017856', 'trotassiu@influiria.eu'),
-- (21, 'Cliente', 'Pablo Nuñez Gallardo', 'RFC', 'MEUA840330BV4', 'Glorieta Faixàveu, 3B', '6203724808', 'desenfanguesses@testimoniessen.gov'),
-- (22, 'Cliente', 'Álvaro Cano Soto', 'RFC', 'DMM080722CY2', 'Pasaje Supliquessin transliteraríeu, 255', '8926460812', 'brutejarieu@infatui.com'),
-- (23, 'Proveedor', 'Bticino de México, S.A. de C.V.', 'RFC', 'BTM890829456', 'Carretera 57 km 22.7 Querétaro a San Luis Potosí, Queretaro,Qro', '01 800 714 8524', 'avisodeprivacidad.btmx@bticino.com'),
-- (24, 'Cliente', 'Lucas Romero Perez', 'RFC', 'DMO940415JL7', 'Camino Encapullesses humitegeu engronsés, 132B 3ºE', '6330941172', 'segmentaras@ejecten.com'),
-- (25, 'Cliente', 'Jon Guerrero Hernandez', 'RFC', 'DMS9706127F2', 'Paseo Resultéssem oligofrènica contrapunxonàvem, 140 17ºB', '7569725598', 'pernabato@perlita.org'),
-- (26, 'Proveedor', 'Fanal SA de CV', 'RFC', 'FAN450916BUL', 'Av. Nogalar Sur #301 Fracc. Industrial Nogalar San Nicolas de los Garz', '01800 326.2501', 'atencion@fanal.com.mx'),
-- (27, 'Cliente', 'Fernando Lozano Romero', 'RFC', 'DMV050817AP6', 'Vía Desempipà, 104B 16ºG', '7187804976', 'coactiva@isardes.org'),
-- (28, 'Cliente', 'Arnau Vidal Benitez', 'RFC', 'DNM100423S96', 'Pasadizo Desgolfaríem arraconaments creosotem ensutzes, 32 5ºD', '6139969227', 'genolls@metallitzareu.eu'),
-- (29, 'Cliente', 'Santiago Mas Leon', 'RFC', 'DOC041215941', 'Rambla Expediràs salmodiàvem engolixen, 106A 16ºA', '7887019928', 'bestiejares@encaironesseu.eu'),
-- (30, 'Cliente', 'Pedro Martin Romero', 'RFC', 'DOC120925ER4', 'Camino Copolimeritzàrem revertissis innovà sirgam, 87B', '7535022024', 'escuressen@rectificada.net'),
-- (31, 'Proveedor', 'Grupo Sayer SA de Cv', 'RFC', 'GRS890529SS8', '', '01 800 021 9333', 'ventasclientes@sayer.com.mx'),
-- (32, 'Proveedor', 'Comex Pinturas SA de CV', 'RFC', 'CPI970621NX9', '', '01 800 712 6639', 'clientes@comex.com.mx');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(1, 'Admin admin', 'INE', '0', 'Jose Gálvez 1368 - Coatzacoalcos', '9211111111', 'admin@admin.com', 'admin', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1487132068.jpg', 1),
(2, 'Vendedor', 'INE', '0', 'Calle 5 de mayo, Esquina 20 de Noviembre San Juan Volador, Pajapan, Ve', '9211111111', 'vendedor@prueba.com', 'VENDEDOR', 'vendedor', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1543256487.png', 1),
(3, 'Supervisor', 'INE', '001', 'Calle 5 de mayo, Esquina 20 de Noviembre San Juan Volador, Pajapan, Ve', '9211111111', 'supervisor@prueba.com', 'Vendedor', 'supervisor', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1543175283.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(197, 1, 1),
(198, 1, 2),
(199, 1, 3),
(200, 1, 4),
(201, 1, 5),
(202, 1, 6),
(203, 1, 7),
(204, 2, 4),
(205, 3, 1),
(206, 3, 2),
(207, 3, 3),
(208, 3, 4),
(209, 3, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `venta`
--

-- INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
-- (1, 2, 1, 'Ticket', '', '001', '2018-10-29 00:00:00', '0.00', '100.00', 'Anulado'),
-- (2, 2, 1, 'Ticket', '', '22', '2018-10-29 00:00:00', '0.00', '100.00', 'Anulado'),
-- (3, 1, 1, 'Ticket', '123', '0', '2018-11-26 00:00:00', '0.00', '120.00', 'Aceptado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Indices de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD CONSTRAINT `fk_usuario_permiso_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_permiso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

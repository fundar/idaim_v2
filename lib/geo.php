<?php

//error_reporting(E_ALL);
$region = (int) $_SERVER['GEOIP_REGION'];
$regiones = array(
	'agu', //'Aguascalientes',
	'bcn', //'Baja California',
	'bcs', //'Baja California Sur',
	'cam', //'Campeche',
	'coa', //'Coahuila de Zaragoza',
	'col', //'Colima',
	'chp', //'Chiapas',
	'chh', //'Chihuahua',
	'dif', //'Distrito Federal',
	'dur', //'Durango',
	'gua', //'Guanajuato',
	'gro', //'Guerrero',
	'hid', //'Hidalgo',
	'jal', //'Jalisco',
	'mex', //'México',
	'mic', //'Michoacán de Ocampo',
	'mor', //'Morelos',
	'nay', //'Nayarit',
	'nle', //'Nuevo León',
	'oax', //'Oaxaca',
	'pue', //'Puebla',
	'que', //'Querétaro',
	'roo', //'Quintana Roo',
	'slp', //'San Luis Potosí',
	'sin', //'Sinaloa',
	'son', //'Sonora',
	'tab', //'Tabasco',
	'tam', //'Tamaulipas',
	'tla', //'Tlaxcala',
	'ver', //'Veracruz de Ignacio de la Llave',
	'yuc', //'Yucatán',
	'zac', //'Zacatecas'
);
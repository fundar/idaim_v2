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

if (false && file_exists(dirname(__FILE__).'/geoip/geoip_city.php')) {
	require_once 'geoip/geoip_city.php';
	$gi = geoip_open("/usr/local/share/GeoIP/GeoLiteCity.dat",GEOIP_STANDARD);
	$data = GeoIP_record_by_addr($gi, '189.212.40.234');
	define('EDO', $data->region-1);
} else {
	define('EDO', 'false');
}


function geo() {
	$server = $_SERVER['HTTP_GEOIP_REGION'] ? $_SERVER['GEOIP_REGION'];
	return $server ? '"'.($server-1).'"' : EDO;
}
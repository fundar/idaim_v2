<!DOCTYPE html>
<?php require('../lib/geo.php'); 
	$geoip = geo();
?>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="css/index.css">
				<style type="text/css">

    </style>
		</head>
		<body>
			<!--
			<div id="idaim-2010">
				<div class="container">
					<p>
						<a href="http://checatuley.org">Conoce el IDAIM 2010</a>
					</p>
				</div>
			</div>
			-->
			<? include('header.php') ;?>
			<script>
			window._geoip = <?= $geoip ?>;
			</script>
			

			<section id="hero">
				<div class="container">
					<div id="hero-text">
						<span class="hero-text l1">El IDAIM</span>
						<span class="hero-text l2">mide las</span>
						<span class="hero-text l3">Leyes de Transparencia</span>
						<span class="hero-text l4">y acceso a la</span>
						<span class="hero-text l5">Información en México</span>
						<span class="hero-text l6">con relación a las</span>
						<span class="hero-text l7">mejores prácticas</span>
						<span class="hero-text l8">Nacionales e Internacionales</span>
					</div>
					<div id="mapita"></div>
				</div>
			</section>

			<section id="nacional" class="sec sec-a">
				<div class="container cf">
					<p>El IDAIM mide la calidad de las leyes de transparencia en México con relación a las mejores prácticas nacionales e internacionales en la materia. Se compone de tres variables principales: diseño normativo, diseño institucional y procedimiento de acceso a la información pública y obligaciones de transparencia. Cada variable se compone de siete, cinco y nueve indicadores respectivamente, los cuales se alimentan de 196 criterios.</p>
					<p>Los criterios representan los elementos que consideramos debe contener una ley de transparencia para que garantice y proteja adecuadamente el ejercicio del derecho de acceso a la información (DAI) y favorezca la transparencia.</p>
					<p>A continuación se presenta una gráfica en donde se pueden observar las calificaciones de cada variable, indicador y criterio para cada ley evaluada. Los colores reflejan el rango en el que se encuentra cada componente. Verde cuando se considera buena (calificación entre 8.0 y 10), amarillo cuando se considera regular (calificación entre 6.0 y 7.9) y rojo cuando se considera mala (calificación entre 0 y 5.9).</p>

					<div id="geolocation">
						<h3>Estás visitándonos desde</h3>

						<div id="select-estado">
							<img src="/img/flecha-roja.png" />
							<select id="geo-select-estado">
								<? $edos = json_decode(file_get_contents('data/estados.json'));
									foreach($edos as $id => $info):
										$checked = $geoip == $id;
										$checked = $geoip=='false' && $id==32? true : $checked;
								?>
								<option value="<?= $id ;?>" <?= $checked ? 'selected' : '' ;?> ><?= $info->n ;?>
								</option>
								<? endforeach; ?>
							</select>
						</div>

						<br />
						<ul>
							<li id="breadcrumb-total" class="breadcrumb active-breadcrumb" data-parent="#gn-total-idaim">
								<a href="#">Estado</a>
							</li>
							<li id="breadcrumb-eje" class="breadcrumb">
								<a href="#" >&gt; Calificación del eje</a>
							</li>
							<li id="breadcrumb-indicador" class="breadcrumb">
								<a href="#">&gt; Calificación del indicador</a>
							</li>
							<li id="breadcrumb-criterio" class="breadcrumb">
								<a href="#">&gt; Calificación del criterio</a>
							</li>
						</ul>
					</div>

					<h3 id="nombre-variable">IDAIM</h3>

					<div class="texto-total" id="total-nacional-cont">
						<h2 class="pc" id="total-nacional"></h2>
						<h3 id="total-nombre">Promedio Nacional</h3>
					</div>

					<div id="graph-total"></div>

					<div class="cf">
						<div id="total-ultimo" class="texto-total">
							<div>El Peor</div>
							<h2 class="pc"></h2>
							<h3></h3>
						</div>
						<div id="total-primero" class="texto-total">
							<div>El Mejor</div>
							<h2 class="pc"></h2>
							<h3></h3>
						</div>
					</div>

					<div class="descripcion-variable">
						<p id="descripcion-variable"></p>
					</div>

					<div class="separador cf"></div>

					<div class="escala cf">
						<div class="titulo">Escala</div>
						<div class="escala-barras">
							<div class="escala-barra-cont">
								<div class="barrita rojo"></div>
								<div class="descr rojo">0 - 5.9</div>
							</div>

							<div class="escala-barra-cont">
								<div class="barrita amarillo"></div>
								<div class="descr amarillo">6 - 7.9</div>
							</div>

							<div class="escala-barra-cont">
								<div class="barrita verde"></div>
								<div class="descr verde">8 - 10</div>
							</div>
						</div>
					</div>
				</div>
			</section>

			<section id="indice-nacional" class="sec sec-b">
				<div class="container">
					<h1>Índice por Estado</h1>
					<label>
						<input type="checkbox" id="indice-nacional-toggle" class="ordena" data-orden="alpha-asc" checked="checked" />
						A-Z
					</label>
					<label>
						<input type="checkbox" id="indice-nacional-toggle" class="ordena" data-orden="alpha-desc" />
						Z-A
					</label>
					<label>
						<input type="checkbox" id="indice-nacional-toggle" class="ordena" data-orden="val-asc" />
						0-10
					</label>
					<label>
						<input type="checkbox" id="indice-nacional-toggle" class="ordena" data-orden="val-desc" />
						10-0
					</label>
					<div id="graph-indices-nacional"></div>
				</div>
			</section>

			<section id="mapa" class="sec sec-a">
				<div class="container">
					<div class="estado-hover">
						<h2 id="estado-hover-nombre">&nbsp;</h2>
						<h1 id="estado-hover-calificacion">&nbsp;</h1>
					</div>
					
					<div id="mapa_svg">
						<?= file_get_contents('./img/mapa.svg') ;?>
					</div>
				</div>
			</section>

			<? include('footer.php') ;?>
			<script src="/js/main.js"></script>
		</body>
</html>

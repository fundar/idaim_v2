<!DOCTYPE html>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="/css/contacto.css">
				<style type="text/css">

    </style>
		</head>
		<body>
			<!--[if lt IE 8]>
					<p class="browsehappy">Estás usando un navegador <strong>anticuado</strong>. Por favor <a href="http://browsehappy.com/?locale=es">actualiza tu navegador</a> para mejorar tu experiencia.</p>
			<![endif]-->
			<header>
				<div class="container">
					<a href="/" id="logo">IDAIM</a>
					<nav id="nav-principal">
							<ul class="nav-paginas">
									<li><a href="/quienes-somos">Quiénes somos</a></li>
									<li><a href="/acerca-de">Acerca de</a></li>
									<li><a href="/contacto" class="activo">Contacto</a></li>
							</ul>

							<ul class="nav-social">
									<li><a class="ss-icon ss-social-regular" href="">email</a></li>
									<li><a class="ss-icon ss-social-regular" href="">tumblr</a></li>
									<li><a class="ss-icon ss-social-regular" href="">facebook</a></li>
							</ul>
					</nav>
				</div>
			</header>

			<div class="contacto cf">
				<article class="container">
					<h1>Contacto</h1>

					<?
						$fields = array('nombre', 'email', 'mensaje');

						if ($_POST['nombre']):
							
							require('../lib/aws.phar');
							$rcpt = 'renata@fundar.org.mx';
							$data = (object) array_combine($fields, array_map(function($f){
								return htmlentities(trim($_POST[$f]));
							}, $fields));

							$client = Aws\Ses\SesClient::factory(array(
								'key' => 'AKIAJYNGUEQXHN53IMEA',
								'secret' => 'Agc8KTm83smQiQNucHVFAlgFESNptQuqyMBfIUjNJG+K',
								'region' => 'us-east-1'
							));

							$msg = <<<EMAIL
<h1>Contacto de <a href="mailto:{$data->email}">{$data->nombre} ({$data->email})</a></h1>
<blockquote>
{$data->mensaje}
</blockquote>

idaim.org.mx
EMAIL;
							$dst = 'rob@surrealista.mx';

							$email = array(
								'Source' => 'idaim@fundar.org.mx',
								'Destination' => array('Renata Terrazas' => $dst),
								'Message' => array(
									'Subject' => array(
										'Data' => 'Contacto de fundar.org.mx',
										'Charset' => 'utf-8'
									),
									'Body' => array(
										'Text' => array(
											'Data' => str_replace('<br />', "\r\n", $msg),
											'Charset' => 'utf-8'
										),
										'Html' => array(
											'Data' => $msg,
											'Charset' => 'utf-8'
										)
									)
								),
								'ReplyToAddresses' => array($data->email),
								'ReturnPath' => $dst
							);

							try {
								$result = $client->sendEmail($email);
							} catch (\Exception $e) {
								echo "Error :/";
								#echo "<!--";
								#var_dump($e);
								#echo "-->";
							}
							
					?>

					<section>
						<p>¡Gracias por tu comentario!</p>
					</section>

					<? else: ?>
					<section>
						<p>Si deseas recibir mayor información lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ornare pharetra velit, et cursus mauris fringilla at. Ut adipiscing tristique erat in dapibus. Morbi quis ligula at sapien gravida cursus sed in odio. Suspendisse at sagittis eros, sit amet consectetur lorem. Pellentesque ut tristique nibh.</p>
					</section>

					<section>
						<form method="post">
							<fieldset>
								<label for="nombre">Nombre*</label>
								<input name="nombre" id="nombre" type="text" required />
							</fieldset>

							<fieldset>
								<label for="email">Email*</label>
								<input name="email" id="email" type="email" required />
							</fieldset>

							<fieldset>
								<label for="mensaje">Mensaje</label>
								<textarea name="mensaje" id="mensaje"></textarea>
							</fieldset>
							<p class="help">* Son campos obligatorios</p>

							<button type="submit">Enviar</button>
						</form>
					</section>
					<? endif; ?>

				</article>
			</div>

			<footer>
				<div class="container">
					<a href="http://fundar.org.mx" id="logo-fundar"></a>

					<nav id="nav-footer">
							<ul class="footer-paginas">
									<li><a href="/quienes-somos">Quiénes somos</a></li>
									<li><a href="/acerca-de">Acerca de</a></li>
									<li><a href="/contacto" class="activo">Contacto</a></li>
									<li><a href="http://www.checatuley.org">IDAIM 2010</a></li>
							</ul>

							<ul class="footer-otros">
									<li><a href="">Aviso de Privacidad</a></li>
									<li><a href="">Ayuda</a></li>
							</ul>
					</nav>

					<div id="copyright">&copy; 2014 Fundar. Todos los derechos reservados</div>
				</div>
			</footer>
		</body>
</html>

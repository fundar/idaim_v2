<!DOCTYPE html>
<html>
		<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>IDAIM - Índice del Derecho de Acceso a la Información en México</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">
				<link rel="stylesheet" href="/css/contacto.css">
				
		</head>
		<body>
			<? include('header.php') ;?>

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
								'key' => 'AKIAJG64LWCC2P72JSQQ',
								'secret' => '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',
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
								'Destination' => array('ToAddresses' => array($dst)),
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
								echo $e->getMessage();
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

			<? include('footer.php') ;?>
		</body>
</html>

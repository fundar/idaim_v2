			<!--[if lt IE 8]>
					<p class="browsehappy">Estás usando un navegador <strong>anticuado</strong>. Por favor <a href="http://browsehappy.com/?locale=es">actualiza tu navegador</a> para mejorar tu experiencia.</p>
			<![endif]-->
			<header>
				<div class="container">

					<a href="/" id="logo">IDAIM</a>
					<nav id="nav-principal">
							<ul class="nav-paginas">
									<?php
										function estamos_en($path) {
											if ($_SERVER['REQUEST_URI'] == "/{$path}") {
												return 'class="activo"';
											}
										}
									?>
									<li><a href="/quienes-somos" <?= estamos_en('quienes-somos');?>>Quiénes somos</a></li>
									<li><a href="/documentos" <?= estamos_en('documentos');?>>Documentos</a></li>
									<li><a href="/contacto" <?= estamos_en('contacto');?>>Contacto</a></li>
							</ul>

							<ul class="nav-social">
									<li><a class="ss-icon ss-social-regular" href="https://twitter.com/IDAIM_Fundar">twitter</a></li>
							</ul>
					</nav>
				</div>
			</header>
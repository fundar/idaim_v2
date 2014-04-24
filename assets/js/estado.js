// require _jquery
// require _d3
// require _color
// require _idaim

$(function(){
	window._edo = window._edo || 'mor';
	var pathEstado = 'estados/'+window._edo;

	$('.breadcrumb:not(.active-breadcrumb)').hide();
	$('.breadcrumb').on('click', function(evt){
		evt.preventDefault();
		var $el = $(this);
		var tipo = this.id.split('-')[1];
		selector = '';
		plural = false;
		switch (tipo) {
			case 'total':
				selector = '.indicador, .criterio, .eje';
				break;
			case 'eje':
				selector = '.indicador, .criterio';
				plural = 'ejes';
				break;
			case 'indicador':
				plural = 'indicadores';
				selector = '.criterio';
				break;
		}
		console.log(tipo);
		var nombre, descripcion, d;
		if (tipo == 'total') {
			d = {
				valor: IDAIM.get(pathEstado).t
			};
			nombre = 'IDAIM';
			descripcion = '';
		} else {
			d = $el.data();
			descripcion = plural && IDAIM.get(plural)[d.id];
			nombre = IDAIM.get('nombres').indicador[d.id];	
		}
		console.log(IDAIM.get(pathEstado));

		$('#calificacion').text(d.valor/10);
		$('#nombre').text(nombre);
		$('#descripcion').text(descripcion);
		
		d3.selectAll(selector).classed('activo', 0);

		$el.addClass('active-breadcrumb').nextAll().hide();
	});
			


	var idaimReady = function(){

		var container = '#graficaEstado';

		$(container).empty();

		var m = {t: 2, r: 2, b: 2, l: 2},
			wC = $(container).width(),
			w = wC - (m.r + m.l),
			h = (w/4),
			s = w / 28,
			filas = 7;

		if (w < 480) {
			h = w;
			s = w / 14;
			filas = 14;
		}

		var hC = h + (m.t + m.b);

		var g = d3.select(container).append('svg')
			.attr("width", wC)
			.attr("height", hC);

		var xSquare = function(c) {
			var index = (typeof c === 'number') ? c-1 : c.id-1;
			return Math.floor(index/filas);
		};

		var ySquare = function(c) {
			var index = (typeof c === 'number') ? c-1 : c.id-1;
			return (index) % filas;
		};

		var polygonPath = function(eje) {
			var inicio = eje.start,
				fin = eje.end;

			var path = "";

			path += "M" + (xSquare(inicio) * s + m.l) + "," + (ySquare(inicio) * s + m.t);

			if (xSquare(fin) > xSquare(inicio)) {
				path += "V" + (filas * s + m.t);
			} else {
				path += "V" + (ySquare(fin) * s + s + m.t);
			}

			if (ySquare(fin) != (filas - 1)) {
				path += "H" + (xSquare(fin) * s + m.l);
				path += "V" + (ySquare(fin) * s + s + m.t);
			}

			path += "H" + (xSquare(fin) * s + s + m.l);

			if (xSquare(fin) > xSquare(inicio)) {
				path += "V" + m.t;
			} else {
				path += "V" + (ySquare(inicio) * s + m.t);
			}

			if (ySquare(inicio) !== 0) {
				path += "H" + (xSquare(inicio) * s + s + m.l);
				path += "V" + (ySquare(inicio) * s + m.t);
			}

			path += "Z";

			return path;
		};

		var generaPoligonos = function(clase, datos) {
			return g.selectAll("."+clase).data(datos)
			.enter().append("path")
			.attr('class', clase)
			.attr('fill', function(d) {return Color(d.valor); })
			.attr('d', polygonPath)
			.on('click', function(d) {
				if (clase == 'eje') {
					selectors = '.eje, .indicador, .criterio';
					descripcion = IDAIM.get('ejes')[d.id];
					nombre = IDAIM.get('nombres').eje[d.id];
					$bc = $('#breadcrumb-eje');
					$bc.data('tipo', 'eje').data('id', d.id).data('valor', d.valor);
					$('.active-breadcrumb').removeClass('active-breadcrumb');
					$bc.show().addClass('active-breadcrumb').prevAll().show();
					$bc.nextAll().hide();
				} else {
					selectors = '.indicador, .criterio';
					descripcion = IDAIM.get('indicadores')[d.id];
					nombre = IDAIM.get('nombres').indicador[d.id];
					$bc = $('#breadcrumb-indicador');
					$bc.data('tipo', 'indicador').data('id', d.id).data('valor', d.valor);
					$('.active-breadcrumb').removeClass('active-breadcrumb');
					$bc.show().addClass('active-breadcrumb').prevAll().show();
					$bc.nextAll().hide();
				}
				d3.selectAll(selectors).classed('activo', 0);
				d3.select(this).classed('activo', 1);
				$('#calificacion').text(d.valor/10);
				$('#nombre').text(nombre)
				$('#descripcion').text(descripcion);
			});
		};

		var data = [];
		$.each(IDAIM.get(pathEstado).c, function(id, criterio){
			data.push({id: id, valor: criterio*100});
		});

		var criterios = g.selectAll(".criterio")
			.data(data)
			.enter().append("rect")
			.attr('class', 'criterio')
			.attr('width', s)
			.attr('height', s)
			.attr('fill', function(d) { return Color(d.valor); } )
			.attr('x', function(d) { return xSquare(d) * s + m.l;})
			.attr('y', function(d) { return ySquare(d) * s + m.t;})
			.on('click', function(d) {
				d3.selectAll('.criterio').classed('activo', 0);
				d3.select(this).classed('activo', 1);
				$bc = $('#breadcrumb-criterio');
				$bc.data('tipo', 'criterio').data('id', d.id).data('valor', d.valor);
				$('.active-breadcrumb').removeClass('active-breadcrumb');
				$bc.show().addClass('active-breadcrumb').prevAll().show();
				$bc.nextAll().hide();

				$('#calificacion').text(d.valor/10);
				$('#nombre').text(IDAIM.get('nombres').criterio[d.id]);
				$('#descripcion').text(' ');
			});

		var dataIndicadores = [];
		var dataEjes = [];

		$.each(IDAIM.get('estructura'), function(index, eje){
			var start = eje.children[0].children[0].id;
			var ultimoIndicador = eje.children[eje.children.length-1];
			var end = ultimoIndicador.children[ultimoIndicador.children.length-1].id;
			dataEjes.push({
				start: start,
				end: end,
				id: eje.id,
				valor: IDAIM.get(pathEstado).e[eje.id]
			});

			$.each(eje.children, function(index, indicador) {
				var ch = indicador.children;
				dataIndicadores.push({
					id: indicador.id,
					valor: IDAIM.get(pathEstado).i[indicador.id],
					start: ch[0].id,
					end: ch[ch.length-1].id
				});
			});
		});

		var indicadores = generaPoligonos('indicador', dataIndicadores);
		var ejes = generaPoligonos('eje', dataEjes);

		var resize = function() {
			// Calculamos tamaños nuevos
			wC = $(container).width(),
			w = wC - (m.r + m.l),
			h = (w/4),
			s = w / 28,
			filas = 7;

			if (w < 480) {
				h = w;
				s = w / 14;
				filas = 14;
			}

			hC = h + (m.t + m.b);

			// Resizeamos
			g
				.attr("width", wC)
				.attr("height", hC);
			criterios
				.attr('width', s)
				.attr('height', s)
				.attr('x', function(d) { return xSquare(d) * s + m.l;})
				.attr('y', function(d) { return ySquare(d) * s + m.t;})
			indicadores
				.attr('d', polygonPath);
			ejes
				.attr('d', polygonPath);

		}

		var debounce = function(fn, timeout) {
			var timeoutID = -1;
			return function() {
				if (timeoutID > -1) {
		            window.clearTimeout(timeoutID);
		        }
		        return timeoutID = window.setTimeout(fn, timeout);
			}
		}

		var debounce_grafica = debounce(resize, 250);
		d3.select(window).on('resize', debounce_grafica);
	};

	IDAIM.load([pathEstado, 'estructura', 'ejes', 'indicadores', 'nombres']);
	IDAIM.on('ready', idaimReady);
});

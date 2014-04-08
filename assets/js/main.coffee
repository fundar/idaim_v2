#= require _jquery
#= require _d3
#= require _color
#= require _idaim
#= require _geo

debounce = (fn, timeout)->
	timeoutID = -1;
	()->
		window.clearTimeout timeoutID if (timeoutID > -1)
		timeoutID = window.setTimeout fn, timeout

$ ()->

	$graphTotal = $ '#graph-total'
	textoVariable =
		nombre: $('#nombre-variable')
		descripcion: $('#descripcion-variable')

	IDAIM.load([
		'regiones',
		'nombres',
		'ejes',
		'indicadores',
		'nacional',
		'estados',
		'estados/nal',
		'estructura'
	]);

	IDAIM.on 'ready', ()->
		totales = IDAIM.get('nacional')
		estados = IDAIM.get('estados')
		graficaTotal = IDAIM.get('estados/nal')
		totalNombre = 'Promedio Nacional';

		locationAquired = (data)->
			console.log(data.id);
			$('#geo-select-estado').val(data.id);
			$('#total-nacional').text totales.total[data.id]
			$('#total-nombre').text data.n
			totalNombre = data.n
			IDAIM.load "estados/#{data.i}", (data)->
				graficaTotal = data;
				dibujaMain();

		$('#geo-select-estado').on 'change', (evt)->
			Geo.instance.cancelGeolocation();
			edo = estados[this.value]
			$('#total-nacional').text totales.total[this.value]
			$('#total-nombre').text edo.n
			totalNombre = edo.n
			IDAIM.load "estados/#{edo.i}", (data)->
				graficaTotal = data;
				dibujaMain();


		Geo.start().onLocation(locationAquired).set(window._geoip)

		$('#total-nacional').text totales.total[32]
		arr = []
		dup = JSON.parse(JSON.stringify totales.total)
		delete dup[32]
		for edo,cal of dup
			$svg = $("svg ##{edo}")
			$svg.click ()->
				$('#estado-hover-nombre').text IDAIM.estado(this.id)
				$('#estado-hover-calificacion').text IDAIM.get('nacional').total[this.id]+'%'
			svg = $svg.get(0)
			svg.cal = cal;
			svg.style.fill = Color(cal)
			svg.style.strokeWidth = 1
			svg.style.stroke = "white"
			arr.push [edo, cal]

		arr.sort (a,b)->
			return  a[1] - b[1]

		last = arr[0]
		first = arr[arr.length-1]
		$('#total-ultimo').find('h2').text(last[1])
		$('#total-primero').find('h2').text(first[1])

		$('#total-ultimo').find('h3').text(IDAIM.estado last[0])
		$('#total-primero').find('h3').text(IDAIM.estado first[0])

		# esto debería de cambiar a pasar argumentos a la función
		# ya que también podríamos tener otro estado, no solo nacional...

		totalesNacional = arr
		totalesNacional.push(["32", totales.total[32]])
		totalesNacional.sort (a,b)->
			#sort por nombre
			if IDAIM.estado(a[0]) > IDAIM.estado(b[0])
				return 1
			if IDAIM.estado(a[0]) < IDAIM.estado(b[0])
				return -1
			return 0

		dibujaMain = ()->
			ww = Math.min $('#mapa .container').width(), 1000
			$('#mapa svg').width(ww).height(ww*0.8)
			IDAIM.mainChart IDAIM.get('estructura'), $('#graph-total'), graficaTotal
			IDAIM.indiceNacional(totalesNacional, '#graph-indices-nacional')
		
		IDAIM.on 'mainChart.click', (data)->
			descripcion = false
			nombre = "Calificación de #{data.tipo}"
			console.log data.tipo == 'total'
			switch data.tipo
				when 'total'
					console.log 'total'
					nombre = totalNombre
				when 'eje'
					descripcion = IDAIM.get('ejes')[data.id]
				when 'indicador'
					descripcion = IDAIM.get('indicadores')[data.id]
			
			action = if descripcion then 'show' else 'hide'
			textoVariable.nombre.text(data.nombre)
			textoVariable.descripcion[action]()
			textoVariable.descripcion.text(descripcion)
			$('#total-nacional').text(data.valor)
			$('#total-nombre').text(nombre)


		operadores =
			asc: (a,b)-> a > b
			desc: (a,b)-> a < b



		$('.ordena').click (evt)->
			$('.ordena').not(this).removeAttr('checked')
			[prop, orden] = $(this).data('orden').split('-')
			
			val = ((item)-> IDAIM.estado(item[0])) if prop=='alpha'
			val = ((item)-> item[1]) if prop=='val'
			compara = operadores[orden]

			totalesNacional.sort (a,b)->
				a = val(a)
				b = val(b)
				return 0 if a == b
				mayor = compara(a, b)
				return 1 if mayor
				return -1 if !mayor

			IDAIM.indiceNacional(totalesNacional, '#graph-indices-nacional')

		$('.shape-estado').on {
			mouseover: (evt)->
				$('#estado-hover-nombre').text IDAIM.estado(this.id)
				$('#estado-hover-calificacion').text IDAIM.get('nacional').total[this.id]+'%'
			mouseout: (evt)->
				$('#estado-hover-nombre').html '&nbsp;'
				$('#estado-hover-calificacion').html '&nbsp;'

		}

		debounce_main = debounce dibujaMain, 250
		dibujaMain()
		$(window).resize debounce_main

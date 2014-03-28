#= require _jquery
#= require _d3
#= require _color
#= require _idaim

debounce = (fn, timeout)->
	timeoutID = -1;
	()->
		window.clearTimeout timeoutID if (timeoutID > -1)
		timeoutID = window.setTimeout fn, timeout

$ ()->

	$graphTotal = $ '#graph-total'

	IDAIM.load([
		'regiones',
		'nombres',
		'indicadores',
		'nacional',
		'estados',
		'estados/nal',
		'estructura'
	]);

	IDAIM.on 'ready', ()->
		totales = IDAIM.get('nacional')
		estados = IDAIM.get('estados')
		$('#total-nacional').text totales.total[32]
		arr = []
		dup = JSON.parse(JSON.stringify totales.total)
		delete dup[32]
		for edo,cal of dup
			$svg = $("svg ##{edo}")
			$svg.click ()->
				alert("#{IDAIM.estado this.id}: #{this.cal}")
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
		dibujaMain = ()->
			IDAIM.mainChart IDAIM.get('estructura'), $('#graph-total'), IDAIM.get('estados/nal')

		$('.eje-text').hide();

		IDAIM.on 'mainChart.click', (data)->
			$('.eje-text').hide();
			$("#texto-eje-#{data.id}").show() if data.tipo is 'eje'
				

		debounce_main = debounce dibujaMain, 250
		dibujaMain()
		$(window).resize debounce_main

		totalesNacional = arr
		totalesNacional.push(["32", totales.total[32]])
		totalesNacional.sort (a,b)->
			#sort por nombre
			if IDAIM.estado(a[0]) > IDAIM.estado(b[0])
				return 1
			if IDAIM.estado(a[0]) < IDAIM.estado(b[0])
				return -1
			return 0

		IDAIM.indiceNacional(totalesNacional, '#graph-indices-nacional')

#= require _jquery
#= require _d3
#= require _color
#= require _idaim
# require _

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
			IDAIM.mainChart IDAIM.get('estructura'), $('#graph-total'), IDAIM.get('estados/nal')
			IDAIM.indiceNacional(totalesNacional, '#graph-indices-nacional')
		

		IDAIM.on 'mainChart.click', (data)->
			descripcion = false
			switch data.tipo
				when 'total'
					console.log 'total'
				when 'eje'
					descripcion = IDAIM.get('ejes')[data.id]
				when 'indicador'
					descripcion = IDAIM.get('indicadores')[data.id]
			
			action = if descripcion then 'show' else 'hide'
			textoVariable.nombre.text(data.nombre)
			textoVariable.descripcion[action]()
			textoVariable.descripcion.text(descripcion)
				

		debounce_main = debounce dibujaMain, 250
		dibujaMain()
		$(window).resize debounce_main

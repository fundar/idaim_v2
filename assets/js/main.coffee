#= require _jquery
#= require _d3
#= require _color
#= require _idaim

$ ()->
	
	$graphTotal = $ '.graph-total'

	IDAIM.load([
		'regiones',
		'nombres',
		'indicadores',
		'nacional',
		'estados',
		'estados/nal'
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

		IDAIM.mainChart(IDAIM.get('estados/nal'), $('#graph-total'))
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

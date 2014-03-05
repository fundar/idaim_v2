#= require _jquery
#= require _d3
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
			arr.push [edo, cal]

		arr.sort (a,b)->
			return a[1] - b[1]

		last = arr[0]
		first = arr[arr.length-1]
		$('#total-ultimo').find('h2').text(last[1])
		$('#total-primero').find('h2').text(first[1])
		
		$('#total-ultimo').find('h3').text(IDAIM.estado last[0])
		$('#total-primero').find('h3').text(IDAIM.estado first[0])

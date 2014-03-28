ColorStuff =
	fijo: (val)->
		if val < 59
			#todos flunkean duro
			return '#D3282F'
		if val < 79
			return '#F7C639'
		else
			return '#8AC65A'
	lineal: (val)->
		if val <= 59
			set = Colores.lineales[0]
		else if val < 79 and val > 59
			set = Colores.lineales[1]
		else
			set = Colores.lineales[2]

		col = '#'+set[Math.round((set.length - 1)*(val)/100)]
		col

Colores = {}
Colores.lineales = [
		['D10715', 'CC4C59', 'E887A5', 'F4B3CB', 'FFEBF3']
		['D10715', 'FFB510', 'FCD786', 'FFE3AB', 'FFF4C7'],
		['72AF31', '94CA65', 'AAD687', 'CAE6B6', 'E5EED4'],
	]


Color = ColorStuff.lineal
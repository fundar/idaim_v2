ColorStuff =
	fijo: (val)->
		if val < 59
			#todos flunkean duro
			return '#d5001b'
		if val < 79
			return '#fccf20'
		else
			return '#6cb439'
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
	['73161A', '8B1B1F', 'A31F25', 'BB242A', 'D3282F'],
	['E87321', 'ED861E', 'F3981A', 'F8AB17', 'FDBD13'],
	['8AC65A', '81BD47', '78B434', '6FAA20', '66A10D']
]


Colores.lineales = [
	['E2031E', 'DB3333', 'E64C4B', 'F26860', 'F98E78'] #rojo
	['FED900','FBE34D','FCD786','FCE586','FEF9C4'].reverse(), #amarillo
	['72AF31', '94CA65', 'AAD687', 'CAE6B6', 'E5EED4'].reverse(), #verde
]

Color = ColorStuff.fijo
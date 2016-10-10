class Trabajo {
	var dinero 
	var nivelDeFelicidad
	constructor (unDinero,unNivelDeFelicidad){
		dinero = unDinero
		nivelDeFelicidad = unNivelDeFelicidad
	}
	
	method sueldo(empleado){
		return dinero
	}
	
	method cambiarFelicidad(empleado) {
		empleado.aumentarFelicidad(nivelDeFelicidad)
	}
}



class Copado inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	
}


class Mercenario inherits Trabajo {
	constructor(dinero,nivelDeFelicidad) = super(dinero,nivelDeFelicidad)
	override method sueldo(empleado) {
		return 100 + empleado.dinero()*0.02
	}	
}

class Aburrido inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	
	override method cambiarFelicidad(empleado) {
		empleado.aumentarFelicidad(- nivelDeFelicidad)
	}
	
}

object desempleado {
 	method sueldo (desempleado) {
		return 0
	}
	method cambiarFelicidad (desempleado) {
		desempleado.aumentarFelicidad(0)
	}
}



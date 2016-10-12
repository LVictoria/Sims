import trabajos.*

class AburridoHastaLaMuerte inherits Trabajo {
	var n 
	
	constructor(dinero,nivelDeFelicidad,unaCantidad) = super (dinero,nivelDeFelicidad) {
		n = unaCantidad
	}
 		
	override method cambiarFelicidad(empleado) {
		empleado.aumentarFelicidad(- nivelDeFelicidad * n )
	}
}


class MercenarioSocial inherits Trabajo  {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	
	override method sueldo(empleado) {
		return 100 + empleado.dinero()*0.02 + self.comision(empleado)
	}
	
	method comision (empleado) {
		return empleado.amigos().size()
	}
	
} 
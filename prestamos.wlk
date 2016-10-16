class Prestamo {
 	
	var simPrestamista
 	var simDeudor
 	var dinero
 	
 	constructor(unSimPrestamista, unSimDeudor, unDinero){
 		dinero = unDinero	
 		simPrestamista = unSimPrestamista
 		simDeudor = unSimDeudor
 	}
 	
 	method realizarPrestamo(){
 		if(self.puedePrestar()){
 			simPrestamista.prestarDinero(dinero)
 			simDeudor.ganarDinero(dinero)
 		}
 		
 		else {
 			self.error("No se puede realizar el prestamo")
 		}
 
 	}
 	
 	method puedePrestar(){
 		return self.prestamistaTieneSuficiente() && self.estaDispuestoAPrestar()
 	}
 	
 	method prestamistaTieneSuficiente(){
 		return simPrestamista.dinero() > dinero
 	}
 	
 	method estaDispuestoAPrestar(){
 		return (self.valorAPrestar() >= dinero) && (simPrestamista.personalidad().prestar(simDeudor, dinero))
 	}
 	
 	method valorAPrestar(){
 		return simPrestamista.valorar(simDeudor) * 10
 	}
 	
 }
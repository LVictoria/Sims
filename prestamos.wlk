
class Prestamo {
var dinero
var simPrestamista
var simDeudor
	constructor(unSimPrestamista, unSimDeudor, unDinero)
	{
		dinero = unDinero	
		simPrestamista = unSimPrestamista
		simDeudor = unSimDeudor
	}
	method realizarPrestamo()
	{
		
		if(self.puedePrestar())
		{
			simPrestamista.prestarDinero(dinero)
			simDeudor.ganarDinero(dinero)
		}
	}
	method puedePrestar()
	{
		
		return self.prestamistaTieneSuficiente() && self.estaDispuestoAPrestar()
	}
	method prestamistaTieneSuficiente()
	{
		return simPrestamista.dinero() > dinero
	}
	
	method estaDispuestoAPrestar()
	{
		return self.valorAPrestar() < dinero && simPrestamista.personalidad().Prestar(simDeudor, dinero)
	}
	method valorAPrestar()
	{
		return simPrestamista.valorar(simDeudor) * 10
	}

}
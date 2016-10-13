

object interesado {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return amigo.dineroDeMisAmigos() * 0.1
	}

	method atraccion(simAtractivo, sim){
		return (simAtractivo.dinero() *2 > sim.dinero() ) 
		}
	method prestar(simDeudor, dinero)
	{
		return simDeudor.dinero() > dinero
	}
}

object superficial {
	
	method  valorarSegun(amigo,nivelDeFelicidad) {
		return 20 * amigo.nivelDeFelicidad()
	}
	
	
	method atraccion(simAtractivo, sim) {
		return sim.amigoMasPopular().obtenerNivelDePopularidad()  <= simAtractivo.obtenerNivelDePopularidad() && simAtractivo.esJoven()
	}
	method prestar(simDeudor, dinero)
	{
		return true
	}
	
}

object buenazo {
	
	method valorarSegun (amigo,nivelDeFelicidad) {
		return nivelDeFelicidad * 0.5
	}
	
	method trabajaConSusAmigos(unSim) {
		if(unSim.trabajaConTodosSusAmigos()){
			unSim.aumentarFelicidad(unSim.obtenerNivelDeFelicidad() * 0.1)
	}}

	method atraccion(simAtractivo,sim){
		return true
	}
	method prestar(simDeudor, dinero)
	{
		return true
	}
}


object peleadoConLaVida {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return 0
	}
	

	method atraccion(unSimAtractivo, unSim){
		return unSimAtractivo.nivelDeFelicidad() < 200
	}
	method prestar(simDeudor, dinero)
	{
		return true
	}
}
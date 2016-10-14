class Relacion { 	
	var sim1
	var sim2
	var miembros = #{} 
	var amigosCompartidos= #{}
	var relacionActiva =  true
	
	
	constructor(unSim, otroSim) {
		//FIXME ¿no les parece un poco complejo este código?
		//¿No ven lógica repetida?  �ARREGLADO?
		
		if(unSim.esSoltero() && otroSim.esSoltero() && not unSim.esJovenParaRelacion() && not otroSim.esJovenParaRelacion()){
			sim1= unSim
			sim2= otroSim
			self.agregarCirculoDeAmigos()
			self.iniciarRelacion(sim1,sim2)
			self.iniciarRelacion(sim2,sim1)
		}
		else{
		 error.throwWithMessage("No pueden iniciar la relaci�n")}
	}	
	
	
	//Getters 
	method miembros () {
		return  miembros
	}
	

	method circuloDeAmigos () {
		return amigosCompartidos
	}
	
	// 
	
	method iniciarRelacion(unSim,otroSim) {
			miembros.add(unSim)
			unSim.nuevaPareja(otroSim,self)
	}

	
	method terminoLaRelacion() {
		return not  relacionActiva
	}
	
	method formaParte(sim) {
		return self.miembros().contains(sim)
	}
	

	method agregarCirculoDeAmigos() { 
		sim1.amigos().forEach{amigo => amigosCompartidos.add(amigo)}
		sim2.amigos().forEach{amigo => amigosCompartidos.add(amigo)}
		
	}
	
	
	method sePudreTodo () {
		return not self.relacionFunciona() && self.algunoSienteAtraccionPorOtro()
	}
	
	method algunoSienteAtraccionPorOtro () {
		return sim1.atraccionPorAlgunAmigoDe(sim2) || sim2.atraccionPorAlgunAmigoDe(sim1)
	}

	method relacionFunciona() {
		return self.seSientenAtraidos()
	}	
	
	method seSientenAtraidos() {
		return sim1.atraccion(sim2) && sim2.atraccion(sim1) 
	}
	
	method terminarRelacion(){
		miembros = #{}
		amigosCompartidos = #{}
		relacionActiva= false 
		soltero.iniciarSolteria(sim1)
		soltero.iniciarSolteria(sim2)
		
	}
	
}

object soltero {
	method iniciarSolteria(sim){
		sim.pareja(self)
	}
}
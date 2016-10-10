

object celos {
	

	method efecto(amigosAEliminar,sim){
		sim.romperAmistad(amigosAEliminar)
	}
	
}

object celosPorPlata {
	
	method amigosAEliminar(sim) {
		return sim.amigos().filter{amigo => amigo.dinero() > sim.dinero()}
	}

	method efectoCelos(sim){
		celos.efecto(self.amigosAEliminar(sim),sim)
	}
}

object celosPorPopularidad  {
	method amigosAEliminar(sim) {
		return sim.amigos().filter{amigo => amigo.nivelDePopularidad() > sim.nivelDePopularidad()}
	}

	method efectoCelos(sim){
		celos.efecto(self.amigosAEliminar(sim),sim)
	}
}

object celosPorPareja{
	method amigosAEliminar(sim) {
		return sim.amigos().filter{amigo => sim.pareja().esAmigo(amigo)}
	}

	method efectoCelos(sim){
		celos.efecto(self.amigosAEliminar(sim),sim)
	}
}
object soniador  {
	method efecto(unSim){
		//FIXME ¡ojo que cuando sale del estado soñador, la amnesia se va !
		
		//So�ador (Nube de Gas): mientras tenga este estado de �nimo, el nivel de felicidad del Sim est� por las nubes (1000 m�s lo que ya ten�a),
		// y no se acuerda de nada (se comporta como si no tuviera ning�n conocimiento).  
		unSim.aumentarFelicidad(1000)
		unSim.tenerAmnesia()
		
	}
}

object incomodo {
	 method efecto(sim){
	 	 sim.aumentarFelicidad(- 200)
	 }
}

object normal {
	method efecto(sim){
		sim.aumentarFelicidad(0)
	}
}
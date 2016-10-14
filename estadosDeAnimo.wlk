object soniador  {
	method efecto(unSim){
		//FIXME Â¡ojo que cuando sale del estado soÃ±ador, la amnesia se va!
		
		//Soñador (Nube de Gas): mientras tenga este estado de ánimo, el nivel de felicidad del Sim está por las nubes (1000 más lo que ya tenía),
		// y no se acuerda de nada (se comporta como si no tuviera ningún conocimiento).  
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
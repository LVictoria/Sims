import sims.*

class FuenteDeInformacion {
	 
	 method proveerInformacion (sim) {
	 	sim.nuevaInformacion(self.pedirInformacion())
	 }
	 
	 method pedirInformacion () { return null }
	  
}


class Libro inherits FuenteDeInformacion{
  var capitulos
  
  constructor(unosCapitulos) {
  capitulos = unosCapitulos
  }
  
  override method pedirInformacion () {
  	return capitulos.anyOne()
  }
  
 }

 
object rial inherits FuenteDeInformacion {
 	 override method pedirInformacion () {
  		return 'Escandalo'
  }
 	
 }


object tinelli inherits FuenteDeInformacion{

  override method pedirInformacion () {
  	return 'Toto'
  }
 
 }
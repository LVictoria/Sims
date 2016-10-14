import sims.*

class FuenteDeInformacion {
	var informacion = #{}
	 
	 method proveerInformacion (sim) {
	 	sim.nuevaInformacion(self.pedirInformacion())
	 }
	 
	 method pedirInformacion () {
	 	return informacion
	 }
	  
}


class Libros inherits FuenteDeInformacion{
  var capitulos = #{}
  
  constructor(unosCapitulos) {
  capitulos = unosCapitulos
  }
  
  override method pedirInformacion () {
  	return capitulos.anyOne()
  }
  
 }

 
object rial inherits FuenteDeInformacion {
 	override method pedirInformacion () {
  		return #{"Esc�ndalo"}
  }
 	
 }


object tinelli inherits FuenteDeInformacion{

 override method pedirInformacion () {
  	return #{"Tot�"}
  }
 
 }
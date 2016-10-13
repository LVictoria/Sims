class Libros {
  var capitulos
  
  constructor(_capitulos) {
  capitulos = _capitulos
  }
  
  method pedirInformacion() {
    return capitulos.anyOne()
  }
 }
 
object rial {
 method pedirInformacion() {
    return "Escándalo"
 }

object tinelli {
 method pedirInformacion() {
    return "Totó"
 }

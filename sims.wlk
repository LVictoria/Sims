
class Sims {
	
	var sexo 
	var	edad
	var nivelDeFelicidad = 100
	var amigos = []
	var nivelDePopularidad
	var personalidad
	var dinero = 0 
	var trabajoActual
	
	constructor (_sexo, _edad, _nivelDeFelicidad, _nivelDePopularidad, _personalidad)
	 {
	 	sexo = _sexo
	 	edad = _edad
		nivelDeFelicidad = _nivelDeFelicidad
		nivelDePopularidad = _nivelDePopularidad
		personalidad = _personalidad
	 }
	
	
	
	// Getters 
	method sexoActual () {
		return sexo 
	}
	
	method nivelDeFelicidad () {
		return nivelDeFelicidad
	}
	
	method personalidad() {
		return personalidad
	}
	
	method dinero () {
		return dinero 
	}
	
	method trabajo(){
		return trabajoActual
	}
	//Felicidad 
	 method modificarFelicidad(cantidad){
	 	nivelDeFelicidad += cantidad
	 }
	
	// Popularidad
	method nivelDePopularidad () {
		nivelDePopularidad = amigos.sum{amigo => amigo.nivelDeFelicidad()}
		return nivelDePopularidad
	}
	
	method amigoMasPopular () {
		return amigos.max{amigo => amigo.nivelDePopularidad()}
	}
	
	method soyPopular() {
		return self.nivelDePopularidad() > self.amigoMasPopular().nivelDePopularidad()
	}
	
	// Amistades
	
	method hacerseAmigo (nuevoAmigo) {
		amigos.add(nuevoAmigo)
		nivelDeFelicidad += self.valorar(nuevoAmigo,self.nivelDeFelicidad())
	}
	
	method esAmigo (amigo) {
		amigos.contains(amigo)
	}
	
	 
	// Valoracion
	method valorar (nuevoAmigo,_nivelDeFelicidad) {
		 return self.personalidad().valorarSegun(nuevoAmigo,_nivelDeFelicidad)
	}
	
	method amigoMasValorado (){
		return amigos.max{amigo => self.valorar(amigo,self.nivelDeFelicidad())}
	}
	
	//Abrazos 
	
 	
 	//Dinero y Trabajo 
	method ganarDinero(_dinero) {
		dinero += _dinero
	}

	
	method dineroDeMisAmigos () {
		return  amigos.sum{amigo => amigo.dinero()}
	}
	
	
	method nuevoEmpleo(trabajo) {
		trabajoActual = trabajo
	}
	
	method trabajar() {
		if (trabajoActual == null ){
			self.ganarDinero(0)
			self.modificarFelicidad(0)
			}
		else 
		trabajoActual.pasarUnDia(self)
		self.verificar() 
	}
	
	method verificar (){
		if(personalidad == buenazo && self.trabajaConTodosSusAmigos()){
			nivelDeFelicidad = nivelDeFelicidad * 1.1
	}}
	
	method trabajaConTodosSusAmigos() {
		return amigos.all{amigo => self.trabajanJuntos(amigo)}
	}
	
	method trabajanJuntos(_sim){
		return _sim.trabajo() == self.trabajo()
	}
	
}

//Personalidades

object interesados {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return amigo.dineroDeMisAmigos()
	}
}


object superficiales {
	
	method  valorarSegun(amigo,nivelDeFelicidad){
		return 20 * amigo.nivelDeFelicidad()
	}
}

object buenazo {
	
	method valorarSegun (amigo,nivelDeFelicidad) {
		return nivelDeFelicidad * 0.5
	}
}

object peleadoConLaVida {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return 0
	}
}


// Trabajo y tipos 

class Trabajo {
	var dinero 
	var nivelDeFelicidad
	constructor (_dinero,_nivelDeFelicidad){
		dinero = _dinero
		nivelDeFelicidad = _nivelDeFelicidad
		
	}
}
class Copados inherits Trabajo {
	constructor(_dinero,_nivelDeFelicidad)= super(_dinero,_nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(_dinero)
		empleado.modificarFelicidad(_nivelDeFelicidad)
	}
	
}

class Mercenarios inherits Trabajo {
	constructor(_dinero,_nivelDeFelicidad)= super(_dinero,_nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(100 + empleado.dinero()*0.02)
	}
	
}

class Aburridos inherits Trabajo {
	constructor(_dinero,_nivelDeFelicidad)= super(_dinero,_nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(_dinero)
		empleado.modificarFelicidad(- _nivelDeFelicidad)
	}
	
}



 

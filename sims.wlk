
class Sim {
	var sexo 
	var	edad
	var nivelDeFelicidad
	var amigos = []
	var nivelDePopularidad
	var personalidad
	var dinero = 0 
	var trabajoActual
	var sexoPreferencia

	constructor (_sexo, _edad, _nivelDeFelicidad, _nivelDePopularidad, _personalidad, _sexoPreferencia)

	 {
	 	sexoPreferencia = _sexoPreferencia
	 	sexo = _sexo
	 	edad = _edad
		nivelDeFelicidad = _nivelDeFelicidad
		nivelDePopularidad = _nivelDePopularidad
		personalidad = _personalidad
		sexoPreferencia = _sexoPreferencia
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
	
	method sexo() {
		return sexo
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
	
	method esPopular() {
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
		if (trabajoActual != null ){
		trabajoActual.pasarUnDia(self)
		self.verificar() 
	}}
	
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
	
//Atracciones
	
	method atraccion(_sim){
		return sexoPreferencia == _sim.sexo() && personalidad.atraccion(_sim,self)
	}
	
}

//Personalidades

object interesado {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return amigo.dineroDeMisAmigos()
	}

	method atracciones(_simAtractivo, _sim){
		return (_sim.dinero() *2) 
		}
}

object superficial {
	
	method  valorarSegun(amigo,nivelDeFelicidad) {
		return 20 * amigo.nivelDeFelicidad()
	}
	
	
	method atracciones(_simAtractivo, _sim) {
		return _sim.amigoMasPopular().nivelDePopularidad()  <= _simAtractivo.nivelDePopularidad()
	}
}

object buenazo {
	
	method valorarSegun (amigo,nivelDeFelicidad) {
		return nivelDeFelicidad * 0.5
	}

	method atracciones(){
		return true
	}
}


object peleadoConLaVida {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return 0
	}
	

	method atracciones(_simAtractivo, _sim){
		return _simAtractivo.nivelDeFelicidad() < 200
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
class Copado inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(dinero)
		empleado.modificarFelicidad(nivelDeFelicidad)
	}
	
}

class Mercenario inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(100 + empleado.dinero()*0.02)
	}
	
}

class Aburrido inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	method pasarUnDia(empleado) {
		empleado.ganarDinero(dinero)
		empleado.modificarFelicidad(- nivelDeFelicidad)
	}
	
}



 



 

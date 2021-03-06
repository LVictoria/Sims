 
//FIXME deberían separar su proyecto en varios archivos. Por ejemplo, uno
// que contenga la declaración del Sim, otro que contenga los abrazos, etc. 
 import personalidades.*
 import trabajos.*
 import relaciones.*
 import celos.*
 import estadosDeAnimo.*
 import abrazos.*
 import nuevosTrabajos.*
 import fuentesDeInformacion.*
 import prestamos.*
 
class Sim inherits FuenteDeInformacion {
	var sexo 
	var	edad
	var nivelDeFelicidad
	var amigos = []
	var nivelDePopularidad
	var personalidad
	var dinero = 0 
	var trabajoActual = desempleado
	var sexoPreferencia
	var informaciones = #{}
	var backup = #{}
	var chismes = #{}
	var estadoDeAnimo = normal
	var estadoDeCelos
	
	//FIXME modelar al estado de la pareja como un string es muy limitante, 
	//porque no pueden asignarle comportamiento. Sugerencia: representar al estado de la pareja
	//con objetos polimórficos 
	
	var pareja = soltero
	var relacionActual 

	//FIXME prefieran la convención unAlgo en lugar de _algo: menos chirimbolos, más felicidad :D . 
	
	
	constructor (unSexo, unaEdad, unNivelDeFelicidad, unaPersonalidad, unSexoPreferencia)

	 {
	 	sexoPreferencia = unSexoPreferencia
	 	sexo = unSexo
	 	edad = unaEdad
		nivelDeFelicidad = unNivelDeFelicidad
		personalidad = unaPersonalidad
		
	 }
	
	
	
	// Getters 
	
	//FIXME agregar el sufijo Actual no aporta nada de información: siempre que se le envia un mensaje
	//a un objeto y éste responde, está respondiendo en base a su conocimiento actual . 
	
	
	method sexo () {
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
	
	
	method informacion(){
		return informaciones
	}
	
	method amigos(){
		return amigos
	}
	
	method pareja(){
		return pareja
	}
	
	method estadoDeAnimo(){
		return estadoDeAnimo
	}
	
	method edad() {
		return edad 
	}
	//Felicidad 
	
	 method aumentarFelicidad(cantidad){
	 	nivelDeFelicidad = nivelDeFelicidad + cantidad
	 }
	 
	 // Edad 
	 
	 method cumplirAnios(){
	 	edad += 1
	 }
	 
	 method esJoven() {
	 	return edad.between(18,29)
	 }
	 
	 method esJovenParaRelacion() {
	 	return edad.between(0,16)
	}
	 
	 //Estado De Animo 
	 method modificarEstadoDeAnimo(estado){
	 	estadoDeAnimo = estado
	 	estadoDeAnimo.efecto(self)
	 }
	 
	 //FIXME esto no es consistente con el método anterior: 
	 //el estado de ánimo es un objeto que entiende `efecto(unSim)`, pero en este caso 
	 //le están asignando un string! 
	 
	 //method estadoDeAnimoNormal () {
	 	//estadoDeAnimo = 'normal'}
	 
	
	// Popularidad
	//FIXME este método, por el nombre, parecería ser un getter. 
	//Sin embargo, cada vez que se evalua, ¡produce un efecto!
	//Dos envios sucesivos del mensaje `nivelDePopularidad()` deberían producir los mismos resultados 
	
	
	method obtenerNivelDePopularidad () {
		nivelDePopularidad += amigos.sum{amigo => amigo.nivelDeFelicidad()}
		return nivelDePopularidad
	}
	
	
	
	method amigoMasPopular () {
		return amigos.max{amigo => amigo.obtenerNivelDePopularidad()}
	}
	
	
	method esPopular() {
		return self.obtenerNivelDePopularidad() > self.amigoMasPopular().obtenerNivelDePopularidad()
	}
	
	// Amistades
	
	method hacerseAmigo (nuevoAmigo) {
		amigos.add(nuevoAmigo)
		//TODO en lugar de modificar el nivel de felicidad cada vez que haen a un amigo, 
		//quizás seria una mejor idea tener un getter que lo calcule en 
		//base a las valoraciones de sus amigos. 
		
		
		 self.aumentarFelicidad(self.valorar(nuevoAmigo))
	}
	
	

	method esAmigo (amigo) {
		return amigos.contains(amigo)
	}
	
	method romperAmistad(_amigos) {
		amigos.remove(_amigos)
	}
	

	method buscarAmigos(antiguedad, cantidad){
		self.tieneSuficientesAmigos(cantidad)
		if( antiguedad ==  "Recientes"){
			return amigos.drop(amigos.size() - cantidad)}
		else{
			return amigos.take(cantidad)
			}
	}
	
	method tieneSuficientesAmigos(cantidad)
	{
		if(amigos.size() < cantidad ){
			error.throwWithMessage("No tienen tantos amigos")
		}
	}
	
	
	//method amigosMasAntiguos(numero) {
		//FIXME ¿no ven lógica repetida entre este método y el anterior?
		//¡Elimínenla! 
		
		//self.tieneSuficientesAmigos(nro);
		//return amigos.take(nro)}
	//
	 
	// Valoracion
	method valorar(nuevoAmigo) {
		 return self.personalidad().valorarSegun(nuevoAmigo,nivelDeFelicidad)
	}
	
	method amigoMasValorado (){
		return amigos.max({amigo => self.valorar(amigo)})
	}
	
	//Abrazos 
	method darAbrazo(tipo,sim){
		tipo.resultadoAbrazo(self,sim)
	}
	
	
	//Relaciones
	method pareja(unaPareja){
		pareja = unaPareja
	}

	
	method nuevaPareja(unaPareja,unaRelacion){
		pareja =unaPareja
		relacionActual = unaRelacion
	}
	
	method esSoltero(){
		return pareja == soltero
	}
	

 	//Dinero y Trabajo 
	method ganarDinero(unDinero) {
		dinero += unDinero
	}
	
	method prestarDinero(unDinero){
		dinero -=unDinero
	}
	
	method dineroDeMisAmigos () {
		return  amigos.sum{amigo => amigo.dinero()}
	}
	
	
	method nuevoEmpleo(trabajo) {
		trabajoActual = trabajo
	}
	
	
	
	method trabajar() {
		//FIXME es una mala idea modelar utilizando null's, porque no pueden asignarle comportamiento
		//Piensen cómo modelar la ausencia de trabajo SIN utilizar nulls
		self.ganarDinero(trabajoActual.sueldo(self))
		trabajoActual.cambiarFelicidad(self)
		trabajoActual.cambiarEstadoDeAnimo(self)
		if(personalidad == buenazo){ 
			personalidad.trabajaConSusAmigos()}
		//FIXME acuérdense de formatear el código apropiadamente
		}
	
	
	//method verificarSiTrabajaConSusAmigos (){
		//FIXME pueden resolver esto sin utilizar un if y el operador ==?
		//La clave de objetos es delegar polimórficamente resposnabilidades de un objeto hacia otro, 
		//pero cuando preguntan por el tipo o identidad de un objeto, y hacen cosas diferentes en función
		//de ellos, están evitando la delegación de responsabilidades
		//if(personalidad == buenazo && self.trabajaConTodosSusAmigos()){
			//nivelDeFelicidad = nivelDeFelicidad * 1.1}
			//self.personalidad().trabajaConSusAmigos()}
	
	method trabajaConTodosSusAmigos() {
		return amigos.all{amigo => self.trabajanJuntos(amigo)}
	}
	
	method trabajanJuntos(unSim){
		return unSim.trabajo() == self.trabajo()
	}
	
	//Atracciones
	
	method atraccion(unSim){
		return sexoPreferencia == unSim.sexo() && personalidad.atraccion(unSim,self)
	}

	method atraccionPorAlgunAmigoDe(_sim) {
		return _sim.amigos().any{amigo => self.atraccion(amigo)}
	}
	
	method quienesAtraen(coleccion){
		return coleccion.filter({sim => self.atraccion(sim)})
	}
	
	//Informacion
	
	method nuevaInformacion(unaInformacion){
		informaciones.add(unaInformacion)
	}
	
	//FIXME noten que acá están utilizando de forma inconsistente el término `informacion`: 
	//En el método anterior representa a un conocimiento individual, mientras que en el segundo representa
	//a un conjunto de conocimientos  
	
	
	method modificarInformacion(modificacion) {
		informaciones = modificacion
	}
	
	
	method tenerAmnesia() {
		backup.addAll(informaciones)
		informaciones = #{}
		
	}
	
	method recuperarInformacion(){
		informaciones.addAll(backup)
	}

	method conocedor (){
		return informaciones.map{informacion => informacion.size()}.sum()
	}
	
	method tieneElConocimiento(unaInfomacion){ 
		return informaciones.contains(unaInfomacion)
	}
	
	method esSecreto(unConocimiento) {
		return self.tieneElConocimiento(unConocimiento) && self.nadieLoConoce(unConocimiento)
	}
	
	method nadieLoConoce(unConocimiento){
		return not(amigos.any({amigo => amigo.tieneElConocimiento(unConocimiento) }))
	}
	
	method difundirInformacion(unConocimiento) {
		if(not(self.tieneElConocimiento(unConocimiento))){
			amigos.forEach({amigo => amigo.nuevaInformacion(unConocimiento)})
			self.nuevaInformacion(unConocimiento)
		}
	}	
	
	method	chismeDe(unSim){
		  return unSim.informacion().find({informacion => unSim.esSecreto(informacion)})
	
		}
		
	method agregarChismeDe(unSim){
		chismes.add(self.chismeDe(unSim))
	}
	
		
	method desparramarChisme(){
		self.difundirInformacion(self.pedirInformacion())
	}
	
	override method pedirInformacion(){
		return chismes.anyOne()
	}
	
	
	//Celos
	
	method ataqueDeCelos(tipoDeCelos){
		estadoDeCelos = tipoDeCelos
		self.aumentarFelicidad(-10)
		tipoDeCelos.efectoCelos(self)	
	}
	
	
}


class Vim inherits Sim {
	
	constructor (unSexo, unaEdad, unNivelDeFelicidad, unaPersonalidad, unSexoPreferencia) = super(unSexo, 18, unNivelDeFelicidad, unaPersonalidad, unSexoPreferencia)
	
	override method cumplirAnios(){
		edad +=0
	}
}	



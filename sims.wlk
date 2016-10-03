//FIXME deberían separar su proyecto en varios archivos. Por ejemplo, uno
// que contenga la declaración del Sim, otro que contenga los abrazos, etc. 

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
	var informaciones = #{}
	var estadoDeAnimo = 'normal'
	var estadoDeCelos
	//FIXME modelar al estado de la pareja como un string es muy limitante, 
	//porque no pueden asignarle comportamiento. Sugerencia: representar al estado de la pareja
	//con objetos polimórficos
	var pareja = 'soltero'
	var relacionActual 

	//FIXME prefieran la convención unAlgo en lugar de _algo: menos chirimbolos, más felicidad :D
	constructor (_sexo, _edad, _nivelDeFelicidad, _nivelDePopularidad, _personalidad, _sexoPreferencia)

	 {
	 	sexoPreferencia = _sexoPreferencia
	 	sexo = _sexo
	 	edad = _edad
		nivelDeFelicidad = _nivelDeFelicidad
		nivelDePopularidad = _nivelDePopularidad
		personalidad = _personalidad
		//FIXME seteen el sexo de preferencia una sola vez
		sexoPreferencia = _sexoPreferencia
	 }
	
	
	
	// Getters 
	//FIXME agregar el sufijo Actual no aporta nada de información: siempre que se le envia un mensaje
	//a un objeto y éste responde, está respondiendo en base a su conocimiento actual
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
	
	method informacion(){
		return informaciones
	}
	
	method amigos(){
		return amigos
	}
	
	method pareja(){
		return pareja
	}
	
	method estadoDeAnimoActual(){
		return estadoDeAnimo
	}
	
	//Felicidad 
	//FIXME este método no permite realizar modificaciones arbitrarias a la felicidad, sino tan sólo
	//aumentarla. Entonces lo llamaría aumentarFelicidad	
	 method modificarFelicidad(cantidad){
	 	nivelDeFelicidad = nivelDeFelicidad + cantidad
	 }
	 
	 // Edad 
	 
	 method esJoven() {
	 	return edad.between(18,29)
	 }
	 
	 //Estado De Animo 
	 method estadoDeAnimo(estado){
	 	estadoDeAnimo =  estado
	 	estadoDeAnimo.efecto(self)
	 }
	 
	 //FIXME esto no es consistente con el método anterior: 
	 //el estado de ánimo es un objeto que entiende `efecto(unSim)`, pero en este caso 
	 //le están asignando un string!
	 method estadoDeAnimoNormal () {
	 	estadoDeAnimo = 'normal'
	 }
	
	// Popularidad
	//FIXME este método, por el nombre, parecería ser un getter. 
	//Sin embargo, cada vez que se evalua, ¡produce un efecto!
	//Dos envios sucesivos del mensaje `nivelDePopularidad()` deberían producir los mismos resultados
	method nivelDePopularidad () {
		nivelDePopularidad += amigos.sum{amigo => amigo.nivelDeFelicidad()}
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
		//TODO en lugar de modificar el nivel de felicidad cada vez que haen a un amigo, 
		//quizás seria una mejor idea tener un getter que lo calcule en 
		//base a las valoraciones de sus amigos. 
		nivelDeFelicidad += self.valorar(nuevoAmigo)
	}

	method esAmigo (amigo) {
		return amigos.contains(amigo)
	}
	
	method romperAmistad(_amigos) {
		amigos.remove(_amigos)
	}
	

	method amigosMasRecientes(nro){
		//TODO procuren no utilizar abreviaturas en los parámetros de los métodos: sean expresivos
		if(amigos.size() < nro ){
			error.throwWithMessage("No tienen tantos amigos")
		}
		return amigos.drop(amigos.size()- nro)
	}
	
	method amigosMasAntiguos(nro) {
		//FIXME ¿no ven lógica repetida entre este método y el anterior?
		//¡Elimínenla!
		if(amigos.size() < nro ){
			error.throwWithMessage("No tienen tantos amigos")
		}
		return amigos.take(nro)
	}
	 
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
	method pareja(_pareja){
		pareja = _pareja
	}

	
	method nuevaPareja(_pareja,_relacion){
		pareja =_pareja
		relacionActual = _relacion
	}
	
	method esSoltero(){
		return pareja == 'soltero'
	}
	

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
		//FIXME es una mala idea modelar utilizando null's, porque no pueden asignarle comportamiento
		//Piensen cómo modelar la ausencia de trabajo SIN utilizar nulls
		if (trabajoActual != null ){
		trabajoActual.pasarUnDia(self)
		self.verificarSiTrabajaConSusAmigos() 
		//FIXME acuérdense de formatear el código apropiadamente
	}}
	
	method verificarSiTrabajaConSusAmigos (){
		//FIXME pueden resolver esto sin utilizar un if y el operador ==?
		//La clave de objetos es delegar polimórficamente resposnabilidades de un objeto hacia otro, 
		//pero cuando preguntan por el tipo o identidad de un objeto, y hacen cosas diferentes en función
		//de ellos, están evitando la delegación de responsabilidades
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

	method atraccionPorAlgunAmigoDe(_sim) {
		return _sim.amigos().any{amigo => self.atraccion(amigo)}
	}
	
	method quienesAtraen(coleccion){
		return coleccion.filter({sim => self.atraccion(sim)})
	}
	
	//Informacion
	method nuevaInformacion(_informacion){
		informaciones.add(_informacion)
	}
	
	//FIXME noten que acá están utilizando de forma inconsistente el término `informacion`: 
	//En el método anterior representa a un conocimiento individual, mientras que en el segundo representa
	//a un conjunto de conocimientos
	method modificarInformacion(modificacion) {
		informaciones = modificacion
	}
	
	//TODO más que `amnesia()` lo llamaría `tenerAmnesia`: recuerden que los métodos
	//que representan acciones (con efecto) suelen contener verbos en el nombre
	method amnesia() {
		informaciones = #{}
	}
	
	method conocedor (){
		return informaciones.map{informacion => informacion.size()}.sum()
	}
	
	method tieneElConocimiento(infomacion){ 
		return informaciones.contains(infomacion)
	}
	
	
	//Celos
	
	method ataqueDeCelos(tipoDeCelos){
		estadoDeCelos = tipoDeCelos
		self.modificarFelicidad(-10)
		tipoDeCelos.efectoCelos(self)
		
	}
	

}

//Personalidades

object interesado {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return amigo.dineroDeMisAmigos() * 0.1
	}

	method atraccion(_simAtractivo, _sim){
		return (_simAtractivo.dinero() *2 > _sim.dinero() ) 
		}
}

object superficial {
	
	method  valorarSegun(amigo,nivelDeFelicidad) {
		return 20 * amigo.nivelDeFelicidad()
	}
	
	
	method atraccion(_simAtractivo, _sim) {
		return _sim.amigoMasPopular().nivelDePopularidad()  <= _simAtractivo.nivelDePopularidad() && _simAtractivo.esJoven()
	}
	
}

object buenazo {
	
	method valorarSegun (amigo,nivelDeFelicidad) {
		return nivelDeFelicidad * 0.5
	}

	method atraccion(_simAtractivo,_sim){
		return true
	}
}


object peleadoConLaVida {
	
	method valorarSegun(amigo,nivelDeFelicidad) {
		return 0
	}
	

	method atraccion(_simAtractivo, _sim){
		return _simAtractivo.nivelDeFelicidad() < 200
	}
}


// Trabajo y tipos 

//FIXME ¡esta clase no tienen ningún comportamiento!
//Si no pueden asignarle responsabilidades a la clase, entonces lo mas probable
//es que esa clase no tenga razón de ser
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
		//FIXME noten que todos los trabajos, dentro de `pasarUnDia(unEmpleado)` terminan
		//enviandole al empleando `ganarDinero(unDinero)`. 
		//Eso es lógica repetida: ¿no podrían evitarla de alguna forma?
		empleado.ganarDinero(dinero)
		empleado.modificarFelicidad(- nivelDeFelicidad)
	}
	
}


//Tipo Abrazos

object abrazoComun{
	method resultadoAbrazo(_abrazador, _abrazado){
		_abrazador.modificarFelicidad(2)
		_abrazado.modificarFelicidad(4)
	}
}

object abrazoProlongado {
	method resultadoAbrazo(_abrazador, _abrazado)
	{
		if(_abrazado.atraccion(_abrazador)){
			_abrazado.estadoDeAnimo(soniador)
		}
		else
		{
			_abrazado.estadoDeAnimo(incomodo)
		}
	}}
	
//Estados De Animo


object soniador  {
	method efecto(_sim){
		//FIXME ¡ojo que cuando sale del estado soñador, la amnesia se va!
		_sim.modificarFelicidad(1000)
		_sim.amnesia()
		
	}
}

object incomodo {
	 method efecto(sim){
	 	sim.modificarFelicidad(- 200)
	 }
}

//Celos

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

//Relaciones

class Relacion { 	
	var sim1
	var sim2
	var miembros = #{} 
	var amigosCompartidos= #{}
	var relacionActiva =  true
	
	
	constructor(_sim1, _sim2) {
		if(_sim1.esSoltero() && _sim2.esSoltero()){
			sim1 = _sim1
			sim2= _sim2
			miembros.add(sim1)
			miembros.add(sim2)
			self.agregarCirculoDeAmigos()
			sim1.nuevaPareja(sim2 , self)
			sim2.nuevaPareja(sim1,self )}
		else{
		 error.throwWithMessage("No estan solteros")}
		 }	
	
	
	//Getters 
	method miembros () {
		return  miembros
	}
	

	method circuloDeAmigos () {
		return amigosCompartidos
	}
	
	// 
	
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
		sim1.nuevaPareja('soltero',self)
		sim2.nuevaPareja('soltero',self)
		
	}
	
}
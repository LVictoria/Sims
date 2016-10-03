//FIXME deberÃ­an separar su proyecto en varios archivos. Por ejemplo, uno
// que contenga la declaraciÃ³n del Sim, otro que contenga los abrazos, etc. 

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
	//con objetos polimÃ³rficos
	var pareja = 'soltero'
	var relacionActual 

	//FIXME prefieran la convenciÃ³n unAlgo en lugar de _algo: menos chirimbolos, mÃ¡s felicidad :D
	constructor (unSexo, unEdad, unNivelDeFelicidad, unNivelDePopularidad, unaPersonalidad, unSexoPreferencia)

	 {
	 	sexoPreferencia = unSexoPreferencia
	 	sexo = unSexo
	 	edad = unEdad
		nivelDeFelicidad = unNivelDeFelicidad
		nivelDePopularidad = unNivelDePopularidad
		personalidad = unaPersonalidad
		//FIXME seteen el sexo de preferencia una sola ve
	 }
	
	
	
	// Getters 
	//FIXME agregar el sufijo Actual no aporta nada de informaciÃ³n: siempre que se le envia un mensaje
	//a un objeto y Ã©ste responde, estÃ¡ respondiendo en base a su conocimiento actual
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
	//FIXME este mÃ©todo no permite realizar modificaciones arbitrarias a la felicidad, sino tan sÃ³lo
	//aumentarla. Entonces lo llamarÃ­a aumentarFelicidad	
	 method aumentarFelicidad(cantidad){
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
	 
	 //FIXME esto no es consistente con el mÃ©todo anterior: 
	 //el estado de Ã¡nimo es un objeto que entiende `efecto(unSim)`, pero en este caso 
	 //le estÃ¡n asignando un string!
	 method estadoDeAnimoNormal () {
	 	estadoDeAnimo = 'normal'
	 }
	
	// Popularidad
	//FIXME este mÃ©todo, por el nombre, parecerÃ­a ser un getter. 
	//Sin embargo, cada vez que se evalua, Â¡produce un efecto!
	//Dos envios sucesivos del mensaje `nivelDePopularidad()` deberÃ­an producir los mismos resultados
	method nivelDePopularidad () {
		nivelDePopularidad = amigos.sum{amigo => amigo.nivelDeFelicidad()} //no se si algo mas afecta a la popularidad TODO
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
		//quizÃ¡s seria una mejor idea tener un getter que lo calcule en 
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
		//TODO procuren no utilizar abreviaturas en los parÃ¡metros de los mÃ©todos: sean expresivos
		self.tieneSuficientesAmigos(nro);
		return amigos.drop(amigos.size()- nro)
	}
	method tieneSuficientesAmigos(nro)
	{
		if(amigos.size() < nro ){
			error.throwWithMessage("No tienen tantos amigos")
		}
	}
	method amigosMasAntiguos(nro) {
		//FIXME Â¿no ven lÃ³gica repetida entre este mÃ©todo y el anterior?
		//Â¡ElimÃ­nenla!
		self.tieneSuficientesAmigos(nro);
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
		//Piensen cÃ³mo modelar la ausencia de trabajo SIN utilizar nulls
		if (trabajoActual != null ){
			self.ganarDinero(trabajoActual.sueldo(self))
			trabajoActual.cambiarFelicidad(self)
			self.personalidad().trabajaConSusAmigos()
		//FIXME acuÃ©rdense de formatear el cÃ³digo apropiadamente
		}
	}
	
	/*method verificarSiTrabajaConSusAmigos (){
		//FIXME pueden resolver esto sin utilizar un if y el operador ==?
		//La clave de objetos es delegar polimÃ³rficamente resposnabilidades de un objeto hacia otro, 
		//pero cuando preguntan por el tipo o identidad de un objeto, y hacen cosas diferentes en funciÃ³n
		//de ellos, estÃ¡n evitando la delegaciÃ³n de responsabilidades
		/*if(personalidad == buenazo && self.trabajaConTodosSusAmigos()){
			nivelDeFelicidad = nivelDeFelicidad * 1.1}*/
		//self.personalidad().trabajaConSusAmigos()
	
	//}
	
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
	
	//FIXME noten que acÃ¡ estÃ¡n utilizando de forma inconsistente el tÃ©rmino `informacion`: 
	//En el mÃ©todo anterior representa a un conocimiento individual, mientras que en el segundo representa
	//a un conjunto de conocimientos
	method modificarInformacion(modificacion) {
		informaciones = modificacion
	}
	
	//TODO mÃ¡s que `amnesia()` lo llamarÃ­a `tenerAmnesia`: recuerden que los mÃ©todos
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
	method trabajaConSusAmigos(unSim)
	{
		if(unSim.trabajaConTodosSusAmigos())
		unSim.nivelDeFelicidad = unSim.nivelDeFelicidad * 1.1
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

//FIXME Â¡esta clase no tienen ningÃºn comportamiento!
//Si no pueden asignarle responsabilidades a la clase, entonces lo mas probable
//es que esa clase no tenga razÃ³n de ser
class Trabajo {
	var dinero 
	var nivelDeFelicidad
	constructor (_dinero,_nivelDeFelicidad){
		dinero = _dinero
		nivelDeFelicidad = _nivelDeFelicidad
	}
	method sueldo(empleado)
	{
		return dinero;
	}
}
class Copado inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	method cambiarFelicidad(empleado) {
		empleado.modificarFelicidad(nivelDeFelicidad)
	}
}

class Mercenario inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	override method sueldo(empleado) {
		return 100 + empleado.dinero()*0.02)
	}
	
}

class Aburrido inherits Trabajo {
	constructor(dinero,nivelDeFelicidad)= super(dinero,nivelDeFelicidad)
	method cambiarFelicidad(empleado) {
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
		//FIXME Â¡ojo que cuando sale del estado soÃ±ador, la amnesia se va!
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
		//FIXME Â¿no les parece un poco complejo este cÃ³digo?
		//Â¿No ven lÃ³gica repetida?
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
import estadosDeAnimo.*

object abrazoComun{
	method resultadoAbrazo(abrazador, abrazado){
		abrazador.aumentarFelicidad(2)
		abrazado.aumentarFelicidad(4)
	}
}

object abrazoProlongado {
	method resultadoAbrazo(abrazador, abrazado)
	{
		if(abrazado.atraccion(abrazador)){
			abrazado.estadoDeAnimo(soniador)
		}
		else
		{
			abrazado.estadoDeAnimo(incomodo)
		}
	}}
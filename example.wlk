class Equipo {
  var property listaJugadores = []
  var property potencial =0
  var property valoracion=0
  var property puntos=0
  method calcularPotencial(){}

  method calcularValoracion(){
    listaJugadores.forEach({j=>j.calcularCotizacion()})
    const listaCotizacion = (listaJugadores.map({j => j.cotizacion()})).filter({n => n>1})
    valoracion = listaCotizacion.sum()
  }
  method ganar(){
    puntos += 3
  }
  method empatar(){
    puntos += 1
  }
}

class EquipoEuropeo inherits Equipo {

  var property championsGanadas = 0;

 override method CalcularPotencial(){
  potencial = valoracion *championsGanadas
 }
}

class EquipoConmebol inherits Equipo{
  var property motivacion =0
  var property popularidad
  var estiloHinchada = ""
  
  method calcularMotivacion(){
    self.calcularValoracion()
    if (estiloHinchada == "entusiasta"){
      motivacion = popularidad *popularidad
    }else if (estiloHinchada == "pecho frio"){
      motivacion = (popularidad/10).max(1)
    }
    else if (estiloHinchada == "mercenaria"){
      motivacion = valoracion * 0.01
    }
  }
   override method CalcularPotencial(){
    self.calcularMotivacion()
    potencial = valoracion * motivacion
 }
}

class EquipoUSA inherits Equipo{
  var property millonesHabitantes = 0

  override method calcularPotencial(){
    potencial = valoracion * millonesHabitantes
 } 
}

class EquipoResto inherits Equipo{
  override method calcularPotencial(){
    potencial = valoracion
  }
}

class Jugador{
  var property monto=0
  var property nombre =""
  var property cotizacion= 0

  method calcularCotizacion() {
    cotizacion =monto * nombre.length()
    
  }
}
class Grupos{
  const property listaEquipos=[]
  var property partidos = []

  method agregarPartido(e1,e2){
    const p = new Partido(equipo1=e1,equipo2=e2)
    partidos.add(p)
  }
  method jugarTodos(){
    partidos.forEach({p => p.jugarPartido()})
  }
  method puntosDe(equipo) = equipo.puntos()

}

class Partido{
  var property equipo1=0
  var property equipo2
  var property potencial1 =0
  var property potencial2 =0
  var property ganador=null
  
  method jugarPartido(){
    equipo1.CalcularPotencial()
    equipo2.CalcularPotencial()
    potencial1 = equipo1.potencial()
    potencial2 = equipo2.potencial()

    if(potencial1>potencial2){
      if((potencial1-potencial2) > 0.2 * potencial2){
        equipo1.ganar()
      }
    }
    else if(potencial2>potencial1){
      if((potencial2-potencial1) >0.2 * potencial1){
        equipo2.ganar()
      }
    }else{
        equipo1.empatar()
        equipo2.empatar()
    }
  }
}
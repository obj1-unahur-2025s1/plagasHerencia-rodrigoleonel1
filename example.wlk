/*
class Cucaracha{

    var poblacion
    var pesoPromedio


    method nivelDaño(){
        return (poblacion / 2)
    }

    method transmiteEnfermedades(){
        return poblacion >= 10 && pesoPromedio >= 10
    }
}

class Pulgas{

    var poblacion

    method nivelDaño(){
        return (poblacion * 2)
    }

    method transmiteEnfermedades(){
        return poblacion >= 10
    }
}

class Garrapata{

    var poblacion
    var pesoPromedio

    method nivelDaño(){
        return (poblacion / 2)
    }

    method transmiteEnfermedades(){
        return poblacion >= 10 && pesoPromedio >= 10
    }
}

class Mosquitos{

    var poblacion 

    method nivelDaño(){
        return poblacion
    }

    method transmiteEnfermedades(){
        return poblacion % 3 == 0 && poblacion >= 10
    }
}
*/

class Plaga{
    var poblacion

    method transmiteEnfermedades(){
        return poblacion >= 10
    }

    method efectoDeAtacar(){
        poblacion = poblacion + poblacion * 0.10
    }

    method atacar(unElemento){
        unElemento.efectoDelAtaque(self)   
        self.efectoDeAtacar()
    }
}

class Cucarachas inherits Plaga {
    var pesoPromedio

    method nivelDaño(){
        return poblacion / 2
    }

    override method transmiteEnfermedades(){
        return super() && pesoPromedio >= 10
    }

    override method efectoDeAtacar(){
        super()
        pesoPromedio = pesoPromedio + 2
    }
}

class Mosquitos inherits Plaga {

    method nivelDaño() = poblacion

    override method transmiteEnfermedades(){
        return super() && poblacion % 3 == 0
    }
}

class Pulgas inherits Plaga{

    method nivelDaño() = poblacion * 2
}

class Garrapatas inherits Pulgas {
    override method efectoDeAtacar(){
        poblacion = poblacion + poblacion * 0.20
    }
}

class Hogar{

    var  nivelMugre
    const  confort

    method esBuena(){
        return  nivelMugre <=  (confort / 2 )
    }

    method efectoDelAtaque(plaga){
        nivelMugre = nivelMugre + plaga.nivelDaño()
    }
}

class Huerta{

    var  capacidadProduccion

    method esBuena() {
      return capacidadProduccion > nivelMinimo.nivel()
    }

    method efectoDelAtaque(unaPlaga){
        capacidadProduccion =  ( capacidadProduccion -  (  (unaPlaga.nivelDaño() * 0.10) + if(unaPlaga.transmiteEnfermedades()) 10 else 0 )  ).max(0)
    }
}

class Mascota{

    var  salud

    method esBuena(){
        return salud > 250
    }

    method efectoDelAtaque(unaPlaga){
        if(unaPlaga.transmiteEnfermedades()){
            salud = (salud - unaPlaga.nivelDaño()).max(0)
        }
    }
}

object nivelMinimo{

    var property nivel = 400    
}

class Barrio{

    const elementos = []

    method agregarElemento(unElemento){
        elementos.add(unElemento)
    }
    
    method esBueno(elemento){
        return elemento.esBuena()
    }

    method cantidadDeElementosBuenos(){
        return elementos.count({e => e.esBuena()})
    }

    method cantidadDeElementosNoBuenos(){
        return elementos.count({e => not e.esBuena()})
    }

    method esCopado(){
        return self.cantidadDeElementosBuenos() > self.cantidadDeElementosNoBuenos()
    }
}
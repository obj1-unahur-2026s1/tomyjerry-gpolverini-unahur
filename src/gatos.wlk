object tom {
    var energia = 50
    
    method energia() = energia
    method energiaConsumidaPorCorrer(distancia) = distancia / 2
    method velocidadMaxima() = 5 + energia / 10
    method correr(distancia) { energia = 0.max(energia - self.energiaConsumidaPorCorrer(distancia)) }
    method comer(raton) { energia += (12 + raton.peso()) }
    method puedeCazarA(distancia) = self.energiaConsumidaPorCorrer(distancia) <= energia
    method cazar(raton, distancia) {
        if(self.puedeCazarA(distancia)) {
            self.correr(distancia)
            self.comer(raton)
        }
    }
}
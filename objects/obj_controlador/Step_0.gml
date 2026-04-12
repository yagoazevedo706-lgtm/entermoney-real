var menor_distancia = 999999; 
var candidato = noone;

if (instance_exists(obj_protagonista)) {
    with (obj_inimigo) {
        var dist = point_distance(x, y, obj_protagonista.x, obj_protagonista.y);
        if (dist < menor_distancia) {
            menor_distancia = dist;
            candidato = id; 
        }
    }
    global.inimigo_mais_proximo = candidato;
}
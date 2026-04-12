function legenda() 
{
    // Verifica se o objeto existe antes de tentar mexer nele
    if (instance_exists(obj_hitbox_inimigo)) {
        with (obj_hitbox_inimigo) {
            if (place_meeting(x, y, obj_ataque)) {
                numero_dano = 5;
            } else if (place_meeting(x, y, obj_ataque_forte)) {
                numero_dano = 8;
            }
        }
    }
}
function fim_da_legenda() 
{
    layer_sequence_destroy(self.elementID);
}
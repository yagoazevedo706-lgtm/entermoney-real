// EVENTO DE COLISÃO DA EXPLOSÃO COM obj_hitbox_dano
if (!variable_instance_exists(id, "ja_deu_dano")) ja_deu_dano = false;

// --- COLLISION EVENT WITH obj_hitbox_dano ---

if (!ja_deu_dano) {
    if (instance_exists(obj_protagonista)) {
        
        // Marcamos como verdadeiro IMEDIATAMENTE para não repetir no próximo frame
        ja_deu_dano = true; 

        with(obj_protagonista) {
            // Chamamos a função que você colocou no Create do Player
            // Passamos: (x da explosão, y da explosão, força horizontal, força pulo)
            tomar_dano_impacto(other.x, other.y, 10, 5);
        }
        
        // Opcional: Screenshake ao ser atingido por explosão
        // instance_create_layer(x, y, layer, obj_screenshake);
    }
}
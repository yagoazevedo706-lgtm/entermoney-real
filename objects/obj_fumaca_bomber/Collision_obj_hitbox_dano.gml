// Causa dano e se destrói
// EVENTO DE COLISÃO DA FUMAÇA COM obj_hitbox_dano
if (instance_exists(obj_protagonista)) {
    // Causar o dano direto na variável global
    global.level_hp -= 6; 
    
    with(obj_protagonista) {
        // Aplica o empurrão e o mini pulo usando a função do player
        tomar_dano_impacto(other.x, other.y, 6, 3);
    }
    
    // Destrói a fumaça após atingir o alvo
    instance_destroy(); 
}
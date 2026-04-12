// --- STEP DO OBJ_MARCA (O CONTROLADOR) ---

if (minha_sequence != -1) {
    if (layer_sequence_is_finished(minha_sequence)) {
        
        // Salvamos a posição de onde a sequence foi criada (352, 9824)
        var _centro_x = x;
        var _centro_y = y;

        // Procuramos todas as "miras" que a sequence deixou na sala
        // Usamos with(obj_marca) para pegar TODAS de uma vez
        with (obj_marca) {
            // Se NÃO for este objeto controlador e estiver perto do ataque
            if (id != other.id && distance_to_point(_centro_x, _centro_y) < 2000) {
                
                // Criamos a explosão visual exatamente nesta marca
                // IMPORTANTE: use o nome do seu objeto que tem o sprite da explosão
                var _exp = instance_create_depth(x, y, depth - 10, obj_explosao);
                
                // Deixa a animação lenta como você pediu
                _exp.image_speed = 1; 
                
                // Destruímos a "mirinha" para ela sumir junto com a explosão
                instance_destroy(); 
            }
        }

        // Deleta a sequence e o controlador
        layer_sequence_destroy(minha_sequence);
        minha_sequence = -1;
        instance_destroy(); 
    }
}
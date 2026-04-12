if (instance_exists(dono) && instance_exists(obj_protagonista)) {
    
    // Pegamos a instância do ataque que colidiu (other)
    var _inst_ataque = other; 

    // --- LÓGICA DO SOM (Corrigida) ---
    // Verificamos se o OBJ_ATAQUE ainda NÃO tocou o som
    if (_inst_ataque.ja_tocou_som == false) {
        audio_play_sound(snd_ataque, 1, false);
        _inst_ataque.ja_tocou_som = true; // TRAVA: Agora ele não entra mais aqui
    }

    // --- 1. IMPACTO FÍSICO ---
    var forca_empurrao = 4;
    if (obj_protagonista.image_xscale == -1) {
        dono.v_x = -forca_empurrao;
    } else {
        dono.v_x = forca_empurrao;
    }

    // --- 2. LÓGICA DE DANO ---
    if (dono.pode_tomar_dano) {
	dono.hp -= 5;
    dono.dano_visual = 5; // <--- O valor que o popup vai ler
    
    dono.pode_tomar_dano = false;
	numero_dano = 5
	layer_sequence_create("sequences", x +10, y +10, sqc_legenda);
	
	
		
        dono.z_vel = 5; 
        dono.tempo_dano = 0.8 * room_speed; 
        dono.sprite_index = spr_bomber_danificado;
        dono.speed = 0;
        dono.carregando_ataque = false;

        dono.alarm[1] = 30; 
        dono.image_blend = c_red;
        dono.alarm[0] = 5; 
    }

    // --- 3. VERIFICAÇÃO DE MORTE ---
    if (dono.hp <= 0) {
        instance_destroy(); 
    }
}
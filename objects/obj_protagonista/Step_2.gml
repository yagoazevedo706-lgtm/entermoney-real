// No Step End do Player
if (instance_exists(meu_corpo)) {
    meu_corpo.x = x;
    meu_corpo.y = y;
    
    
    // Se quiser que a hitbox siga a rasteira/rotação:
    meu_corpo.image_xscale = image_xscale;
    meu_corpo.image_angle = image_angle;
    
    // Se o player estiver invisível ou no dash, você pode mudar a hitbox aqui
    if (dash_timer > 0) {
        meu_corpo.sprite_index = spr_hitbox; // Exemplo
    } else {
        meu_corpo.sprite_index = spr_hitbox;
    }
}if(ataque and pode_atacar){
	pode_atacar = false
	alarm[1] = game_get_speed(gamespeed_fps) * 0.1
	sprite_index = spr_protagonista_atacando;
    image_index = 0; // Começa a animação do início
    
    // Toca o som do "vento" do ataque (Apenas uma vez aqui)
    audio_play_sound(snd_ataque_sem, 1, false);
    // 1. PRIORIDADE: ATAQUE PARA CIMA
    if (key_up and !key_down and !key_right and !key_left) {
        meu_ataque = instance_create_depth(x, y - z - 40, -10, obj_ataque);
		if (instance_exists(meu_ataque)) {
            meu_ataque.image_angle = 90; // Gira o sprite para cima]
			z_vel = mini_dash_z
			impulso_ataque_timer = 10
        }
    } 
	    // 2. PRIORIDADE: BAIXO (Novo)
    else if (key_down and !key_up and !key_right and !key_left) {
        meu_ataque = instance_create_depth(x, y - z + 40, -10, obj_ataque);
        if (instance_exists(meu_ataque)) {
			meu_ataque.image_angle = 270;
			z_vel = -mini_dash_z
			impulso_ataque_timer = 8
		}
    }
    // 2. SENÃO, ATAQUE PARA O LADO (XSCALE 1)
    else if (image_xscale == 1) {
        meu_ataque = instance_create_depth(x + 40, y - z, -10, obj_ataque);
		if(instance_exists(meu_ataque)){
			vel_x = mini_dash; 
			impulso_ataque_timer = 10; // Ativa a trava por 10 frames // Ativa a trava por 10 frames
			
					if(instance_exists(obj_ataque)){
    with(obj_ataque){
        // 'other' refere-se ao objeto que está rodando este código (Player ou Inimigo)
        if(place_meeting(x, y, obj_hitbox_inimigo)){
			if (!audio_is_playing(snd_ataque)) {
			audio_play_sound(snd_ataque, 1, false);
			}
			
			other.atraindo_inimigo = false;
            other.vel_x = +other.mini_dash;
            other.impulso_ataque_timer = 10;
			other.z_vel += 6
			other.z += 35
			
			other.x += 0.1
			other.y -= other.z_vel
            
            
            other.alarm[2] = game_get_speed(gamespeed_fps) * 0.1;
        }
		}}
    }}
    // 3. SENÃO, ATAQUE PARA O OUTRO LADO (XSCALE -1)
    else if (image_xscale == -1) {
        meu_ataque = instance_create_depth(x - 40, y - z, -11, obj_ataque);
        if (instance_exists(meu_ataque)) {
			meu_ataque.image_xscale = -1;
			vel_x = -mini_dash;
			impulso_ataque_timer = 10; // Ativa a trava por 10 frames // Ativa a trava por 10 frames
			
		if(instance_exists(obj_ataque)){
    with(obj_ataque){
        // 'other' refere-se ao objeto que está rodando este código (Player ou Inimigo)
        if(place_meeting(x, y, obj_bomber_inimigo)){
            other.atraindo_inimigo = false;
            other.vel_x = -other.mini_dash;
            other.impulso_ataque_timer = 10;
			other.z_vel += 6; // <-- EDITE AQUI: Aumenta a força da subida no impacto
			other.z += 35;
			
			other.x -= 0.1
			other.y -= other.z_vel
            
            
            other.alarm[2] = game_get_speed(gamespeed_fps) * 0.1;
        }
    }
}
			}
		}
	}

// LÓGICA PARA SEGUIR (ATUALIZADA)

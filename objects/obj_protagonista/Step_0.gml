#region Combos

#region inputs e contagem
//tamanho da string
var hl = string_length(input_sequence)

//limitando o historico
if string_length(input_sequence) > input_max{
	input_sequence = string_copy(input_sequence, hl - input_max + 1, input_max)
}

//rodando timer do com
input_window_timer -= delta_time / 1000000

//zerando contagens quando o tempo chega ao fim
if input_window_timer <= 0{
	input_sequence = ""
	combo = 0
}

//pegando as keys
var key_ataque_fraco = keyboard_check_pressed(ord("F"))
var key_ataque_forte = keyboard_check_pressed(ord("T"))

//adicionando no historico de input
if key_ataque_fraco{
	input_sequence += "F"
}
if key_ataque_forte{
	input_sequence += "T"
}

//resetando tempo de input
if key_ataque_forte or key_ataque_fraco{
	input_window_timer = input_window_time	
}


//--aplicando combo--
//function pra ficar mais organizado
function input_combo(sequencia){
	if string_ends_with(input_sequence,sequencia){
		return true
	}else{
		return false	
	}
}

//aplicando (sempre comece com o maior numero de combinaçõs pro menor)
//combo 1
if input_combo("FFFT"){
	estado = "combo1"
	combo_timer = combo1_time //resetando timer
	input_sequence = "" //resetando
}

//combo 2
else if input_combo("FFT")
{
	estado = "combo2"
	combo_timer = combo1_time //resetando timer
	input_sequence = "" //resetando
}

//combo 3
else if input_combo("FT")
{
	estado = "combo3"
	combo_timer = combo3_time //resetando timer
	input_sequence = "" //resetando
}
#endregion

// No topo do Step do Player e dos Inimigos:
if (instance_exists(obj_selecao_combate)) {
    if (obj_selecao_combate.modo_menu == "selecao_inicial") {
        image_speed = 0; // Para a animação se quiser
        exit; // Aborta o resto do código (movimento, ataques, etc)
    }
}
image_speed = 1; // Volta a animar se o menu fechar


// --- 1. INPUTS ---
key_dash  = keyboard_check_pressed(ord("V"));
key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
ataque = keyboard_check_pressed(ord("X"))
key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));

var key_pulo = keyboard_check_pressed(ord("Z"))

var move_dir = key_right - key_left;

var moveh = key_left - key_right
var movev = key_up - key_down

//show_debug_message(global.level_hp)

// No seu Step do Player, após receber dano:
// --- DENTRO DO STEP DO PLAYER ---
// --- DENTRO DO STEP DO PLAYER ---
// --- NO STEP DO PLAYER ---
if (global.level_hp <= 0) {
    if (!instance_exists(obj_morte_controlador)) {
        // 1. Criamos o controlador e guardamos a ID dele numa variável temporária
        var _inst = instance_create_layer(x, y, "Instances", obj_morte_controlador);
        
        // 2. PASSAMOS as coordenadas ANTES de desativar tudo
        _inst.morte_x = x;
        _inst.morte_y = y;
        
        // 3. Deixamos o player invisível
        visible = false;
        
        // 4. Desativamos o resto
        instance_deactivate_all(true);
        instance_activate_object(obj_morte_controlador);
    }
}

// --- 2. LÓGICA DE VELOCIDADE (X) ---
// --- 2. LÓGICA DE VELOCIDADE (X e Y) ---
// --- 2. LÓGICA DE VELOCIDADE (X) ---
// SÓ calcula velocidade pelo teclado se NÃO estiver no impulso do ataque

// --- 2. LÓGICA DE VELOCIDADE E GIRO ---
// O player SEMPRE vira para a direção que você aperta (Independente de ataque)
if (key_right) image_xscale = 1;
if (key_left)  image_xscale = -1;

// Controle de Velocidade
// --- 2. LÓGICA DE VELOCIDADE (X e Y) ---

/*
// 1. PRIORIDADE: Impulso do Ataque (Dash do X)
if (impulso_ataque_timer > 0) {
    impulso_ataque_timer--;
    // Deixa as velocidades que você deu no Step End agirem
    vel_x *= 0.85; 
    vel_y *= 0.85;
} 
// 2. PRIORIDADE: Rasteira (Botão V)
else if (dash_timer > 0) {
    dash_timer--; 
    if (abs(vel_x) > walk_speed) vel_x -= sign(vel_x) * dash_friction;
    
    // [ADIÇÃO] Se bater em um inimigo DURANTE a rasteira
    if (place_meeting(x + vel_x, y, obj_hitbox_inimigo)) {
        if (audio_is_playing(snd_rasteira)) audio_stop_sound(snd_rasteira);
        if (!audio_is_playing(snd_rasteira_acertou)) audio_play_sound(snd_rasteira_acertou, 1, false);
    }
} */
// 3. MOVIMENTO NORMAL
//else {
    vel_x = move_dir * walk_speed;
    vel_y = (key_down - key_up) * walk_speed;

   /* if (key_dash) {
        dash_timer = dash_duration; 
        vel_x = image_xscale * dash_speed; 
        
        // [ADIÇÃO] Toca o som do vento da rasteira ao iniciar
        audio_play_sound(snd_rasteira, 1, false);
    }*/
//}

//setando direção binária
if vel_x != 0{
	bin_dir = sign(vel_x)
}

// GIRO DO PERSONAGEM (Sempre fora dos timers para não travar)

// --- 5. APLICAÇÃO DE IMAGEM ---
// --- 5. APLICAÇÃO DE IMAGEM ---
// Só permite mudar a direção que o personagem olha se o dash NÃO estiver ativo

switch(estado)
{
	case "parado":
	{
		//animação
		sprite_index = spr_protagonista_teste
		
		#region resets
		//ataques
		atk_fraco_timer = atk_fraco_tempo
		atk_forte_timer = atk_forte_tempo
		inst_create = true
		
		//slide
		slide_timer = slide_duration
		
		//combo1
		combo_jump = true
		combo1_dano = true
		combo1_create = true
		
		//combo2
		combo2_create = true
		#endregion
		
		//trocas
		//andando
		if moveh != 0 or movev != 0{
			image_index = 0
			estado = "andando"	
		}
		
		//pulando
		if key_pulo{
			image_index = 0
			z_vel = 7.5
			estado = "pulando"
		}
		
		//ataque fraco
		if key_ataque_fraco{
			image_index = 0
			estado = "ataque fraco"
		}
		
		//ataque forte
		if key_ataque_forte{
			image_index = 0
			estado = "ataque forte"
		}
		
		//rasteira
		if key_dash{
			image_index = 0
			if !audio_is_playing(snd_rasteira){
				audio_play_sound(snd_rasteira, 1, false)
			}
			estado = "rasteira"
		}
		break
	}
	
    case "andando":
	{
		//animação
		sprite_index = spr_protagonista_correndo
		
		
    // COLISÃO HORIZONTAL (Ajustada para não travar o jogo)
    if (place_meeting(x + vel_x, y, obj_colisao) and z <= 0){
        while (!place_meeting(x + sign(vel_x), y, obj_colisao)) {
            x += sign(vel_x); // Move 1 por 1 até encostar
        }
        vel_x = 0; 
    }
    
    if (place_meeting(x + vel_x, y, obj_colisao_cima) and z <= 0) {
        while (!place_meeting(x + sign(vel_x), y, obj_colisao_cima)) {
            x += sign(vel_x);
        }
        vel_x = 0;
    }
    
    if (place_meeting(x + vel_x, y, obj_colisao_esquerda)) {
        while (!place_meeting(x + sign(vel_x), y, obj_colisao_esquerda)) {
            x += sign(vel_x);
        }
        x = 66; 
        vel_x = 0;
    }

    if (place_meeting(x + vel_x, y, obj_colisao_direita)) {
        while (!place_meeting(x + sign(vel_x), y, obj_colisao_direita)) {
            x += sign(vel_x);
        }
        x = 563;
        vel_x = 0;
    }

     // Aplica movimento horizontal final

    // COLISÃO VERTICAL (Mantendo sua lógica de vel_y -= 7 etc)
    if (place_meeting(x, y + sign(vel_y), obj_colisao)) {
        while (!place_meeting(x, y + sign(vel_y), obj_colisao)) {
            y += sign(vel_y);
        }
        y = 9860;
    }
    
    if (place_meeting(x, y + vel_y, obj_colisao_cima)) {
        while (!place_meeting(x, y + sign(vel_y), obj_colisao_cima)) {
            y += sign(vel_y);
        }
        y = 9759;
    }
    
    if (place_meeting(x, y + vel_y, obj_colisao_esquerda)) {
        while (!place_meeting(x, y + sign(vel_y), obj_colisao_esquerda)) {
            y += sign(vel_y);
        }
        vel_y = 0;
    }
	
		//trocas
		//parado
		if moveh == 0 and movev == 0{
			image_index = 0
			estado = "parado"
		}
		
		//pulando
		if key_pulo{
			image_index = 0
			z_vel = 7.5
			estado = "pulando"
		}
		
		//ataque fraco
		if key_ataque_fraco{
			image_index = 0
			estado = "ataque fraco"
		}
		
		//ataque forte
		if key_ataque_forte{
			image_index = 0
			estado = "ataque forte"
		}
    
    break; // Fim do case andando
	}
	
	case "pulando":
	{
		//animação
		sprite_index = spr_protagonista_pulo
		
		//trocas
		//parado
		if z_vel = 0{
			estado = "parado"	
		}
		break
	}

	case "rasteira":
	{
		//animação
		sprite_index = spr_protagonista_rasteira
		
		//comportamento
		vel_y = 0
		
		//timer
		slide_timer--
		
		//movimentando
		slide_speed = lerp(slide_speed, slide_speed_target, slide_acc)
		
		
		//trocas
		//parado
		if slide_timer <= 0{
			image_index = 0
			estado = "parado"
		}
		break
	}
	
	case "ataque fraco":
	{
		//animação
		sprite_index = spr_protagonista_atacando
		
		//comportamento
		//parando
		vel_x = 0
		vel_y = 0
		
		//minidash
		vel_x += atk_fraco_impulse * bin_dir
		
		//timer
		atk_fraco_timer--
		
		//atacando
		if inst_create{
			var inst = instance_create_layer(x + 60 * bin_dir,y,"col_attack",obj_col_attack)
			inst.impulse = vel_x * velocidade
			inst.dano = atk_fraco_dano
			
			//efeito
			var fx = instance_create_layer(x + 60 * bin_dir,y,"efeitos",obj_effect)
			fx.sprite_index = spr_ataque_base
			fx.image_xscale = bin_dir
			
			inst_create = false
		}
		
		//troca
		if atk_fraco_timer <= 0{
			estado = "parado"
			image_index = 0
		}
		break
	}
		
	case "ataque forte":
	{
		//animação
		sprite_index = spr_ataque_forte_protagonista
		
		//comportamento
		//parando
		vel_x = 0
		vel_y = 0
		
		//minidash
		vel_x += atk_forte_impulse * bin_dir
		
		//timer
		atk_forte_timer--
		
		//atacando
		if inst_create{
			var inst = instance_create_layer(x + 60 * bin_dir,y,"col_attack",obj_col_attack)
			inst.impulse = atk_forte_impulse * bin_dir
			inst.dano = atk_forte_dano
			
			//efeito
			var fx = instance_create_layer(x + 60 * bin_dir,y,"efeitos",obj_effect)
			fx.sprite_index = spr_ataque_forte
			fx.image_xscale = bin_dir
			
			inst_create = false
		}
		
		//troca
		if atk_forte_timer <= 0{
			estado = "parado"
			image_index = 0
		}
		break
	}
		
	case "combo1":
	{
		//animação
		sprite_index = spr_protagonista_teste
		
		//comportamento
		vel_y = 0
		vel_x = 0
		
		combo_timer--
		
		if combo1_create{
			combo1_inst = instance_create_layer(x + 64 * bin_dir,y,"col_attack",obj_combo1_col)
			
			//efeito
			var fx = instance_create_layer(x + 60 * bin_dir,y,"efeitos",obj_effect)
			fx.sprite_index = spr_ataque_misturado
			fx.image_xscale = bin_dir
			
			combo1_create = false
		}
		
		if instance_exists(combo1_inst)
		{
			combo1_enemy = instance_place(combo1_inst.x,combo1_inst.y,obj_enemy_father)

			if combo1_enemy != noone
			{
				//colidi com um inimigo
				combo1_col = true
				
				//tirando dano
				if combo1_inst.atk{
					combo1_enemy.vida -= combo1_inst.dano
					combo1_enemy.estado = "dano"
					combo1_inst.atk = false
				}
			}
		
			if combo1_col
			{
				//seguindo o obj
				combo1_inst.y -= z_vel
				
				combo1_enemy.x = combo1_inst.x
				combo1_enemy.y = combo1_inst.y
			
				//pulando
				image_index = 0
				if combo_jump{
					z_vel = 7.5
					combo_jump = false
				}
					
				//caindo
				if z_vel < 0{
					combo1_enemy.image_yscale = -1
				}
					
				//caiu
				if z_vel == 0{	
					instance_destroy(obj_combo1_col)

					if combo1_dano{
						combo1_enemy.vida -= 5
						combo1_enemy.estado = "atordoado"
						combo1_enemy.atordoado = true
						combo1_enemy.atordoado_tempo = 3
						combo1_enemy.image_yscale = 1
						combo1_dano = false
					}
				
					//aplicando efeito nos inimigos em volta
					var raio = 150
				
					if point_distance(obj_enemy_father.x, obj_enemy_father.y, combo1_enemy.x, combo1_enemy.y) <= raio{
						estado = "atordoado"
						atordoado = true
						atordoado_tempo = 2.5
					}	
					
					image_index = 0
					estado = "parado"
				}
			}
		}
		
		//trocas
		//parado
		if combo_timer <= 0 and combo1_col == false{
			instance_destroy(obj_combo1_col)
			image_index = 0
			estado = "parado"
		}
		break
	}
		
	case "combo2":
	{
		//animação
		sprite_index = spr_protagonista_teste
		
		//comportamento
		vel_y = 0
		vel_x = 0
		
		combo_timer--
		
		//atacando
		if combo2_create{
			combo2_inst = instance_create_layer(x + 64 * bin_dir,y,"col_attack",obj_combo2_col)
			
			//efeito
			var fx = instance_create_layer(x + 60 * bin_dir,y,"efeitos",obj_effect)
			fx.sprite_index = spr_ataque_misturado
			fx.image_xscale = bin_dir
			
			combo2_create = false
		}
		
		if instance_exists(combo2_inst)
		{
			var i = instance_place(combo2_inst.x,combo2_inst.y,obj_enemy_father)
			
			if i != noone
			{
				//colidi com um inimigo
				combo2_col = true
				if combo2_inst.atk{
					i.vida -= combo2_dano
					combo2_inst.atk = false
				}
				
				i.dir = bin_dir
				i.p_lastx = x
				i.estado = "combo2"
				
				estado = "parado"
				image_index = 0
				
				instance_destroy(combo2_inst)
			}
		}
		
		//troca
		if combo_timer <= 0{
			instance_destroy(combo2_inst)
			combo2_create = false
			estado = "parado"
			image_index = 0
		}
		break
	}
		
	case "combo3":
	{
		//animação
		sprite_index = spr_protagonista_teste
		
		//comportamento
		//animação
		sprite_index = spr_ataque_forte_protagonista
		
		//comportamento
		//parando
		vel_x = 0
		vel_y = 0
		
		//timer
		combo_timer--
		
		//atacando
		if inst_create{
			var inst = instance_create_layer(x + 60 * bin_dir,y,"col_attack",obj_col_attack)
			inst.dano = combo3_dano
			
			//efeito
			var fx = instance_create_layer(x + 60 * bin_dir,y,"efeitos",obj_effect)
			fx.sprite_index = spr_ataque_misturado
			fx.image_xscale = bin_dir
			
			inst_create = false
		}
		
		//troca
		if combo_timer <= 0{
			estado = "parado"
			image_index = 0
		}
		break
	}
}

#region slide

slide_speed = lerp(slide_speed,0,slide_dcc)

vel_x += slide_speed * bin_dir

#endregion

/*
if (dash_timer <= 0) {
    
    // Verificação Horizontal (X)
    if (place_meeting(x + vel_x, y, obj_hitbox_inimigo)) {
        // Aproxima o player até encostar na borda da hitbox
        while (!place_meeting(x + sign(vel_x), y, obj_hitbox_inimigo)) {
            x += sign(vel_x);
        }
        vel_x = 0; // Zera a velocidade para o script não somar depois
    }

    // Verificação Vertical (Y)
    if (place_meeting(x, y + vel_y, obj_hitbox_inimigo)) {
        // Aproxima o player até encostar na borda da hitbox
        while (!place_meeting(x, y + sign(vel_y), obj_hitbox_inimigo)) {
            y += sign(vel_y);
        }
        vel_y = 0; // Zera a velocidade para o script não somar depois
    }
}
*/

// --- [ADIÇÃO] PROCESSAMENTO DO EMPURRÃO (KNOCKBACK) ---
if (abs(v_x) > 0.1) {
    if (!place_meeting(x + v_x, y, obj_colisao)) {
        x += v_x;
    }
    v_x = lerp(v_x, 0, 0.1); 
} else {
    v_x = 0;
}

x += vel_x;
y += vel_y; 
// Colisão Horizontal

; // Aplica o que sobrou (ou zero)

// aplica colisão Y (AGORA CORRETO)
// Se o caminho vertical estiver livre, anda tudo

// No Step do obj_protagonista:

// Aplicar movimento de impacto (v_x)
if (abs(v_x) > 0.1) {
    if (!place_meeting(x + v_x, y, obj_colisao_pai)) {
        x += v_x;
    }
    v_x = lerp(v_x, 0, 0.1); // Vai parando aos poucos
} else {
    v_x = 0;
}

// física (corrigido)
if z > 0 or z_vel > 0
{
    z += z_vel
    z_vel -= gravidade_pulo
}
if (!keyboard_check(ord("Z"))){
    //z_vel-=.4
}

if (place_meeting(x, y, obj_arena_cima) or z> 0){
    pode_pular = false
}
if(z <= 0){
    pode_pular = true
}
// chão (corrigido)
if (z <= 0)
{
    z = 0
    z_vel = 0
    pode_pular = true
}

// --- [ADIÇÃO] ATUALIZAR HITBOX DE DANO ---
if (instance_exists(obj_hitbox_dano) and dash_timer <= 0) {
    obj_hitbox_dano.x = x;
    obj_hitbox_dano.y = y;
}

// --- 5. SPRITES ---

// --- 8. TEMPO DE DANO E SPRITES ---
if (tempo_dano > 0) tempo_dano--;
/*
// [ADIÇÃO] LÓGICA DE PRIORIDADE PARA SPRITE DE ATAQUE E DANO:
if (tempo_sprite_ataque > 0) {
    tempo_sprite_ataque--;
    sprite_index = spr_protagonista_atacando;
}
else if (tempo_dano > 0) {
    sprite_index = spr_protagonista_pulo; // Feedback de hit
}
else if (z > 0) {
    sprite_index = spr_protagonista_pulo;
} 
else if (abs(vel_x) > walk_speed and dash_timer > 0) { // ENQUANTO O TIMER ESTIVER RODANDO...
    sprite_index = spr_protagonista_rasteira; // Seu sprite de dash aqui
} 
else if (vel_x != 0 or vel_y != 0) {
    sprite_index = spr_protagonista_correndo;
} 
else {
    sprite_index = spr_protagonista_teste;
}


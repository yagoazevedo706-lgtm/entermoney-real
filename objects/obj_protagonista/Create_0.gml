estado = "parado"
tempo_sprite_ataque = 0
// --- MANTENHA SEUS INPUTS E VARIÁVEIS NO CREATE ---
v_x = 0; 
tempo_dano = 0;

// Definição da função de dano (Coloque no Create)
tomar_dano_impacto = function(_ox, _oy, _forca_h, _forca_v) {
    // REMOVEMOS a checagem: if (dash_timer <= 0)
    
    global.level_hp -= 8;
    var _dir = point_direction(_ox, _oy, x, y);
    v_x = lengthdir_x(_forca_h, _dir); // Força do empurrão
    z_vel = _forca_v;                  // Força do pulo
    tempo_dano = 15;                   // Ativa o estado de dano
    
    // Se o player estava na rasteira, cancelamos o dash para ele sentir o impacto
    dash_timer = 0; 
}

meu_corpo = instance_create_layer(x, y, "Instances", obj_hitbox_dano)
atraindo_inimigo = false;
meu_ataque = noone; // Começa vazio
mini_dash_z = 5
mini_dash = 25

atraindo_inimigo = true
// No Create do Player
impulso_ataque_timer = 0;
mini_dash = 12; // Teste com um valor alto para ver se move

pode_atacar = true;

key_right = keyboard_check(vk_right) or keyboard_check(ord("D"))
key_left = keyboard_check(vk_left) or keyboard_check(ord("A"));
key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
v_rasteira = keyboard_check(ord("V"))
ataque = keyboard_check(ord("X"))
// No Evento Create
distancia_ataque_x = 10; // Mude o valor para ajustar o tamanho do pulo do ataque


pode_perseguir = false

walk_speed = 4
nao_vai_cair = false
to_enlouquecendo = false

z = 0

z_vel = 0

gravidade_pulo = 0.35

base_gravidade = 0.2

vel_x = 0

velocidade = 4; // O player vai andar 4 pixels por frame

vel_y = 0

pode_mover_x = false

pode_pular = false


// Configurações do Dash
dash_speed = 18;
dash_duration = 20;    // QUANTOS FRAMES o dash vai durar (ex: 20 frames = 1/3 de segundo)
dash_timer = dash_duration;        // O contador que vai diminuir
dash_friction = 0.8; // O quanto de velocidade perde por frame

// Configurações de Ataque
#region Ataque
inst_create = true

//fraco
atk_fraco_tempo = 5
atk_fraco_timer = atk_fraco_tempo

atk_fraco_impulse = 5

atk_fraco_dano = 5

//forte
atk_forte_tempo = 10
atk_forte_timer = atk_forte_tempo

atk_forte_impulse = 5

atk_forte_dano = 9

#endregion

#region Combo

input_window_time = 10 //tempo em segundos do espaço de tempo que tenho pra apertar cada tecla
input_window_timer = input_window_time

input_sequence = ""
input_max = 6

combo_timer = 0

combo_jump = true

#region combo1 (FFFT)

combo1_time = 20 //tempo q fica no ocmbo até voltar (em ticks)
combo1_inst = -1

combo1_col = false

combo1_dano = true

ombo1_enemy = -1

combo1_create = true

#endregion

#region combo2 (FFT)

combo2_time = 20 //tempo q fica no ocmbo
combo2_dano = 8

combo2_inst = -1
combo2_enemy = -1

combo2_col = false

combo2_impulse = 10

combo2_create = true

#endregion

#region combo3 (FT)

combo3_time = 20
combo3_dano = 7

#endregion

#endregion

#region Rasteira

slide_speed_target = 15
slide_speed = 0

slide_duration = 20
slide_timer = slide_duration

slide_acc = 0.5
slide_dcc = 0.5

#endregion

bin_dir = 1 //direção do player, 1 = direita, -1 = esquerda


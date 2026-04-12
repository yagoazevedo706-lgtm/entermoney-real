estado = "andando"
tempo_sprite_ataque = 0;
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
dash_timer = 0;        // O contador que vai diminuir
dash_friction = 0.8; // O quanto de velocidade perde por frame

// Configurações de Ataque




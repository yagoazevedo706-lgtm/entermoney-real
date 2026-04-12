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
var move_dir = key_right - key_left;

show_debug_message(global.level_hp)

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
} 
// 3. MOVIMENTO NORMAL
else {
    vel_x = move_dir * walk_speed;
    vel_y = (key_down - key_up) * walk_speed;

    if (key_dash) {
        dash_timer = dash_duration; 
        vel_x = image_xscale * dash_speed; 
        
        // [ADIÇÃO] Toca o som do vento da rasteira ao iniciar
        audio_play_sound(snd_rasteira, 1, false);
    }
}

// GIRO DO PERSONAGEM (Sempre fora dos timers para não travar)

// --- 5. APLICAÇÃO DE IMAGEM ---
// --- 5. APLICAÇÃO DE IMAGEM ---
// Só permite mudar a direção que o personagem olha se o dash NÃO estiver ativo

switch(estado){
    case "andando":

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
    
    break; // Fim do case andando
}

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

if (pode_pular == true && keyboard_check_pressed(ord("Z")))
{
    z_vel = 7.5
}

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
if (z > 0 or z_vel > 0 and keyboard_check(ord("Z")))
{
    z += z_vel
    z_vel -= gravidade_pulo
}
if (!keyboard_check(ord("Z"))){
    z_vel-=.4
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
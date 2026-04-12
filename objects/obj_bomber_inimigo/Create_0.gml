/// @description Insert description here
// You can write your code in this editor
event_inherited(); // Puxa as variáveis do Pai (z, gravidade, etc)
vel_inimigo = 2;
distancia_parada = 40;

// Agora SOBRESCREVE apenas para o Bomber
spr_idling = spr_bomber;
spr_walking = spr_bomber_correndo;
spr_preparing = spr_carregando_ataque_bomber;
distancia_parada = 60; // Bomber para um pouco mais longe
estado = "perseguindo"; // ESSENCIAL: começar como perseguindo

// Adicione ao seu Create atual 
timer_ataque = 20; // Tempo de "preparação" (em frames)
distancia_parada = 50; // Ajuste conforme necessário

// Cria a própria hitbox
// Cria a hitbox na mesma posição do inimigo
minha_hitbox = instance_create_depth(x, y, depth, obj_hitbox_inimigo);

// Define quem ela deve seguir
minha_hitbox.dono = id; 

// Define o tamanho exato que você pediu
minha_hitbox.image_xscale = 2.3125;
minha_hitbox.image_yscale = 1;

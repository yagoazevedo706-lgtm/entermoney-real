/// @description Insert description here
// You can write your code in this editor
// Salva como ela foi criada na Room
escala_x_inicial = image_xscale;
escala_y_inicial = image_yscale;
angulo_inicial = image_angle;
esta_atacando = false
numero_dano = 0
// Define o tamanho 2.5D que você pediu
image_xscale = 2.5;
image_yscale = 1.0;

// Deixe a hitbox invisível se não quiser ver o retângulo na tela
visible = false;

// Variável para saber quem esse objeto deve seguir
dono = noone; 
id_inimigo = noone;

dano_causado = false; // Controle simples se for apenas um alvo
inimigos_atingidos = ds_list_create(); // Lista para múltiplos alvos

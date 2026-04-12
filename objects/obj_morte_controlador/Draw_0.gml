/// @description Desenha a cena de morte e o Fade

// 1. Garante que o fundo da arena suma (retângulo preto estático)
draw_set_color(c_black);
draw_set_alpha(1);
draw_rectangle(0, 0, room_width, room_height, false);

// 2. Desenha o sprite quebrado na posição da morte
draw_sprite_ext(spr_selecao_quebrado, 0, morte_x, morte_y, 0.6, 0.6, 0, c_white, 1);

// 3. EFEITO DE FADE (Opcional - para a transição suave)
// Desenha um segundo retângulo preto por cima de tudo, usando o fade_alpha
draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1); // Reseta o alpha para não bugar outros desenhos
/// @description Insert description here
// You can write your code in this editor
/// @description Desenha o efeito clareando
draw_set_color(c_black);
draw_set_alpha(fade_alpha); // Usa o alpha que está diminuindo

// Pega o tamanho da interface para cobrir tudo
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

draw_rectangle(0, 0, _gui_w, _gui_h, false);

draw_set_alpha(1); // SEMPRE resete o alpha para 1 ao final
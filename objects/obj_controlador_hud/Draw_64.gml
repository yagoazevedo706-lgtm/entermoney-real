/// @description Insert description here
// You can write your code in this editor
/// @description Desenhar Interface de HP (HUD)
if (instance_exists(obj_inimigo)) {
    with (obj_inimigo) {
        var gui_x = x - camera_get_view_x(view_camera[0]);
        var gui_y = y - camera_get_view_y(view_camera[0]);
        
        draw_set_color(c_white);
        draw_text(gui_x, gui_y - 60, "HP: " + string(hp));
        
        if (carregando_ataque) {
             draw_set_color(c_yellow);
             draw_text(gui_x, gui_y - 80, "CARREGANDO!");
        }
    }
}
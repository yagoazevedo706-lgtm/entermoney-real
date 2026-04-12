if (instance_exists(global.inimigo_mais_proximo)) {
    draw_set_color(c_red);
    // Desenha o círculo na posição do inimigo guardado na global
    draw_circle(global.inimigo_mais_proximo.x, global.inimigo_mais_proximo.y, 32, true);
}
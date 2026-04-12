if (instance_exists(dono)) {
    // Centraliza no X e Y do inimigo (subtraindo o Z para subir junto)
    x = dono.x;
    y = dono.y - dono.z; 
    
    // Inverte o lado conforme o inimigo vira (mantendo o tamanho 2.3125)
    // Usamos o sign para saber se o dono olha pra esquerda ou direita
    image_xscale = 2.5 * sign(dono.image_xscale);
    image_yscale = 1;
} else {
    // Se o inimigo for destruído, a hitbox some
    instance_destroy();
}

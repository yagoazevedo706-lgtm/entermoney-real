if (fade_alpha > 0) {
    fade_alpha -= fade_speed; // Diminui o preto
} else {
    instance_destroy(); // Quando o preto some, o objeto se auto-destrói
}
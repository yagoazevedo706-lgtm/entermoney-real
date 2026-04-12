/// @description Lógica de contagem e Fade

if (!indo_para_gameover) {
    timer_morte--;
    if (timer_morte <= 0) {
        indo_para_gameover = true;
    }
} 
else {
    // Quando o tempo acaba, escurece a tela
    if (fade_alpha < 1) {
        fade_alpha += 0.02; 
    } else {
        // MUDANÇA DE SALA: Só acontece quando o fade chega no máximo
        room_goto(rm_game_over); 
    }
}
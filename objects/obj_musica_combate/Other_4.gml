/// @description Insert description here
// You can write your code in this editor
if (room == rm_batalha_1) {
    // Verifica se a música já não está tocando para não dar "overlap"
    if (!audio_is_playing(snd_combate)) {
        // Toca em loop (true), prioridade 10
        audio_play_sound(snd_combate, 10, true, 0.3);
    }
}
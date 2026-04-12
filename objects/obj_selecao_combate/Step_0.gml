/// @description Navegação e Ativação do Combate
if (modo_menu == "selecao_inicial") {
    
    // 1. NAVEGAÇÃO ENTRE AS OPÇÕES (Grade 2x2)
    if (keyboard_check_pressed(vk_right)) opcao_x = 1;
    if (keyboard_check_pressed(vk_left))  opcao_x = 0;
    if (keyboard_check_pressed(vk_down))  opcao_y = 1;
    if (keyboard_check_pressed(vk_up))    opcao_y = 0;

    // 2. POSICIONAMENTO DO CURSOR
    if (opcao_x == 0) { 
        cursor.x = 310;
        cursor.y = (opcao_y == 0) ? 9945 : 9975;
    } else { 
        cursor.x = 475;
        cursor.y = (opcao_y == 0) ? 9945 : 9975;
    }

    // 3. SELEÇÃO DA OPÇÃO (Z ou ENTER)
    if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
        
      // --- CASO SELECIONE: FIGHT ---
if (opcao_x == 0 && opcao_y == 0) {
    modo_menu = "combate_ativo";
    sprite_index = spr_selecao_combate_nada;
    cursor.visible = false;

    // Play nas sequences da sala
    
    
    // DANO NOS INIMIGOS - DIRETO NO OBJETO
// --- DANO NO MENU FIGHT ---
// No seu objeto de menu, quando confirmar o ataque:
// --- DANO NO MENU FIGHT ---

        }
    }
}
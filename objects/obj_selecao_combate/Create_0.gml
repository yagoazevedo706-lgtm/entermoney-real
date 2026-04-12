/// @description Configuração do Menu e Trava de Sequences
// --- 1. CONFIGURAÇÕES DE ESTADO ---
sprite_index = spr_selecao_combate;
modo_menu = "selecao_inicial"; // Controla em qual sub-menu estamos

// Coordenadas da Grade (0 ou 1)
opcao_x = 0; // 0 = Esquerda (Fight/Item), 1 = Direita (Magic/Combo)
opcao_y = 0; // 0 = Cima (Fight/Magic), 1 = Baixo (Item/Combo)

// --- 2. CONTROLE DO CURSOR ---
// Criar o cursor (obj_selecao) se ele não existir
if (!instance_exists(obj_selecao)) {
    cursor = instance_create_depth(x, y, depth - 1, obj_selecao);
} else {
    cursor = obj_selecao;
}
cursor.visible = true;

// --- 3. SEQUESTRO E PAUSA DE SEQUENCES DA ROOM ---
sequences_na_sala = []; // Array para armazenar os IDs das sequences

// Capturar a camada pelo nome (garante que o ID esteja correto)
var _camada_id = layer_get_id("sequences");

if (layer_exists(_camada_id)) {
    var _elementos = layer_get_all_elements(_camada_id);
    
    for (var _i = 0; _i < array_length(_elementos); _i++) {
        if (layer_get_element_type(_elementos[_i]) == layerelementtype_sequence) {
            var _seq_id = _elementos[_i];
            
            // Adiciona na lista para podermos dar "Play" depois no Step
            array_push(sequences_na_sala, _seq_id);
            
            // Pausa a sequence imediatamente no frame 0
            layer_sequence_pause(_seq_id); 
            
            // ACESSO À INSTÂNCIA PARA FORÇAR O SCALE 0.6
            var _inst_seq = layer_sequence_get_instance(_seq_id);
            if (_inst_seq != -1) {
                _inst_seq.xscale = 0.6;
                _inst_seq.yscale = 0.6;
            }
        }
    }
}
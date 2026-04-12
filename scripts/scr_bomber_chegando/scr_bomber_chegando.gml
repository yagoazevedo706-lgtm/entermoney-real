function final_animacao_bomber() {
    // 1. Recupera a instância da SEQUENCE que chamou a função
    var _seq_inst_wrapper = self.active_sequence; 
    
    // 2. Acessa a instância do OBJETO que está "pilotando" essa sequence
    var _inst_inimigo = _seq_inst_wrapper.instanceID; 

    // 3. Aplicamos as mudanças APENAS nesse inimigo específico
    with(_inst_inimigo) {
        x = _seq_inst_wrapper.x;
        y = _seq_inst_wrapper.y;
        visible = true;
        
        // Forçamos o scale aqui para garantir que ele saia da sequence com 0.6
        image_xscale = 0.6;
        image_yscale = 0.6;
        
        animacao_rodando = false; 
        pode_executar = false;
        
        show_debug_message("Inimigo " + string(id) + " finalizou a sequence.");
    }

    // 4. Destrói a sequence para não ficar pesando na memória
    layer_sequence_destroy(_seq_inst_wrapper.instanceID);
}

// Sua função da sequence que você não queria que removesse:
function sqc_bomber_chegando()
{
    // Este espaço é o container da sequence no script
}
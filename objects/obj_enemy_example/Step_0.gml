event_inherited()

switch estado
{
	case "parado":
	{
		//animação
		sprite_index = spr_bomber
		
		//resets
		atordoado_timer = atordoado_tempo
		dano_delay_timer = dano_delay
		
		combo2_fase = "fase1"
		
		//trocas
		//atordoado
		if atordoado{
			estado = "atordoado"
		}
		break	
	}
	
	case "dano":
	{
		//animação
		sprite_index = spr_bomber_danificado
		
		//comportamento
		dano_delay_timer--
		
		if dano_delay_timer <= 0{
			image_index = 0
			estado = "parado"
		}
		
		//atordoado
		if atordoado{
			estado = "atordoado"
		}
		break
	}
	
	case "atordoado":
	{
		//animação
		sprite_index = spr_bomber_danificado
		
		//reset
		combo2_fase = "fase1"
		
		//comportamento
		atordoado_timer -= delta_time/1000000
	
		if atordoado_timer <= 0{
			estado = "parado"
			atordoado = false	
		}
		break
	}
	
	
	case "combo2":
	{
		//animação
		sprite_index = spr_bomber_danificado
		
		//comportamento
		var i = instance_place(x,y,obj_enemy_father)
		
		if i != noone{
			if i.combo2_atk{
				i.vida -= combo2_slide_dano
				i.combo2_atk = false
			}
		}
		
		//fases do combo
		switch combo2_fase
		{
			case "fase1":
			{
				//comportamento
				if !place_meeting(x+dir,y,obj_colisao_pai){
					hspd = obj_protagonista.combo2_impulse * dir
		
					x+=hspd
				}
				//troca
				else{
					combo2_fase = "fase2"
				}
				break
			}
			
			case "fase2":
			{
				//rebatendo
				var _dir = sign(p_lastx-x)
			
				hspd = obj_protagonista.combo2_impulse * _dir
			
				if abs(p_lastx - x) > 64{
					x += hspd
				}
				else{
					hspd = 0
					atordoado_tempo = 1.5
					estado = "atordoado"
				}
				
				break
			}
		}
		break
	}
}
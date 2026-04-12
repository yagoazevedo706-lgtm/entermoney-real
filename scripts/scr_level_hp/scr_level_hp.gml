// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.xp = 0
global.level = 1
global.level_1_xp = 8
global.level_hp = 45

global.venceu_batalha = false

if(global.venceu_batalha){
	global.venceu_batalha = false
	global.xp += 4
}
if(global.xp >= 8){
	global.level = 2
	global.level_hp = 53
}
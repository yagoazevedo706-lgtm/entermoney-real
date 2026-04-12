if(obj_protagonista.dash_timer >0 and obj_protagonista.image_xscale = 1) {
	x = obj_protagonista.x
	y = obj_protagonista.y + 30
	image_angle = 30
}
else if(obj_protagonista.dash_timer >0 and obj_protagonista.image_xscale = -1){
	x = obj_protagonista.x
	y = obj_protagonista.y + 30
	image_angle = -30
}
else{}
if(obj_protagonista.dash_timer <= 0){
	x = obj_protagonista.x
	y = obj_protagonista.y - obj_protagonista.z
	image_angle = 0
}
else{
	
}
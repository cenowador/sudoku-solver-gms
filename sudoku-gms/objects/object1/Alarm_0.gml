///@description iterate
alarm[0] = iteration_time;

if(population_pos >= (grid_w*grid_h)){
	populated_grid = true;
	population_pos = -1;
}
	
////first populate grid
//if(!populated_grid){
//	var val;
//	do{
//		population_pos += 1;
//		if(population_pos >= (grid_w*grid_h)){
//			break;
//		}
//		val = grid_pos(population_pos);
//	}until(val == 0);
//	//put on a random number
//	if(population_pos < (grid_w*grid_h))
//		grid_set_valid_at(population_pos);
		
//	//still populating
//	exit;
//}

var val;
do{
	population_pos += 1;
	if(population_pos >= (grid_w*grid_h)){
		break;
	}
	val = grid_pos(population_pos);
}until(val == 0);
//put on a random number
if(population_pos < (grid_w*grid_h))
	grid_set_valid_at(population_pos);

///@description iterate
alarm[0] = iteration_time;

//search 100% reliable values
var reliableFound = grid_search_reliable();
//if(reliableFound >= 0){
//	grid_set_valid_at(reliableFound);
//	exit;
//}
exit;
//no more reliable values found
if(population_pos >= (grid_w*grid_h)){
	population_pos = -1;
}

var val;
do{
	population_pos += 1;
	if(population_pos >= (grid_w*grid_h)){
		break;
	}
	val = grid_pos(population_pos).val;
}until(val == 0);

if(population_pos < (grid_w*grid_h)){
	grid_set_valid_at(population_pos);
}

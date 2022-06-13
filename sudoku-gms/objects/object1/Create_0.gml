/// @description variables
show_debug_overlay(true);
draw_set_font(Font1);
draw_set_color(c_black);
draw_set_halign(fa_center);
alarm[0] = true;

grid_w = 9;
grid_h = 9;
grid_qw = sqrt(grid_w);
grid_qh = sqrt(grid_h);
grid = ds_grid_create(grid_w, grid_h);
pos_x = function(i){
	return i mod grid_w;
}
pos_y = function(i){
	return floor(i/grid_w);
}
grid_pos = function(i){
	return grid[# pos_x(i), pos_y(i)];
}
//look for forbidden values at pos
grid_get_forbidden_at = function(forbidden, pos){
	//check row
	var myPx = pos_x(pos);
	var myPy = pos_y(pos);
	for(var i = 0; i < grid_w; ++i){
		if(i != myPx){
			var value = grid[# i, myPy].val;
			if(value > 0){
				if(ds_list_find_index(forbidden, value) < 0)
					ds_list_add(forbidden, value);
			}
		}
	}
	
	//check column
	for(var i = 0; i < grid_h; ++i){
		if(i != myPy){
			var value = grid[# myPx, i].val;
			if(value > 0){
				if(ds_list_find_index(forbidden, value) < 0)
					ds_list_add(forbidden, value);
			}
		}
	}
	
	//check quadrant
	var startX = floor(myPx/grid_qw)*grid_qw;
	var endX = startX+2;
	var startY = floor(myPy/grid_qh)*grid_qh;
	var endY = startY+2;
	for(var i = startX; i <= endX; ++i){
		for(var j = startY; j <= endY; ++j){
			if(i != myPx || j != myPy){
				var value = grid[# i, j].val;
				if(value > 0){
					if(ds_list_find_index(forbidden, value) < 0)
						ds_list_add(forbidden, value);
				}
			}
		}
	}	
}
//iterate throug grid searching for a 100% reliable match
grid_search_reliable = function(){
	var broke = false;
	var pos = -1;
	for(var i = 0; i < grid_w; ++i){
		for(var j = 0; j < grid_h; ++j){
			pos += 1;
			var num = grid[# i, j];
			if(!num.fixed){
				var forbidden = ds_list_create();
				ds_list_clear(forbidden);
				
				grid_get_forbidden_at(forbidden, pos);
				//if there is only one possible value to use
				if(ds_list_size(forbidden) == grid_w-1){
					var value = 1;
					while(ds_list_find_index(forbidden, value) > -1){
						value += 1;
					}
					if(value <= grid_w){
						grid[# pos_x(pos), pos_y(pos)] = {
							val: value,
							fixed: true
						}
						broke = true;
					}
				}
				ds_list_destroy(forbidden);
				if(broke)
					break;
			}
		}
		if(broke)
			break;
	}
}
grid_set_valid_at = function(pos){
	//iterate through grid to get forbidden numbers
	var forbidden = ds_list_create();
	ds_list_clear(forbidden);
	
	grid_get_forbidden_at(forbidden, pos);
	
	//insert a value that isn't forbidden
	var value = 1;
	while(ds_list_find_index(forbidden, value) > -1){
		value += 1;
	}
	if(value >= grid_w){
		value = 0;	
	}
	grid[# pos_x(pos), pos_y(pos)] = {
		val: value,
		fixed: false
	}
	
	//clear DS from memory to avoid memory leaks
	ds_list_destroy(forbidden);
}

iteration_time = 1;//room_speed/8;
populated_grid = false;
population_pos = -1;

initial_board = [
	5, 3, 0,   0, 7, 0,   0, 0, 0,
	6, 0, 0,   1, 9, 5,   0, 0, 0,
	0, 9, 8,   0, 0, 0,   0, 6, 0,
	
	8, 0, 0,   0, 6, 0,   0, 0, 3,
	4, 0, 0,   8, 0, 3,   0, 0, 1,
	7, 0, 0,   0, 2, 0,   0, 0, 6,
	
	0, 6, 0,   0, 0, 0,   2, 8, 0,
	0, 0, 0,   4, 1, 9,   0, 0, 5,
	0, 0, 0,   0, 8, 0,   0, 7, 9,
];
solution_board = [
	5, 3, 4,   6, 7, 8,   9, 1, 2,
	6, 7, 2,   1, 9, 5,   3, 4, 8,
	1, 9, 8,   3, 4, 2,   5, 6, 7,
	
	8, 5, 9,   7, 6, 1,   4, 2, 3,
	4, 2, 6,   8, 5, 3,   7, 9, 1,
	7, 1, 3,   9, 2, 4,   8, 5, 6,
	
	9, 6, 1,   5, 3, 7,   2, 8, 4,
	2, 8, 7,   4, 1, 9,   6, 3, 5,
	3, 4, 5,   2, 8, 6,   1, 7, 9,
];
init_board = function(){
	ds_grid_clear(grid, 0);
	var leng = array_length(initial_board);
	for(var i = 0; i < leng; ++i){
		grid[# pos_x(i), pos_y(i)] = {
			val: initial_board[i],
			fixed: (initial_board[i] != 0)
		}
	}
}
init_board();

check_solution = function(){
	var leng = array_length(solution_board);
	for(var i = 0; i < leng; ++i){
		if(grid[# pos_x(i), pos_y(i)].val != solution_board[i]){
			return false;
		}
	}
	return true;
}
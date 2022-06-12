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
grid_set_valid_at = function(pos){
	//iterate through grid to get forbidden numbers
	var forbidden = ds_list_create();
	ds_list_clear(forbidden);
	
	//check row
	var myPx = pos_x(pos);
	var myPy = pos_y(pos);
	for(var i = 0; i < grid_w; ++i){
		if(i != myPx){
			ds_list_add(forbidden, grid[# i, myPy]);
		}
	}
	
	//check column
	for(var i = 0; i < grid_h; ++i){
		if(i != myPy){
			ds_list_add(forbidden, grid[# myPx, i]);
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
				ds_list_add(forbidden, grid[# i, j]);
			}
		}
	}
	
	//insert a value that isn't forbidden
	var val = 1;
	while(ds_list_find_index(forbidden, val) > -1){
		val += 1;
	}
	if(val >= grid_w){
		val = 0;	
	}
	grid[# pos_x(pos), pos_y(pos)] = val;
	
	//clear DS from memory to avoid memory leaks
	ds_list_destroy(forbidden);
}

iteration_time = room_speed/8;
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
		grid[# pos_x(i), pos_y(i)] = initial_board[i];
	}
}
init_board();

check_solution = function(){
	var leng = array_length(solution_board);
	for(var i = 0; i < leng; ++i){
		if(grid[# pos_x(i), pos_y(i)] != solution_board[i]){
			return false;
		}
	}
	return true;
}
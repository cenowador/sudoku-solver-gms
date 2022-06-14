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
init_board = function(){
	ds_grid_clear(grid, 0);
	var leng = array_length(initial_board);
	for(var i = 0; i < leng; ++i){
		grid[# pos_x(i), pos_y(i)] = initial_board[i];
	}
}
init_board();

possible = function(myPx, myPy, val){
	//iterate through grid to get forbidden numbers
	var forbidden = ds_list_create();
	ds_list_clear(forbidden);
	
	//check row
	for(var i = 0; i < grid_w; ++i){
		if(i != myPx){
			var value = grid[# i, myPy];
			if(value > 0){
				if(ds_list_find_index(forbidden, value) < 0)
					ds_list_add(forbidden, value);
			}
		}
	}
	
	//check column
	for(var i = 0; i < grid_h; ++i){
		if(i != myPy){
			var value = grid[# myPx, i];
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
				var value = grid[# i, j];
				if(value > 0){
					if(ds_list_find_index(forbidden, value) < 0)
						ds_list_add(forbidden, value);
				}
			}
		}
	}
	
	var result = (ds_list_find_index(forbidden, val) < 0);
	
	//clear DS from memory to avoid memory leaks
	ds_list_destroy(forbidden);
	
	return result;
}

solve = function(row=0, col=0){
	if(row == grid_w-1 && col == grid_w){
		return true;
	}
	
	if(col == grid_w){
		row += 1;
		col = 0;
	}
	
	if(grid[# row, col] > 0){
		return solve(row, col+1);
	}
	
	for(var k = 1; k <= grid_w; ++k){
		if(possible(row, col, k)){
			grid[# row, col] = k;
			if(solve(row, col+1))
				return true;
		}
		grid[# row, col] = 0;
	}
	return false;
}
solve();

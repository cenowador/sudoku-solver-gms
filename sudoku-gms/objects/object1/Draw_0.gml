/// @description draw grid

var mx = view_wport[0]/2-sprite_get_width(Sprite1)/2;
var my = view_hport[0]/2-sprite_get_height(Sprite1)/2;
var imx = 51;
var imy = 46;
draw_sprite(Sprite1, 0, mx-23, my-15);
for(var i = 0; i < grid_w; ++i){
	for(var j = 0; j < grid_h; ++j){
		var num = grid[# i, j].val;
		if(num != 0){
			draw_text(mx+(imx*i), my+(imy*j), num);
		}
	}
}

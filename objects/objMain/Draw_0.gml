draw_set_valign(fa_top);

var origin_x, origin_y, col, alp;
origin_x = 10;
origin_y = 40;
col = c_black;
alp = 1;

var i, j, num, name_length_limit, line_count, column_count, line_offset, column_offset;
num = 0;
name_length_limit = 15;
line_count = 6;
column_count = 5;
line_offset = 190;
column_offset = 320;

var name, difficulty, difficulty_lable, rating, point, potential, note, rank, time;
var pure_count, max_pure_count, far_count, lost_count;
var songlist, songinfo;
var difficulty_range, col_lable, current_timestamp, delta_timestamp;

songlist = struct.content.best30_list;
songinfo = struct.content.best30_songinfo;
difficulty_range = "PST PRS FTR BYD ";
col_lable = [ $CA8342, $55B759, $C13B96, $333BC9 ];
current_timestamp = date_second_span(date_create_datetime(1970, 1, 2, 0, 0, 0), date_current_datetime()) + 86400;
for (i = 0; i < line_count; i++)
{
	for (j = 0; j < column_count; j++)
	{
		name = songinfo[num].name_en;
		if (string_length(name) > name_length_limit)
		{
			name = string_copy(name, 1, name_length_limit-4) + "...";
		}
		
		difficulty = string(floor(songinfo[num].difficulty/2)) + (frac(songinfo[num].difficulty/2)>0 ? "+" : "");
		difficulty_lable = string_copy(difficulty_range, songlist[num].difficulty*4+1, 4);
		
		rating = string(floor(songinfo[num].rating/10)) + "." + string_copy(frac(songinfo[num].rating/10), 3, 1);
		
		point = songlist[num].score;
		
		potential = string(floor(songlist[num].rating)) + "." + string_copy(frac(songlist[num].rating), 3, 3);
		
		note = songinfo[num].note;
		
		rank = "D";
		if (point >= 8600000){ rank = "C"; }
		if (point >= 8900000){ rank = "B"; }
		if (point >= 9200000){ rank = "A"; }
		if (point >= 9500000){ rank = "AA"; }
		if (point >= 9800000){ rank = "EX"; }
		if (point >= 9900000){ rank = "EX+"; }
		if (point >= 10000000){ rank = "PM"; }
		if (point >= 10000000+note){ rank = "PM+"; }
		
		if (string_length(point) < 8){ point = "0" + string(point); }
		
		time = songlist[num].time_played;
		delta_timestamp = current_timestamp - floor(time/1000);
		
		pure_count = string(songlist[num].perfect_count);
		max_pure_count = string(songlist[num].shiny_perfect_count);
		far_count = string(songlist[num].near_count);
		lost_count = string(songlist[num].miss_count);
		
		// base
		col = c_white;
		draw_sprite_stretched_ext(sprBox, 0, origin_x-10 + j*column_offset, origin_y-5 + i*line_offset, column_offset-5, line_offset-5, col, 0.8);
		// difficulty lable
		col = col_lable[songlist[num].difficulty];
		draw_sprite_stretched_ext(sprBox, 0, origin_x-10 + j*column_offset + 200, origin_y-5+1 + i*line_offset + 10, 100, 30+2, col, 1);
		
		col = c_black;
		draw_set_halign(fa_left);
		draw_set_font(fntKazesawa);
		draw_text_color(origin_x + j*column_offset, origin_y + i*line_offset, name, col, col, col, col, alp);
		col = c_white;
		draw_set_halign(fa_middle);
		draw_set_font(fntKazesawa);
		draw_text_color(origin_x + j*column_offset + 245-3, origin_y + i*line_offset + 5, difficulty_lable + difficulty, col, col, col, col, alp);
		
		col = c_black;
		draw_set_halign(fa_left);
		draw_set_font(fntExo);
		draw_text_color(origin_x + j*column_offset, origin_y + i*line_offset + 50, point, col, col, col, col, alp);
		draw_text_color(origin_x + j*column_offset + 10, origin_y + i*line_offset + 110, rank, col, col, col, col, alp);
		var _width_offset;
		_width_offset = string_width(point);
		draw_set_font(fntExoSmall);
		draw_text_color(origin_x + j*column_offset + _width_offset, origin_y + i*line_offset + 60, "/ " + string(rating) + " / " + string(potential), col, col, col, col, alp);
		draw_text_color(origin_x + j*column_offset + 80, origin_y + i*line_offset + 110-15+5, "P: " + pure_count + " (+" + max_pure_count + ")", col, col, col, col, alp);
		draw_text_color(origin_x + j*column_offset + 80, origin_y + i*line_offset + 110+15+5, "F: " + far_count + "    " + "L: " + lost_count, col, col, col, col, alp);
		
		draw_set_halign(fa_right);
		draw_text_color(origin_x + j*column_offset + column_offset - 25, origin_y + i*line_offset + line_offset*0.75 + 5, string(delta_timestamp/(24*3600)) + "D", col, col, col, col, alp);
		num++
	}
}

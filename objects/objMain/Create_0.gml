var path;
path = get_open_filename("Best30 Json With Songinfo|*.txt;*.json", "");
if (path != "")
{
	var file, raw;
	file = file_text_open_read(path);
	raw = file_text_read_string(file);
	file_text_close(file);
}
else
{
	game_end();
}

struct = json_parse(raw);
date_set_timezone(timezone_utc);

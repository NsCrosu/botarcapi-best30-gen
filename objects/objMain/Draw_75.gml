var path;
path = get_save_filename("Best30 Image|*.jpg", "");
if (path != "")
{
	screen_save(path);
}

game_end();

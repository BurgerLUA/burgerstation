#define DIRECTIONS_ALL list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
#define DIRECTIONS_CARDINAL list(NORTH,EAST,SOUTH,WEST)
#define DIRECTIONS_X list(NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)



proc/direction_to_text(var/dir)
	switch(dir)
		if(NORTHWEST)
			return "northwest"
		if(NORTHEAST)
			return "northeast"
		if(SOUTHWEST)
			return "southwest"
		if(SOUTHEAST)
			return "southeast"
		if(NORTH)
			return "north"
		if(SOUTH)
			return "south"
		if(EAST)
			return "east"
		if(WEST)
			return "west"
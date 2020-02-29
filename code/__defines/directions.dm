#define DIRECTIONS_ALL list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
#define DIRECTIONS_CARDINAL list(NORTH,EAST,SOUTH,WEST)
#define DIRECTIONS_INTERCARDINAL list(NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)

#define DIRECTIONS_CARDINAL_BIT NORTH | EAST | SOUTH | WEST

#define DOWN 16
#define UP 32


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
		if(UP)
			return "UP"
		if(DOWN)
			return "DOWN"
		if(0)
			return "center"
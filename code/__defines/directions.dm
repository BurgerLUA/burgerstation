#define DIRECTIONS_ALL list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
#define DIRECTIONS_CARDINAL list(NORTH,EAST,SOUTH,WEST)
#define DIRECTIONS_INTERCARDINAL list(NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)

#define DIRECTIONS_CARDINAL_BIT NORTH | EAST | SOUTH | WEST

#define DOWN 16
#define UP 32


proc/direction_to_text(var/dir)

	. = list()

	if(dir & NORTH)
		. += "north"
	if(dir & SOUTH)
		. += "south"
	if(dir &EAST)
		. += "east"
	if(dir & WEST)
		. += "west"

	return english_list(.,"none","-","-")
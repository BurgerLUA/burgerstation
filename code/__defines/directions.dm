#define DIRECTIONS_ALL list(NORTH,NORTHEAST,EAST,SOUTHEAST,SOUTH,SOUTHWEST,WEST,NORTHWEST)
#define DIRECTIONS_CARDINAL list(NORTH,EAST,SOUTH,WEST)
#define DIRECTIONS_INTERCARDINAL list(NORTHEAST,SOUTHEAST,SOUTHWEST,NORTHWEST)

#define DIRECTIONS_CARDINAL_BIT NORTH | EAST | SOUTH | WEST

#define DOWN 16
#define UP 32

/proc/is_cardinal_dir(var/dir)
	return dir && (dir == NORTH || dir == SOUTH || dir == EAST || dir == WEST)

/proc/is_intercardinal_dir(var/dir)
	return dir && (dir == NORTHEAST || dir == SOUTHEAST || dir == SOUTHWEST || dir == NORTHWEST)
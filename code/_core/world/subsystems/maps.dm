#define MAP_DIRECTORY "maps/RPG/"

var/global/list/map_2_zlevel = list()

SUBSYSTEM_DEF(maps)
	name = "Maps Subsystem"
	desc = ""
	priority = SS_ORDER_MAPS

/subsystem/maps/Initialize()
	var/list/map_files = flist(MAP_DIRECTORY)
	ls_quicksort(map_files)
	for(var/i=1,i<=length(map_files),i++)
		map_2_zlevel[map_files[i]] = i

/proc/get_z_level(var/z_level)
	return map_2_zlevel[z_level]


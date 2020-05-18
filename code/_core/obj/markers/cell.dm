var/global/cell_unit_number = 0

/obj/marker/map
	name = "cell marker"
	icon = 'icons/5x5.dmi'
	icon_state = "yellow"
	var/map_file


/obj/marker/map/proc/post_map_load()
	return TRUE

/obj/marker/map/cell/
	icon = 'icons/obj/markers/prefab_5x5.dmi'
	var/door_code = 0
	var/unit_number = 1
	var/map_size_x = 5
	var/map_size_y = 5


/obj/marker/map/cell/post_map_load()

	cell_unit_number++
	unit_number = cell_unit_number
	door_code = rand(1111,9999)

	var/turf/T1 = locate(x,y,z)
	var/turf/T2 = locate(x+map_size_x,y+map_size_y,z)
	for(var/turf/T in block(T1,T2))
		for(var/atom/A in T.contents)
			if(istype(A,/obj/structure/interactive/computer/console/old/station_job/))
				var/obj/structure/interactive/computer/console/old/station_job/SJ = A
				SJ.door_code = door_code
				SJ.unit_number = unit_number
			if(istype(A,/obj/structure/interactive/door/airlock/station/private))
				var/obj/structure/interactive/door/airlock/station/private/P = A
				P.name = "crew cabin #[unit_number]"
				var/obj/item/device/keypad/K = new(P)
				K.code = door_code
				INITIALIZE(K)
				GENERATE(K)

/obj/marker/map/cell/north
	map_file = 'maps/horde/prefabs/cabin_north.dmm'
	icon_state = "cell_north"

/obj/marker/map/cell/south
	map_file = 'maps/horde/prefabs/cabin_south.dmm'
	icon_state = "cell_south"


/obj/marker/map/cell/north/double
	map_file = 'maps/horde/prefabs/cabin_double_north.dmm'
	icon = 'icons/obj/markers/prefab_6x5.dmi'
	icon_state = "cell_north"
	map_size_x = 6
	map_size_y = 5


/obj/marker/map/cell/south/double
	map_file = 'maps/horde/prefabs/cabin_double_north.dmm'
	icon = 'icons/obj/markers/prefab_6x5.dmi'
	icon_state = "cell_south"
	map_size_x = 6
	map_size_y = 5

/obj/marker/map/cell/east
	map_file = 'maps/horde/prefabs/cabin_quadruple_east.dmm'
	icon = 'icons/obj/markers/prefab_10x5.dmi'
	icon_state = "cell_east"
	map_size_x = 10
	map_size_y = 5

/obj/marker/map/cell/west
	map_file = 'maps/horde/prefabs/cabin_quadruple_west.dmm'
	icon = 'icons/obj/markers/prefab_10x5.dmi'
	icon_state = "cell_west"
	map_size_x = 10
	map_size_y = 5
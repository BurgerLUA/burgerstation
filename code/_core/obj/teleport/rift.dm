/obj/trigger/rift
	name = "rift"
	desc = "Where does this go? Nobody knows."
	icon = 'icons/obj/trigger/rift.dmi'
	icon_state = "rift"
	var/area/teleport_area

/obj/trigger/rift/New(loc)
	..()
	queue_delete(src,ITEM_DELETION_TIME_DROPPED)

/obj/trigger/rift/on_trigger(var/atom/movable/triggerer)

	if(!length(rift_markers))
		return FALSE

	triggerer.force_move(pick(rift_markers))

	return TRUE

/obj/trigger/rift/forest_debug
	teleport_area = /area/enviroment/forest/

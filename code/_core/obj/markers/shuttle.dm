/obj/marker/shuttle
	name = "shuttle position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "chargen"

	var/obj/marker/desired_marker

/obj/marker/shuttle/proc/move_to_marker(var/atom/movable/A)

	if(!desired_marker)
		return FALSE

	var/obj/marker/M = locate(desired_marker) in world

	var/diff_x = A.x - src.x
	var/diff_y = A.y - src.y

	var/desired_x = M.x + diff_x
	var/desired_y = M.y + diff_y

	A.force_move(locate(desired_x,desired_y,1))

	return TRUE

/obj/marker/shuttle/station/
	name = "station shuttle position"
	desired_marker = null //We don't move.

/obj/marker/shuttle/transit/
	name = "station shuttle position"
	desired_marker = /obj/marker/shuttle/station/

/obj/marker/shuttle/home/
	name = "station shuttle position"
	desired_marker = /obj/marker/shuttle/transit/

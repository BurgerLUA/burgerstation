var/global/obj/marker/shuttle/transit/transit_shuttle
var/global/obj/marker/shuttle/dock/dock_shuttle


/obj/marker/shuttle
	name = "shuttle position"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "chargen"


/obj/marker/shuttle/dock/proc/do_move(var/atom/movable/A)

	var/diff_x = A.x - transit_shuttle.x
	var/diff_y = A.y - transit_shuttle.y

	var/desired_x = dock_shuttle.x + diff_x
	var/desired_y = dock_shuttle.y + diff_y

	A.force_move(locate(desired_x,desired_y,1))

	return TRUE


/obj/marker/shuttle/dock/New(var/desired_loc)
	. = ..()
	dock_shuttle = src
	return .

/obj/marker/shuttle/transit/New(var/desired_loc)
	. = ..()
	transit_shuttle = src
	return .


/obj/trigger/military_trap
	name = "drop pod trap"
	invisibility = 100
	density = TRUE

/obj/trigger/military_trap/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	if(!is_player(O))
		return .
	trap(TRUE)

/obj/trigger/military_trap/proc/trap(var/range_check=FALSE)

	if(src.qdeleting)
		return FALSE

	var/turf/T = get_turf(src)

	var/obj/structure/interactive/crate/closet/supply_pod/yankee/occupied/O = new(T)
	INITIALIZE(O)
	GENERATE(O)
	FINALIZE(O)

	qdel(src)

	if(range_check)
		for(var/obj/trigger/military_trap/MT in range(VIEW_RANGE,T))
			MT.trap(FALSE)
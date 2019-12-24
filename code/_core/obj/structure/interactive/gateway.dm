var/global/list/obj/structure/interactive/gateway/all_gateways = list()

/obj/structure/interactive/gateway
	name = "gateway"
	desc = "Brings you to places!"
	icon = 'icons/obj/structure/gateway.dmi'
	icon_state = "gateway"
	pixel_x = -32
	pixel_y = -32

	var/enabled = FALSE

/obj/structure/interactive/gateway/update_icon()
	icon_state = initial(icon_state)
	if(enabled)
		icon_state = "[icon_state]_on"

	return ..()

/obj/structure/interactive/gateway/proc/enable(var/toggle=TRUE)
	enabled = toggle
	update_icon()
	return TRUE

/obj/structure/interactive/gateway/New(var/desired_loc)
	all_gateways += src
	return ..()

/obj/structure/interactive/gateway/Crossed(var/atom/movable/O)

	if(enabled)
		var/turf/T = get_step(pick(all_hoarde_spawnpoints),O.move_dir)
		O.force_move(T)
		O.move_delay = 10
		if(is_living(O))
			var/mob/living/L = O
			L.add_paralyze(30)

	return ..()


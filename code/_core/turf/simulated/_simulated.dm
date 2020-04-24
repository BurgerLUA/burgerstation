var/global/list/turf_icon_cache = list()
var/global/saved_icons = 0


/turf/simulated/

	var/real_icon
	var/real_icon_state

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT
	desired_light_range = DEFAULT_RANGE_AMBIENT
	desired_light_color = "#FFFFFF"

	dynamic_lighting = TRUE

	var/fade = FALSE

	var/tile = FALSE //Set to true if this is a tile.

	var/turf/destruction_turf
	health = null
	health_base = 100

	var/reinforced_material_id
	var/reinforced_color

	var/exposed = TRUE //Are pipes and other hidden objects visible?

	var/turf_temperature_mod = 0

	var/list/air_contents = list(
		"oxygen" = 21,
		"nitrogen" = 80
	)

	var/blocks_air = 0x0

/turf/proc/is_occupied()

	for(var/atom/movable/A in contents)
		if(istype(A,/obj/effect/temp/construction/))
			return A
		if(is_living(A))
			return A
		if(is_structure(A))
			return A

	return null


/turf/proc/can_construct_on(var/mob/caller)
	caller.to_chat(span("warning","You cannot deploy on this turf!"))
	return FALSE

/turf/simulated/floor/can_construct_on(var/mob/caller,var/obj/structure/structure_to_make)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	var/area/A = loc
	if(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION)
		caller.to_chat(span("warning","You cannot deploy im this area!"))
		return FALSE

	for(var/obj/structure/S in src.contents)
		if(S.under_tile != SAFEVAR(structure_to_make,under_tile))
			continue
		if(istype(S,structure_to_make))
			var/flags_placement = SAFEVAR(structure_to_make,flags_placement)
			if(flags_placement & FLAGS_PLACEMENT_ALLOW_MULTIPLE)
				continue
			if(flags_placement & FLAGS_PLACEMENT_DIRECTIONAL)
				if(!(S.dir & caller.dir))
					continue
		caller.to_chat(span("warning","There is a structure ([S.name]) here already!"))
		return FALSE

	return TRUE

/turf/simulated/get_examine_list(var/mob/caller)
	. = ..()
	. += div("notice","The health of the object is: [health ? health.health_current : "none"].")
	return .

/turf/simulated/New(var/atom/desired_loc)

	if(real_icon)
		icon = real_icon
	if(real_icon_state)
		icon_state = real_icon_state

	var/area/A = loc
	desired_light_power *= A.area_light_power

	return ..()

/turf/simulated/get_examine_list(var/mob/examiner)
	return ..() + div("notice","Air Block Dirs: [direction_to_text(blocks_air)].")


/turf/simulated/on_destruction(var/atom/caller,var/damage = FALSE)

	if(!destruction_turf)
		log_error("ERROR! [src.type] called on_destruction without having a destruction turf!")
		return FALSE

	pixel_x = 0
	pixel_y = 0

	change_turf(destruction_turf,)

	queue_update_turf_edges(src)
	Initialize()

	return ..()

/turf/simulated/Initialize()
	var/area/A = loc
	if(!(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION))
		if(!destruction_turf)
			if(loc && loc.type != src.type && is_floor(loc))
				destruction_turf = loc.type
			else if(A.destruction_turf != src.type)
				destruction_turf = A.destruction_turf
		if(destruction_turf)
			health = /health/turf/
	set_exposed(exposed,!exposed)
	. = ..()
	update_sprite()
	return .

/turf/simulated/update_icon()

	if(!corner_icons)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = direction_to_text(d)
		var/turf/T = get_step(src,d)

		calc_list[dir_to_text] = FALSE //Default

		if(!T)
			calc_list[dir_to_text] = FALSE
			continue

		if(should_smooth_with(T))
			calc_list[dir_to_text] = TRUE
			continue

	var/ne = ""
	var/nw = ""
	var/sw = ""
	var/se = ""

	if(!tile)
		if(calc_list["north"])
			ne += "n"
			nw += "n"
		if(calc_list["south"])
			se += "s"
			sw += "s"

		if(calc_list["east"])
			ne += "e"
			se += "e"
		if(calc_list["west"])
			nw += "w"
			sw += "w"

	if(nw == "nw" && calc_list["north-west"])
		nw = "f"

	if(ne == "ne" && calc_list["north-east"])
		ne = "f"

	if(sw == "sw" && calc_list["south-west"])
		sw = "f"

	if(se == "se" && calc_list["south-east"])
		se = "f"

	if(!ne) ne = "i"
	if(!nw) nw = "i"
	if(!se) se = "i"
	if(!sw) sw = "i"

	/*
	if(opacity && "[nw][ne][sw][se]" == "ffff")
		dynamic_lighting = FALSE
		icon = 'icons/debug/turfs.dmi'
		icon_state = "black"
		plane = PLANE_ALWAYS_VISIBLE
		return FALSE
	*/

	var/full_icon_string = "[type]_[ne][nw][se][sw]"

	var/icon/I

	if(turf_icon_cache[full_icon_string])
		I = turf_icon_cache[full_icon_string]
		saved_icons++
	else
		I = new /icon(icon,"1-[nw]")

		var/icon/NE = new /icon(icon,"2-[ne]")
		I.Blend(NE,ICON_OVERLAY)

		var/icon/SW = new /icon(icon,"3-[sw]")
		I.Blend(SW,ICON_OVERLAY)

		var/icon/SE = new /icon(icon,"4-[se]")
		I.Blend(SE,ICON_OVERLAY)

		if(fade)
			var/icon/A = new /icon(icon,"fade")
			I.Blend(A,ICON_MULTIPLY)

		turf_icon_cache[full_icon_string] = I

	icon = I
	pixel_x = (32 - I.Width())/2
	pixel_y = (32 - I.Height())/2
	layer = initial(layer) + 0.1

/turf/simulated/update_overlays()

	. = ..()

	if(reinforced_material_id)
		overlays.Cut()
		var/image/I2 = new/image(initial(icon),"ref")
		add_overlay(I2)

	return .

/turf/simulated/proc/set_exposed(var/desired_exposed = FALSE,var/force=FALSE)

	if(desired_exposed == exposed && !force)
		return FALSE

	for(var/obj/O in contents)
		if(!O.under_tile)
			continue
		if(desired_exposed)
			O.invisibility = 0
		else
			O.invisibility = 101

	return TRUE
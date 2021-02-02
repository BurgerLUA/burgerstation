var/global/list/turf_icon_cache = list()
var/global/saved_icons = 0

var/global/list/blood_turfs = list()

/turf/simulated/

	var/real_icon
	var/real_icon_state

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

	var/image/overlay/stored_water_overlay
	var/water_reagent

	var/blood_level = 0
	var/wet_level = 0

	var/drying_add = 0.1
	var/drying_mul = 0.02

	var/slip_factor = 1

/turf/simulated/proc/get_slip_strength(var/mob/living/L)
	return (wet_level ? 1 : 0) + (wet_level/100)*slip_factor

/turf/simulated/proc/add_wet(var/wet_to_add)
	var/old_wet = wet_level
	wet_level += wet_to_add
	SSturfs.wet_turfs |= src
	if(old_wet <= 0)
		overlays.Cut()
		update_overlays()
	return TRUE

/turf/simulated/Entered(var/atom/movable/O,var/atom/new_loc)

	. = ..()

	if(is_living(O))
		var/mob/living/L = O
		if(!L.horizontal && L.move_mod > 1)
			var/slip_strength = get_slip_strength(L)
			if(slip_strength >= 4 - L.move_mod)
				var/obj/item/wet_floor_sign/WFS = locate() in range(1,src)
				if(!WFS || L.move_mod > 2)
					L.add_status_effect(SLIP,slip_strength*10,slip_strength*10)

	return .

/turf/simulated/get_examine_list(var/mob/caller)
	. = ..()
	. += div("notice","The health of the object is: [health ? health.health_current : "none"].")
	. += div("notice","The slippery percentage is [get_slip_strength()*100]%.")
	return .

/*
/turf/simulated/New(var/atom/desired_loc)

	if(real_icon)
		icon = real_icon
	if(real_icon_state)
		icon_state = real_icon_state

	return ..()
*/

/turf/simulated/on_destruction(var/mob/caller,var/damage = FALSE)

	if(!destruction_turf)
		CRASH_SAFE("[get_debug_name()] called on_destruction without having a destruction turf!")
		return FALSE

	for(var/obj/effect/temp/impact/I in src.contents)
		I.alpha = 0

	. = ..()

	pixel_x = 0
	pixel_y = 0

	change_turf(destruction_turf)

	return .

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
	return ..()

/turf/simulated/PostInitialize()
	. = ..()
	update_sprite()
	return .

/turf/simulated/proc/get_smooth_code()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = dir2text(d)
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

	return list(ne,nw,se,sw)


/turf/simulated/update_sprite()

	if(real_icon)
		icon = real_icon
	if(real_icon_state)
		icon_state = real_icon_state

	return ..()

/turf/simulated/proc/smooth_turfs()

	var/list/smooth_code = get_smooth_code()

	var/ne = smooth_code[1]
	var/nw = smooth_code[2]
	var/se = smooth_code[3]
	var/sw = smooth_code[4]

	var/full_icon_string = "[type]_[icon_state]_[ne][nw][se][sw]"

	desc = full_icon_string

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
	pixel_x = (TILE_SIZE - I.Width())/2
	pixel_y = (TILE_SIZE - I.Height())/2

	return TRUE

/turf/simulated/update_icon()

	if(!corner_icons)
		return ..()

	smooth_turfs()

	return TRUE

/turf/simulated/update_overlays()

	. = ..()

	if(reinforced_material_id)
		var/image/I = new/image(initial(icon),"ref")
		add_overlay(I)

	if(wet_level)
		var/image/I = new/image('icons/obj/effects/water.dmi',"wet_floor")
		add_overlay(I)

	return .

/turf/simulated/proc/set_exposed(var/desired_exposed = FALSE,var/force=FALSE)

	if(desired_exposed == exposed && !force)
		return FALSE

	for(var/obj/O in src.contents)
		if(!O.under_tile)
			continue
		if(desired_exposed)
			O.invisibility = 0
		else
			O.invisibility = 101

	return TRUE


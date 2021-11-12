
/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE
	collision_dir = NORTH | EAST | SOUTH | WEST
	vis_flags = VIS_INHERIT_ID | VIS_INHERIT_PLANE

	anchored = TRUE

	var/bullet_block_chance = 100 //Chance to block bullets, assuming that the object is solid.

	var/mob/living/buckled

	can_rotate = TRUE

	var/flags_placement = FLAGS_PLACEMENT_NONE
	var/list/structure_blacklist = list() //Things that can't be constructed on the same turf that's occupying this.

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_HORIZONTAL

	var/material_id = /material/steel
	var/reinforced_material_id = null
	var/reinforced_color = "#FFFFFF"

/obj/structure/update_overlays()

	. = ..()

	if(reinforced_material_id)
		var/image/I = new/image(initial(icon),"ref")
		I.appearance_flags = RESET_COLOR
		I.color = reinforced_color
		I.alpha = 100
		add_overlay(I)

/obj/structure/on_crush()
	. = ..()
	loc.visible_message(span("warning","\The [src.name] is crushed under \the [src.loc.name]!"))
	qdel(src)

/obj/structure/should_smooth_with(var/turf/T)

	if(T.plane == plane && T.corner_category == corner_category)
		return T

	for(var/obj/structure/O in T.contents)
		if(O.corner_category != corner_category)
			continue
		if(O.plane != plane)
			continue
		return O

	. = ..()

/obj/structure/Initialize()

	. = ..()

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

/obj/structure/Finalize()
	if(corner_icons) SSsmoothing.queued_smoothing += src
	. = ..()


/obj/structure/proc/on_active(var/mob/living/advanced/player/P)
	return TRUE

/obj/structure/proc/on_inactive(var/mob/living/advanced/player/P)
	return TRUE

/obj/structure/proc/buckle(var/mob/living/victim,var/mob/caller,var/silent = FALSE)

	if(!silent)
		if(!caller || caller == victim)
			victim.visible_message(span("notice","\The [caller.name] buckles themselves to \the [src.name]."),span("notice","You buckle yourself to \the [src.name]."))
		else
			victim.visible_message(span("notice","\The [caller.name] buckles \the [victim.name] into \the [src.name]."),span("notice","You buckle \the [victim.name] to \the [src.name]."))

	buckled = victim
	buckled.buckled_object = src
	buckled.anchored = TRUE

	return TRUE

/obj/structure/proc/unbuckle(var/mob/caller,var/silent=FALSE)

	if(!buckled)
		return FALSE

	if(!silent)
		if(!caller || caller == buckled)
			buckled.visible_message(span("notice","\The [buckled.name] unbuckles themselves from \the [src.name]."),span("notice","You unbuckle yourself from \the [src.name]."))
		else
			buckled.visible_message(span("notice","\The [buckled.name] is unbuckled from \the [src.name] by \the [caller.name]."),span("notice","You were unbuckled from \the [src.name] by \the [caller.name]."))

	buckled.buckled_object = null
	buckled.anchored = initial(buckled.anchored)
	buckled = null

	return TRUE


/obj/structure/Cross(atom/movable/O,atom/oldloc)

	if(!O || O.collision_flags & src.collision_flags)
		var/direction = get_dir(oldloc,src)
		if(turn(direction,180) & collision_dir)
			return FALSE
		if(is_structure(O)) //Prevents infinite loops.
			var/obj/structure/S = O
			if(collision_dir & S.collision_dir)
				return FALSE

	return TRUE

/obj/structure/Uncross(var/atom/movable/O,atom/newloc)

	if(O.collision_flags & src.collision_flags)
		var/direction = get_dir(src,newloc)
		if(collision_dir == (NORTH | SOUTH | EAST | WEST))
			return TRUE //Prevents people from getting stuck in walls.
		if(direction & collision_dir)
			return FALSE

	return TRUE


/obj/structure/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	var/area/A = get_area(src)
	if(A.flags_area & FLAGS_AREA_NO_CONSTRUCTION)
		return FALSE
	return ..()



/obj/structure/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(!corner_icons || !anchored)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = "[d]"
		calc_list[dir_to_text] = FALSE
		var/turf/T = get_step(src,d)
		if(!T)
			continue
		if(should_smooth_with(T))
			calc_list[dir_to_text] = TRUE
			continue

	var/ne = ""
	var/nw = ""
	var/sw = ""
	var/se = ""

	if(calc_list["[NORTH]"])
		ne += "n"
		nw += "n"
	if(calc_list["[SOUTH]"])
		se += "s"
		sw += "s"

	if(calc_list["[EAST]"])
		ne += "e"
		se += "e"
	if(calc_list["[WEST]"])
		nw += "w"
		sw += "w"

	if(nw == "nw" && calc_list["[NORTHWEST]"])
		nw = "f"

	if(ne == "ne" && calc_list["[NORTHEAST]"])
		ne = "f"

	if(sw == "sw" && calc_list["[SOUTHWEST]"])
		sw = "f"

	if(se == "se" && calc_list["[SOUTHEAST]"])
		se = "f"

	if(!ne) ne = "i"
	if(!nw) nw = "i"
	if(!se) se = "i"
	if(!sw) sw = "i"

	var/icon/I = ICON_INVISIBLE

	var/icon/NW = new /icon(icon,"1-[nw]")
	I.Blend(NW,ICON_OVERLAY)

	var/icon/NE = new /icon(icon,"2-[ne]")
	I.Blend(NE,ICON_OVERLAY)

	var/icon/SW = new /icon(icon,"3-[sw]")
	I.Blend(SW,ICON_OVERLAY)

	var/icon/SE = new /icon(icon,"4-[se]")
	I.Blend(SE,ICON_OVERLAY)

	icon = I
	pixel_x = (32 - I.Width())/2
	pixel_y = (32 - I.Height())/2
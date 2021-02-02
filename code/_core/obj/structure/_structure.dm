#define FLAGS_PLACEMENT_NONE 0x0
#define FLAGS_PLACEMENT_ALLOW_MULTIPLE 0x1 //Allow multiple of this structure to exist on this turf, always.
#define FLAGS_PLACEMENT_DIRECTIONAL 0x2 //Allow multiple of this structure to exist on this turf as long as the directions are different.


/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_NONE
	collision_dir = NORTH | EAST | SOUTH | WEST

	anchored = TRUE

	var/bullet_block_chance = 100 //Chance to block bullets, assuming that the object is solid.

	var/mob/living/buckled

	can_rotate = TRUE

	var/flags_placement = FLAGS_PLACEMENT_NONE
	var/list/structure_blacklist = list() //Things that can't be constructed on the same turf that's occupying this.

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_HORIZONTAL

/obj/structure/on_crush()
	. = ..()
	loc.visible_message(span("warning","\The [src.name] is crushed under \the [src.loc.name]!"))
	qdel(src)
	return .

/obj/structure/should_smooth_with(var/turf/T)

	for(var/obj/structure/O in T.contents)
		if(O.corner_category != corner_category)
			continue
		if(O.plane != plane)
			continue
		return TRUE

	return FALSE

/obj/structure/Initialize()

	. = ..()

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	return .

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
	buckled = null

	return TRUE


/obj/structure/Cross(atom/movable/O)

	if(O.collision_flags & src.collision_flags)
		var/direction = O.move_dir
		if(turn(direction,180) & collision_dir)
			return FALSE
		if(is_structure(O)) //Prevents infinite loops.
			var/obj/structure/S = O
			if(collision_dir & S.collision_dir)
				return FALSE

	return TRUE

/obj/structure/Uncross(var/atom/movable/O)

	if(O.collision_flags & src.collision_flags)
		var/direction = O.move_dir
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
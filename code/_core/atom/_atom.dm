/atom/
	name = "atom"
	desc = "What the fuck is this?"

	var/desc_extended = "Such a strange object. I bet not even the gods themselves know what this thing is. Who knows what mysteries it can hold?"
	var/id = null

	plane = PLANE_OBJ

	density = FALSE //DEPCRECATED. Should always be set to false!

	var/health_base = 1
	var/mana_base = 1
	var/stamina_base = 1

	var/throw_speed = 8 //How far the object travels in pixels per decisecond, when thrown

	var/damage_type = "default" //The id of the damage type of the weapon, if any.

	var/attack_range = 1 //If it's a melee weapon, it needs a range. TODO: MOVE TO ITEM

	var/override_icon = FALSE

	var/doing_progress = FALSE

	var/collision_flags = FLAG_COLLISION_NONE
	var/collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/interact_distance = 1

	var/command_delay_base = 1 //For things like clicking.
	var/command_last = 0

	var/attack_delay = 5 //The attack delay for an object.
	var/attack_delay_max = 10 //For living mobs using this object, the maximum attack delay.

	var/attack_next = -1

	var/thinks = FALSE

	var/allow_beaker_transfer = FALSE
	var/reagent_container/reagents

	var/object_size = 1 //This-1 is added to attack range.

	var/corner_icons = FALSE
	var/corner_category = "none"

	var/health/health //The health object. If an object is supposed to take damage, give it a health datum.

	var/immortal = FALSE

	var/footstep_id //The sound the object makes when something enters or exits it.

	var/ignore_incoming_collisons = FALSE

	var/has_quick_function = FALSE
	var/quick_function_type =  FLAG_QUICK_INSTANT
	//FLAG_QUICK_INSTANT
	//FLAG_QUICK_TOGGLE


/atom/proc/add_overlay(var/datum/desired_overlay)

	overlays += desired_overlay

	if(length(overlays) >= 100)
		log_error("Warning: Object [src]([src.type]) exceeds 100 overlays! Cutting...")
		overlays.Cut()

	return TRUE

/obj/structure/should_smooth_with(var/turf/T)

	for(var/obj/structure/O in T.contents)
		if(O.corner_category != corner_category)
			continue
		return TRUE

	return FALSE

/atom/proc/should_smooth_with(var/turf/T)
	return FALSE

/turf/should_smooth_with(var/turf/T)
	return (T.corner_category == corner_category)

/atom/proc/on_destruction(var/atom/caller,var/damage = FALSE) //Called when destructed by tools or damage.
	return TRUE

/atom/Destroy()

	for(var/datum/O in underlays)
		qdel(O)
	underlays.Cut()

	for(var/datum/O in overlays)
		qdel(O)
	overlays.Cut()

	if(reagents)
		qdel(reagents)

	reagents = null

	if(health)
		qdel(health)

	health = null

	stop_thinking(src)

	for(var/atom/A in contents)
		qdel(A)

	appearance = null
	invisibility = 101

	return ..()

/atom/Cross(var/atom/A)

	if(!ignore_incoming_collisons && src.collision_flags & A.collision_flags)
		return FALSE

	return ..()

/atom/New()

	. = ..()

	if(opacity && isturf(loc))
		var/turf/T = loc
		T.has_opaque_atom = TRUE // No need to recalculate it in this case, it's guaranteed to be on afterwards anyways.

	if(reagents && ispath(reagents))
		reagents = new reagents(src)

	if(health)
		health = new health(src)
		INITIALIZE(health)

	set_dir(dir,TRUE)

	return .

/atom/proc/defer_click_on_object()
	return src

/atom/proc/get_xp_multiplier() //How much XP should this object give for interacting with it.
	return 0


/atom/proc/can_be_attacked(var/atom/attacker)

	if(!src.health)
		return FALSE

	if(!BYPASS_AREA_NO_DAMAGE && attacker && is_valid(attacker))

		var/area/A1 = get_area(attacker)
		var/area/A2 = get_area(src)

		if(!(A1 && A2))
			return FALSE

		if(A1.flags_area & FLAGS_AREA_NO_DAMAGE != A2.flags_area & FLAGS_AREA_NO_DAMAGE)
			return FALSE

	return TRUE


/atom/proc/think()
	return thinks

/atom/Enter(var/atom/movable/enterer,var/atom/oldloc)
	return TRUE

/atom/Exit(var/atom/movable/exiter,var/atom/newloc)
	return TRUE


/atom/proc/get_touching_space(var/intercardinal = FALSE)

	. = 0x0

	var/turf/T = get_turf(src)
	for(var/dir in (intercardinal ? DIRECTIONS_ALL : DIRECTIONS_CARDINAL))
		var/turf/T2 = get_step(T,dir)
		var/area/A = T2.loc
		if(A.is_space)
			. |= dir

	return .


/atom/proc/get_best_touching_space()

	var/turf/T = get_turf(src)
	for(var/dir in list(NORTH,SOUTH,EAST,WEST))
		var/turf/T2 = get_step(T,dir)
		var/area/A = T2.loc
		if(A.is_space)
			return dir

	for(var/dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST))
		var/turf/T2 = get_step(T,dir)
		var/area/A = T2.loc
		if(A.is_space)
			return dir

	return 0x0

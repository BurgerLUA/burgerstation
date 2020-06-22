/atom/
	name = "atom"
	desc = "What the fuck is this?"

	var/desc_extended = "Such a strange object. I bet not even the gods themselves know what this thing is. Who knows what mysteries it can hold?"
	var/id = null

	plane = PLANE_OBJ

	density = FALSE //DEPCRECATED. Should always be set to FALSE!

	var/health_base = 1
	var/mana_base = 1
	var/stamina_base = 1

	var/damage_type = /damagetype/error //The id of the damage type of the weapon, if any.

	var/collision_flags = FLAG_COLLISION_NONE
	var/collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	var/collision_dir = 0x0

	var/interact_distance = 1 //You must be at least this close to interact with this object, and for the object to interact with others.
	var/object_size = 1 //This-1 is added to attack range.
	var/attack_range = 1 //If it's a melee weapon, it needs a range.

	var/attack_delay = 5 //The attack delay for an object.
	var/attack_delay_max = 10 //For living mobs using this object, the maximum attack delay.
	var/attack_next = -1

	var/reagent_container/reagents //The reagents object. If an object is supposed to hold liquid, give it a reagent_container datum.
	var/health/health //The health object. If an object is supposed to take damage, give it a health datum.

	var/corner_icons = FALSE
	var/corner_category = "none"

	var/immortal = FALSE //Is this object allowed to take damage?

	var/ignore_incoming_collisons = FALSE //TODO: Replace with tiny.

	var/initialize_type = INITIALIZE_NORMAL //TODO: Make this apply to turfs, mobs, and areas.

	var/luck = 50 //The luck of the atom. Affects rolling against or for user luck.

/atom/proc/add_overlay(var/datum/desired_overlay)

	if(length(overlays) >= 100)
		log_error("Warning: [get_debug_name()] exceeds 100 overlays!")
		return FALSE

	overlays += desired_overlay

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

	set_light(FALSE)

	for(var/datum/O in underlays)
		qdel(O)
	underlays.Cut()

	for(var/datum/O in overlays)
		qdel(O)
	overlays.Cut()

	QDEL_NULL(reagents)
	QDEL_NULL(health)

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

/atom/Initialize()

	if(health)
		health = new health(src)
		INITIALIZE(health)

	return ..()

/atom/New()

	. = ..()

	if(opacity && isturf(loc))
		var/turf/T = loc
		T.has_opaque_atom = TRUE // No need to recalculate it in this case, it's guaranteed to be on afterwards anyways.

	if(reagents && ispath(reagents))
		reagents = new reagents(src)

	set_dir(dir,TRUE)

	return .

/atom/proc/defer_click_on_object(location,control,params)
	return src

/atom/proc/get_xp_multiplier() //How much XP should this object give for interacting with it.
	return 0


/atom/proc/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

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
	return TRUE

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

/atom/proc/is_player_controlled()
	return FALSE

/atom/is_safe_to_delete()

	if(is_player_controlled())
		return FALSE

	for(var/atom/A in contents)
		if(!A.is_safe_to_delete())
			return FALSE

	return ..()

/atom/get_debug_name()
	return "[src.name]([src.type])([x],[y],[z])"



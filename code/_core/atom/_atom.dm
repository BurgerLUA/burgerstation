/atom/
	name = "atom"
	desc = "What the fuck is this?"
	var/label

	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND

	var/desc_extended = "Such a strange object. I bet not even the gods themselves know what this thing is. Who knows what mysteries it can hold?"

	plane = PLANE_OBJ

	density = FALSE //Should always be set to FALSE! Controls if an object should receive a Cross/Uncross/Crossed/Uncrossed proc calls.

	var/health_base = 1
	var/mana_base = 1
	var/stamina_base = 1

	var/damage_type = /damagetype/error //The id of the damage type of the weapon, if any.

	var/collision_flags = FLAG_COLLISION_NONE
	var/collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	var/collision_dir = 0x0

	var/interaction_flags = FLAG_INTERACTION_LIVING

	var/interact_distance = 1 //You must be at least this close to interact with this object, and for the object to interact with others.
	var/object_size = 1 //This-1 is added to attack range.
	var/attack_range = 1 //If it's a melee weapon, it needs a range.

	var/reagent_container/reagents //The reagents object. If an object is supposed to hold liquid, give it a reagent_container datum.
	//This applies to things like beakers and whatnot. This affects player-controlled transfers, and does not affect procs like add_reagent
	var/allow_reagent_transfer_to = FALSE
	var/allow_reagent_transfer_from = FALSE

	var/health/health //The health object. If an object is supposed to take damage, give it a health datum.

	var/corner_icons = FALSE
	var/corner_category = "none"

	var/immortal = FALSE //Is this object allowed to take damage?

	var/ignore_incoming_collisons = FALSE //TODO: Replace with tiny.

	var/initialize_type = INITIALIZE_NORMAL //TODO: Make this apply to turfs, mobs, and areas.

	var/luck = 50 //The luck of the atom. Affects rolling against or for user luck.

	var/desired_light_frequency = 1 //Setting this to a number other than 1 should be reserved for turfs.
	var/desired_light_range = 0 //Range of the light.
	var/desired_light_power = 0 //Power of the light.
	var/desired_light_color = "#FFFFFF" //Color of the light.
	var/desired_light_angle = LIGHT_OMNI //Angle of the light.

	var/attack_next = -1

	var/listener = FALSE //Setting this to true doesn't make it listen after it's been initialized.

	var/dir_offset = TILE_SIZE

/atom/proc/update_name(var/desired_name)
	name = desired_name
	if(label)
		name = "[name] ([label])"
	return TRUE

/atom/proc/get_consume_verb()
	return "eat"

/atom/proc/get_consume_sound()
	return 'sound/items/consumables/eatfood.ogg'

/atom/proc/update_atom_light()
	if(desired_light_range > 0 && desired_light_power > 0)
		if(src.x % desired_light_frequency || src.y % desired_light_frequency)
			return FALSE
		set_light(desired_light_range,desired_light_power,desired_light_color,desired_light_angle)
		return TRUE
	return FALSE

/atom/proc/should_smooth_with(var/turf/T)
	return FALSE

/atom/proc/on_destruction(var/mob/caller,var/damage = FALSE) //Called when destructed by tools or damage.
	HOOK_CALL("on_destruction")
	return TRUE

/atom/Destroy()

	stop_thinking(src)

	set_light(FALSE)

	QDEL_CUT(underlays)
	QDEL_CUT(overlays)

	QDEL_NULL(reagents)
	QDEL_NULL(health)

	for(var/k in contents)
		var/atom/movable/A = k
		qdel(A)

	appearance = null
	invisibility = 101
	mouse_opacity = 0
	icon = null
	icon_state = null

	all_listeners -= src

	return ..()

/atom/Cross(atom/movable/O)

	if(!ignore_incoming_collisons && src.collision_flags & O.collision_flags)
		return FALSE

	return ..()

/atom/PostInitialize()

	if(health)
		health = new health(src)
		INITIALIZE(health)
		FINALIZE(health)

	update_atom_light()

	return ..()

/atom/Initialize()

	if(reagents)
		reagents = new reagents(src)

	if(listener)
		all_listeners |= src

	return ..()

/atom/Finalize()
	. = ..()
	update_name(name) //Setup labels
	return .

/atom/New()

	. = ..()

	if(opacity && isturf(loc))
		var/turf/T = loc
		T.has_opaque_atom = TRUE // No need to recalculate it in this case, it's guaranteed to be on afterwards anyways.

	set_dir(dir,TRUE)

	return .

/atom/proc/defer_click_on_object(var/mob/caller,location,control,params)
	return src

/atom/proc/get_xp_multiplier() //How much XP should this object give for interacting with it.
	return 0


/atom/proc/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!src.initialized)
		return FALSE

	if(!src.health)
		return FALSE

	return TRUE

/atom/proc/think()
	return TRUE

/atom/proc/get_touching_space(var/intercardinal = FALSE)

	. = 0x0

	var/turf/T = get_turf(src)
	for(var/dir in (intercardinal ? DIRECTIONS_ALL : DIRECTIONS_CARDINAL))
		var/turf/T2 = get_step(T,dir)
		if(T2.is_space())
			. |= dir

	return .


/atom/proc/get_best_touching_space(var/intercardinal = TRUE)

	var/turf/T = get_turf(src)
	for(var/dir in list(NORTH,SOUTH,EAST,WEST))
		var/turf/T2 = get_step(T,dir)
		if(T2.is_space())
			return dir

	if(intercardinal)
		for(var/dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST))
			var/turf/T2 = get_step(T,dir)
			if(T2.is_space())
				return dir

	return 0x0

/atom/proc/is_player_controlled()
	return FALSE

/atom/is_safe_to_delete(var/check_loc = TRUE)

	if(is_player_controlled())
		return FALSE

	if(check_loc && loc && !isturf(loc))
		return FALSE

	for(var/k in contents)
		var/atom/movable/A = k
		if(!A.is_safe_to_delete(FALSE))
			return FALSE

	return ..()

/atom/get_debug_name()
	return "[src.name]([src.type])<a href='?spectate=1;x=[x];y=[y];z=[z]'>([x],[y],[z])</a>"

/atom/get_log_name()
	return "[src.name]([src.type])([x],[y],[z])</a>"

/atom/proc/get_inaccuracy(var/atom/source,var/atom/target,var/inaccuracy_mod = 1)
	return 0


/atom/proc/on_projectile_hit(var/obj/projectile/P,var/atom/hit_atom)
	return TRUE

/atom/proc/is_busy()
	return SSprogressbars.all_progress_bars[src] ? TRUE : FALSE


/atom/Enter(atom/movable/O,atom/oldloc) //Override default
	return TRUE

/atom/Exit(atom/movable/O,atom/oldloc) //Override default
	return TRUE

/atom/Cross(atom/movable/O) //Override default
	return TRUE

/atom/Crossed(atom/movable/O) //Override default
	return TRUE

/atom/proc/on_listen(var/atom/speaker,var/datum/source,var/text,var/language_text,var/talk_type,var/frequency,var/language=LANGUAGE_BASIC,var/talk_range=TALK_RANGE)
	return TRUE


/atom/proc/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK,var/talk_range=TALK_RANGE,var/language_to_use=null)

	if(should_sanitize)
		text_to_say = sanitize(text_to_say)

	talk(src,src,text_to_say,talk_type_to_use,null,language_to_use,talk_range)

	return TRUE
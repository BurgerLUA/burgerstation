/atom/

	desc = "What the fuck is this?"
	var/desc_extended = "Such a strange object. I bet not even the gods themselves know what this thing is. Who knows what mysteries it can hold?"

	var/health_max = 0
	var/health_current = 0
	var/health_regeneration = 0

	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)
	var/id

	var/throw_speed = 8 //How far the object travels in pixels per decisecond, when thrown

	var/damagetype/damage_type //The damage type of the weapon, if any.

	var/list/resistance = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0) //How much to subtract damage

	var/attack_range = 1 //If it's a melee weapon, it needs a range.

	var/attack_delay = 4
	var/attack_last = 0

	var/initialized = FALSE

	var/area/area //The object's area.

	density = FALSE

	plane = PLANE_DEFAULT

	var/list/additional_blends = list()

	var/override_icon = FALSE
/atom/proc/Initialize()
	initialize_blends()
	//Initialize things here
	initialized = TRUE
	update_health()
	update_icon()
	area = get_area(src)

/atom/New(var/new_loc)
	if(damage_type)
		damage_type = new damage_type
	. = ..()

/atom/proc/can_not_leave(var/atom/A,var/move_direction)
	return null

/atom/proc/can_not_enter(var/atom/A,var/move_direction)
	return null

/atom/proc/on_enter(var/atom/A,var/move_direction)
	return TRUE

/atom/proc/on_exit(var/atom/A,var/move_direction)
	return TRUE

/atom/proc/do_bump(var/atom/A,var/bump_direction,var/movement_override = 0)
	return TRUE

/atom/proc/defer_click_on_object()
	return src

/atom/proc/get_xp_multiplier() //How much XP should this object give for interacting with it.
	return 0

/atom/proc/can_be_attacked(var/atom/attacker)
	return TRUE
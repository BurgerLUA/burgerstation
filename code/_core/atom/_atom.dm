/atom/
	var/health_max = 100
	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0)
	var/id

	var/throw_speed = 8 //How far the object travels in pixels per decisecond, when thrown

	var/datum/damage_type //The damage type of the weapon, if any.

	var/list/resistance = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0) //How much to subtract damage

	var/attack_range = 1 //If it's a melee weapon, it needs a range.

/atom/proc/Initialize()
	//Initialize things here

/atom/New()
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

/atom/proc/do_bump(var/atom/A,var/bump_direction)
	return TRUE
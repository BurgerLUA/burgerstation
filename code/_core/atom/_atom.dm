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



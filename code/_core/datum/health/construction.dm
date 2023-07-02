/health/construction/

	/*
	damage_base = list(  //Base armor for the mob.
		BLADE = INFINITY,
		BLUNT = INFINITY,
		PIERCE = INFINITY,
		LASER = INFINITY,
		ARCANE = INFINITY,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)
	*/

/health/construction/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	if(!owner)
		return .
	if(health_current <= 0 && owner.can_do_destruction())
		owner.on_destruction()

/health/construction/glass
	var/old_damage_number = 0

/health/construction/glass/update_health()
	. = ..()
	if(!owner)
		return .
	var/damage_number = 3 - FLOOR((health_current/health_max)*3, 1)
	if(old_damage_number != damage_number)
		owner.update_sprite()
		old_damage_number = damage_number

/health/construction/glass/reinforced








/health/construction/field_generator/

/health/construction/field_generator/get_damage_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	if(istype(weapon,/obj/structure/interactive/emitter))
		return 0

	. = ..()
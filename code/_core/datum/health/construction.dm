/health/construction/

	/*
	armor_base = list(  //Base armor for the mob.
		BLADE = ARMOR_X,
		BLUNT = ARMOR_X,
		PIERCE = ARMOR_X,
		LASER = ARMOR_X,
		MAGIC = ARMOR_X,
		HEAT = ARMOR_X,
		COLD = ARMOR_X,
		BOMB = 0,
		BIO = ARMOR_X,
		RAD = ARMOR_X,
		HOLY = ARMOR_X,
		DARK = ARMOR_X,
		FATIGUE = ARMOR_X
	)
	*/

	var/old_damage_number = 0


/health/construction/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && health_current <= 0)
		var/obj/structure/interactive/construction/C = owner
		C.on_destruction(attacker,TRUE)

	return .


/health/construction/glass


/health/construction/glass/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && owner)

		var/damage_number = 3 - FLOOR((health_current/health_max)*3, 1)

		if(old_damage_number != damage_number)

			if(length(owner.overlays))
				owner.overlays.Cut()

			owner.update_icon()

			if(damage_number > 0)
				var/image/I = new/image('icons/obj/effects/glass_damage.dmi',"damage_[damage_number]")
				owner.overlays += I

			old_damage_number = damage_number

	return .

/health/construction/glass/reinforced

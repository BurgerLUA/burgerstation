/mob/living/simple/npc/turret/port
	var/state = 0
	// 0 = closed
	// 1 = opening
	// 2 = open
	// 3 = closing
	icon_state = "turretCover"

	ai = /ai/ranged/immobile/turret/port

/mob/living/simple/npc/turret/port/proc/open()

	if(dead)
		return FALSE

	if(state != 0)
		return FALSE

	state = 1
	update_icon()

	spawn(5.5)
		state = 2
		update_icon()

	return TRUE

/mob/living/simple/npc/turret/port/proc/close()

	if(dead)
		return FALSE

	if(state != 2)
		return FALSE

	state = 3
	update_icon()

	spawn(5.5)
		state = 0
		update_icon()

	return TRUE

/mob/living/simple/npc/turret/port/update_icon()

	underlays = list()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/desired_cover_state
	var/desired_gun_state

	if(dead)
		desired_cover_state = "openTurretCover"
		desired_gun_state = "broken"
	else
		switch(state)
			if(0)
				desired_cover_state = "turretCover"
			if(1)
				desired_cover_state = "popup"
			if(2)
				desired_cover_state = "openTurretCover"
			if(3)
				desired_cover_state = "popdown"

		if(!stored_weapon)
			desired_gun_state = "off"
		else
			switch(mode)
				if(0)
					desired_gun_state = "off"
				if(1)
					desired_gun_state = "stun"
				if(2)
					desired_gun_state = "lethal"

	var/icon/icon_base = new(icon,"basedark")
	var/icon/icon_gun = new(icon,desired_gun_state)
	icon_base.Blend(icon_gun,ICON_OVERLAY)

	underlays += icon_base
	icon_state = desired_cover_state

/mob/living/simple/npc/turret/port/can_attack(var/atom/victim,vat/atom/weapon/var/params)
	if(state != 2)
		return FALSE

	return ..()
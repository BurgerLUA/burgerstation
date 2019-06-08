/mob/living/simple/npc/turret
	name = "turret"
	icon = 'icons/mob/living/simple/turrets.dmi'
	icon_state = "turretCover"

	var/gun_type = "standard"

	var/state = 0
	// 0 = closed
	// 1 = opening
	// 2 = open
	// 3 = closing

	var/mode = 1
	// 0 = off
	// 1 = stun
	// 2 = lethal

	ai = /ai/ranged/immobile/turret

	var/obj/item/stored_weapon

	health_base = 100

	class = "spider"


/mob/living/simple/npc/turret/Initialize()
	. = ..()

	if(stored_weapon)
		stored_weapon = new stored_weapon(src)

	return .

/mob/living/simple/npc/turret/on_left_down(object,location,control,params)
	if(stored_weapon)
		stored_weapon.click_on_object(src,object,location,control,params)
	return TRUE

/mob/living/simple/npc/turret/can_attack(var/atom/victim,var/params)

	if(mode == 0)
		return FALSE

	if(state != 2)
		return FALSE

	return ..()

/mob/living/simple/npc/turret/proc/open()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(state != 0)
		return FALSE

	state = 1
	update_icon()

	spawn(5.5)
		state = 2
		update_icon()

	return TRUE

/mob/living/simple/npc/turret/proc/close()

	if(status & FLAG_STATUS_DEAD)
		return FALSE

	if(state != 2)
		return FALSE

	state = 3
	update_icon()

	spawn(5.5)
		state = 0
		update_icon()

	return TRUE

/mob/living/simple/npc/turret/update_icon()

	underlays = list()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/desired_cover_state
	var/desired_gun_state

	if(status & FLAG_STATUS_DEAD)
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

/mob/living/simple/npc/turret/smg
	stored_weapon = /obj/item/weapon/ranged/laser/unlimited



/mob/living/simple/npc/turret/laser
	stored_weapon = /obj/item/weapon/ranged/laser/unlimited
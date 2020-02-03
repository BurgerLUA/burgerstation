/mob/living/simple/npc/turret
	name = "turret"
	icon = 'icons/mob/living/simple/turrets.dmi'
	icon_state = "syndie_off"

	var/gun_type = "standard"

	var/mode = 1
	// 0 = off
	// 1 = stun
	// 2 = lethal

	ai = /ai/ranged/immobile/turret

	var/obj/item/stored_weapon

	health_base = 100

	class = "spider"

/mob/living/simple/npc/turret/Destroy()
	qdel(stored_weapon)
	stored_weapon = null
	return ..()

/mob/living/simple/npc/turret/update_icon()

	if(dead)
		icon_state = "syndie_broken"
		return

	switch(mode)
		if(0)
			icon_state = "syndie_off"
		if(1)
			icon_state = "syndie_stun"
		if(2)
			icon_state = "syndie_lethal"

/mob/living/simple/npc/turret/Initialize()
	. = ..()

	if(stored_weapon)
		stored_weapon = new stored_weapon(src)

	return .

/mob/living/simple/npc/turret/on_left_down(object,location,control,params)
	if(stored_weapon)
		return stored_weapon.click_on_object(src,object,location,control,params)

	return TRUE

/mob/living/simple/npc/turret/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(mode == 0)
		return FALSE

	return ..()

/mob/living/simple/npc/turret/laser
	stored_weapon = /obj/item/weapon/ranged/energy/unlimited

/mob/living/simple/npc/turret/port/laser
	stored_weapon = /obj/item/weapon/ranged/energy/unlimited
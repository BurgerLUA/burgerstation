/mob/living/simple/silicon/cyborg

	name = "cyborg"
	icon = 'icons/mob/living/simple/cyborg.dmi'
	icon_state = "robot"

	var/module = null

	var/obj/item/weapon/stored_melee_weapon
	var/obj/item/weapon/ranged/stored_ranged_weapon

	var/obj/item/powercell/stored_battery

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/robot
	blood_volume = 500

	health_base = 500
	mana_base = 100
	stamina_base = 500

	armor = /armor/borg

	damage_type = /damagetype/squats/

	level = 15

/mob/living/simple/silicon/cyborg/Destroy()
	QDEL_NULL(stored_melee_weapon)
	QDEL_NULL(stored_ranged_weapon)
	QDEL_NULL(stored_battery)
	. = ..()

/mob/living/simple/silicon/cyborg/get_battery()
	return stored_battery

/mob/living/simple/silicon/cyborg/Generate()
	. = ..()
	if(!stored_battery)
		stored_battery = new /obj/item/powercell/recharging(src)
		INITIALIZE(stored_battery)
		GENERATE(stored_battery)
		FINALIZE(stored_battery)

/mob/living/simple/silicon/cyborg/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = module

/mob/living/simple/silicon/cyborg/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]_e")
	add_overlay(I)

/mob/living/simple/silicon/cyborg/proc/do_transform()
	module = pick("sec","medical","engineer")
	icon_state = "[module]_transform"
	add_status_effect(PARALYZE,duration=50,magnitude=-1,stealthy=TRUE,bypass_limits=TRUE)
	CALLBACK("\ref[src]_finish_transform",50,src,.proc/finish_transform)

/mob/living/simple/silicon/cyborg/proc/finish_transform()

	if(qdeleting || dead || !module)
		return FALSE

	update_sprite()

	switch(module)
		if("sec")
			stored_melee_weapon = new/obj/item/weapon/melee/energy/stunbaton(src)
			stored_ranged_weapon = new/obj/item/weapon/ranged/energy/rifle(src)
		if("medical")
			stored_melee_weapon = new/obj/item/weapon/melee/sword/butcher_cleaver(src)
			stored_ranged_weapon = new/obj/item/weapon/ranged/energy/freezegun(src)
		if("engineer")
			stored_melee_weapon = new/obj/item/weapon/melee/axe/fireaxe(src)
			stored_ranged_weapon = new/obj/item/weapon/ranged/energy/flamethrower(src)

	if(stored_melee_weapon)
		INITIALIZE(stored_melee_weapon)
		GENERATE(stored_melee_weapon)
		FINALIZE(stored_melee_weapon)

	if(stored_ranged_weapon)
		INITIALIZE(stored_ranged_weapon)
		GENERATE(stored_ranged_weapon)
		FINALIZE(stored_ranged_weapon)


/mob/living/simple/silicon/cyborg/death(var/silent=FALSE)
	. = ..()
	if(.)
		if(silent)
			qdel(src)
		else
			gib()

/mob/living/simple/silicon/cyborg/post_move(var/atom/old_loc)
	. = ..()
	if(. && !module && loc && !qdeleting && !dead)
		do_transform()

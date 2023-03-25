/mob/living/simple/silicon/ai
	name = "The AI"
	icon = 'icons/mob/living/simple/ai.dmi'
	icon_state = "idle"

	var/next_spawner_spawn = 0

	var/list/linked_spawners = list()
	var/list/linked_generators = list()

	health_base = 1000
	stamina_base = 50
	mana_base = 50

/mob/living/simple/silicon/ai/proc/spawn_spawners()

	if(!z)
		return FALSE

	var/leap_distance = round(VIEW_RANGE,2) //Needs to be even.
	var/list/all_directions = DIRECTIONS_ALL
	for(var/k in all_directions)
		var/list/offsets = direction_to_pixel_offset(k)
		var/turf/simulated/T = locate(x + offsets[1]*leap_distance,y + offsets[2]*leap_distance,z)
		if(!T || !is_simulated(T))
			continue
		var/maximum_checks = 4 //This probably won't happen but this is really just in case some fuckery happens.
		while(maximum_checks > 0 && T.density && T.health)
			maximum_checks--
			if(maximum_checks > 0 && T.destruction_turf && !initial(T.destruction_turf.density))
				T.change_turf(T.destruction_turf)
			else
				T.change_turf(/turf/simulated/floor/plating)
			sleep(-1)
		var/mob/living/simple/silicon/spawner/S = locate() in T.contents
		if(S)
			if(S.dead)
				gib(S)
			continue
		S = new /mob/living/simple/silicon/spawner(T)
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		linked_spawners += S

	next_spawner_spawn = world.time + SECONDS_TO_DECISECONDS(60)

/mob/living/simple/silicon/ai/remove_status_effect(var/status_type,var/check_horizontal=TRUE)
	. = ..()
	if(.)
		update_icon()

/mob/living/simple/silicon/ai/add_status_effect(var/status_type,var/magnitude,var/duration,var/atom/source,var/force=FALSE,var/stealthy=FALSE,var/bypass_limits=FALSE)
	. = ..()
	if(.)
		update_icon()

/mob/living/simple/silicon/ai/Destroy()
	linked_spawners.Cut()
	linked_spawners = null
	. = ..()

/mob/living/simple/silicon/ai/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(dead)
		icon_state = "dead"
	else if(has_status_effect(STUN))
		icon_state = "stunned"
	else if(ai && ai.objective_attack)
		icon_state = "living"

/mob/living/simple/silicon/ai/death(var/silent=TRUE)
	. = ..()
	if(.)
		for(var/k in linked_spawners)
			var/mob/living/L = k
			L.death(silent)


/mob/living/simple/silicon/ai/post_death()
	. = ..()
	update_icon()



/mob/living/simple/ai/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 15 && prob(damage_amount) && (icon_state == "living" || icon_state == "stunned"))
		flick("[icon_state]_damage",src)

/mob/living/simple/silicon/spawner
	name = "cyborg spawner"
	icon = 'icons/mob/living/simple/ai.dmi'
	icon_state = "spawner"

	anchored = TRUE
	ai = null

	health_base = 500

	var/list/active_silicons = list()

	var/silicon_limit = 5

	pixel_y = 10

/mob/living/simple/silicon/spawner/Destroy()
	. = ..()
	active_silicons.Cut()
	active_silicons = null

/mob/living/simple/silicon/spawner/Finalize()
	. = ..()
	pixel_y = 0
	animate(src,pixel_y=initial(pixel_y),time=10)
	flick("spawner_new",src)
	start_creating()

/mob/living/simple/silicon/spawner/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_destroyed"

/mob/living/simple/silicon/spawner/proc/start_creating()
	if(dead || qdeleting)
		return FALSE

	for(var/k in active_silicons)
		var/mob/living/L = k
		if(L.dead || L.qdeleting || get_dist(src,L) >= VIEW_RANGE*2)
			active_silicons -= L

	if(length(active_silicons) > silicon_limit)
		CALLBACK("\ref[src]_start_creating",SECONDS_TO_DECISECONDS(5),src,.proc/start_creating) //Try again later.
		return FALSE

	icon_state = "[initial(icon_state)]_creating"
	CALLBACK("\ref[src]_create_silicon",SECONDS_TO_DECISECONDS(10),src,.proc/create_silicon)
	return TRUE

/mob/living/simple/silicon/spawner/proc/create_silicon()
	if(dead || qdeleting)
		return FALSE
	icon_state = "[initial(icon_state)]_open"

	var/mob/living/simple/silicon/cyborg/SM = new(src.loc)
	INITIALIZE(SM)
	GENERATE(SM)
	FINALIZE(SM)
	if(SM.ai)
		SM.ai.set_active(TRUE)
		SM.ai.find_new_objectives(AI_TICK,TRUE)
		SM.ai.roaming_distance = VIEW_RANGE*0.5
		SM.ai.allow_far_roaming = FALSE
	SM.Move(get_step(SM,SOUTH))
	active_silicons += SM

	CALLBACK("\ref[src]_start_creating",SECONDS_TO_DECISECONDS(10),src,.proc/start_creating) //Repeat.

	return TRUE

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

/mob/living/simple/silicon/ai
	name = "The AI"
	icon = 'icons/mob/living/simple/ai.dmi'
	icon_state = "idle"

	ai = /ai/boss/ai_core

	var/next_spawner_spawn = 0

	var/list/linked_spawners = list()
	var/list/linked_generators = list()

	var/list/linked_shield_walls = list()

	health_base = 5000
	stamina_base = 50
	mana_base = 50

	anchored = TRUE
	density = TRUE

	boss = TRUE
	boss_loot = /loot/lavaland/ai_core

	boss_music = /track/dead

	var/next_cyborg_spawn_time = -1

	var/list/hit_directions = list()

/mob/living/simple/silicon/ai/Initialize()
	. = ..()
	for(var/d in DIRECTIONS_ALL)
		hit_directions["[d]"] = 0
		linked_shield_walls["[d]"] = list()

/mob/living/simple/silicon/ai/handle_transform(var/force=FALSE)
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
	else if(horizontal)
		icon_state = "stunned"
	else if(ai && ai.objective_attack)
		icon_state = "living"

/mob/living/simple/silicon/ai/death(var/silent=TRUE)
	. = ..()
	if(.)
		for(var/k in linked_spawners)
			var/mob/living/L = k
			L.death(silent)

/mob/living/simple/silicon/ai/on_life_slow()
	. = ..()
	if(z && !dead && next_cyborg_spawn_time > 0)
		handle_shield_walls()
		handle_spawners()

/mob/living/simple/silicon/ai/post_death()
	. = ..()
	update_icon()
	for(var/d_text in linked_shield_walls)
		for(var/k in linked_shield_walls[d_text])
			var/obj/shield_wall/SW = k
			qdel(SW)
			linked_shield_walls[d_text] -= k

/mob/living/simple/silicon/ai/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount > 0)
		var/d = get_dir(src,attacker)
		if(d)
			var/distance_mod = (get_dist(src,attacker)/VIEW_RANGE*0.75)
			hit_directions["[d]"] = min(hit_directions["[d]"] + damage_amount*distance_mod,LIFE_TICK_SLOW*50*10) //Maximum 10 seconds of shield.

	if(damage_amount >= 15 && prob(damage_amount) && (icon_state == "living" || icon_state == "stunned"))
		flick("[icon_state]_damage",src)

	if(next_cyborg_spawn_time <= 0)
		destroy_surrounding_obstacles_in_area() //This sets next_cyborg_spawn_time.



/mob/living/simple/silicon/ai/proc/handle_shield_walls() //Runs every LIFE_TICK_SLOW

	for(var/d_text in hit_directions)
		var/d = text2num(d_text)
		var/hit_amount = hit_directions[d_text]
		if(hit_amount <= 0)
			for(var/k in linked_shield_walls[d_text])
				var/obj/shield_wall/SW = k
				qdel(SW)
				linked_shield_walls[d_text] -= k
			continue
		if(length(linked_shield_walls[d_text]))
			hit_amount = max(0,hit_amount-LIFE_TICK_SLOW*50) //Decay
		else if(hit_amount >= LIFE_TICK_SLOW*50*4) //Create some! Minimum 4 seconds of shield.
			var/shield_range = round(VIEW_RANGE,2)

			var/list/offsets = direction_to_pixel_offset(d)
			for(var/i=-shield_range,i<=shield_range,i++)
				var/turf/T = locate(\
					round(offsets[1]*shield_range + offsets[2]*i,1),
					round(offsets[2]*shield_range + offsets[1]*i,1)
				)
				if(T)
					var/obj/shield_wall/W = new(T)
					INITIALIZE(W)
					GENERATE(W)
					FINALIZE(W)
					linked_shield_walls[d_text] += W
					W.alpha = 100
					animate(W.alpha=200,time=5,easing=ELASTIC_EASING)


//Stolen from gabber.
/mob/living/simple/silicon/ai/proc/destroy_surrounding_obstacles_in_area()

	var/ix=0
	var/iy=0
	var/imaximum = 0
	var/area/A = get_area(src)
	while(imaximum < VIEW_RANGE)
		if(iy > imaximum)
			imaximum++
			ix = -imaximum
			iy = -imaximum
		else if(ix > imaximum)
			ix = -imaximum
			iy += 1
		else
			ix += 1
		var/turf/T = locate(x + ix,y + iy,z)
		if(!T || A != T.loc)
			continue
		CALLBACK("\ref[src]_create_turf_destruction_[ix]_[iy]",(abs(ix) + abs(iy))*4,src,src::create_turf_destruction(),T)

	next_cyborg_spawn_time = max(next_cyborg_spawn_time,world.time + VIEW_RANGE*10)

/mob/living/simple/silicon/ai/proc/create_turf_destruction(var/turf/T)
	new /obj/effect/gabber_turf_destruction(T,force_turf=/turf/simulated/floor/circuit/red)
	return TRUE


/mob/living/simple/silicon/ai/proc/handle_spawners()

	if(next_cyborg_spawn_time > world.time)
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
				break
			sleep(-1)
		var/mob/living/simple/silicon/spawner/S = locate() in T.contents
		if(S)
			if(S.dead)
				gib(S)
			continue //Wait until next cycle
		S = new /mob/living/simple/silicon/spawner(T)
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		linked_spawners += S

	next_cyborg_spawn_time = world.time + SECONDS_TO_DECISECONDS(30)
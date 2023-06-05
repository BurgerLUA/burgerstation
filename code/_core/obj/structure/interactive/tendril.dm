var/global/list/possible_monsters_to_spawn = list(
	/mob/living/simple/legionare_head,
	/mob/living/simple/goliath,
	/mob/living/simple/hivelord,
	/mob/living/simple/watcher
)

/obj/structure/interactive/tendril
	name = "necropolis tendril"
	desc = "The source of all life in lavaland."
	desc_extended = "A very dangerous tendril that creates life, as well as destroys it. Killing the surrounding fauna will destroy the tendril and grant a reward."

	icon = 'icons/obj/structure/tendril.dmi'
	icon_state = "idle"

	var/mob/living/monster_to_spawn
	var/spawn_limit = 5
	var/list/mob/living/tracked_mobs = list()
	var/tracked_mobs_length = 0 //Read only.

	var/mob/living/boss_to_spawn

	var/deaths_until_loot = 12

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	density = TRUE

	anchored = 2

	desired_light_power = 0.75
	desired_light_range = VIEW_RANGE*0.5
	desired_light_color = "#C67000"

	plane = PLANE_MOVABLE

	mouse_opacity = 1

/obj/structure/interactive/tendril/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","\The [src.name] has [max(deaths_until_loot,0)] spawns left, with [length(tracked_mobs_length)] monsters protecting it...")

/obj/structure/interactive/tendril/Destroy()
	. = ..()
	tracked_mobs.Cut()

/obj/structure/interactive/tendril/Generate()
	. = ..()
	if(!monster_to_spawn)
		monster_to_spawn = pick(possible_monsters_to_spawn)

/obj/structure/interactive/tendril/Finalize()
	. = ..()
	CALLBACK("\ref[src]_spawn",SECONDS_TO_DECISECONDS(2),src,src::spawn_monster())
	for(var/d in DIRECTIONS_ALL + 0x0)
		var/turf/T = get_step(src,d)
		if(T && is_simulated(T))
			var/turf/simulated/S = T
			if(S.health || !S.density)
				S.change_turf(/turf/simulated/floor/basalt/)

/obj/structure/interactive/tendril/proc/telegraph_delete()

	for(var/k in DIRECTIONS_ALL + 0x0)
		var/turf/T = get_step(src,k)
		if(T && is_simulated(T))
			var/turf/simulated/S = T
			if(S.health || !S.density)
				S.change_turf(/turf/simulated/liquid/lava/)

	qdel(src)

/obj/structure/interactive/tendril/proc/spawn_monster()

	if(src.qdeleting)
		return FALSE

	for(var/k in tracked_mobs)
		var/mob/living/L = k
		if(!L || L.qdeleting || L.dead)
			tracked_mobs -= L
			deaths_until_loot -= 1
		else if(get_dist(L,src) >= VIEW_RANGE*2)
			tracked_mobs -= L

	tracked_mobs_length = length(tracked_mobs)

	if(tracked_mobs_length <= 0 && deaths_until_loot <= 0)
		alpha = 0
		set_density(0)
		mouse_opacity = 0
		var/obj/structure/interactive/crate/necro/C = new(get_turf(src))
		INITIALIZE(C)
		GENERATE(C)
		FINALIZE(C)
		play_sound('sound/effects/tendril_destroyed.ogg',get_turf(src))
		CALLBACK("\ref[src]_telegraph_delete",SECONDS_TO_DECISECONDS(6),src,src::telegraph_delete())
		return TRUE

	if(tracked_mobs_length < spawn_limit && deaths_until_loot > 0)

		var/list/valid_turfs = list()
		for(var/d in DIRECTIONS_ALL)
			var/turf/T2 = get_step(src,d)
			if(T2 && !T2.density && T2.can_move_to())
				valid_turfs += T2

		if(length(valid_turfs))
			var/turf/T2 = pick(valid_turfs)
			var/mob/living/L = new monster_to_spawn(T2)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)
			tracked_mobs += L
			var/obj/effect/temp/E = new(T2,SECONDS_TO_DECISECONDS(1))
			E.icon = 'icons/obj/effects/tendril_spawn.dmi'
			E.icon_state = "spawning"
			L.color = "#000000"
			animate(L,color=initial(L.color),SECONDS_TO_DECISECONDS(1))
			flick("spawn",src)
			if(L.ai)
				var/chunk/C = CHUNK(T2)
				if(C && C.visited_by_player)
					L.ai.set_active(TRUE)
					L.ai.find_new_objectives(AI_TICK,TRUE)
					L.ai.roaming_distance = VIEW_RANGE*0.5
					L.ai.allow_far_roaming = FALSE


	CALLBACK("\ref[src]_spawn",SECONDS_TO_DECISECONDS(2+tracked_mobs_length),src,src::spawn_monster())

	return TRUE
/event/soldier
	name = "Soldier Migration"

	probability = 10 //relative

	var/list/possible_enemy_types = list(
		/mob/living/advanced/npc/ashwalker/hunter,
		/mob/living/advanced/npc/beefman,
		/mob/living/advanced/npc/pirate_crew/magic,
		/mob/living/advanced/npc/rev,
		/mob/living/advanced/npc/sorcerer,
		/mob/living/advanced/npc/syndicate/quadruple,
		/mob/living/simple/npc/arachnid,
		/mob/living/simple/npc/bear/space,
		/mob/living/simple/npc/bull,
		/mob/living/simple/npc/crab,
		/mob/living/simple/npc/glockroach,
		/mob/living/simple/npc/goliath,
		/mob/living/simple/npc/spacecarp,
		/mob/living/simple/npc/spider,
		/mob/living/simple/npc/venus_human_trap,
		/mob/living/simple/npc/watcher,
		/mob/living/simple/npc/xenomorph
	)

	occurances_max = 10

/event/soldier/Destroy()
	return ..()

/event/soldier/on_start()

	LOG_DEBUG("Starting Soldier Migration Event")

	var/mob/living/L = pick(possible_enemy_types)

	var/obj/marker/map_node/spawn_node = SShorde.find_viable_spawn()
	if(!spawn_node)
		log_error("ERROR: Could not find a valid horde spawn!")
		return FALSE

	var/obj/marker/map_node/target_node = SShorde.find_viable_target()
	if(!target_node)
		log_error("ERROR: Could not find a valid horde target!")
		return FALSE

	var/obj/marker/map_node/list/found_path = spawn_node.find_path(target_node)
	if(!found_path)
		log_error("ERROR: Could not find a valid path from [spawn_node.get_debug_name()] to [target_node.get_debug_name()]!")
		return FALSE

	announce(
		"Central Command Intelligence Division",
		"Enemy Troop Movements.",
		"A group of hostile [initial(L.name)] reinforcements has been detected near the area of operations. Personel are advised not to travel alone."
	)

	var/turf/T = get_turf(spawn_node)

	notify_ghosts("A wave of hostile [initial(L.name)] is being created!",T)

	for(var/i=1,i<=rand(4,8),i++)
		CHECK_TICK(50,FPS_SERVER*5)
		var/mob/living/L2 = new L(T)
		INITIALIZE(L2)
		L2.ai.set_path(found_path)

	return ..()

/event/carp/on_end()
	LOG_DEBUG("Ending Carp Migration Event")
	return ..()
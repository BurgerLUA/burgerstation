/mob/living/simple/npc/legion
	name = "legion"

	icon = 'icons/mob/living/simple/lavaland/legioner.dmi'
	icon_state = "legion"


	damage_type = /damagetype/unarmed/fists
	class = /class/legion
	ai = /ai/legion

	health_base = 200

	value = 500

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/mob/living/advanced/stored_corpse = /mob/living/advanced/npc/nanotrasen/shaft_miner

	var/mob/living/simple/npc/legion_head/head_type = /mob/living/simple/npc/legion_head

	var/list/mob/living/simple/npc/legion_head/tracked_heads = list()

	var/head_limit = 3

	iff_tag = "Legion"
	loyalty_tag = "Legion"

/mob/living/simple/npc/legion/Destroy()

	if(stored_corpse)
		stored_corpse.force_move(get_turf(src))

	stored_corpse = null

	for(var/k in tracked_heads)
		var/mob/living/simple/npc/legion_head/L = k
		L.death()

	return ..()

/mob/living/simple/npc/legion/proc/create_head()

	if(length(tracked_heads) >= head_limit)
		return FALSE

	var/mob/living/simple/npc/legion_head/L = new head_type(get_turf(src))
	L.parent_legion = src
	INITIALIZE(L)
	GENERATE(L)
	FINALIZE(L)

	if(L.ai)
		if(ai && ai.objective_attack)
			L.ai.set_objective(ai.objective_attack)
		else
			L.ai.set_active(TRUE)

	tracked_heads += L

	return TRUE

/mob/living/simple/npc/legion/Finalize()

	if(ispath(stored_corpse))
		stored_corpse = new /mob/living/advanced/npc/nanotrasen/shaft_miner(src)
		INITIALIZE(stored_corpse)
		GENERATE(stored_corpse)
		FINALIZE(stored_corpse)
		stored_corpse.death()
		if(stored_corpse.health) stored_corpse.health.adjust_loss_smart(brute=100,burn=100)

	return ..()

/mob/living/simple/npc/legion/post_death()
	qdel(src)
	return ..()

/mob/living/simple/npc/legion/snow
	name = "snow legion"
	icon = 'icons/mob/living/simple/snowlegion.dmi'
	icon_state = "living"

	stun_angle = 0

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -50,
		ARCANE = 100,
		HEAT = -200,
		COLD = INFINITY,
		BOMB = -50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = -50,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = INFINITY
	)



	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/legion/snow/post_death()
	. = ..()
	icon_state = "dead"
	return .
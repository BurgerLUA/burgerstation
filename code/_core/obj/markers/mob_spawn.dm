/obj/marker/mob_spawn/
	name = "Mob Spawnpoint"
	desc = "This is where a mob should be placed at round start."

	icon = 'icons/lighting.dmi'
	icon_state = "white"

	var/type_to_spawn
	var/time_to_respawn = 0 //Set to 0 if it doesn't respawn.

	//Internal Values
	var/mob/living/owning_mob
	var/death_time = 0

/obj/marker/mob_spawn/New()
	mob_spawnpoints += src

/obj/marker/mob_spawn/proc/attempt_spawn()

	if(!type_to_spawn)
		return

	if(owning_mob)
		if(!time_to_respawn)
			return
		if(!death_time && owning_mob.status & FLAG_STATUS_DEAD)
			death_time = curtime
			return
		if(death_time && death_time + time_to_respawn > curtime)
			return

	owning_mob = new type_to_spawn(src.loc)
	death_time = 0

/obj/marker/mob_spawn/hostile_human
	name = "hostile new player spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/greytide


/obj/marker/mob_spawn/tutorial_cultist
	name = "tutorial cultist spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/cultist/tutorial


/obj/marker/mob_spawn/tutorial_security
	name = "tutorial security spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/security/tutorial


/obj/marker/mob_spawn/marwani
	name = "marwani spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/unique/marwani


/obj/marker/mob_spawn/marwani/ship
	name = "ship marwani spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/unique/marwani/ship



/obj/marker/mob_spawn/diamond_with_flaw
	name = "diamond spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/unique/diamond_with_flaw


/obj/marker/mob_spawn/arena_red
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/red
	color = "#FF0000"

/obj/marker/mob_spawn/arena_green
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/green
	color = "#00FF00"

/obj/marker/mob_spawn/arena_blue
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/blue
	color = "#0000FF"

/obj/marker/mob_spawn/arena_yellow
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/yellow
	color = "#FFFF00"


/obj/marker/mob_spawn/deus_vault
	name = "deus vault spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/deus_vault
	color = "#FF0000"


/obj/marker/mob_spawn/spider
	name = "spider spawnpoint"
	type_to_spawn = /mob/living/simple/npc/spider
	color = "#00FF00"


/obj/marker/mob_spawn/cult/cultist
	name = "cultist spawnpoint"
	type_to_spawn = /mob/living/simple/npc/cult/cultist
	color = "#00FF00"

/obj/marker/mob_spawn/cult/behemoth
	name = "behemoth spawnpoint"
	type_to_spawn = /mob/living/simple/npc/cult/behemoth
	color = "#FF0000"

/obj/marker/mob_spawn/cult/artificer
	name = "artificer spawnpoint"
	type_to_spawn = /mob/living/simple/npc/cult/artificer
	color = "#FFFF00"
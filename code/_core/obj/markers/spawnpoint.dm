var/global/list/observer_spawnpoints = list()
var/global/list/spawnpoints_new_character = list()
var/global/list/world_spawnpoints = list()
var/global/list/mob_spawnpoints = list()

/obj/marker/spawnpoint
	name = "SPAWNPOINT"

/obj/marker/spawnpoint/ghost
	name = "ghost spawnpoint"
	desc = "This is where ghosts spawn."

/obj/marker/spawnpoint/ghost/New()
	observer_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/new_character
	name = "new player spawnpoint"
	desc = "This is where new players spawn."

/obj/marker/spawnpoint/new_character/New()
	spawnpoints_new_character += get_turf(src)

/obj/marker/spawnpoint/world_point
	name = "world point"
	desc = "This is where you enter the world."

/obj/marker/spawnpoint/world_point/New()
	world_spawnpoints += get_turf(src)

/obj/marker/spawnpoint/mob/
	name = "Mob Spawnpoint"
	desc = "This is where a mob should be placed at round start."

	icon = 'icons/lighting.dmi'
	icon_state = "white"

	var/type_to_spawn
	var/mob/living/owning_mob

/obj/marker/spawnpoint/mob/New()
	mob_spawnpoints += src

/obj/marker/spawnpoint/mob/proc/trigger_spawn()
	if(owning_mob)
		return

	if(!type_to_spawn)
		return

	owning_mob = new type_to_spawn(src.loc)



/obj/marker/spawnpoint/mob/hostile_human
	name = "hostile new player spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/greytide


/obj/marker/spawnpoint/mob/tutorial_cultist
	name = "tutorial cultist spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/cultist/tutorial


/obj/marker/spawnpoint/mob/tutorial_security
	name = "tutorial security spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/security/tutorial


/obj/marker/spawnpoint/mob/marwani
	name = "tutorial marwani spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/unique/marwani

/obj/marker/spawnpoint/mob/diamond_with_flaw
	name = "diamond spawnpoint"

	type_to_spawn = /mob/living/advanced/human/npc/unique/diamond_with_flaw


/obj/marker/spawnpoint/mob/arena_red
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/red
	color = "#FF0000"

/obj/marker/spawnpoint/mob/arena_green
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/green
	color = "#00FF00"

/obj/marker/spawnpoint/mob/arena_blue
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/blue
	color = "#0000FF"

/obj/marker/spawnpoint/mob/arena_yellow
	name = "arena spawnpoint"
	type_to_spawn = /mob/living/advanced/human/npc/arena_guard/yellow
	color = "#FFFF00"
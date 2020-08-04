/gamemode/horde/rev
	name = "Horde Mode (Revolutionaries)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/rev = 100,
		/mob/living/simple/npc/bear/armored/revolutionary = 20,
		/mob/living/simple/npc/rev_leader = 1
	)
	hidden = FALSE

/gamemode/horde/xeno
	name = "Horde Mode (Xenos)"
	enemy_types_to_spawn = list(
		/mob/living/simple/npc/xeno/drone = 1,
		/mob/living/simple/npc/xeno/hunter = 3,
		/mob/living/simple/npc/xeno/sentinel = 2
	)
	hidden = FALSE

	enemies_to_spawn_base = 10
	enemies_to_spawn_per_player = 2
	enemies_to_spawn_per_minute = 0.15

/gamemode/horde/syndicate
	name = "Horde Mode (Syndicate)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/syndicate = 40,
		/mob/living/advanced/npc/sorcerer = 10,
		/mob/living/vehicle/mech/gygax/dark = 1
	)
	hidden = FALSE

/*
/gamemode/horde/beefmen
	name = "Horde Mode (Beefmen)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/beefman = 1
	)
*/

/gamemode/horde/ashwalkers
	name = "Horde Mode (Ashwalkers)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/ashwalker/assassin = 1,
		/mob/living/advanced/npc/ashwalker/hunter = 2,
		/mob/living/advanced/npc/ashwalker/warrior = 3
	)
	hidden = FALSE

/gamemode/horde/pirates
	name = "Horde Mode (Pirates)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/pirate_crew/magic = 2,
		/mob/living/advanced/npc/pirate_crew/melee = 3,
		/mob/living/advanced/npc/pirate_crew/ninja = 1,
		/mob/living/advanced/npc/pirate_crew/ranged = 4
	)
	hidden = FALSE
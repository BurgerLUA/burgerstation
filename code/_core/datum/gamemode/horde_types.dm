/gamemode/horde/rev
	name = "Horde Mode (Revolutionaries)"
	desc = "Fight off an endless wave of Russian Revolutionaries while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/rev = 100,
		/mob/living/simple/npc/bear/armored/revolutionary = 20,
		/mob/living/simple/npc/rev_leader = 1
	)
	hidden = FALSE

/gamemode/horde/xeno
	name = "Horde Mode (Xenos)"
	desc = "Fight off an endless wave of Acid-Spitting and Leaping Xenos while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/simple/npc/xeno/drone = 1,
		/mob/living/simple/npc/xeno/hunter = 3,
		/mob/living/simple/npc/xeno/sentinel = 2
	)
	hidden = FALSE

	enemies_to_spawn_base = 10
	enemies_to_spawn_per_player = 2
	enemies_to_spawn_per_minute = 0.15


/gamemode/horde/zombie
	name = "Horde Mode (Zombies)"
	desc = "Fight off an endless wave of non-infectious Zombies while attempting to complete objectives. Note that the rate of which zombies spawn is increased significantly every minute!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/zombie/greytide = 100,
		/mob/living/advanced/npc/zombie/captain = 1,
		/mob/living/advanced/npc/zombie/botanist = 10,
		/mob/living/advanced/npc/zombie/chaplain = 5,
		/mob/living/advanced/npc/zombie/security = 10
	)
	hidden = FALSE

	enemies_to_spawn_base = 20
	enemies_to_spawn_per_player = 3
	enemies_to_spawn_per_minute = 1


/gamemode/horde/syndicate
	name = "Horde Mode (Syndicate)"
	desc = "Fight off an endless wave of traitorous syndicate soliders while attempting to completele objectives. Some Syndicate soliders may have spells!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/syndicate = 40,
		/mob/living/advanced/npc/sorcerer = 10
	)
	hidden = FALSE


/gamemode/horde/beefmen
	name = "Horde Mode (Beefmen)"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/beefman = 1
	)
	hidden = TRUE

/gamemode/horde/death_squad
	name = "Horde Mode (Death Squad)"
	desc = "Fight off an endless wave of NanoTrasen deathsquad while attemtping to complete objectives in this lethal training excercise!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/deathsquad = 1
	)
	hidden = FALSE

/gamemode/horde/ashwalkers
	name = "Horde Mode (Ashwalkers)"
	desc = "Fight off an endless wave of Hostile Ashwalkers while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/ashwalker/assassin = 1,
		/mob/living/advanced/npc/ashwalker/hunter = 2,
		/mob/living/advanced/npc/ashwalker/warrior = 3
	)
	hidden = FALSE

/gamemode/horde/pirates
	name = "Horde Mode (Pirates)"
	desc = "Fight off an endless wave of Skeleton Pirates while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/pirate_crew/magic = 2,
		/mob/living/advanced/npc/pirate_crew/melee = 3,
		/mob/living/advanced/npc/pirate_crew/ninja = 1,
		/mob/living/advanced/npc/pirate_crew/ranged = 4
	)
	hidden = FALSE
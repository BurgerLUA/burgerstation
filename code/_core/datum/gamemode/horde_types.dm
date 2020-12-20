/gamemode/horde/rev
	name = "Horde Mode (Revolutionaries)"
	desc = "Fight off an endless wave of Russian Revolutionaries while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/rev = 5,
		/mob/living/simple/bear/armored/revolutionary = 1
	)
	hidden = FALSE

/gamemode/horde/xeno
	name = "Horde Mode (Xenos)"
	desc = "Fight off an endless wave of Acid-Spitting and Leaping Xenos while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/simple/xeno/drone = 1,
		/mob/living/simple/xeno/hunter = 3,
		/mob/living/simple/xeno/sentinel = 2
	)
	hidden = FALSE

	enemies_to_spawn_base = 10
	enemies_to_spawn_per_player = 2
	enemies_to_spawn_per_minute = 0.15

/gamemode/horde/xeno/get_enemy_types_to_spawn()
	if(!tracked_xeno_queen && prob(1))
		return list(/mob/living/simple/xeno/queen)
	return ..()


/gamemode/horde/zombie
	name = "Horde Mode (Zombies)"
	desc = "Fight off an endless wave of non-infectious Zombies while attempting to complete objectives. Note that the rate of which zombies spawn is increased significantly every minute!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/zombie/greytide = 50,
		/mob/living/advanced/npc/zombie/botanist = 10,
		/mob/living/advanced/npc/zombie/chaplain = 5,
		/mob/living/advanced/npc/zombie/security = 10,
		/mob/living/advanced/npc/zombie/scientist = 5,
		/mob/living/advanced/npc/zombie/librarian = 5,
		/mob/living/advanced/npc/zombie/clown = 2,
		/mob/living/advanced/npc/zombie/medical = 3,
		/mob/living/advanced/npc/zombie/chemist = 2,
		/mob/living/advanced/npc/zombie/bartender = 2,
		/mob/living/advanced/npc/zombie/chef = 2

	)
	hidden = FALSE


/gamemode/horde/syndicate
	name = "Horde Mode (Syndicate)"
	desc = "Fight off an endless wave of traitorous syndicate soliders while attempting to completele objectives. Some Syndicate soliders may have spells!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/syndicate = 10,
		/mob/living/advanced/npc/sorcerer = 4,
		/mob/living/simple/silicon/syndieborg = 1
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
	desc = "Fight off an endless wave of NanoTrasen deathsquad while attemtping to complete objectives in this extremely lethal training excercise!"
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/deathsquad/light = 8,
		/mob/living/advanced/npc/deathsquad/medium = 4,
		/mob/living/advanced/npc/deathsquad/heavy = 1
	)
	hidden = FALSE

	enemies_to_spawn_base = 3
	enemies_to_spawn_per_player = 0.25
	enemies_to_spawn_per_minute = 0.05

/gamemode/horde/ashwalkers
	name = "Horde Mode (Ashwalkers)"
	desc = "Fight off an endless wave of Hostile Ashwalkers while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/ashwalker/assassin = 1,
		/mob/living/advanced/npc/ashwalker/hunter = 2,
		/mob/living/advanced/npc/ashwalker/warrior = 3
	)
	hidden = TRUE

/gamemode/horde/pirates
	name = "Horde Mode (Pirates)"
	desc = "Fight off an endless wave of Skeleton Pirates while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/advanced/npc/pirate_crew/magic = 2,
		/mob/living/advanced/npc/pirate_crew/melee = 3,
		/mob/living/advanced/npc/pirate_crew/ninja = 1,
		/mob/living/advanced/npc/pirate_crew/ranged = 4
	)
	hidden = TRUE

/gamemode/horde/cultists
	name = "Horde Mode (Cultists)"
	desc = "Fight off an endless wave of Cultists while attempting to complete objectives."
	enemy_types_to_spawn = list(
		/mob/living/simple/cult/construct/artificer = 10,
		/mob/living/simple/cult/construct/behemoth = 10,
		/mob/living/simple/cult/construct/chosen = 1,
		/mob/living/simple/cult/construct/floating = 25,
		/mob/living/advanced/npc/cultist = 70,
		/mob/living/advanced/npc/cultist/hard = 30
	)
	hidden = FALSE


/gamemode/horde/boss_rush
	name = "Horde Mode (Boss Rush)"
	desc = "Oh god oh fuck."
	enemy_types_to_spawn = list(
		/mob/living/simple/can_man = 1,
		/mob/living/simple/ash_drake = 4,
		/mob/living/simple/bubblegum = 3,
		/mob/living/simple/colossus = 3,
		/mob/living/simple/herald = 1,
		/mob/living/simple/goliath/broodmother = 1
	)
	hidden = TRUE

	spawn_on_markers = FALSE

	enemies_to_spawn_base = 4
	enemies_to_spawn_per_player = 0
	enemies_to_spawn_per_minute = 0

/gamemode/horde/boss_rush/get_wave_size()
	return 1

/gamemode/horde/boss_rush/create_horde_mob(var/desired_loc)
	var/mob/living/L = ..()
	L.set_loyalty_tag("Boss")
	L.set_iff_tag("Boss")
	return L
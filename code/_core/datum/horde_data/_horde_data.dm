/horde_data/

	var/list/horde_weights = list()
	var/list/horde_squads = list()

	var/ignore_gamemode = FALSE

/horde_data/forest

	horde_weights = list(
		"syndicate" = 50,
		/mob/living/simple/slime/forest = 10,
		/mob/living/simple/slime/water = 5,
		"goblin" = 30,
		"wizard" = 20

	)

	horde_squads = list(
		"syndicate" = list(
			/mob/living/advanced/npc/syndicate = 100,
			/mob/living/simple/silicon/syndieborg = 10
		),
		"goblin" = list(
			/mob/living/advanced/npc/goblin/mage = 20,
			/mob/living/advanced/npc/goblin/warrior = 40,
			/mob/living/advanced/npc/goblin = 80
		),
		"wizard" = list(
			/mob/living/advanced/npc/hostile_wizard = 1
		)
	)

/horde_data/jungle

	horde_weights = list(
		/mob/living/simple/arachnid = 10,
		/mob/living/simple/gorilla = 20,
		/mob/living/simple/slime/jungle = 10,
		/mob/living/simple/spider/twilight = 10,
		/mob/living/simple/venus_human_trap = 40,
	)


/horde_data/cave

	horde_weights = list(
		/mob/living/simple/bear = 30,
		/mob/living/simple/bear/black = 10,
		"cult" = 10,
		/mob/living/simple/slime/blood = 5,
		/mob/living/simple/slime/cave = 10,
		/mob/living/simple/slime/oil = 5,
		/mob/living/simple/slime/water = 5,
		/mob/living/simple/spider = 10
	)

	horde_squads = list(
		"cult" = list(
			/mob/living/simple/cult/construct/artificer = 10,
			/mob/living/simple/cult/construct/behemoth = 5,
			/mob/living/simple/cult/construct/floating = 20,
			/mob/living/simple/cult/construct/harvester = 10,
			/mob/living/simple/cult/construct/proteon = 10,
			/mob/living/advanced/npc/cultist = 50,
			/mob/living/advanced/npc/cultist/hard = 10
		)

	)

/horde_data/snow

	horde_weights = list(
		"rev" = 50,
		/mob/living/simple/legionare/snow = 10,
		/mob/living/simple/slime/ice = 5,
		/mob/living/simple/slime/snow = 10,
		/mob/living/advanced/npc/zombie/normal = 20
	)

	horde_squads = list(
		"rev" = list(
			/mob/living/advanced/npc/rev = 100,
			/mob/living/simple/bear/armored/revolutionary = 10
		)

	)

/horde_data/lava

	horde_weights = list(
		"goliath" = 20,
		/mob/living/simple/hivelord = 10,
		/mob/living/simple/legionare = 20,
		/mob/living/simple/slime/basalt = 5,
		/mob/living/simple/slime/magma = 5,
		/mob/living/simple/watcher = 30,
		"ashwalker" = 50
	)

	horde_squads = list(
		"goliath" = list(
			/mob/living/simple/goliath = 100,
			/mob/living/simple/goliath/ancient = 20
		),
		"ashwalker" = list(
			/mob/living/advanced/npc/ashwalker/shaman = 5,
			/mob/living/advanced/npc/ashwalker/hunter = 20,
			/mob/living/advanced/npc/ashwalker/warrior = 20
		)
	)

	ignore_gamemode = TRUE

/horde_data/beach

	horde_weights = list(
		/mob/living/simple/megacarp = 10,
		/mob/living/simple/lobster = 20,
		/mob/living/simple/spacecarp/ = 40,
		"pirates" = 60
	)

	horde_squads = list(
		"pirates" = list(
			/mob/living/advanced/npc/pirate_crew/magic = 5,
			/mob/living/advanced/npc/pirate_crew/melee = 50,
			/mob/living/advanced/npc/pirate_crew/ninja = 10,
			/mob/living/advanced/npc/pirate_crew/ranged = 20
		)
	)

/horde_data/desert

	horde_weights = list(
		/mob/living/simple/slime/sand = 10,
		/mob/living/simple/spider/glow = 10
	)

/horde_data/xeno

	horde_weights = list(
		/mob/living/simple/xeno/drone = 20,
		/mob/living/simple/xeno/hunter = 30,
		/mob/living/simple/xeno/predatorian = 5,
		/mob/living/simple/xeno/sentinel = 10
	)

	ignore_gamemode = TRUE


/horde_data/soldiers

	horde_weights = list(
		/mob/living/advanced/npc/space_soldier = 100,
		/mob/living/advanced/npc/space_soldier/special_operative = 5
	)

/horde_data/tax

	horde_weights = list(
		/mob/living/advanced/npc/tax_collector = 100
	)

	ignore_gamemode = TRUE




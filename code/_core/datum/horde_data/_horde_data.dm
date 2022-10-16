/horde_data/

	var/list/horde_weights = list()
	var/list/horde_squads = list()

/horde_data/city

	horde_weights = list(
		/mob/living/advanced/npc/abductor = 5,
		"zombie" = 100
	)

	horde_squads = list(
		"zombie" = list(
			/mob/living/advanced/npc/zombie/civilian = 200,
			/mob/living/advanced/npc/zombie/bartender = 5,
			/mob/living/advanced/npc/zombie/chaplain = 5,
			/mob/living/advanced/npc/zombie/chef = 5,
			/mob/living/advanced/npc/zombie/chemist = 5,
			/mob/living/advanced/npc/zombie/clown = 5,
			/mob/living/advanced/npc/zombie/librarian = 5,
			/mob/living/advanced/npc/zombie/medical = 20,
			/mob/living/advanced/npc/zombie/scientist = 10,
			/mob/living/advanced/npc/zombie/security = 30
		)
	)

/horde_data/forest

	horde_weights = list(
		"syndicate" = 50,
		/mob/living/simple/slime/forest = 10,
		/mob/living/simple/slime/water = 5,
		"goblin" = 30

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
		)
	)


/horde_data/syndicate
	horde_weights = list(
		/mob/living/advanced/npc/syndicate = 100,
		/mob/living/simple/silicon/syndieborg = 10
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
		/mob/living/advanced/npc/zombie/winter = 20
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
			/mob/living/advanced/npc/ashwalker/assassin = 40,
			/mob/living/advanced/npc/ashwalker/hunter = 20,
			/mob/living/advanced/npc/ashwalker/warrior = 20
		)


	)

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
		/mob/living/simple/spider/glow = 10,
		/mob/living/advanced/npc/zombie/desert = 40,
	)

/horde_data/hive
	horde_weights = list(
		/mob/living/simple/xeno/drone = 20,
		/mob/living/simple/xeno/hunter = 30,
		/mob/living/simple/xeno/predatorian = 5,
		/mob/living/simple/xeno/sentinel = 10
	)
/loot/bushes/
	name = "bush loot"
	id = "village_bush"
	desc = "Loot you find in bushes"
	loot_table = list(
		/obj/item/currency/{value=1} = 10,
		/obj/item/currency/{value=2} = 5,
		/obj/item/currency/{value=3} = 2,
		/obj/item/clothing/mask/gas = 1
	)

/loot/wizard/
	name = "wizard loot"
	id = "wizard"
	desc = "Loot you find off of dead wizards."
	loot_table = list(
		/obj/item/weapon/ranged/magic/scroll/fireball{scroll_count=5} = 100,
		/obj/item/weapon/ranged/magic/staff/basic = 50,
		/obj/item/weapon/ranged/magic/tome/fireball = 25,
		/obj/item/soulgem/rare = 25,
		/obj/item/clothing/head/hat/wizard/blue = 10,
		/obj/item/weapon/ranged/magic/tome/lightning = 10,
		/obj/item/soapstone/blue = 5,
		/obj/item/color/crayon/blue = 5
	)

	loot_count = 3

/loot/spider/
	name = "spider loot"
	id = "spider"
	desc = "Loot you find off of dead spiders."
	loot_table = list()

	loot_count = 4

/loot/crab/
	name = "crab loot"
	id = "crab"
	desc = "Loot for crabs."
	loot_table = list(
		/obj/item/clothing/glasses/sun = 5,
		/obj/item/color/crayon/orange = 5,

	)
	chance_none = 75

/loot/crab_king
	name = "crab king loot"
	id = "crab_king"
	desc = "Loot for crabs."
	loot_table = list(
		/obj/item/soapstone/orange = 5,


	)


/loot/cult/
	name = "cult loot"
	id = "cult"
	desc = "Loot you find off of dead cultists."
	loot_table = list(
		/obj/item/clothing/head/hood/cult = 75,
		/obj/item/clothing/overwear/armor/cult = 100,

		/obj/item/clothing/overwear/armor/cult/hard = 20,
		/obj/item/clothing/head/helmet/cult = 10
	)

	loot_count = 1

	chance_none = 90
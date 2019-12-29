/loot/bushes/
	id = "village_bush"
	loot_table = list(
		/obj/item/currency/{value=1} = 10,
		/obj/item/currency/{value=2} = 5,
		/obj/item/currency/{value=3} = 2,
		/obj/item/clothing/mask/gas = 1
	)

/loot/wizard/
	id = "wizard"
	loot_table = list(
		/obj/item/weapon/ranged/magic/scroll/fireball{scroll_count=5} = 100,
		/obj/item/weapon/ranged/magic/staff/basic = 50,
		/obj/item/weapon/ranged/magic/tome/fireball = 25,
		/obj/item/soulgem/rare = 25,
		/obj/item/clothing/head/hat/wizard/blue = 10,
		/obj/item/weapon/ranged/magic/tome/lightning = 10,
		/obj/item/soapstone/blue = 5
	)

	loot_count = 3

/loot/spider/
	id = "spider"
	loot_table = list()

	loot_count = 4

/loot/crab/
	id = "crab"

	loot_table = list(
		/obj/item/clothing/glasses/sun = 5

	)
	chance_none = 75

/loot/crab_king
	id = "crab_king"
	loot_table = list(
		/obj/item/soapstone/orange = 5,


	)


/loot/cult/
	id = "cult"
	loot_table = list(
		/obj/item/clothing/head/hood/cult = 75,
		/obj/item/clothing/overwear/armor/cult = 100,

		/obj/item/clothing/overwear/armor/cult/hard = 20,
		/obj/item/clothing/head/helmet/cult = 10
	)

	loot_count = 1

	chance_none = 90


/loot/chicken/
	id = "chicken"
	loot_table = list(
		/obj/item/container/food/dynamic/chicken/raw = 100
	)
	loot_count = 3


/loot/cow/
	id = "cow"
	loot_table = list(
		/obj/item/container/food/dynamic/meat/raw = 100
	)
	loot_count = 5
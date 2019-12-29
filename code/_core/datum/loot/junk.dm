/loot/junk/
	id = "junk"

	loot_table = list(
		/obj/item/weapon/ranged/bullet/crossbow = 1,
		/obj/item/weapon/ranged/bullet/revolver/detective = 0.25,
		/obj/item/weapon/ranged/bullet/revolver/dbarrel = 0.25
	)


/loot/money/
	id = "money"
	loot_table = list(
		/obj/item/currency/{value=1} = 100,
		/obj/item/currency/{value=2} = 50,
		/obj/item/currency/{value=3} = 25,
		/obj/item/currency/{value=4} = 12,
		/obj/item/currency/{value=5} = 6,
		/obj/item/currency/{value=6} = 3,
		/obj/item/currency/{value=7} = 2,
		/obj/item/currency/{value=8} = 1,
	)

	loot_count = 1
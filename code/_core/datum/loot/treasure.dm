/loot/treasure
	loot_table = list(
		/loot/supply_crate/all = 1,
		/loot/soulgem/assorted = 1,
		/loot/experience_scrolls = 1,
		/obj/item/currency/magic_token/random = 1,
		/loot/enchanting_book = 1,
		/loot/tempering_items = 1
	)
	loot_table_guaranteed = list(
	 	/obj/item/portal_scroll
	 )
	loot_count = 1

/loot/treasure/boss
	loot_count = 5

/loot/tempering_items
	loot_table = list(
		/obj/item/tempering/luck = 30,
		/obj/item/tempering/quality/clothing = 30,
		/obj/item/tempering/quality/energy = 30,
		/obj/item/tempering/quality/magic = 50,
		/obj/item/tempering/quality/melee = 30,
		/obj/item/tempering/quality/ranged = 30,
	)
	loot_count = 6
	chance_none = 25

/loot/experience_scrolls
	loot_table = list(
		/loot/skill_scroll,
		/loot/attribute_scroll,
	)
	loot_count = 3

/loot/soulgem
	loot_table = list(
		/obj/item/soulgem/common = 4**4,
		/obj/item/soulgem/uncommon = 4**3,
		/obj/item/soulgem/rare = 4**2,
		/obj/item/soulgem/mystic = 4**1,
		/obj/item/soulgem/godly = 4**0
	)
	loot_count = 1

/loot/soulgem/filled
	loot_table = list(
		/obj/item/soulgem/common/filled = 4**4,
		/obj/item/soulgem/uncommon/filled = 4**3,
		/obj/item/soulgem/rare/filled = 4**2,
		/obj/item/soulgem/mystic/filled = 4**1
	)
	loot_count = 1

/loot/soulgem/assorted
	loot_table = list(
		/loot/soulgem  = 5,
		/loot/soulgem/filled = 1
	)
	loot_count = 6
	chance_none = 25

/loot/enchanting_book
	loot_table = list(
		/obj/item/paper/book/enchanting/fire = 1,
		/obj/item/paper/book/enchanting/stagger = 1,
		/obj/item/paper/book/enchanting/stun = 1,
		/obj/item/paper/book/enchanting/disarm = 1,
		/obj/item/paper/book/enchanting/blood_leech = 1,
		/obj/item/paper/book/enchanting/soul_trap = 1
	)
	loot_count = 1


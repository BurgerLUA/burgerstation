/loot/treasure
	loot_table = list(
		/loot/supply_crate/all = 5,
		/loot/soulgem/assorted = 5,
		/loot/experience_scrolls = 5,
		/loot/enchanting_book = 5,
		/loot/tempering_items = 5,
		/loot/rings/good = 1
	)
	loot_table_guaranteed = list(
	 	/obj/item/portal_scroll,
	 	/loot/spellswap
	 )
	loot_count = 1

/loot/treasure/boss
	loot_count = 5


/loot/spellswap
	loot_table = list(
		/obj/item/spellswap/magic_missile = 1,
		/obj/item/spellswap/chaos = 1,
		/obj/item/spellswap/fireball = 1,
		/obj/item/spellswap/flame = 1,
		/obj/item/spellswap/frost = 1,
		/obj/item/spellswap/arcblade = 1,
		/obj/item/spellswap/tesla = 1,
	)

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
		/obj/item/soulgem/common = 75,
		/obj/item/soulgem/uncommon = 15,
		/obj/item/soulgem/rare = 5,
		/obj/item/soulgem/mystic = 3,
		/obj/item/soulgem/godly = 2
	)
	loot_count = 1

/loot/soulgem/filled
	loot_table = list(
		/obj/item/soulgem/common/filled = 75,
		/obj/item/soulgem/uncommon/filled = 18,
		/obj/item/soulgem/rare/filled = 7,
		/obj/item/soulgem/mystic/filled = 5
	)
	loot_count = 1

/loot/soulgem/assorted
	loot_table = list(
		/loot/soulgem  = 80,
		/loot/soulgem/filled = 20
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
	)
	loot_count = 1


/loot/treasure
	loot_table = list(
		/loot/supply_crate/all = 1,
		/loot/soulgem/assorted = 1,
		/loot/experience_scrolls = 1,
		/loot/enchanting_book = 1,
		/loot/tempering_items = 1
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

	use_value = TRUE

/loot/tempering_items
	loot_table = list(
		/obj/item/tempering/luck = 1,
		/obj/item/tempering/quality/clothing = 1,
		/obj/item/tempering/quality/energy = 1,
		/obj/item/tempering/quality/magic = 1,
		/obj/item/tempering/quality/melee = 1,
		/obj/item/tempering/quality/ranged = 1,
	)
	loot_count = 6
	chance_none = 25

	use_value = TRUE

/loot/experience_scrolls
	loot_table = list(
		/loot/skill_scroll = 4,
		/loot/attribute_scroll = 1,
	)
	loot_count = 3

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


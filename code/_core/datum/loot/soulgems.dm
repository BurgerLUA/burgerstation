/loot/soulgem
	loot_table = list(
		/obj/item/soulgem/common = 1,
		/obj/item/soulgem/uncommon = 1,
		/obj/item/soulgem/rare = 1,
		/obj/item/soulgem/mystic = 1,
		/obj/item/soulgem/godly = 1
	)
	loot_count = 1
	use_value = TRUE

/loot/soulgem/filled
	loot_table = list(
		/obj/item/soulgem/common/filled = 1,
		/obj/item/soulgem/uncommon/filled = 1,
		/obj/item/soulgem/rare/filled = 1,
		/obj/item/soulgem/mystic/filled = 1
	)
	loot_count = 1

	use_value = TRUE

/loot/soulgem/assorted
	loot_table = list(
		/loot/soulgem  = 5,
		/loot/soulgem/filled = 1
	)
	loot_count = 6
	chance_none = 25
	use_value = FALSE
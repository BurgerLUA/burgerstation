/obj/item/clothing/neck/cape
	name = "cape"
	icon = 'icons/obj/items/clothing/suit/cape.dmi'
	polymorphic = TRUE

	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		MAGIC = ARMOR_C,
		COLD = ARMOR_C
	)

	rarity = RARITY_UNCOMMON


/obj/item/clothing/neck/cape/hunter
	name = "hunter's cape"
	color_primary = "#700100"
	color_secondary = "#700100"
	color_tertiary = "#490000"

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_D,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_E,
		COLD = ARMOR_C,
		DARK = ARMOR_C
	)

	rarity = RARITY_MYTHICAL

/obj/item/clothing/neck/cape/hide
	name = "hide cape"
	color_primary = "#703B18"
	color_secondary = "#703B18"
	color_tertiary = "#703B18"

	defense_rating = list(
		BLADE = ARMOR_D,
		BLUNT = ARMOR_E,
		PIERCE = ARMOR_D,
		MAGIC = ARMOR_D,
		COLD = ARMOR_C
	)

	rarity = RARITY_UNCOMMON
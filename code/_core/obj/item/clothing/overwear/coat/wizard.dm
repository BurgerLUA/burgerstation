/obj/item/clothing/overwear/coat/wizard
	name = "wizard's robes"
	icon = 'icons/obj/item/clothing/suit/wizard.dmi'

	desc = "EI NATH!!"
	desc_extended = "A cheap mass-produced enchanted set of robes. Not necessairly required to use magic, but wearing this, or any other clothing with magic protection will make your spells stronger."

	armor = /armor/dark/arcane

	size = SIZE_3

	value = 120

	dyeable = TRUE

	polymorphs = list(
		"base" = "#FFFFFF",
		"lightening" = "#FFFFFF",
	)

	no_initial_blend = TRUE

/obj/item/clothing/overwear/coat/wizard/red
	polymorphs = list(
		"base" = COLOR_RED,
		"lightening" = "#FFFFFF",
	)

/obj/item/clothing/overwear/coat/wizard/blue
	polymorphs = list(
		"base" = COLOR_BLUE,
		"lightening" = "#FFFFFF",
	)

/obj/item/clothing/overwear/coat/wizard/real
	name = "authentic wizard robes"
	desc = "The real deal."
	desc_extended = "A real, entirely authentic enchanted wizard robes with all the protection a serious wizard needs."

	armor = /armor/cloth/arcane/bonus

	rarity = RARITY_RARE

	mob_values_add = list(
		SKILL_MAGIC = 5,
		SKILL_SUMMONING = 5
	)

/obj/item/clothing/overwear/coat/wizard/real/purple
	polymorphs = list(
		"base" = "#B05FE2",
		"lightening" = "#FFFFFF",
	)

/obj/item/clothing/overwear/coat/wizard/real/blue
	polymorphs = list(
		"base" = "#0751C0",
		"lightening" = "#FFFFFF",
	)

/obj/item/clothing/overwear/coat/wizard/real/red
	polymorphs = list(
		"base" = "#F62A12",
		"lightening" = "#FFFFFF",
	)

/obj/item/clothing/overwear/coat/wizard/real/syndicate
	polymorphs = list(
		"base" = COLOR_BLACK,
		"lightening" = "#FFFFFF",
	)
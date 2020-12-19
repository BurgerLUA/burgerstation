/obj/item/clothing/head/helmet/security/old
	name = "old riot helmet"
	icon = 'icons/obj/item/clothing/hats/security.dmi'
	desc = "Protects against cream pies."
	desc_extended = "A relatively sturdy riot helmet. It is quite outdated."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		ARCANE = -AP_SWORD,
		PAIN = AP_CLUB
	)

	size = SIZE_3


	value = 20


/obj/item/clothing/head/helmet/security/tactical
	name = "tactical helmet"
	icon = 'icons/obj/item/clothing/hats/tacticool.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet. Protects your head from bullets."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		PAIN = AP_CLUB
	)

	size = SIZE_3

	value = 60

/obj/item/clothing/head/helmet/security/tactical/advanced
	name = "advanced tactical helmet"
	icon = 'icons/obj/item/clothing/hats/tacticool2.dmi'
	desc = "RUSH B"
	desc_extended = "A sturdy tactical helmet, usually worn by syndicate soliders. Protects your head from bullets."

	defense_rating = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_CLUB,
		LASER = AP_AXE,
		ARCANE = -AP_AXE,
		BOMB = AP_AXE,
		PAIN = AP_CLUB
	)

	size = SIZE_3


	value = 120
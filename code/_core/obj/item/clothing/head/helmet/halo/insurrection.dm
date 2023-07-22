/obj/item/clothing/head/helmet/halo/insurrection
	name = "LV28L Armored Helmet"
	icon = 'icons/obj/item/clothing/hats/ins.dmi'
	desc = "Don't mess with guys in that helmet!"
	desc_extended = "The LV28L an armored helmet composed of materials salvaged from a wide array of UNSC equipment for a lightweight design crafted by X-52 for the new armor series being rolled out from Eridanus Secundus"
	loyalty_tag = "Syndicate"

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_CLUB,
		PIERCE = AP_CLUB,
		LASER = -AP_AXE,
		ARCANE = -AP_AXE,
		HEAT = AP_SWORD,
		COLD = AP_SWORD,
		BOMB = AP_SWORD,
		BIO = AP_SWORD,
		RAD = AP_SWORD,
		PAIN = AP_CLUB
	)

//	additional_clothing = list(/obj/item/clothing/glasses/nightvision)

	size = SIZE_3

	value = 100

/obj/item/clothing/head/helmet/halo/insurrection/commander
	name = "URF commander turban"
	icon = 'icons/obj/item/clothing/hats/ins_c.dmi'
	desc = "Don't mess with guys in that helmet!"
	desc_extended = "Literally turban with armor"

/obj/item/clothing/pants/brown
	name = "brown pants"
	desc = "An office worker's favorite."
	desc_extended = "The pants of choice for boring people everywhere."
	icon = 'icons/obj/item/clothing/pants/brown_pants.dmi'

	desc = "Please wear these at least."
	desc_extended = "The peak of fashion."

	defense_rating = list(
		BLADE = AP_SWORD,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		COLD = AP_DAGGER
	)

	size = SIZE_2

	value = 20


/obj/item/clothing/pants/kilt
	name = "kilt"
	icon = 'icons/obj/item/clothing/pants/kilt.dmi'

	desc = "THERE CAN ONLY BE ONE."
	desc_extended = "A very tough and fashionable kilt. Needs to be held up by a kilt belt."

	defense_rating = list(
		BLADE = AP_DAGGER,
		BLUNT = AP_DAGGER,
		PIERCE = AP_DAGGER,
		ARCANE = AP_SWORD,
		HEAT = AP_DAGGER,
		COLD = AP_DAGGER
	)

	size = SIZE_2


	value = 60

	dyeable = TRUE

/obj/item/clothing/pants/kilt/green
	color = "#003714"


/obj/item/clothing/pants/cloth
	name = "cloth"
	icon = 'icons/obj/item/clothing/pants/cloth.dmi'

	desc = "Modest?"
	desc_extended = "A basic piece of cloth worn around the torso."

	defense_rating = list(
		ARCANE = AP_AXE
	)

	size = SIZE_2

	value = 15

	dyeable = TRUE

/obj/item/clothing/pants/cloth/black
	color = COLOR_BLACK
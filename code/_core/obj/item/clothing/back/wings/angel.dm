obj/item/clothing/back/wings/angel
	name = "angel wings"
	desc = "Proof of divinity."
	desc_extended = "A pair of absolutely divine angel wings. Good for the holy."
	icon = 'icons/obj/item/clothing/back/wings/angel.dmi'
	rarity = RARITY_LEGENDARY

	defense_rating = list(
		HOLY = 100,
		DARK = -100
	)

	dyeable = TRUE

	value = 3000

	speed_bonus = 0.25 //25% faster.

obj/item/clothing/back/wings/angel/demon
	name = "demon wings"
	desc = "Heaven's not my kind of place anyway."
	desc_extended = "A pair of absolutely infernal demonic wings. Good for the profane."
	icon = 'icons/obj/item/clothing/back/wings/demon.dmi'
	rarity = RARITY_LEGENDARY

	defense_rating = list(
		HOLY = -100,
		DARK = 100
	)

	value = 3000

	speed_bonus = 0.25 //25% faster.

	color = COLOR_BLACK

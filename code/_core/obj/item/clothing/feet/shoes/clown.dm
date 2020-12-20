/obj/item/clothing/feet/shoes/clown
	name = "right clown shoe"
	desc = "A part of the prankster's attire. Damn, they're huge!"
	desc_extended = "Squeaky footsteps included for all your clowning needs. Honk!"
	rarity = RARITY_MYTHICAL
	icon_state = "inventory_right"
	icon_state_worn = "worn_right"

	icon = 'icons/obj/item/clothing/shoes/clown.dmi'

	item_slot = SLOT_FOOT_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	defense_rating = list(
		BLUNT = AP_SWORD,
		ARCANE = AP_SWORD,
		HOLY = -AP_CLUB,
		DARK = AP_CLUB
	)

	size = SIZE_2


	value = 100

	speed_bonus = -0.05



/obj/item/clothing/feet/shoes/clown/get_footsteps(var/list/original_footsteps,var/enter=FALSE)
	original_footsteps += /footstep/clownstep
	return original_footsteps

/obj/item/clothing/feet/shoes/clown/left
	name = "left clown shoe"
	icon_state = "inventory_left"
	icon_state_worn = "worn_left"

	item_slot = SLOT_FOOT_LEFT
	protected_limbs = list(BODY_FOOT_LEFT)
	blocks_clothing = SLOT_FOOT_LEFT | SLOT_FOOT_LEFT_U
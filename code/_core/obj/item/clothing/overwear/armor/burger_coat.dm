/obj/item/clothing/overwear/armor/burger_coat
	name = "burger coat"
	icon = 'icons/obj/item/clothing/suit/burger_coat_armor.dmi'
	desc = "Being the best isn't hard, it's letting go."
	desc_extended = "Burgers never change."

	rarity = RARITY_MYTHICAL

	defense_rating = list(
		BLADE = 45,
		BLUNT = 45,
		PIERCE = 45,
		LASER = 45,
		ARCANE = -15,
		HEAT = -10,
		COLD = -10,
	)

	weight = 20 //Now the suit actually speeds you up.

	size = SIZE_4

	value = 5000

	speed_bonus = 0.1


/obj/item/clothing/overwear/armor/burger_coat/courier
	name = "Courier Jacket"
	icon = 'icons/obj/item/clothing/suit/courier.dmi'
	desc = "Being the best isn't hard, it's letting go."
	desc_extended = "War never changes."


/obj/item/clothing/overwear/armor/burger_coat/courier/ncr
	name = "NCR Courier Jacket"
	icon_state = "inventory_ncr"
	icon_state_worn = "worn_ncr"
	desc = "Patrolling the Mojave almost makes you wish for a nuclear winter."
	desc_extended = "When I got this assignment I was hoping there would be more gambling."


/obj/item/clothing/overwear/armor/burger_coat/courier/legion
	name = "Legion Courier Jacket"
	icon_state = "inventory_legion"
	icon_state_worn = "worn_legion"
	desc = "Ave, true to Caesar!"
	desc_extended = "Degenerates like you belong on a cross."


/obj/item/clothing/overwear/armor/burger_coat/courier/ulysses
	name = "Ulysses Jacket"
	icon_state = "inventory_ulysses"
	icon_state_worn = "worn_ulysses"
	desc = "No need for bombs, when hate will do."
	desc_extended = "You came all this way for answers. Only currency I have."
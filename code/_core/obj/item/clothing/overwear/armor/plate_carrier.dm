/obj/item/clothing/overwear/armor/plate_carrier
	name = "plate carrier"
	desc = "Standard armor for the soldiering kind."
	desc_extended = "A plate carrier system. Requires an armor plate to useable."
	icon = 'icons/obj/item/clothing/suit/plate_carrier.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		MAGIC = -10
	)

	value = 50

	var/obj/item/installed_plate_carrier


/obj/item/clothing/overwear/armor/plate_carrier/pocket
	name = "tactical plate carrier"
	desc = "Can carry forks, spoons, and knives too."
	desc_extended = "A plate carrier system. Requires an armor plate to useable."
	icon = 'icons/obj/item/clothing/suit/plate_carrier_pouched.dmi'

	protected_limbs = list(BODY_TORSO,BODY_GROIN)

	dyeable = TRUE

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		MAGIC = -10
	)

	value = 70
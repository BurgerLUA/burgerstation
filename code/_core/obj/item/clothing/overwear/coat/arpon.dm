/obj/item/clothing/overwear/coat/apron
	name = "apron"
	icon = 'icons/obj/item/clothing/suit/apron.dmi'
	desc = "Protect yourself. From stains."
	desc_extended = "A regular apron that chefs usually use."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	defense_rating = list(
		MAGIC = 25,
		HEAT = 50
	)

	size = SIZE_2


	value = 15

/obj/item/clothing/overwear/coat/apron/chef
	name = "chef's apron"
	icon = 'icons/obj/item/clothing/suit/apron_chef.dmi'
	desc = "A sign of a master."
	desc_extended = "A special apron worn by only the fanciest of chefs."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	defense_rating = list(
		BLADE = 50,
		MAGIC = 75,
		HEAT = 50
	)

	size = SIZE_2


	value = 400


/obj/item/clothing/overwear/coat/apron/blacksmith
	name = "blacksmith's apron"
	icon = 'icons/obj/item/clothing/suit/apron_leather.dmi'
	desc = "An apron used to protect yourself from fire and steel shrapnel when blacksmithing.  Blacksmithing with no clothes on besides the apron is very sexy, but it's also very dangerous."
	desc_extended = "Contains large pockets, capable of holding two Size 3 items."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	is_container = TRUE
	dynamic_inventory_count = 2

	container_max_size = SIZE_3

	defense_rating = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 25,
		HEAT = 75
	)

	size = SIZE_3


	value = 30

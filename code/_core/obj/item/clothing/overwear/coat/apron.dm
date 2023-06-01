/obj/item/clothing/overwear/coat/apron
	name = "apron"
	icon = 'icons/obj/item/clothing/suit/apron.dmi'
	desc = "Protect yourself. From stains."
	desc_extended = "A regular apron that chefs usually use."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	armor = /armor/cloth/protective

	size = SIZE_2

	value = 20

	dyeable = TRUE

/obj/item/clothing/overwear/coat/apron/blue
	color = COLOR_BLUE

/obj/item/clothing/overwear/coat/apron/chef
	name = "chef's apron"
	icon = 'icons/obj/item/clothing/suit/apron_chef.dmi'
	desc = "A sign of a master."
	desc_extended = "A special apron worn by only the fanciest of chefs."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	armor = /armor/cloth/protective/chef

	size = SIZE_3

	value = 400

	dyeable = FALSE


/obj/item/clothing/overwear/coat/apron/blacksmith
	name = "leather apron"
	icon = 'icons/obj/item/clothing/suit/apron_leather.dmi'
	desc = "An apron used to protect yourself from fire and steel shrapnel when blacksmithing.  Blacksmithing with no clothes on besides the apron is very sexy, but it's also very dangerous."
	desc_extended = "Contains large pockets, capable of holding two Size 3 items."

	protected_limbs = list(BODY_TORSO, BODY_GROIN)

	is_container = TRUE
	dynamic_inventory_count = 2

	container_max_size = SIZE_2

	armor = /armor/leather/protective

	size = SIZE_3

	dyeable = FALSE

	value = 120

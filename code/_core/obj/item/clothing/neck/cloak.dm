/obj/item/clothing/neck/cloak
	name = "cloak"
	icon = 'icons/obj/item/clothing/suit/cloak.dmi'
	desc = "A simple cloak. Wear your colors proudly."
	desc_extended = "Attaches to the neck slot for extra fashion, and in this case, for team identification if dyed correctly."
	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	item_slot = SLOT_NECK


	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = 40,
		COLD = 20,
	)

	value = 20

	dyeable = TRUE

	item_slot_layer = 3


/obj/item/clothing/neck/cloak/green
	color = "#002200"

/obj/item/clothing/neck/cloak/brown
	color = "#603A20"

/obj/item/clothing/neck/cloak/red
	color = "#8E0000"

/obj/item/clothing/neck/cloak/blue
	color = COLOR_BLUE

/obj/item/clothing/neck/cloak/nanotrasen
	color = COLOR_NANOTRASEN


/obj/item/clothing/neck/cloak/black
	color = COLOR_BLACK

/obj/item/clothing/neck/cloak/mercenary
	color = COLOR_OLIVE_DRAB
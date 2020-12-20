/obj/item/clothing/neck/cloak
	name = "cloak"
	icon = 'icons/obj/item/clothing/suit/cloak.dmi'
	desc = "A simple cloak. Wear your colors proudly."
	desc_extended = "Attaches to the neck slot for extra fashion, and in this case, for team identification if dyed correctly."
	worn_layer = LAYER_MOB_CLOTHING_NECK_OVER

	protected_limbs = list(BODY_TORSO)

	defense_rating = list(
		ARCANE = AP_AXE,
		COLD = AP_SWORD,
	)

	value = 20

	dyeable = TRUE


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
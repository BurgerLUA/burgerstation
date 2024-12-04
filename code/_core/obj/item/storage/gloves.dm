/obj/item/storage/glovebox/
	name = "glovebox"
	desc = "Contains a matching pair of gloves."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "glovebox"

	size = SIZE_2

	is_container = TRUE
	container_max_size = SIZE_1

	dynamic_inventory_count = 2

	value = 0

/obj/item/storage/glovebox/white
	name = "white glovebox"
	value = 1

/obj/item/storage/glovebox/white/fill_inventory()
	new /obj/item/clothing/hands/gloves/colored(src)
	new /obj/item/clothing/hands/gloves/colored/left(src)
	. = ..()

/obj/item/storage/glovebox/yellow/
	name = "insulated glovebox"
	desc = "Contains 2 insulated yellow gloves."
	value = 1

/obj/item/storage/glovebox/yellow/fill_inventory()
	new /obj/item/clothing/hands/gloves/colored/insulated(src)
	new /obj/item/clothing/hands/gloves/colored/insulated/left(src)
	. = ..()

/obj/item/storage/glovebox/padded/
	name = "padded glovebox"
	desc = "Contains 2 padded black gloves. Perfect for winter conditions."
	value = 1

/obj/item/storage/glovebox/padded/fill_inventory()
	new /obj/item/clothing/hands/gloves/colored/padded/black(src)
	new /obj/item/clothing/hands/gloves/colored/padded/black/left(src)
	. = ..()


/obj/item/storage/glovebox/brown_padded/
	name = "brown padded glovebox"
	desc = "Contains 2 padded brown gloves. Perfect for work conditions."
	value = 1

/obj/item/storage/glovebox/brown_padded/fill_inventory()
	new /obj/item/clothing/hands/gloves/colored/padded/brown(src)
	new /obj/item/clothing/hands/gloves/colored/padded/brown/left(src)
	. = ..()
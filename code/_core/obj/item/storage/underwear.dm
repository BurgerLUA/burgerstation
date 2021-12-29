/obj/item/storage/underwear
	name = "underwear box"
	desc = "What's inside the box?"
	desc_extended = "A regular grey cardboard box."

	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "box"

	size = SIZE_3

	is_container = TRUE
	container_max_size = SIZE_2

	dynamic_inventory_count = 4

	value = 10

/obj/item/storage/underwear/fill_inventory()
	new /obj/item/clothing/underbottom/underwear/boxers/random(src)
	new /obj/item/clothing/undertop/underwear/shirt/random(src)
	new /obj/item/clothing/feet/socks/knee/white(src)
	new /obj/item/clothing/feet/socks/knee/white(src)
	. = ..()
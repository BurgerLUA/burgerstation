/obj/item/clothing/belt/bandoliers/musket_bag
	name = "musket bag"
	desc = "It's called a POWDER HORN, okay?"
	desc_extended = "A nerdy bag and nerdy horn for nerds that need to hold more ammo for flintlocks (You know who you are). ALT+Click to grab additional charges while already holding a charge. Holds up to 80 charges"

	icon = 'icons/obj/item/clothing/belts/musket_bag.dmi'
	worn_layer = LAYER_MOB_CLOTHING_COAT_OVER
	dyeable = FALSE


	value = 0
	size = SIZE_3

	stored_bullets = list()

	bullet_count = 0
	max_bullets = 80
	bullet_type = /obj/item/bullet_cartridge/flintlock
	bullet_type_premium = /obj/item/bullet_cartridge/flintlock/premium

	next_regen = 0 //Ammo restocking functionality woo!
	can_be_restocked = TRUE

	num_overlays = 0

/obj/item/clothing/belt/bandoliers/musket_bag/get_base_value()
	return max_bullets*3

/obj/item/clothing/belt/bandoliers/musket_bag/basic/Generate()
	. = ..()
	stored_bullets[/obj/item/bullet_cartridge/flintlock] = rand(20,30)
	bullet_count = stored_bullets[/obj/item/bullet_cartridge/flintlock]

/obj/item/clothing/belt/bandoliers/musket_bag/premium/Generate()
	. = ..()
	stored_bullets[/obj/item/bullet_cartridge/flintlock/premium] = rand(20,30)
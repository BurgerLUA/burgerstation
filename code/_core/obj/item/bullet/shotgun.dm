/obj/item/bullet/shotgun/
	id = "shotgun"
	icon = 'icons/obj/items/bullet/shotgun.dmi'
	bullet_capacity = 6
	bullet_capacity_icon = 6

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

/obj/item/bullet/shotgun/can_be_worn()
	return TRUE

/obj/item/bullet/shotgun/on_spawn()
	bullet_count = 3

/obj/item/bullet/shotgun/slug
	name = "\improper 12 gauge slug"
	desc = ""
	icon_state = "slug"

/obj/item/bullet/shotgun/buckshot
	name = "\improper 12 gauge buckshot shell"
	desc = ""
	icon_state = "buckshot"
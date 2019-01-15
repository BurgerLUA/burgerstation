/obj/item/magazine/
	name = "weapon magazine"
	id = "bullet"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	var/bullet_capacity = 30 //How many bullets can this store
	var/list/obj/item/bullet/stored_bullets

/obj/item/magazine/examine(var/atom/examiner)
	..()
	examiner.to_chat("it contains [length(stored_bullets)] bullets.")

/obj/item/magazine/New()
	. = ..()
	stored_bullets = list()
	add_ammo()
	update_icon()

/obj/item/magazine/proc/add_ammo()
	return

/obj/item/magazine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/G = object

	if(!G.stored_magazine)
		src.drop_item(G)
		src.loc = G
		G.stored_magazine = src
		G.open = FALSE

	G.update_icon()

	return TRUE
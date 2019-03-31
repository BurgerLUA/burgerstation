/obj/item/magazine/
	name = "weapon magazine"
	var/bullet_type = "none"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	var/bullet_capacity = 30 //How many bullets can this store
	var/list/obj/item/bullet/stored_bullets

/obj/item/magazine/New()
	..()
	update_icon()

/obj/item/magazine/get_examine_text(var/mob/examiner)
	return ..() + span("notice","it contains [length(stored_bullets)] bullets.")

/obj/item/magazine/New()
	stored_bullets = list()
	..()

/obj/item/magazine/proc/get_ammo_count()
	return length(stored_bullets)

/obj/item/magazine/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(is_inventory(object))
		var/obj/inventory/I = object
		var/obj/item/bullet/B = stored_bullets[length(stored_bullets)-1]
		if(I.add_held_object(B))
			B.update_icon()
			stored_bullets -= B

	return ..()

/obj/item/magazine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(src,/obj/item/magazine/clip))
		return FALSE

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/G = object
	if(bullet_type != G.bullet_type)
		caller.to_chat(span("notice","You can't insert this type of magazine into \the [G]."))
		return TRUE

	if(!G.stored_magazine)
		src.drop_item(G)
		src.force_move(G)
		G.stored_magazine = src
		G.open = FALSE

	G.update_icon()

	return TRUE
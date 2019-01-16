/obj/item/magazine/clip/
	name = "weapon clip"
	bullet_type = "none"
	desc = "IT'S NOT A MAGAZINE. IT'S A CLIP."

/obj/item/magazine/clip/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/G = object
	if(bullet_type != G.bullet_type)
		caller.to_chat(span("notice","You can't insert this type of magazine into \the [G]."))
		return TRUE

	var/insert_count = 0

	for(var/obj/item/bullet/B in stored_bullets)
		if(!B.insert_into_gun(caller,G,location,control,params,FALSE))
			break
		insert_count += 1
		stored_bullets -= B

	if(insert_count)
		caller.to_chat(span("notice","You insert [insert_count] bullet\s into \the [object]."))
		G.update_icon()
		update_icon()
		return TRUE

	return ..()
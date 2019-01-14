/obj/item/magazine/
	name = "weapon magazine"
	id = "bullet"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	var/bullet_capacity = 30 //How many bullets can this store
	var/list/obj/item/bullet/stored_bullets

/obj/item/magazine/New()
	. = ..()
	stored_bullets = list()
	add_ammo()
	update_icon()

/obj/item/magazine/proc/add_ammo()
	return

/obj/item/magazine/clip/
	name = "weapon clip"
	id = "bullet"
	desc = "IT'S NOT A MAGAZINE. IT'S A CLIP."

/obj/item/magazine/clip/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/G = object

	var/insert_count = 0

	for(var/obj/item/bullet/B in stored_bullets)
		if(!B.insert_into_gun(caller,G,location,control,params,FALSE))
			break
		insert_count += 1
		stored_bullets -= B

	if(insert_count)
		caller.to_chat(span("notice","You insert [insert_count] bullet\s into \the [object]."))
	//else
		//caller.to_chat(span("notice","You cannot find a way to insert the bullets into \the [object]!"))

	update_icon()

	return TRUE
/obj/item/magazine/clip/
	name = "weapon clip"
	desc = "IT'S NOT A MAGAZINE. IT'S A CLIP."

/obj/item/magazine/clip/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()


	var/obj/item/weapon/ranged/bullet/G = object

	var/insert_count = 0

	for(var/obj/item/bullet_cartridge/B in stored_bullets)

		var/target_point = get_first_missing_value(G.stored_bullets)
		if(target_point == 0)
			break

		B.force_move(G)
		G.stored_bullets[target_point] = B
		insert_count += 1
		stored_bullets -= B

	if(insert_count)
		caller.to_chat(span("notice","You load [insert_count] bullet\s into \the [object]."))
		G.update_sprite()
		update_sprite()
		return TRUE
	else
		caller.to_chat(span("notice","You can't load anything into \the [object] with \the [src]!"))

	return ..()


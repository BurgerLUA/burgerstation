/obj/item/magazine/clip/
	name = "weapon clip"
	desc = "Leaving theese around the field won't get you in trouble with the Sergeant Major."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."

/obj/item/magazine/clip/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_ranged_bullet_weapon(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/weapon/ranged/bullet/G = object
		if(!G.open)
			caller.to_chat(span("warning","You need to open \the [G.name] before inserting \the [src.name] into it!"))
			return FALSE
		var/insert_count = 0
		for(var/k in src.stored_bullets)
			var/bullet_count = src.stored_bullets[k]
			for(var/i=1,i<=bullet_count,i++)
				var/obj/item/bullet_cartridge/B = k
				if(!G.can_load_stored(caller,B))
					return TRUE
				var/target_point = get_first_missing_value(G.stored_bullets)
				if(target_point == 0)
					return TRUE
				src.stored_bullets[B] -= 1
				if(src.stored_bullets[B] <= 0)
					src.stored_bullets -= B
				B = new B
				INITIALIZE(B)
				B.amount = 1
				FINALIZE(B)
				G.stored_bullets[target_point] = B
				insert_count += 1
		if(insert_count)
			caller.to_chat(span("notice","You load [insert_count] bullet\s into \the [object.name]."))
			G.update_sprite()
			update_sprite()
			return TRUE
		else
			caller.to_chat(span("warning","You can't load anything into \the [object.name] with \the [src.name]!"))
		return TRUE

	. = ..()


/obj/item/magazine/
	name = "weapon magazine"
	var/bullet_type = "none"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	var/bullet_count_max = 30 //How many bullets can this store
	var/list/obj/item/bullet/stored_bullets

	var/list/weapon_whitelist = list() //What guns can fit this object?

	var/ammo

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new ammo(src)
	update_icon()
	return ..()

/obj/item/magazine/Destroy()

	for(var/obj/item/bullet/B in stored_bullets)
		qdel(B)

	stored_bullets.Cut()

	return ..()

/obj/item/magazine/New()
	..()
	update_icon()

/obj/item/magazine/get_examine_text(var/mob/examiner)
	return ..() + div("notice","It contains [length(stored_bullets)] bullets.")

/obj/item/magazine/New()
	stored_bullets = list()
	..()

/obj/item/magazine/proc/get_ammo_count()
	return length(stored_bullets)

/obj/item/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(is_inventory(object) && length(stored_bullets))
		var/obj/hud/inventory/I = object
		var/obj/item/bullet/B = stored_bullets[length(stored_bullets)]
		if(I.add_held_object(B))
			B.update_icon()
			stored_bullets -= B
		update_icon()
		return TRUE

	return ..()

/obj/item/magazine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(src,/obj/item/magazine/clip))
		return FALSE

	object = object.defer_click_on_object()

	if(!is_bullet_gun(object))
		return ..()

	var/obj/item/weapon/ranged/bullet/magazine/G = object
	if(!(G.type in weapon_whitelist))
		caller.to_chat(span("notice","You can't insert this type of magazine into \the [G]."))
		return TRUE

	if(G.stored_magazine)
		G.eject_magazine(caller)

	src.drop_item(G)
	src.force_move(G)
	G.stored_magazine = src
	G.open = FALSE
	var/area/A = get_area(caller)
	play_sound(pick(G.mag_insert_sounds),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	G.update_icon()

	return TRUE

/obj/item/magazine/get_examine_text(var/mob/examiner)

	if(!is_advanced(examiner))
		return ..()

	var/mob/living/advanced/A = examiner

	var/returning_text = ..()
	var/len = length(stored_bullets)

	if(len && stored_bullets[len])
		var/obj/item/bullet/B = stored_bullets[len]
		returning_text += B.get_damage_type_text(A)

	return returning_text
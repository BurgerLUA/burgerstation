/obj/item/weapon/ranged/bullet

	var/obj/item/bullet/chambered_bullet //One in the chamber
	var/list/obj/item/bullet/stored_bullets //This is a fixed list, so be careful.

	var/bullet_type = "none"
	var/bullet_count_max = 0 //How many bullets can this store on top of the chambered bullet

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?

	requires_bullets = TRUE

/obj/item/weapon/ranged/bullet/get_damage_type()
	return chambered_bullet ? chambered_bullet.damage_type : damage_type


/obj/item/weapon/ranged/bullet/proc/eject_chambered_bullet(var/new_loc)

	if(!chambered_bullet)
		return FALSE

	var/obj/item/bullet/B = chambered_bullet
	B.force_move(new_loc)
	B.update_icon()

	chambered_bullet = null

	return B

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets(var/new_loc)

	for(var/obj/item/bullet/B in stored_bullets)
		eject_stored_bullet(B,new_loc)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets_spent(var/new_loc)

	for(var/obj/item/bullet/B in stored_bullets)
		if(!B.is_spent)
			continue
		eject_stored_bullet(B,new_loc)

	return TRUE

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullet(var/obj/item/bullet/bullet_to_remove,var/new_loc)

	if(!(bullet_to_remove in stored_bullets))
		return FALSE

	stored_bullets -= bullet_to_remove
	bullet_to_remove.force_move(new_loc)
	bullet_to_remove.update_icon()
	stored_bullets += null

	return bullet_to_remove

/obj/item/weapon/ranged/bullet/proc/spend_chambered_bullet()

	if(!chambered_bullet || chambered_bullet.is_spent)
		return FALSE

	return chambered_bullet.spend_bullet()

/obj/item/weapon/ranged/bullet/proc/spend_stored_bullet(var/bullet_position = 1)

	if(length(stored_bullets) && stored_bullets[bullet_position]) //Spend a bullet
		var/obj/item/bullet/B = stored_bullets[bullet_position]
		B = B.spend_bullet()
		return B

	return FALSE

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	return spend_chambered_bullet()

/obj/item/weapon/ranged/bullet/New()
	. = ..()

	if(bullet_count_max)
		stored_bullets = new/list(bullet_count_max)

	update_icon()
	return .

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return chambered_bullet ? 1 : 0
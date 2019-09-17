/obj/item/weapon/ranged/bullet

	var/list/obj/item/bullet/stored_bullets //Also good for one in the chamber stuff.
	var/list/obj/item/bullet/stored_bullet_casings

	var/bullet_type = "none"
	var/bullet_count_max = 1 //How many bullets can this store? Note that this isn't neccisarily the magazine size.

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?


/obj/item/weapon/ranged/bullet/get_damage_type()
	return length(stored_bullets) && stored_bullets[1] ? stored_bullets[1].damage_type : damage_type

/obj/item/weapon/ranged/bullet/proc/eject_spent_casings(var/mob/caller, var/new_loc)
	for(var/obj/item/bullet/B in stored_bullet_casings)
		stored_bullet_casings -= B
		B.force_move(new_loc)
		B.update_icon()

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets(var/mob/caller, var/new_loc)
	for(var/obj/item/bullet/B in stored_bullets)
		stored_bullets -= B
		B.force_move(new_loc)
		B.update_icon()

/obj/item/weapon/ranged/bullet/proc/eject_top_stored_bullet(var/mob/caller, var/new_loc)
	if(length(stored_bullets) && stored_bullets[length(stored_bullets)])
		var/obj/item/bullet/B = stored_bullets[length(stored_bullets)]
		stored_bullets -= B
		B.force_move(new_loc)
		B.update_icon()
		return B

	return FALSE


/obj/item/weapon/ranged/bullet/proc/spend_bullet()
	if(length(stored_bullets)) //Spend a bullet
		var/obj/item/bullet/B = stored_bullets[1]
		stored_bullets -= B
		if(B)
			B.spend_bullet()
			stored_bullet_casings += B
		return B

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	var/obj/item/bullet/B = spend_bullet()
	return B

/obj/item/weapon/ranged/bullet/New()

	. = ..()

	stored_bullets = list()
	stored_bullet_casings = list()

	update_icon()

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return length(stored_bullets)
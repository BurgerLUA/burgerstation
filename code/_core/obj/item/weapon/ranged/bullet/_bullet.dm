/obj/item/weapon/ranged/bullet

	var/obj/item/magazine/stored_magazine //You can use one or the other.
	var/list/obj/item/bullet/stored_bullets //Also good for one in the chamber stuff.
	var/list/obj/item/bullet/stored_bullet_casings

	var/bullet_type = "none"
	var/bullet_capacity = 1 //How many bullets can this store? Note that this isn't neccisarily the magazine size.

	var/icon_state_open = "inventory"

	var/insert_limit = 1 //How many bullets are you allowed to insert at once?


/obj/item/weapon/ranged/bullet/clicked_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(stored_magazine && object && is_inventory(object) && src && src.loc && is_inventory(src.loc) && !(caller.movement_flags & MOVEMENT_CROUCHING))
		caller.to_chat(span("notice","You eject the magazine from \the [src]."))
		var/obj/inventory/offhand_slot = object
		stored_magazine.force_move(caller.loc)
		offhand_slot.add_object(stored_magazine)
		stored_magazine.update_icon()
		stored_magazine = null
		open = TRUE
		update_icon()

	return ..()

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

/obj/item/weapon/ranged/bullet/proc/spend_bullet()
	if(length(stored_bullets)) //Spend a bullet
		var/obj/item/bullet/B = stored_bullets[1]
		stored_bullets -= B
		if(B)
			B.spend_bullet()
			stored_bullet_casings += B
		return B

/obj/item/weapon/ranged/bullet/proc/load_bullet_from_magazine()
	if(stored_magazine && length(stored_magazine.stored_bullets)) //Get a new bullet
		var/obj/item/bullet/B = stored_magazine.stored_bullets[1]
		if(B)
			stored_magazine.stored_bullets -= B
			stored_bullets += B

/obj/item/weapon/ranged/bullet/handle_ammo(var/mob/caller)
	var/obj/item/bullet/B = spend_bullet()
	load_bullet_from_magazine()
	return B

/obj/item/weapon/ranged/bullet/New()

	. = ..()

	if(stored_magazine)
		stored_magazine = new(src)

	stored_bullets = list()
	stored_bullet_casings = list()

	update_icon()

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return length(stored_bullets)
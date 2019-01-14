/obj/item/weapon/ranged/bullet

	var/obj/item/magazine/stored_magazine //You can use one or the other.
	var/list/obj/item/bullet/stored_bullets //Also good for one in the chamber stuff.
	var/list/obj/item/bullet/stored_bullet_casings

	var/bullet_type = "none"
	var/bullet_capacity = 1 //How many bullets can this store? Note that this isn't neccisarily the magazine size.

	var/open = TRUE //Whether or not this object can accept bullets.
	var/icon_state_open = "inventory"


/obj/item/weapon/ranged/bullet/proc/eject_spent_casings(var/mob/caller, var/new_loc)
	for(var/obj/item/bullet/B in stored_bullet_casings)
		stored_bullet_casings -= B
		B.loc = new_loc

/obj/item/weapon/ranged/bullet/proc/eject_stored_bullets(var/mob/caller, var/new_loc)
	for(var/obj/item/bullet/B in stored_bullets)
		stored_bullet_casings -= B
		B.loc = new_loc

/obj/item/weapon/ranged/bullet/update_icon()
	if(open)
		icon_state = icon_state_open
	else
		icon_state = initial(icon_state)
	. = ..()

/obj/item/weapon/ranged/bullet/handle_ammo()

	if(length(stored_bullets)) //Spend a bullet
		var/obj/item/bullet/B = stored_bullets[1]
		stored_bullets -= B
		B.spend_bullet()
		stored_bullet_casings += B

	if(stored_magazine && length(stored_magazine.stored_bullets)) //Get a new bullet
		var/obj/item/bullet/B = stored_magazine.stored_bullets[1]
		stored_magazine.stored_bullets -= B
		stored_bullets += B

/obj/item/weapon/ranged/bullet/New()

	. = ..()

	if(stored_magazine)
		stored_magazine = new(src)

	stored_bullets = list()
	stored_bullet_casings = list()

	update_icon()

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return length(stored_bullets)


/obj/item/weapon/ranged/bullet/can_gun_shoot(var/mob/caller)

	if(!..())
		return FALSE

	if(open)
		caller.to_chat(span("notice","You must close \the [src] first before shooting it!"))
		return FALSE

	if(get_ammo_count() <= 0)
		caller.to_chat(span("danger","*click click*"))
		return FALSE


	return TRUE

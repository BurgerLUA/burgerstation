/obj/item/weapon/ranged/bullet
	var/obj/item/magazine/stored_magazine //You can use one or the other.
	var/list/obj/item/bullet/stored_bullets //Also good for one in the chamber stuff.

	var/bullet_type = "none"
	var/bullet_capacity = 1 //How many bullets can this store? Note that this isn't neccisarily the magazine size.

	var/open = TRUE //Whether or not this object can accept bullets.
	var/icon_state_open = "inventory"

/obj/item/weapon/ranged/bullet/update_icon()
	if(open)
		icon_state = icon_state_open
	else
		icon_state = initial(icon_state)

/obj/item/weapon/ranged/bullet/New()

	. = ..()

	if(stored_magazine)
		stored_magazine = new(src)

	stored_bullets = list()

/obj/item/weapon/ranged/bullet/get_ammo_count()
	return length(stored_bullets)
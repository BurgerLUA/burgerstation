/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

	var/obj/item/magazine/stored_magazine //You can use one or the other.

	var/list/mag_remove_sounds = list(
		'sounds/weapons/mag_remove1.ogg',
		'sounds/weapons/mag_remove2.ogg',
		'sounds/weapons/mag_remove3.ogg',
		'sounds/weapons/mag_remove4.ogg',
		'sounds/weapons/mag_remove5.ogg'
	)

	var/list/mag_insert_sounds = list(
		'sounds/weapons/mag_insert1.ogg',
		'sounds/weapons/mag_insert2.ogg',
		'sounds/weapons/mag_insert3.ogg',
		'sounds/weapons/mag_insert4.ogg',
		'sounds/weapons/mag_insert5.ogg',
		'sounds/weapons/mag_insert6.ogg',
		'sounds/weapons/mag_insert7.ogg',
		'sounds/weapons/mag_insert8.ogg',
		'sounds/weapons/mag_insert9.ogg'
	)

	var/cock_sound = 'sounds/weapons/generic_close.ogg'

/obj/item/weapon/ranged/bullet/magazine/New()

	if(stored_magazine)
		stored_magazine = new(src)

	return ..()

/obj/item/weapon/ranged/bullet/magazine/click_self(var/mob/caller)
	caller.to_chat(span("notice","You cock \the [src]."))
	eject_stored_bullets(caller,caller.loc)
	load_bullet_from_magazine()
	var/area/A = get_area(caller.loc)
	play_sound(cock_sound,all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	update_icon()
	return TRUE


/obj/item/weapon/ranged/bullet/magazine/proc/eject_magazine(var/mob/caller as mob,var/atom/object)
	var/area/A = get_area(caller)
	play_sound(pick(mag_remove_sounds),all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
	stored_magazine.force_move(caller.loc)
	if(object)
		var/obj/hud/inventory/offhand_slot = object
		offhand_slot.add_object(stored_magazine)
	stored_magazine.update_icon()
	stored_magazine = null
	open = TRUE
	update_icon()

/obj/item/weapon/ranged/bullet/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	object = object.defer_click_on_object()

	if(!wielded && stored_magazine && object && is_inventory(object) && src && src.loc && is_inventory(src.loc) && !(caller.movement_flags & MOVEMENT_CROUCHING))
		eject_magazine(caller,object)
		return TRUE

	return ..()

/obj/item/weapon/ranged/bullet/magazine/proc/load_bullet_from_magazine()
	if(stored_magazine && length(stored_magazine.stored_bullets)) //Get a new bullet
		var/obj/item/bullet/B = stored_magazine.stored_bullets[1]
		if(B)
			stored_magazine.stored_bullets -= B
			stored_bullets += B

/obj/item/weapon/ranged/bullet/magazine/handle_ammo(var/mob/caller)
	. = ..()
	eject_spent_casings(caller,caller.loc)
	load_bullet_from_magazine()
	return .


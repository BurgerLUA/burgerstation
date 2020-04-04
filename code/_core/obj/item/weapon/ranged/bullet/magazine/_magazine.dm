/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

	var/obj/item/magazine/stored_magazine //You can use one or the other.

	var/requires_cock_each_shot = FALSE

	stored_bullets = null

/obj/item/weapon/ranged/bullet/magazine/proc/get_cock_sound(var/direction="both")
	switch(direction)
		if("both")
			return 'sounds/weapons/gun/general/bolt_rack.ogg'
		if("forward")
			return 'sounds/weapons/gun/general/bolt_drop.ogg'
		if("back")
			return 'sounds/weapons/gun/general/slide_lock_1.ogg'

/obj/item/weapon/ranged/bullet/magazine/on_spawn()

	if(stored_magazine)
		stored_magazine = new stored_magazine(src)
		stored_magazine.on_spawn()
		open = FALSE
		update_sprite()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/click_self(var/mob/caller)

	var/cock_type // = "flacid"

	if(eject_chambered_bullet(caller,caller.loc,TRUE))
		cock_type = "back"

	if(load_new_bullet_from_magazine(caller))
		cock_type = cock_type == "back" ? "both" : "forward"

	if(cock_type)
		var/area/A = get_area(caller.loc)
		play_sound(get_cock_sound(cock_type),src)
		update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/proc/eject_magazine(var/mob/caller as mob,var/atom/object)
	var/area/A = get_area(caller)
	play_sound(stored_magazine.get_magazine_eject_sound(),src)
	stored_magazine.force_move(caller.loc)
	if(object)
		var/obj/hud/inventory/offhand_slot = object
		offhand_slot.add_object(stored_magazine)
	stored_magazine.update_sprite()
	stored_magazine = null
	open = TRUE
	update_sprite()

/obj/item/weapon/ranged/bullet/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object
	if(!wielded && stored_magazine && object && is_inventory(object) && src && src.loc && is_inventory(src.loc) && !(caller.movement_flags & MOVEMENT_CROUCHING))
		eject_magazine(caller,object)
		return TRUE
	return ..()

/obj/item/weapon/ranged/bullet/magazine/proc/load_new_bullet_from_magazine(var/mob/caller)
	if(stored_magazine && length(stored_magazine.stored_bullets) && stored_magazine.stored_bullets[1] && !chambered_bullet)
		var/obj/item/bullet_cartridge/B = stored_magazine.stored_bullets[1]
		if(can_load_chamber(null,B))
			stored_magazine.stored_bullets -= B
			B.force_move(src)
			chambered_bullet = B
			return TRUE

	return FALSE

/obj/item/weapon/ranged/bullet/magazine/handle_ammo(var/mob/caller)

	. = ..()

	if(. && !is_npc(caller))
		eject_chambered_bullet(caller,get_turf(src),TRUE)
		if(!requires_cock_each_shot)
			load_new_bullet_from_magazine(caller)

	return .
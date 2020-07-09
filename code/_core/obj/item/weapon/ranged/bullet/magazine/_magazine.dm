/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

	var/obj/item/magazine/stored_magazine //You can use one or the other.

	var/requires_cock_each_shot = FALSE

	stored_bullets = null

/obj/item/weapon/ranged/bullet/magazine/save_item_data(var/save_inventory = TRUE)
	. = ..()
	if(src.stored_magazine) .["stored_magazine"] = src.stored_magazine.save_item_data(save_inventory)
	return .


/obj/item/weapon/ranged/bullet/magazine/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["stored_magazine"])
		src.stored_magazine = load_and_create(P,object_data["stored_magazine"],src)
		src.open = FALSE

	return .


/obj/item/weapon/ranged/bullet/magazine/proc/get_cock_sound(var/direction="both")
	switch(direction)
		if("both")
			return 'sound/weapons/gun/general/bolt_rack.ogg'
		if("forward")
			return 'sound/weapons/gun/general/bolt_drop.ogg'
		if("back")
			return 'sound/weapons/gun/general/slide_lock_1.ogg'

/obj/item/weapon/ranged/bullet/magazine/Generate()

	if(stored_magazine)
		var/obj/item/magazine/M = new stored_magazine(src)
		stored_magazine = null
		INITIALIZE(M)
		GENERATE(M)
		M.click_on_object(null,src)
		src.click_self()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/click_self(var/mob/caller)

	var/cock_type // = "flacid"

	if(eject_chambered_bullet(caller,caller ? caller.loc : get_turf(src),TRUE))
		cock_type = "back"

	if(load_new_bullet_from_magazine(caller))
		cock_type = cock_type == "back" ? "both" : "forward"

	var/turf/T = get_turf(src)

	if(cock_type)
		if(T) play(get_cock_sound(cock_type),T)
		update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/proc/eject_magazine(var/mob/caller as mob)

	if(!stored_magazine)
		CRASH_SAFE("[caller.get_debug_name()] tried to eject a magazine from [src.get_debug_name()], but there was no stored_magazine!")
		return FALSE

	var/turf/T = get_turf(caller)

	if(!T)
		qdel(src)
	else
		stored_magazine.force_move(T)
		play(stored_magazine.get_magazine_eject_sound(),T)
		if(stored_magazine)
			stored_magazine.update_sprite()
			stored_magazine = null

	open = TRUE
	update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(stored_magazine && !wielded && object && is_inventory(object) && src && src.loc && is_inventory(src.loc) && !(caller.movement_flags & MOVEMENT_CROUCHING))
		var/obj/item/magazine/M = stored_magazine
		var/obj/hud/inventory/I = object
		eject_magazine(caller)
		if(M && !M.qdeleting)
			I.add_held_object(M)
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

	if(.)
		eject_chambered_bullet(caller,get_turf(src),TRUE)
		if(!requires_cock_each_shot)
			load_new_bullet_from_magazine(caller)

	return .


/obj/item/weapon/ranged/bullet/magazine/proc/can_fit_magazine(var/obj/item/I)

	if(is_magazine(I))
		var/obj/item/magazine/M = I
		if(M.weapon_whitelist[src.type])
			return TRUE

	return FALSE
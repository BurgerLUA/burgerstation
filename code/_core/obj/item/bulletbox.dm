/obj/item/bulletbox
	name = "bullet box"
	desc = "Boxy!"
	desc_extended = "A non-descript green box that contains bullets for a weapon."
	icon = 'icons/obj/item/bulletbox.dmi'
	icon_state = "ammo"

	var/bullet_count = 0
	var/bullet_max = 0 //Updated when a new bullet is added.

	var/obj/item/bullet_cartridge/stored_bullet

	size = SIZE_5
	weight = 30

	value = 200

/obj/item/bulletbox/Finalize()
	. = ..()
	update_sprite()

/obj/item/bulletbox/Destroy()
	. = ..()
	set_stored_bullet(null)

/obj/item/bulletbox/get_value()
	. = ..()
	if(stored_bullet)
		. += bullet_count*stored_bullet.get_value()

/obj/item/bulletbox/get_examine_list(var/mob/caller)
	. = ..()
	if(stored_bullet)
		. += div("notice","It stores [stored_bullet.name] ([bullet_count]/[bullet_max] capacity).")

/obj/item/bulletbox/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEPATH("stored_bullet")
	SAVEVAR("bullet_count")

/obj/item/bulletbox/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()

	if(object_data["stored_bullet"])
		var/obj/item/bullet_cartridge/BC = text2path(object_data["stored_bullet"])
		if(BC) set_stored_bullet(BC)

	LOADVAR("bullet_count")

/obj/item/bulletbox/click_self(var/mob/caller)

	if(!anchored)
		drop_item(get_turf(caller))
		anchored = TRUE
		update_sprite()
		return TRUE

	return TRUE

/obj/item/bulletbox/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(5)

	if(is_bullet(object))
		var/obj/item/bullet_cartridge/B = object
		if(!stored_bullet)
			var/bullets_to_add = min(B.item_count_current,bullet_max)
			set_stored_bullet(B.type)
			bullets_to_add = abs(B.add_item_count(-bullets_to_add))
			bullet_count += bullets_to_add
			caller.to_chat(span("notice","You add [bullets_to_add] bullet\s to \the [src.name]."))
			update_sprite()
			return TRUE
		if(B.type == stored_bullet.type)
			var/bullets_to_add = min(B.item_count_current,bullet_max - bullet_count)
			if(bullets_to_add <= 0)
				return TRUE
			bullets_to_add = abs(B.add_item_count(-bullets_to_add))
			bullet_count += bullets_to_add
			caller.to_chat(span("notice","You add [bullets_to_add] bullet\s to \the [src.name]."))
			update_sprite()
			return TRUE
		caller.to_chat(span("warning","It would be a bad idea to mix bullets up..."))
		return TRUE

	if(anchored && caller.attack_flags & CONTROL_MOD_DISARM)
		anchored = FALSE
		update_sprite()
		caller.to_chat(span("notice","You pack up \the [src.name]."))
		return TRUE

	if(!stored_bullet)
		return ..()

	if(is_inventory(object))
		var/bullets_to_take = min(bullet_count,stored_bullet.item_count_max)
		if(bullets_to_take <= 0)
			return TRUE
		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/BC = new stored_bullet.type(get_turf(src))
		INITIALIZE(BC)
		BC.item_count_current = bullets_to_take
		FINALIZE(BC)
		I.add_object(BC)
		bullet_count -= bullets_to_take
		caller.to_chat(span("notice","You take [bullets_to_take] bullets from \the [src.name]."))
		update_sprite()
		return TRUE

	if(is_magazine(object))
		var/obj/item/magazine/M = object
		if(!M.can_load_magazine(caller,stored_bullet))
			return TRUE
		var/bullets_to_take = min(bullet_count,M.bullet_count_max-length(M.stored_bullets))
		if(bullets_to_take <= 0)
			return TRUE
		for(var/i=1,i<=bullets_to_take,i++)
			var/obj/item/bullet_cartridge/BC = new stored_bullet.type(M)
			INITIALIZE(BC)
			FINALIZE(BC)
			M.stored_bullets += BC
		bullet_count -= bullets_to_take
		M.update_sprite()
		caller.to_chat(span("notice","You fill up \the [M.name] with [bullets_to_take] bullets from \the [src.name]."))
		update_sprite()
		return TRUE

	. = ..()

/obj/item/bulletbox/proc/set_stored_bullet(var/desired_path)

	if(!desired_path)
		if(stored_bullet && istype(stored_bullet))
			qdel(stored_bullet)
		stored_bullet = null
		bullet_count = 0
		bullet_max = 0
		return TRUE

	if(ispath(desired_path))
		stored_bullet = new desired_path(src)
		INITIALIZE(stored_bullet)
		stored_bullet.item_count_current = 1
		FINALIZE(stored_bullet)
		bullet_max = FLOOR( 10*(size**3)/stored_bullet.bullet_diameter, 1)
		if(!bullet_max)
			set_stored_bullet(null)
			update_sprite()
			return FALSE
		return TRUE

	return FALSE

/obj/item/bulletbox/update_sprite()
	. = ..()
	name = initial(name)
	if(istype(stored_bullet))
		name = "[name] ([stored_bullet.name])"

/obj/item/bulletbox/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	if(anchored)
		icon_state = "[icon_state]_open"

/obj/item/bulletbox/update_overlays()
	. = ..()
	if(istype(stored_bullet)) //Draw the logo on the bullet
		var/image/I = new/image(stored_bullet.icon,stored_bullet.icon_state)
		I.appearance = stored_bullet.appearance
		I.color = "#AAAAAA"
		I.alpha = 200
		var/matrix/M = matrix()
		M.Turn(90)
		I.transform = M
		I.pixel_y = -6
		I.pixel_x = 3
		add_overlay(I)
	if(anchored && bullet_count) //Draw the bullets inside.
		var/ratio = 1 + FLOOR((bullet_count/bullet_max)*2,1)
		if(stored_bullet && stored_bullet.bulletbox_icon_state)
			var/image/I = new/image(icon,"[stored_bullet.bulletbox_icon_state]_[ratio]")
			add_overlay(I)

/obj/item/bulletbox/rifle_556/Generate()
	. = ..()
	set_stored_bullet(/obj/item/bullet_cartridge/rifle_223/nato/premium)
	bullet_count = bullet_max


/obj/item/bulletbox/rifle_762/Generate()
	. = ..()
	set_stored_bullet(/obj/item/bullet_cartridge/rifle_308/nato/premium)
	bullet_count = bullet_max
/obj/item/weapon/ranged/bullet/revolver/
	open = FALSE
	var/current_chamber = 1

	var/can_shoot_while_open = FALSE

	inaccuracy_modifer = 0.5

	movement_spread_base = 0.02
	movement_spread_mul = 0.05

/obj/item/weapon/ranged/bullet/revolver/New(var/desired_loc)
	. = ..()
	stored_bullets = new/list(bullet_count_max)
	return .

/obj/item/weapon/ranged/bullet/revolver/get_ranged_damage_type()
	return stored_bullets[current_chamber] ? stored_bullets[current_chamber].damage_type : damage_type

/obj/item/weapon/ranged/bullet/revolver/can_load_chamber(var/mob/caller,var/obj/item/bullet_cartridge/B)
	return FALSE

/obj/item/weapon/ranged/bullet/revolver/proc/rotate_cylinder(var/rotate_amount=1)

	if(rotate_amount == 0)
		return FALSE

	current_chamber += rotate_amount
	current_chamber = SAFEINDEX(current_chamber,bullet_count_max)

	return current_chamber

/obj/item/weapon/ranged/bullet/revolver/click_self(var/mob/caller)
	open = !open

	if(open)
		eject_stored_bullets_spent(caller,get_turf(src),TRUE)
		caller.to_chat(span("notice","You open \the [src]. It contains [get_ammo_count()] bullet\s."))
	else
		caller.to_chat(span("notice","You close \the [src]."))

	play('sound/weapons/revolver_click2.ogg',src)

	update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/revolver/get_ammo_count()
	return get_real_length(stored_bullets)

/obj/item/weapon/ranged/bullet/revolver/handle_ammo(var/mob/caller,var/bullet_position=1)
	var/obj/item/bullet_cartridge/B = spend_stored_bullet(caller,current_chamber)
	rotate_cylinder(1)
	return B

/obj/item/weapon/ranged/bullet/revolver/can_gun_shoot(var/mob/caller)

	if(!can_shoot_while_open && open)
		return FALSE

	return ..()

/obj/item/weapon/ranged/bullet/revolver/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	var/atom/defer_object = object.defer_click_on_object(location,control,params)

	if(open && defer_object && is_inventory(defer_object) && src && src.loc && is_inventory(src.loc)) //The revolver is in an inventory, and you're click on it with your hands.

		var/obj/hud/inventory/I = object

		var/last_value = get_last_value(stored_bullets)

		if(last_value)
			var/obj/item/bullet_cartridge/B = eject_stored_bullet(caller,last_value,get_turf(src))
			if(B)
				caller?.to_chat(span("notice","You remove \the [B.name] from \the [src.name]."))
				I.add_object(B)

		return TRUE

	return ..()
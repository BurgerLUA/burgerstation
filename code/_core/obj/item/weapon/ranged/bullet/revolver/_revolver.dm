/obj/item/weapon/ranged/bullet/revolver/
	open = FALSE
	var/current_chamber = 1

	var/can_shoot_while_open = FALSE

	movement_spread_base = 0.03

	inaccuracy_modifier = 0.5

	damage_mod = 1.2

	tier_type = "revolver"

	var/has_quickshot = FALSE

/obj/item/weapon/ranged/bullet/revolver/Initialize()
	if(can_shoot_while_open)
		open = TRUE
	. = ..()

/obj/item/weapon/ranged/bullet/revolver/proc/can_fit_clip(var/obj/item/I)

	if(istype(I,/obj/item/magazine/clip/revolver))
		var/obj/item/magazine/M = I
		if(M.weapon_whitelist[src.type])
			return TRUE

	return FALSE

/obj/item/weapon/ranged/bullet/revolver/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1,var/click_called=FALSE)

	if(!has_quickshot)
		return ..()

	var/quick_shot = click_called && world.time - last_shoot_time < shoot_delay

	if(quick_shot)
		damage_multiplier *= 0.9

	. = ..()

	if(. && quick_shot)
		var/turf/T = get_turf(src)
		play_sound('sound/weapons/revolver_timing.ogg',T)


/obj/item/weapon/ranged/bullet/revolver/get_shoot_delay(var/mob/caller,var/atom/target,location,params)

	. = ..()

	if(!caller.client || !has_quickshot)
		return .

	var/shot_ago = world.time - last_shoot_time

	if(shot_ago >= 1 && shot_ago <= .) //Can shoot really fast, for a penalty.
		return shot_ago

/obj/item/weapon/ranged/bullet/revolver/New(var/desired_loc)
	. = ..()
	stored_bullets = new/list(bullet_count_max)

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

	if(can_shoot_while_open)
		return TRUE

	INTERACT_CHECK
	INTERACT_DELAY(1)

	open = !open

	var/turf/T = get_turf(src)

	if(open)
		eject_stored_bullets_spent(caller,T,TRUE)
		caller.to_chat(span("notice","You open \the [src]. It contains [get_ammo_count()] bullet\s."))
	else
		caller.to_chat(span("notice","You close \the [src]."))

	play_sound('sound/weapons/revolver_click2.ogg',T,range_max=VIEW_RANGE*0.25)

	update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/revolver/get_ammo_count()
	return get_real_length(stored_bullets)

/obj/item/weapon/ranged/bullet/revolver/handle_ammo(var/mob/caller,var/bullet_position=1)
	var/obj/item/bullet_cartridge/B = spend_stored_bullet(caller,current_chamber)
	rotate_cylinder(1)
	return B

/obj/item/weapon/ranged/bullet/revolver/can_gun_shoot(var/mob/caller,var/atom/object,location,params,var/check_time=TRUE,var/messages=TRUE)

	if(!can_shoot_while_open && open)
		if(messages) caller.to_chat(span("warning","Close \the [src.name] before firing!"))
		return FALSE

	return ..()

/obj/item/weapon/ranged/bullet/revolver/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(open && is_inventory(object) && src && is_inventory(src.loc)) //The revolver is in an inventory, and you clicked on it with your empty hands.

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		var/obj/hud/inventory/I = object

		var/last_value = get_last_value(stored_bullets)

		if(last_value)
			var/obj/item/bullet_cartridge/B = eject_stored_bullet(caller,last_value,get_turf(src))
			if(B)
				caller?.to_chat(span("notice","You remove \the [B.name] from \the [src.name]."))
				I.add_object(B)
				//TODO: Bullet removal sounds?

		return TRUE

	return ..()
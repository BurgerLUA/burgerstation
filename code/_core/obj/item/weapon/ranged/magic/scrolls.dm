/obj/item/weapon/ranged/magic/scroll/

	open = FALSE
	damage_type = null //TODO: Paper cut
	ranged_damage_type = null

	icon = 'icons/obj/item/weapons/ranged/magic/scroll.dmi'
	icon_state = "scroll"

	override_icon_state = TRUE

	has_quick_function = TRUE

	automatic = FALSE

	var/scroll_count = 1

	weight = 0.1


/obj/item/weapon/ranged/magic/scroll/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("scroll_count")
	return .

/obj/item/weapon/ranged/magic/scroll/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("scroll_count")
	return .

/obj/item/weapon/ranged/magic/scroll/get_value()
	. = ..()
	. *= (1 + scroll_count)
	return .

/obj/item/weapon/ranged/magic/scroll/quick(var/mob/caller as mob,var/atom/object,location,params)
	shoot(caller,object,location,params)
	return TRUE

/obj/item/weapon/ranged/magic/scroll/click_self(var/mob/caller)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	open = !open
	caller.to_chat(span("notice","You [open ? "unravel" : "roll up"] the scroll."))
	update_sprite()
	return TRUE

/obj/item/weapon/ranged/magic/scroll/can_gun_shoot(var/mob/caller)

	if(!open)
		caller.to_chat(span("notice","You need to unravel the scroll before firing it!"))
		return FALSE

	if(get_ammo_count() <= 0)
		caller.to_chat(span("notice","The scroll is blank!"))
		return FALSE

	return ..()

/obj/item/weapon/ranged/magic/scroll/get_ammo_count()
	return scroll_count

/obj/item/weapon/ranged/magic/scroll/update_icon()

	icon_state = initial(icon_state)

	if(open)
		icon_state += "_open"

	if(get_ammo_count() <= 0)
		icon_state += "_empty"

	..()

/obj/item/weapon/ranged/magic/scroll/handle_empty(var/mob/caller)
	if(!open)
		caller.to_chat(span("warning","You must unravel the scroll before using it!"))
	else
		caller.to_chat(span("warning","This scroll is blank and void of magic!"))
	return TRUE //No melee

/obj/item/weapon/ranged/magic/scroll/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_scroll(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)

		if(scroll_count <= 0)
			caller.to_chat(span("warning","This scroll is blank and void of magic!"))
			return TRUE

		var/obj/item/weapon/ranged/magic/scroll/S = object

		if(S.scroll_count <= 0)
			caller.to_chat(span("warning","The scroll is blank and void of magic!"))
			return TRUE

		if(S.type != type) //Need to be the exact same id.
			caller.to_chat(span("warning","It wouldn't be a very good idea to mix scrolls together without a tome."))
			return TRUE

		var/transfer_count = S.scroll_count

		caller.to_chat(span("notice","You take [transfer_count] scroll\s from \the [S]."))

		S.scroll_count -= scroll_count
		scroll_count += transfer_count
		if(S.scroll_count <= 0)
			qdel(S)

		return TRUE

	return ..()

/obj/item/weapon/ranged/magic/scroll/handle_ammo(var/mob/caller,var/bullet_position=1)
	scroll_count--
	update_sprite()
	return ..()

/obj/item/weapon/ranged/magic/scroll/fireball
	name = "scroll of true fireball"
	desc = "Shoots an explosive fireball."

	projectile = /obj/projectile/magic/fireball/explosive

	ranged_damage_type = /damagetype/ranged/magic/fireball

	shoot_delay = 10
	projectile_speed = 16

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	value = 15

/obj/item/weapon/ranged/magic/scroll/fireball/Generate()
	scroll_count = 5
	return ..()
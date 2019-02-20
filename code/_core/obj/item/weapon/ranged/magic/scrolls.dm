/obj/item/weapon/ranged/magic/scroll/
	var/scroll_count = 1
	open = FALSE
	damage_type = null //TODO: Paper cut

	icon = 'icons/obj/items/weapons/ranged/magic/scroll.dmi'
	icon_state = "scroll"

	override_icon_state = TRUE

/obj/item/weapon/ranged/magic/scroll/click_self(var/mob/caller)
	open = !open
	caller.to_chat(span("notice","You [open ? "unravel" : "roll up"] the scroll."))
	update_icon()
	return TRUE

/obj/item/weapon/ranged/magic/scroll/can_gun_shoot(var/mob/caller)
	if(!open)
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
		caller.to_chat(span("notice","You must unravel the scroll before using it!"))
	else
		caller.to_chat(span("notice","This scroll is blank and void of magic!"))
	return TRUE //No melee

/obj/item/weapon/ranged/magic/scroll/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_scroll(object))

		if(scroll_count <= 0)
			caller.to_chat(span("notice","This scroll is blank and void of magic!"))
			return TRUE

		var/obj/item/weapon/ranged/magic/scroll/S = object

		if(S.scroll_count <= 0)
			caller.to_chat(span("notice","The scroll is blank and void of magic!"))
			return TRUE

		if(S.id != id) //Need to be the exact same id.
			caller.to_chat(span("notice","It wouldn't be a very good idea to mix scrolls together without a tome."))
			return TRUE

		var/transfer_count = S.scroll_count

		caller.to_chat(span("notice","You take [transfer_count] scroll\s from \the [S]."))

		S.scroll_count -= scroll_count
		scroll_count += transfer_count
		if(S.scroll_count <= 0)
			qdel(S)

		return TRUE

	return ..()

/obj/item/weapon/ranged/magic/scroll/handle_ammo(var/mob/caller as mob,var/atom/object,location,params)
	scroll_count -= 1
	update_icon()

/obj/item/weapon/ranged/magic/scroll/fireball
	name = "scroll of fireball"
	desc = "Shoots a fireball."
	id = "fireball"

	projectile = /obj/projectile/bullet/fireball

	shoot_delay = 10
	bullet_speed = 16

	shoot_sounds = list('sounds/weapon/ranged/magic/fireball.ogg')

/obj/item/weapon/ranged/magic/scroll/fireball/amount_3/on_spawn()
	scroll_count = 5
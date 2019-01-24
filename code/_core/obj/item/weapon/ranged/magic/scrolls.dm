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

		S.scroll_count -= 1
		scroll_count += 1
		if(S.scroll_count <= 0)
			del(S)

		return TRUE

	return ..()

/obj/item/weapon/ranged/magic/scroll/shoot(var/mob/caller as mob,var/atom/object,location,params)

	if(..())
		scroll_count -= 1
		update_icon()

	return TRUE

/obj/item/weapon/ranged/magic/scroll/fireball
	name = "scroll of fireball"
	desc = "Shoots a fireball."
	id = "fireball"

	projectile = /obj/projectile/bullet/fireball
	ranged_damage_type = /damagetype/ranged/fireball

	shoot_delay = 10

	bullet_speed = 16


/obj/item/weapon/ranged/magic/scroll/fireball/amount_10
	scroll_count = 10
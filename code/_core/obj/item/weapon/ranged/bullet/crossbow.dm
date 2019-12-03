/obj/item/weapon/ranged/bullet/crossbow
	name = "bolt crossbow"
	icon = 'icons/obj/items/weapons/ranged/crossbow.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 20

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "bolt"

	shoot_sounds = list('sounds/weapons/crossbow/fire.ogg')

	override_icon_state = TRUE

	open = TRUE

	icon_state_worn = "worn"
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	view_punch = 4

/obj/item/weapon/ranged/bullet/crossbow/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return TRUE

/obj/item/weapon/ranged/bullet/crossbow/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/crossbow/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/crossbow/update_icon()

	if(chambered_bullet)
		icon_state = "inventory_1"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/crossbow/handle_ammo(var/mob/caller)
	. = ..()
	if(.)
		eject_stored_bullet(.,get_turf(src))
	return .
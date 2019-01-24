/obj/item/weapon/ranged/magic/staff
	cost_charge = 10
	total_charge = 1000

/obj/item/weapon/ranged/magic/staff/shoot(var/mob/caller as mob,var/atom/object,location,params)
	. = ..()
	if(.)
		total_charge -= cost_charge
		update_icon()

	return .

/obj/item/weapon/ranged/magic/staff/get_ammo_count()
	return total_charge / cost_charge

/obj/item/weapon/ranged/magic/staff/fire
	name = "Wand of Fireballs"
	desc = "Shoot fireballs!"
	cost_charge = 100
	total_charge = 1000

	bullet_speed = 16

	icon = 'icons/obj/items/weapons/ranged/magic/fire.dmi'

	projectile = /obj/projectile/bullet/fireball
	ranged_damage_type = /damagetype/ranged/fireball
	damage_type = /damagetype/sword/

	override_icon_state = TRUE

/obj/item/weapon/ranged/magic/staff/fire/update_icon()

	icon_state = "[initial(icon_state)][get_ammo_count() >= 1 ? "_1" : ""]"

	..()

/obj/item/weapon/ranged/magic/staff/chaos

	name = "Staff of Chaos"
	desc = "Summon Chaos!"
	cost_charge = 250
	total_charge = 1000

	bullet_speed = 8

	bullet_count = 3

	icon = 'icons/obj/items/weapons/ranged/magic/chaos.dmi'

	projectile = /obj/projectile/bullet/chaos
	ranged_damage_type = /damagetype/ranged/chaos
	damage_type = /damagetype/sword/
/obj/item/weapon/ranged/magic/staff
	var/cost_charge = 100
	var/total_charge = 1000

/obj/item/weapon/ranged/magic/staff/can_gun_shoot(var/mob/caller)

	if(total_charge < cost_charge)
		handle_empty(caller)
		return FALSE

	return ..()

/obj/item/weapon/ranged/magic/staff/get_examine_list(var/mob/caller)
	return ..() + div("notice","It has [get_ammo_count()] charges ([total_charge]) remaining.")

/obj/item/weapon/ranged/magic/staff/handle_ammo(var/mob/caller,var/bullet_position=1)
	total_charge -= cost_charge
	update_sprite()
	return FALSE

/obj/item/weapon/ranged/magic/staff/get_ammo_count()
	return round(total_charge / cost_charge)

/obj/item/weapon/ranged/magic/staff/fire
	name = "Wand of Fireballs"
	desc = "Shoot fireballs!"
	cost_charge = 100
	total_charge = 2500

	projectile_speed = 16
	shoot_delay = SECONDS_TO_DECISECONDS(2)

	icon = 'icons/obj/items/weapons/ranged/magic/fire.dmi'

	projectile = /obj/projectile/magic/fireball
	damage_type = /damagetype/ranged/magic/fireball

	override_icon_state = TRUE

	shoot_sounds = list('sounds/weapons/magic/fireball.ogg')

/obj/item/weapon/ranged/magic/staff/fire/New()
	..()
	update_sprite()

/obj/item/weapon/ranged/magic/staff/fire/update_icon()

	icon_state = "[initial(icon_state)][get_ammo_count() >= 1 ? "_1" : ""]"

	..()

/obj/item/weapon/ranged/magic/staff/chaos

	name = "Staff of Chaos"
	desc = "Summon Chaos!"
	cost_charge = 250
	total_charge = 1000

	shoot_delay = 20

	projectile_speed = 4

	bullet_count = 9

	icon = 'icons/obj/items/weapons/ranged/magic/chaos.dmi'

	projectile = /obj/projectile/magic/chaos
	damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sounds/weapons/magic/chaos.ogg')


/obj/item/weapon/ranged/magic/staff/chaos/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/bullet_num,var/accuracy)

	var/num = bullet_num/bullet_count

	var/norm_x = sin(num*360)
	var/norm_y = cos(num*360)

	return list(norm_x,norm_y)

/obj/item/weapon/ranged/magic/staff/basic

	name = "Staff of Magic Missile"
	desc = "MAGIC MWISSLE."
	cost_charge = 100
	total_charge = 1000

	projectile_speed = 20
	bullet_count = 1

	icon = 'icons/obj/items/weapons/ranged/magic/basic.dmi'

	projectile = /obj/projectile/magic/magic_missile
	damage_type = /damagetype/ranged/magic/magic_missile



	shoot_sounds = list('sounds/weapons/magic/magic_missile.ogg')

/obj/item/weapon/ranged/magic/staff/focus

	name = "Staff of the Rift"
	desc = "Shoot rifts and annoy the shit out of people."
	cost_charge = 100
	total_charge = 1000

	projectile_speed = 31
	bullet_count = 1

	icon = 'icons/obj/items/weapons/ranged/magic/focus.dmi'

	projectile = /obj/projectile/magic/rift
	damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sounds/weapons/magic/teleport_out.ogg')


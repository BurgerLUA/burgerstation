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

	icon = 'icons/obj/item/weapons/ranged/magic/fire.dmi'

	projectile = /obj/projectile/magic/fireball
	ranged_damage_type = /damagetype/ranged/magic/fireball

	override_icon_state = TRUE

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	value = 1200

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

	icon = 'icons/obj/item/weapons/ranged/magic/chaos.dmi'

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	value = 900

/obj/item/weapon/ranged/magic/staff/chaos/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/accuracy)

	var/num = bullet_num/bullet_count

	var/norm_x = initial_offset_x + sin(num*360)
	var/norm_y = initial_offset_y + cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/obj/item/weapon/ranged/magic/staff/chaos/get_static_spread() //Base spread
	return 0


/obj/item/weapon/ranged/magic/staff/basic

	name = "Staff of Magic Missile"
	desc = "MAGIC MWISSLE."
	cost_charge = 100
	total_charge = 1000

	projectile_speed = 20
	bullet_count = 1

	icon = 'icons/obj/item/weapons/ranged/magic/basic.dmi'

	projectile = /obj/projectile/magic/magic_missile
	ranged_damage_type = /damagetype/ranged/magic/magic_missile

	shoot_sounds = list('sound/weapons/magic/magic_missile.ogg')

	value = 1000

/obj/item/weapon/ranged/magic/staff/focus

	name = "Staff of the Rift"
	desc = "Shoot rifts and annoy the shit out of people."
	cost_charge = 100
	total_charge = 1000

	projectile_speed = 31
	bullet_count = 1

	icon = 'icons/obj/item/weapons/ranged/magic/focus.dmi'

	projectile = /obj/projectile/magic/rift
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/teleport_out.ogg')


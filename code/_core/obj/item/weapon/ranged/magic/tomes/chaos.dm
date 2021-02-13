/obj/item/weapon/ranged/magic/tome/chaos
	name = "tome of chaos"
	desc = "Can't aim? Shoot balls of pure chaos around you."
	desc_extended = "Costs mana to use."
	cost_mana = 15
	shoot_delay = 20

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/chaos.dmi'

	bullet_count = 9
	projectile_speed = 4

	projectile = /obj/projectile/magic/chaos
	ranged_damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	value = 200

/obj/item/weapon/ranged/magic/tome/chaos/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	var/num = bullet_num/bullet_num_max

	var/norm_x = initial_offset_x + sin(num*360)
	var/norm_y = initial_offset_y + cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/obj/item/weapon/ranged/magic/tome/chaos/get_static_spread()
	return 0


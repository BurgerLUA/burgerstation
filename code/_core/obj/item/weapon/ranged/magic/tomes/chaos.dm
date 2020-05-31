/obj/item/weapon/ranged/magic/tome/chaos
	name = "tome of chaos"
	desc = "Can't aim? Shoot balls of pure chaos around you."
	desc_extended = "Costs mana to use."
	cost_mana = 16
	shoot_delay = 10

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/chaos.dmi'

	associated_skill = SKILL_SORCERY

	bullet_count = 9
	projectile_speed = 4

	projectile = /obj/projectile/magic/chaos
	damage_type = /damagetype/ranged/magic/chaos

	shoot_sounds = list('sounds/weapons/magic/chaos.ogg')

	value = 200

/obj/item/weapon/ranged/magic/tome/chaos/get_projectile_path(var/atom/caller,var/desired_x,var/desired_y,var/bullet_num,var/accuracy)

	var/num = bullet_num/bullet_count

	var/norm_x = sin(num*360)
	var/norm_y = cos(num*360)

	return list(norm_x,norm_y)

/obj/item/weapon/ranged/magic/tome/chaos/get_static_spread() //Base spread
	return 0.1


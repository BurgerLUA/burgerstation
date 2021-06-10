/obj/item/weapon/ranged/magic/tome/fireball
	name = "tome of the fireball"
	desc = "Shoot fireballs in long hallways like an asshole."
	desc_extended = "Costs mana to use."
	cost_mana = 50
	shoot_delay = 8

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/fireball.dmi'

	projectile = /obj/projectile/magic/fireball
	ranged_damage_type = /damagetype/ranged/magic/fireball

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	projectile_speed = TILE_SIZE*0.75 - 1

	value = 600
/obj/item/weapon/ranged/magic/tome/frost
	name = "tome of frost spray"
	desc = "Sprays an enemy with frost."
	desc_extended = "Costs mana to use."
	cost_mana = 2
	shoot_delay = 1.5

	automatic = TRUE

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/frost.dmi'

	projectile = /obj/projectile/magic/frost

	ranged_damage_type = /damagetype/ranged/magic/frost

	shoot_sounds = list('sound/weapons/magic/frost.ogg')

	projectile_speed = TILE_SIZE*0.5 - 1

	value = 600
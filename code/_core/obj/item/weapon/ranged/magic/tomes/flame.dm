/obj/item/weapon/ranged/magic/tome/flame
	name = "tome of flames"
	desc = "Sprays an enemy with flames."
	desc_extended = "Costs mana to use."
	cost_mana = 2
	shoot_delay = 2

	automatic = TRUE

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/flame.dmi'

	projectile = /obj/projectile/magic/lesser_fire

	ranged_damage_type = /damagetype/ranged/magic/flame

	shoot_sounds = list('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')

	projectile_speed = TILE_SIZE*0.75 - 1

	value = 600
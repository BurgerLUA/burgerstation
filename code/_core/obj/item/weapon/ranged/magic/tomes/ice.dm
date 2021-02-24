/obj/item/weapon/ranged/magic/tome/ice
	name = "tome of the ice crystal"
	desc = "Cool."
	desc_extended = "Fires a large ice crystal."
	cost_mana = 15
	shoot_delay = 8

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/ice.dmi'

	projectile = /obj/projectile/magic/crystal/ice

	ranged_damage_type = /damagetype/ranged/magic/ice

	shoot_sounds = list('sound/weapons/freeze.ogg')

	projectile_speed = TILE_SIZE*0.75 - 1

	value = 500
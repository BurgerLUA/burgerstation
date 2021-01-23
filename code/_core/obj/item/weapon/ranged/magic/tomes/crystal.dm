/obj/item/weapon/ranged/magic/tome/crystal
	name = "tome of the plasma crystal"
	desc = "Shoot plasma crystals at a rapid rate."
	desc_extended = "Costs mana to use."
	cost_mana = 4
	shoot_delay = 1.25

	automatic = TRUE

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/crystal.dmi'

	projectile = /obj/projectile/magic/crystal

	ranged_damage_type = /damagetype/ranged/magic/crystal

	shoot_sounds = list('sound/weapons/magic/zap.ogg')

	projectile_speed = TILE_SIZE - 1

	value = 600
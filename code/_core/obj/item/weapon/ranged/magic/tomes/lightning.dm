/obj/item/weapon/ranged/magic/tome/lightning
	name = "tome of the lightning bolt"
	desc = "Be like Zeus!"
	desc_extended = "Fires slow moving lightning bolts at foes."
	cost_mana = 16
	shoot_delay = 15

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/lightning.dmi'

	projectile = /obj/projectile/magic/lightning_bolt

	ranged_damage_type = /damagetype/ranged/magic/lightning

	shoot_sounds = list('sound/weapons/magic/zap_large.ogg')

	projectile_speed = TILE_SIZE - 1

	value = 300
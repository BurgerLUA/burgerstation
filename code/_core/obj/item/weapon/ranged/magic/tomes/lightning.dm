/obj/item/weapon/ranged/magic/tome/lightning
	name = "tome of the lightning bolt"
	desc = "Be like Zeus!"
	desc_extended = "Fires slow moving lightning bolts at foes."
	cost_mana = 16
	shoot_delay = 10

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/lightning.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/magic/lightning_bolt

	ranged_damage_type = /damagetype/ranged/magic/lightning

	shoot_sounds = list('sounds/weapons/magic/zap_large.ogg')

	projectile_speed = 10

	value = 300
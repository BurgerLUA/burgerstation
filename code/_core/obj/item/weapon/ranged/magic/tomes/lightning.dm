/obj/item/weapon/ranged/magic/tome/lightning
	name = "tome of the lightning bolt"
	desc = "Be like Zeus!"
	desc_extended = "Hold down the fire button to charge up a powerful lightning bolt. The longer the tome is charged, the higher the damage."
	cost_mana = 40
	shoot_delay = 10

	icon = 'icons/obj/items/weapons/ranged/magic/tomes/lightning.dmi'

	associated_skill = SKILL_PRAYER

	projectile = /obj/projectile/bullet/lightning_bolt

	damage_type = /damagetype/ranged/magic/lightning

	shoot_sounds = list('sounds/weapons/magic/zap_large.ogg')

	projectile_speed = 10
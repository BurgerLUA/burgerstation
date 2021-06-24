/obj/item/weapon/ranged/magic/tome/shock
	name = "tome of shock spray"
	desc = "Sprays an enemy with shock."
	desc_extended = "Costs mana to use."
	cost_mana = 2


	shoot_delay = 30
	burst_delay = 3
	max_bursts = 3
	bullet_count = 2

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/shock.dmi'

	projectile = /obj/projectile/magic/lightning

	ranged_damage_type = /damagetype/ranged/magic/shock

	shoot_sounds = list('sound/effects/zzzt.ogg')

	projectile_speed = TILE_SIZE - 1

	value = 600
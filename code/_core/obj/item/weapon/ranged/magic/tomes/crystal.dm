/obj/item/weapon/ranged/magic/tome/crystal
	name = "tome of the plasma crystal"
	desc = "Shoot plasma crystals at a rapid rate."
	desc_extended = "Costs mana to use."
	cost_mana = 4
	shoot_delay = 7
	burst_delay = 2
	max_bursts = 3

	automatic = FALSE

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/crystal.dmi'

	projectile = /obj/projectile/magic/crystal

	ranged_damage_type = /damagetype/ranged/magic/crystal

	shoot_sounds = list('sound/weapons/magic/zap.ogg')

	projectile_speed = TILE_SIZE*0.75 - 1

	value = 600


/obj/item/weapon/ranged/magic/tome/crystal/true
	name = "true tome of the plasma crystal"
	desc = "Shoot plasma crystals at a rapid rate."
	desc_extended = "Costs mana to use."
	cost_mana = 5

	shoot_delay = 6
	burst_delay = 1
	max_bursts = 5

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/crystal.dmi'

	projectile = /obj/projectile/magic/crystal

	ranged_damage_type = /damagetype/ranged/magic/crystal/true

	shoot_sounds = list('sound/weapons/magic/zap.ogg')

	projectile_speed = TILE_SIZE - 1

	value = 2000
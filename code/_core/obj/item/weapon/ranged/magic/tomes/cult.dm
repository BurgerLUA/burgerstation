/obj/item/weapon/ranged/magic/tome/cult
	name = "cultist's tome"
	desc = "No normies allowed."
	desc_extended = "Costs mana to use."
	cost_mana = 15
	shoot_delay = 30

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/cult.dmi'

	bullet_count = 3
	projectile_speed = TILE_SIZE*0.75

	projectile = /obj/projectile/magic/cultist
	ranged_damage_type = /damagetype/ranged/magic/cult

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	value = 200


/obj/item/weapon/ranged/magic/tome/cult/get_base_spread()
	return 0.1
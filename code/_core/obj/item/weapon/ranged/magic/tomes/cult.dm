/obj/item/weapon/ranged/magic/tome/cult
	name = "cultist's tome"
	desc = "No normies allowed."
	desc_extended = "Costs mana to use."
	cost_mana = 15
	shoot_delay = 10

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/cult.dmi'

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.5

	projectile = /obj/projectile/magic/cultist
	ranged_damage_type = /damagetype/ranged/magic/cult

	shoot_sounds = list('sound/weapons/magic/chaos.ogg')

	value = 800

/obj/item/weapon/ranged/magic/tome/cult/get_base_spread()
	return 0.07
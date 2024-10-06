/obj/item/weapon/ranged/energy/captain
	name = "\improper Captain's laser pistol"
	desc = "All craftsmanship is of the highest quality."
	desc_extended = "A fancier version of the laser rifle that self-charges. It has become innacurate due to its age."
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'

	company_type = "NanoTrasen"

	value = 4000

	damage_mod = 1.1

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/carbine

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/energy/captain/shoot.ogg')

	charge_cost = (CELL_SIZE_BASIC*0.5) / 40

	override_icon_state = TRUE

	heat_max = 0.05

	size = SIZE_3
	weight = 10

	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

	rarity = RARITY_LEGENDARY

	charge_icon_state_count = 4

/obj/item/weapon/ranged/energy/captain/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/captain/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

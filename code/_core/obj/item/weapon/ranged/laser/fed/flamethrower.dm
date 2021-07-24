/obj/item/weapon/ranged/energy/fed/flamethrower //it's the only way to be sure
	name = "flamethrower"
	desc = "W + M1"
	desc_extended = "Bioweapons are fun, but they leave one hell of a mess. Why not make the cleanup fun too?"
	icon = 'icons/obj/item/weapons/melee/polearms/goedendag.dmi'
	rarity = RARITY_UNCOMMON
	value = 0 //This is, after all, part of the Flamethrower Pack
	value_burgerbux = 1

	shoot_sounds = list('sound/weapons/cutter/fire.ogg')

	projectile = /obj/projectile/bullet/flamer
	ranged_damage_type = /damagetype/ranged/laser/flamethrower

	shoot_delay = 1
	charge_cost = 1

	charge_per_feed = 100
	fed_item = /obj/item/crafting/ingredient/part/p_tank
	feed_delay = 5

	projectile_speed = TILE_SIZE*0.3

	bullet_color = null

	automatic = TRUE

	can_wield = TRUE
	wield_only = TRUE //sorting is hell

/obj/item/weapon/ranged/energy/fed/flamethrower/Initialize()
	firing_pin = new firing_pin(src)
	INITIALIZE(firing_pin)
	GENERATE(firing_pin)
	FINALIZE(firing_pin)
	battery = new /obj/item/powercell/dummy(src)
	INITIALIZE(battery)
	GENERATE(battery)
	FINALIZE(battery)
	return ..()
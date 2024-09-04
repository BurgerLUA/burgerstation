/obj/item/weapon/ranged/spellgem/blackflame
	name = "blackflame spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a single slow-moving high-damage unholy fireball that ignites targets and explodes already ignited targets."
	icon_state = "damage"

	rarity = RARITY_UNCOMMON

	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.6 - 1

	company_type = "Ashwalkers"

	projectile = /obj/projectile/magic/blackflame
	ranged_damage_type = /damagetype/ranged/magic/blackflame

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#404040"
	color_2 = "#FFFFFF"
	color_3 = "#000000"

	value = 800

/obj/item/weapon/ranged/spellgem/blackflame/get_base_value()
	. = ..()
	. += 600 //For the explosion + Ignite.

/obj/item/weapon/ranged/spellgem/blackflame/calculate_mana_cost()
	. = ..()
	. += 10 //For the explosion + Ignite.
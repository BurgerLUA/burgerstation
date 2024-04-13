/obj/item/weapon/ranged/spellgem/unholy_skull
	name = "unholy skull spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots an unholy skull that homes into its target, then explodes on contact."
	icon_state = "damage"

	rarity = RARITY_RARE

	shoot_delay = 20

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.3 - 1

	company_type = "Ashwalkers"

	projectile = /obj/projectile/magic/unholy_skull
	ranged_damage_type = /damagetype/ranged/magic/unholy_skull

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#303030"
	color_2 = "#7F0000"
	color_3 = "#7F0000"

	value = 800

/obj/item/weapon/ranged/spellgem/unholy_skull/get_base_value()
	. = ..()
	. += 400 //For the explosion + homing

/obj/item/weapon/ranged/spellgem/unholy_skull/calculate_mana_cost()
	. = ..()
	. += 10 //For the explosion + homing
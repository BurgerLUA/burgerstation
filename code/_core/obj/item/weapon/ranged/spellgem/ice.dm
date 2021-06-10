/obj/item/weapon/ranged/spellgem/ice_spear
	name = "ice spear spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a fast moving ice crystal that pierces."
	icon_state = "damage"

	cost_mana = 15
	shoot_delay = 8

	bullet_count = 1
	projectile_speed = TILE_SIZE - 1

	projectile = /obj/projectile/magic/crystal/ice
	ranged_damage_type = /damagetype/ranged/magic/ice

	shoot_sounds = list('sound/weapons/freeze.ogg')

	color = "#75C7FF"
	color_2 = "#5D8EAF"
	color_3 = "#C2FFFF"

	value = 800
/obj/item/weapon/ranged/spellgem/projectile_armor
	name = "reinforce other spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots an armor creating blast. ."
	icon_state = "protection"
	color = "#a7007d"
	color_2 = "#500028"
	shoot_delay = 10

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	use_loyalty_tag = FALSE

	projectile_utility = TRUE
	mana_cost_override = 50

	projectile = /obj/projectile/magic/buff/armor
	ranged_damage_type = /damagetype/ranged/magic/buff //AKA no dmg

	shoot_sounds = list('sound/weapons/magic/magic_missile.ogg')
	value = 800
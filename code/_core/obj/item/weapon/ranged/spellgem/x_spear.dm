/obj/item/weapon/ranged/spellgem/ice_spear
	name = "ice spear spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a fast moving ice crystal that pierces."
	icon_state = "damage"

	company_type = "Ashwalkers"

	shoot_delay = 8

	bullet_count = 1
	projectile_speed = TILE_SIZE - 1

	projectile = /obj/projectile/magic/crystal/ice
	ranged_damage_type = /damagetype/ranged/magic/ice

	shoot_sounds = list('sound/weapons/ranged/energy/freeze_gun/shoot1.ogg')

	color = "#75C7FF"
	color_2 = "#5D8EAF"
	color_3 = "#C2FFFF"

	value = 800

/obj/item/weapon/ranged/spellgem/fire_spear
	name = "fire spear spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a fast moving accurate fire crystal can pierce."
	icon_state = "damage"

	company_type = "Ashwalkers"

	shoot_delay = 8

	bullet_count = 1
	projectile_speed = TILE_SIZE - 1

	projectile = /obj/projectile/magic/crystal/fire
	ranged_damage_type = /damagetype/ranged/magic/fire

	shoot_sounds = list('sound/weapons/ranged/energy/freeze_gun/shoot2.ogg')

	color = "#FF8E75"
	color_2 = "#AD6C5D"
	color_3 = "#FFEAC4"

	value = 800
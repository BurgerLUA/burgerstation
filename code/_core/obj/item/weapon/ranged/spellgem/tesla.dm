/obj/item/weapon/ranged/spellgem/tesla
	name = "tesla spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a slow moving tesla ball that shoots at and follows nearby enemies."
	icon_state = "damage"

	shoot_delay = 30

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.1 - 1

	projectile = /obj/projectile/magic/tesla
	ranged_damage_type = /damagetype/ranged/magic/tesla

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#FFFFFF"
	color_2 = "#E0F2FF"
	color_3 = "#8B969E"

	value = 800

	rarity = RARITY_MYTHICAL

/obj/item/weapon/ranged/spellgem/tesla/get_base_value()
	. = ..()
	. *= 8

/obj/item/weapon/ranged/spellgem/tesla/get_base_mana_cost()
	. = ..()
	. *= 8
/obj/item/weapon/ranged/spellgem/lightning
	name = "lightning bolt spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a fast moving lightning bolt that chains."
	icon_state = "damage"
	cost_mana = 16
	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE - 1

	projectile = /obj/projectile/magic/lightning_bolt
	ranged_damage_type = /damagetype/ranged/magic/lightning

	color = "#FFD846"
	color_2 = "#C6FFE1"
	color_3 = "#FFFFBE"

	shoot_sounds = list('sound/weapons/magic/zap_large.ogg')
	value = 800
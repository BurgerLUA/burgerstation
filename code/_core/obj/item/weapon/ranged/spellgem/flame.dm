/obj/item/weapon/ranged/spellgem/flame
	name = "flame stream spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a cone of igniting flames."
	icon_state = "damage"

	cost_mana = 10
	shoot_delay = 2

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.3 - 1

	projectile = /obj/projectile/magic/lesser_fire
	ranged_damage_type = /damagetype/ranged/magic/flame

	shoot_sounds = list('sound/weapons/magic/firestream.ogg')

	color = "#FF934A"
	color_2 = "#FF521F"
	color_3 = "#FF521F"

	value = 800
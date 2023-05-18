/obj/item/weapon/ranged/spellgem/frost
	name = "frost spray spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a stream of slowing frost."
	icon_state = "damage"

	shoot_delay = 3

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/frost
	ranged_damage_type = /damagetype/ranged/magic/frost

	shoot_sounds = list('sound/weapons/magic/frost.ogg')

	color = "#0094FF"
	color_2 = "#77C6FF"
	color_3 = "#4D82A8"

	value = 800
/obj/item/weapon/ranged/spellgem/shock
	name = "shock stream spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a short stream of lightning."
	icon_state = "damage"

	shoot_delay = 5

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/lightning

	ranged_damage_type = /damagetype/ranged/magic/shock

	color = "#FFB600"
	color_2 = "#FFE566"
	color_3 = "#FFD800"

	shoot_sounds = list('sound/effects/zzzt.ogg')
	value = 800
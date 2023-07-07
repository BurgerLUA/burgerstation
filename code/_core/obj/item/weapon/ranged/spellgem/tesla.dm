/obj/item/weapon/ranged/spellgem/tesla
	name = "tesla bolt spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots a tesla bolt."
	icon_state = "damage"

	projectile = /obj/projectile/magic/tesla_bolt // The projectile for this projectile to shoot when near valid targets.
	ranged_damage_type = /damagetype/ranged/magic/tesla_shock
	shoot_delay = 5 //The delay in which the projectile can shoot.

	projectile_speed = TILE_SIZE*0.3 - 1
	shoot_sounds = list('sound/effects/tesla.ogg')

	color = "#FFFFFF"
	color_2 = "#E0F2FF"
	color_3 = "#8B969E"

	value = 800

	rarity = RARITY_UNCOMMON
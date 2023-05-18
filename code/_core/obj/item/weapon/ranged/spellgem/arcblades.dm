/obj/item/weapon/ranged/spellgem/arcblades
	name = "arcblades spell gem"
	desc = "The source of all magic."
	desc_extended = "A magical gem filled with pure arcane energy that gives the user the ability to cast spells. Can be augmented onto wands. This one shoots two spinning arc blades that pierces enemies and bounces off walls."
	icon_state = "damage"

	shoot_delay = 20

	bullet_count = 2
	projectile_speed = TILE_SIZE*0.5 - 1

	projectile = /obj/projectile/magic/arcblade
	ranged_damage_type = /damagetype/ranged/magic/arcblade

	shoot_sounds = list('sound/weapons/magic/arc_blade.ogg')

	color = "#FFFFFF"
	color_2 = "#00FFFF"
	color_3 = "#008CFF"

	value = 800

	spread_per_shot = 20
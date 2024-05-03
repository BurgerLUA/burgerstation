/obj/item/weapon/ranged/spellgem/fireball
	name = "firebolt spell gem"
	desc = "The source of all magic."
	desc_extended = "Shoots a single high-damage bolt of fire that can ignite."
	icon_state = "damage"

	rarity = RARITY_UNCOMMON

	shoot_delay = 35

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.8 - 1

	projectile = /obj/projectile/magic/fireball
	ranged_damage_type = /damagetype/ranged/magic/fireball

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	color = "#FF6A00"
	color_2 = "#FF0000"
	color_3 = "#FFD800"

	value = 800

	rarity = RARITY_UNCOMMON
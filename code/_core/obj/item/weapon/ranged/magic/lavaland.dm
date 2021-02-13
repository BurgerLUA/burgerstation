/obj/item/weapon/ranged/magic/staff/lavaland
	name = "staff of lava"
	desc = "You can also use it to reheat soup in a pinch."
	desc_extended = "A special staff that shoots special lava projectiles that temporarily create pits of lava. Allies and the caster are immune to it."

	icon = 'icons/obj/item/weapons/ranged/magic/lavaland.dmi'

	shoot_delay = 30

	cost_charge = 500
	total_charge = 5000

	bullet_count = 1
	projectile_speed = 8

	projectile = /obj/projectile/magic/fireball/lava/
	ranged_damage_type = /damagetype/ranged/magic/fireball

	shoot_sounds = list('sound/weapons/magic/fireball.ogg')

	value = 2000

	rarity = RARITY_RARE


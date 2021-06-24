/obj/item/bullet_cartridge/gauss
	name = "\improper 2x12mm steel ball gauss cartridge"
	desc = "I've got balls of steel."
	desc_extended = "A steel ball attached to an overcharged tri-lithium battery. For use in gauss weapons."
	rarity = RARITY_RARE
	icon = 'icons/obj/item/bullet/gauss.dmi'

	bullet_diameter = 2
	bullet_length = 12
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/pistol/stealth
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun

	projectile_speed = TILE_SIZE-1

	size = 0.04
	value = 50


/obj/item/bullet_cartridge/gauss/surplus
	name = "\improper surplus 2x12mm steel ball gauss cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/surplus
	jam_chance = 1
	value = 0

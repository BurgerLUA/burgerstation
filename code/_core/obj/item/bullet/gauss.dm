/obj/item/bullet_cartridge/gauss
	name = "\improper 2.54x12mm Gauss cartridge"
	desc = "I've got balls of steel."
	desc_extended = "A material ball attached to an overcharged tri-lithium battery. For use in gauss weapons."
	icon = 'icons/obj/item/bullet/gauss.dmi'

	bullet_diameter = 2.54
	bullet_length = 12
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/pistol/stealth
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun

	projectile_speed = TILE_SIZE-1

	size = 0.04
	value = 50

/obj/item/bullet_cartridge/gauss/ap
	name = "\improper 2.54x12mm depleted uranium ball gauss cartridge"
	icon = 'icons/obj/item/bullet/gauss_ap.dmi'
	rarity = RARITY_UNCOMMON
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/ap
	value = 80
	penetrations = 3

/obj/item/bullet_cartridge/gauss/explosive
	name = "\improper 2.54x12mm compressed gibtonite ball gauss cartridge"
	icon = 'icons/obj/item/bullet/gauss_explosive.dmi'
	rarity = RARITY_UNCOMMON
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/explosive
	value = 80

/obj/item/bullet_cartridge/gauss/ion
	name = "\improper 2.54x12mm iron-uranium alloy ball gauss cartridge"
	icon = 'icons/obj/item/bullet/gauss_ion.dmi'
	rarity = RARITY_UNCOMMON
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/ion
	value = 80

/obj/item/bullet_cartridge/gauss/incendiary
	name = "\improper 2.54x12mm compressed napalm ball gauss cartridge"
	icon = 'icons/obj/item/bullet/gauss_incendiary.dmi'
	rarity = RARITY_UNCOMMON
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/incendiary
	value = 80

/obj/item/bullet_cartridge/gauss/surplus
	name = "\improper surplus 2.54x12mm pig iron ball gauss cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/gauss_gun/surplus
	jam_chance = 1
	value = 0
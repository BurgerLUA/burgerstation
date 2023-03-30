/obj/item/bullet_cartridge/sniper_127
	name = "\improper 12.7x90mm sniper round"
	desc = "For when you want to shoot something so hard their family will feel it too."
	desc_extended = "For sniper rifles that require 12.7x90mm ammo."
	icon = 'icons/obj/item/bullet/127_mm.dmi'


	bullet_diameter = 12.7
	bullet_length = 90
	bullet_color = COLOR_BULLET

	amount_max = 4
	amount_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.09

	penetrations = 2

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/sniper_127/surplus
	name = "\improper surplus 12.7x90mm sniper round"
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/sniper_127/ap
	name = "\improper AP 12.7x90mm sniper round"
	desc = "For when you want to shoot someone's armor so hard their family will feel it too."
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127/ap
	rarity = RARITY_UNCOMMON

/obj/item/bullet_cartridge/sniper_127/premium //incase you want someone extremely dead.
	name = "\improper premium 12.7x90mm sniper round"
	desc = "For when you want to shoot something so hard everone feels it."
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127/premium
	rarity = RARITY_RARE

/obj/item/bullet_cartridge/sniper_127/du //incase you want someone EXTREMELY dead.
	name = "\improper DU 12.7x90mm sniper round"
	desc = "For when you want to shoot something so hard everone slumps over in pain."
	rarity = RARITY_RARE
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127/du
	penetrations = 3

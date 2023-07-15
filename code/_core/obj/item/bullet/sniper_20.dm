/obj/item/bullet_cartridge/sniper_20
	name = "\improper 20x117mm sniper round"
	desc = "For when you really want something to die."
	desc_extended = "For guns that require 20x117mm ammo."
	icon = 'icons/obj/item/bullet/20mm.dmi'

	bullet_diameter = 20
	bullet_length = 117
	bullet_color = COLOR_BULLET

	amount_max = 4
	amount_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.2

	penetrations = 3

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/sniper_20/surplus
	name = "\improper surplus 20x117mm sniper round"
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/sniper_20/du
	name = "\improper DU 20x117mm sniper round"
	desc_extended = "For guns that require 20x117mm ammo. This one has a depleted uranium tip."
	rarity = RARITY_RARE
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20/du

/obj/item/bullet_cartridge/sniper_20/hei
	name = "\improper HEI 20x117mm sniper round"
	desc = "For when you absolutely, positively, without a doubt want something to die."
	desc_extended = "For guns that require 20x117mm ammo. This one is packed with explosives and an incendiary mixture. Its payload makes cycling unreliable, however."
	rarity = RARITY_RARE
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20/hei
	jam_chance = 25
	penetrations = 0

/obj/item/bullet_cartridge/sniper_20/hei/sap
	name = "\improper SAPHEI 20x117mm sniper round"
	desc_extended = "For guns that require 20x117mm ammo. This one is packed with explosives, an incendiary mixture and a tungsten penetrator. Its payload makes cycling unreliable, however."
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20/hei/sap

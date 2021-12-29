/obj/item/bullet_cartridge/pistol_10mm/
	name = "\improper 10mm pistol cartridge"
	desc = "At least 1mm bigger than 9mm"
	desc_extended = "For pistols, revolvers, and smgs that require 10mm auto ammo."
	icon = 'icons/obj/item/bullet/10mm.dmi'

	item_count_max = 6
	item_count_max_icon = 6

	bullet_diameter = 10.17
	bullet_length = 32
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_10mm

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.02
	value = 1

/obj/item/bullet_cartridge/pistol_10mm/surplus
	name = "\improper surplus 10mm pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_10mm/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_10mm/ap
	name = "\improper AP 10mm pistol cartridge"
	desc_extended = "For pistols, revolvers, and smgs that require 10mm auto ammo. This one has an armor piercing tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/10mm_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_10mm/ap

	size = 0.02
	value = 2

	penetrations = 1

/obj/item/bullet_cartridge/pistol_50
	name = "\improper .50 pistol cartridge"
	desc = "The cool kids use this."
	desc_extended = "For pistols that require .50."
	icon = 'icons/obj/item/bullet/50ae.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	bullet_diameter = 12.7
	bullet_length = 33
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/revolver/
	damage_type_bullet = /damagetype/ranged/bullet/pistol_50

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	value = 1.3

/obj/item/bullet_cartridge/pistol_50/surplus
	name = "\improper surplus .50 pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_50/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_50/ap
	name = "\improper AP .50 pistol cartridge"
	desc_extended = "For pistols that require .50. This one has an armor piercing tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/50ae_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_50/ap

	value = 2.6

	penetrations = 1

/obj/item/bullet_cartridge/pistol_50/heartbreaker
	name = "\improper heartbreaker .50 pistol cartridge"
	desc_extended = "For pistols that require .50. This one has an armor piercing tip with an exploding shrapnel bullet."
	rarity = RARITY_RARE
	icon = 'icons/obj/item/bullet/50ae_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_50/heartbreaker

	value = 6

/obj/item/bullet_cartridge/pistol_12mm/
	name = "\improper 12.7mm pistol catridge"
	desc = "The pistol round of the future, today!"
	desc_extended = "For pistols, revolvers, and smgs that require 12.7mm ammo."
	icon = 'icons/obj/item/bullet/12mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	bullet_diameter = 12.7
	bullet_length = 33
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/revolver
	damage_type_bullet = /damagetype/ranged/bullet/pistol_12mm

	projectile_speed = BULLET_SPEED_PISTOL_HEAVY

	size = 0.025
	value = 1.2

/obj/item/bullet_cartridge/pistol_12mm/surplus
	name = "\improper surplus 12.7mm pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_12mm/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_12mm/ap
	name = "\improper AP 12.7mm pistol catridge"
	desc_extended = "For pistols, revolvers, and smgs that require 12.7mm ammo. This has an armor piercing tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/12mm_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_12mm/ap

	value = 2.4

	penetrations = 1

/obj/item/bullet_cartridge/pistol_9mm/
	name = "\improper 9mm pistol cartridge"
	desc = "The average bullet for the average shooter."
	desc_extended = "For pistols, revolvers, and smgs that require 9mm ammo."
	icon = 'icons/obj/item/bullet/9mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 9
	bullet_length = 19
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_9mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	value = 0.9

/obj/item/bullet_cartridge/pistol_9mm/surplus
	name = "\improper surplus 9mm pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_9mm/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_9mm/ap
	name = "\improper AP 9mm pistol cartridge"
	desc_extended = "For pistols, revolvers, and smgs that require 9mm ammo. This one has an armor piercing tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/9mm_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_9mm/ap

	value = 1.8

	penetrations = 1

/obj/item/bullet_cartridge/pistol_4mm/
	name = "\improper 4.6x30mm smg cartridge"
	desc = "Pierces armor like butter."
	desc_extended = "For smgs that require 4.6x30mm ammo."
	icon = 'icons/obj/item/bullet/46mm.dmi'

	item_count_max = 5
	item_count_max_icon = 5


	bullet_diameter = 4.6
	bullet_length = 30
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm

	projectile_speed = TILE_SIZE - 1 //fast as fuck booooooooooi

	size = 0.01
	value = 0.4


/obj/item/bullet_cartridge/pistol_4mm/toxin
	name = "\improper toxin 4.6x30mm smg cartridge"
	rarity = RARITY_UNCOMMON
	caseless = TRUE

	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/toxin

	value = 0.5

/obj/item/bullet_cartridge/pistol_4mm/ion
	name = "\improper ion 4.6x30mm smg cartridge"
	rarity = RARITY_UNCOMMON
	caseless = TRUE

	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/ion

	value = 0.5

/obj/item/bullet_cartridge/pistol_4mm/ap
	name = "\improper AP 4.6x30mm smg cartridge"
	rarity = RARITY_UNCOMMON
	caseless = TRUE

	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/ap

	value = 0.5

	penetrations = 1

/obj/item/bullet_cartridge/pistol_4mm/incendiary
	name = "\improper incendiary 4.6x30mm smg cartridge"
	rarity = RARITY_UNCOMMON
	caseless = TRUE

	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/incendiary

	value = 0.5

/obj/item/bullet_cartridge/pistol_4mm/surplus
	name = "\improper surplus 4.6x30mm pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_4mm/caseless
	name = "\improper 4.6x30mm caseless smg cartridge"
	rarity = RARITY_UNCOMMON
	caseless = TRUE
	value = 0.5

/obj/item/bullet_cartridge/pistol_4mm/caseless/surplus
	name = "\improper surplus 4.6x30mm caseless pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/smg_4mm/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_40/
	name = "\improper .40 pistol cartridge"
	desc = "Different than 9mm!"
	desc_extended = "For pistols, revolvers, and smgs that require .40 ammo."
	icon = 'icons/obj/item/bullet/40.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	bullet_diameter = 10
	bullet_length = 22
	bullet_color = COLOR_BULLET


	projectile = /obj/projectile/bullet/firearm/pistol
	damage_type_bullet = /damagetype/ranged/bullet/pistol_40

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	value = 1

/obj/item/bullet_cartridge/pistol_40/surplus
	name = "\improper surplus .40 pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_40/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_40/ap
	name = "\improper AP .40 pistol cartridge"
	desc = "Different than 9mm!"
	desc_extended = "For pistols, revolvers, and smgs that require .40 ammo. This one has a steel tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/40_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_40/ap

	value = 2

	penetrations = 1

/obj/item/bullet_cartridge/pistol_40/tranq
	name = "\improper tranq .40 pistol cartridge"
	desc = "Different than 9mm!"
	desc_extended = "For pistols, revolvers, and smgs that require .40 ammo. This one has a chemical casing with sedatives in it."
	rarity = RARITY_RARE
	icon = 'icons/obj/item/bullet/40_tranq.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_40/tranq

	value = 6

	jam_chance = 100 //Required.

/obj/item/bullet_cartridge/pistol_40/tranq/surplus
	name = "\improper surplus tranq .40 pistol cartridge"
	rarity = RARITY_UNCOMMON
	damage_type_bullet = /damagetype/ranged/bullet/pistol_40/tranq/surplus
	misfire_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_45/
	name = "\improper .45 pistol catridge"
	desc = "Can't go wrong with the classics."
	desc_extended = "For pistols and smgs that requre .45 ammo."
	icon = 'icons/obj/item/bullet/45.dmi'

	item_count_max = 6
	item_count_max_icon = 6

	bullet_diameter = 11.43
	bullet_length = 23
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/smg
	damage_type_bullet = /damagetype/ranged/bullet/pistol_45

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.015
	value = 1.5

/obj/item/bullet_cartridge/pistol_45/surplus
	name = "\improper surplus .45 pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/pistol_45/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_45/Generate()
	item_count_current = 6
	update_sprite()
	return ..()

/obj/item/bullet_cartridge/pistol_45/ap
	name = "\improper AP .45 pistol catridge"
	desc_extended = "For pistols and smgs that requre .45 ammo. This one has an armor piercing tip."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/45_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/pistol_45/ap

	value = 1.5

	penetrations = 1

/obj/item/bullet_cartridge/pistol_45holy/
	name = "\improper Holy .45 pistol cartridge"
	desc = "Joshua Graham style."
	desc_extended = "For pistols and smgs that require holy .45 ammo."
	icon = 'icons/obj/item/bullet/holy45.dmi'

	item_count_max = 6
	item_count_max_icon = 6

	bullet_diameter = 11.777
	bullet_length = 24
	bullet_color = COLOR_SILVER

	projectile = /obj/projectile/bullet/firearm/smg
	damage_type_bullet = /damagetype/ranged/bullet/holybullet

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.015
	value = 2

/obj/item/bullet_cartridge/pistol_45holy/surplus
	name = "\improper surplus Holy .45 pistol cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/holybullet/surplus
	jam_chance = 1
	value = 0

/obj/item/bullet_cartridge/pistol_45holy/Generate()
	item_count_current = 6
	update_sprite()
	return ..()

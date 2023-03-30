/obj/item/bullet_cartridge/rifle_223
	name = "\improper .223 rifle bullet"
	desc = "The round of choice for soldier cosplayers."
	desc_extended = "For rifles and machineguns that requre .223."
	icon = 'icons/obj/item/bullet/223.dmi'

	bullet_diameter = 5.56
	bullet_length = 45
	bullet_color = COLOR_BULLET

	amount_max = 5
	amount_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_223

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	size = 0.03

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/rifle_223/surplus
	name = "\improper surplus .223 rifle cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/rifle_223/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/rifle_223/ap
	name = "\improper .223 AP rifle bullet"
	rarity = RARITY_UNCOMMON
	desc_extended = "For rifles and machineguns that requre .223. This one has an armor piercing tip."
	icon = 'icons/obj/item/bullet/223_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/rifle_223/ap

	size = 0.03

	penetrations = 1

/obj/item/bullet_cartridge/rifle_223/du
	name = "\improper .223 DU rifle bullet"
	desc_extended = "For rifles that require .223. This one has a depleted uranium tip."
	rarity = RARITY_RARE
	damage_type_bullet = /damagetype/ranged/bullet/rifle_223/du
	projectile_speed = BULLET_SPEED_RIFLE_HEAVY
	penetrations = 2


/obj/item/bullet_cartridge/rifle_223/nato
	name = "\improper 5.56mm rifle bullet"
	desc = "The poodle shooter's favorite."
	desc_extended = "For rifles and machineguns that requre 5,56mm."
	rarity = RARITY_COMMON

	amount_max = 5
	amount_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

/obj/item/bullet_cartridge/rifle_223/nato/surplus
	name = "\improper surplus 5.56mm rifle bullet"
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm/surplus
	jam_chance = 1
	rarity = RARITY_BROKEN

/obj/item/bullet_cartridge/rifle_223/nato/premium
	name = "\improper premium 5.56mm rifle bullet"
	rarity = RARITY_RARE
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm/premium

/obj/item/bullet_cartridge/rifle_223/nato/caseless
	name = "\improper 5.56mm caseless rifle bullet"
	desc = "The poodle shooter's favorite. Now in caseless!"
	desc_extended = "For rifles and machineguns that requre 5,56mm. This doesn't leave a case."
	rarity = RARITY_UNCOMMON

	amount_max = 5
	amount_max_icon = 5

	projectile = /obj/projectile/bullet/firearm/rifle
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	caseless = TRUE

/obj/item/bullet_cartridge/rifle_223/caseless/surplus
	name = "\improper surplus 5.56mm rifle bullet"
	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm/surplus
	jam_chance = 1
	value = 0
	rarity = RARITY_BROKEN



/obj/item/bullet_cartridge/rifle_223/nato/ap
	name = "\improper 5.56mm AP rifle bullet"
	rarity = RARITY_UNCOMMON
	desc_extended = "For rifles and machineguns that requre 5,56mm. This one has an armor piercing tip."
	icon = 'icons/obj/item/bullet/223_ap.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/rifle_556mm/ap

	size = 0.03

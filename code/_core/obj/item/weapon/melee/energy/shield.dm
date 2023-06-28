/obj/item/weapon/melee/energy/shield/
	name = "energy shield"
	desc = "A shield made out of ENERGY. Please do not sue."
	icon = 'icons/obj/item/weapons/melee/laser/shield_new.dmi'
	icon_state = "inventory"

	damage_type = /damagetype/melee/club/shield/energy
	damage_type_on = /damagetype/melee/club/shield/energy/on

	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#FFFFFF",
		"shield" = "#65B4FD"
	)

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.9,
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0.9,
		ATTACK_TYPE_MAGIC = 0
	)

	weight = 2
	size = SIZE_2

	value = 1000

	dan_mode = TRUE

	rarity = RARITY_RARE

/obj/item/weapon/melee/energy/shield/syndicate
	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#FFFFFF",
		"shield" = "#DD352B"
	)
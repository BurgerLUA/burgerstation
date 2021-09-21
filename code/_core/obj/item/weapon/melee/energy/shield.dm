/obj/item/weapon/melee/energy/shield/
	name = "energy shield"
	desc = "A shield made out of ENERGY. Please do not sue."
	icon = 'icons/obj/item/weapons/melee/laser/shield.dmi'

	damage_type = /damagetype/melee/club/shield/energy
	damage_type_on = /damagetype/melee/club/shield/energy/on

	value = 500

	dan_mode = TRUE

	polymorphs = list(base = "#FFFFFF")

	block_defense = list(
		ATTACK_TYPE_UNARMED = 0.5,
		ATTACK_TYPE_MELEE = 0.75,
		ATTACK_TYPE_RANGED = 0.75,
		ATTACK_TYPE_MAGIC = 0
	)

	weight = 2
	size = SIZE_2

	value = 1000

/obj/item/weapon/melee/energy/shield/blue
	polymorphs = list(base = "#0000FF")

/obj/item/weapon/melee/energy/shield/green
	polymorphs = list(base = "#00FF00")

/obj/item/weapon/melee/energy/shield/red
	polymorphs = list(base = "#FF0000")

/obj/item/weapon/melee/energy/shield/yellow
	polymorphs = list(base = "#FFFF00")

/obj/item/weapon/melee/energy/shield/classic
	polymorphs = list(base = "#5EB9FF")
/obj/item/weapon/melee/null_rod
	name = "null rod"
	desc = "A holy null rod meant to dispel evil. Works as a great club too. Has the ability to block magic."
	icon = 'icons/obj/items/weapons/melee/clubs/nullrod.dmi'

	block_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "stunbaton_off"


/obj/item/weapon/melee/null_rod/staff
	name = "null staff"
	desc = "A long, lightweight piece of blessed ceramic designed to show religious authority in the form of robust beatings. Has the ability to block magic exceptionally well.."
	icon = 'icons/obj/items/weapons/melee/clubs/nullstaff.dmi'

	block_mul = list(
		ATTACK_TYPE_MELEE = 2,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "stunbaton_off"


/obj/item/weapon/melee/null_rod/dagger
	name = "null dagger"
	desc = "A short holy dagger that is somehow legal for a priest to carry around openly. Has the ability to block magic, and is also good for parrying attacks."
	icon = 'icons/obj/items/weapons/melee/clubs/nullathame.dmi'

	block_mul = list(
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 2,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "stunbaton_off"
/obj/item/weapon/melee/baton
	name = "harmbaton"
	desc = "A classic wooden baton."
	icon = 'icons/obj/items/weapons/melee/clubs/baton.dmi'
	damage_type = "stunbaton_off"

	block_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 1,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "stunbaton_off"
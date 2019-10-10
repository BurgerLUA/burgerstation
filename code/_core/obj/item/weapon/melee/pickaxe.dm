/obj/item/weapon/melee/pickaxe
	name = "steel pickaxe"
	desc = "Useful for lobotomies."
	icon = 'icons/obj/items/weapons/melee/clubs/pickaxe_steel.dmi'

	block_mul = list(
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 1
	)

	parry_mul = list(
		ATTACK_TYPE_MELEE = 0.5,
		ATTACK_TYPE_RANGED = 0,
		ATTACK_TYPE_MAGIC = 0
	)

	damage_type = "pickaxe"

	flags_tool = FLAG_TOOL_PICKAXE

	tool_time = SECONDS_TO_DECISECONDS(2)
/obj/item/weapon/melee/energy/stunbaton
	name = "harmbaton"
	desc = "A stunbaton, except the stun setting is stuck on lethal."
	icon = 'icons/obj/items/weapons/melee/clubs/stunbaton.dmi'
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


/obj/item/weapon/melee/energy/stunbaton/click_self(var/atom/caller)
	. = ..()
	var/area/A = get_area(caller.loc)
	if(enabled)
		play_sound('sounds/weapon/melee/saberon.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
		damage_type = "stunbaton_on"
	else
		play_sound('sounds/weapon/melee/saberoff.ogg',all_mobs_with_clients,vector(caller.x,caller.y,caller.z),environment = A.sound_environment)
		damage_type = "stunbaton_off"

	return .
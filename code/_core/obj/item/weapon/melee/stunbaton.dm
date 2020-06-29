/obj/item/weapon/melee/energy/stunbaton
	name = "harmbaton"
	desc = "A stunbaton, except the stun setting is stuck on lethal."
	icon = 'icons/obj/item/weapons/melee/clubs/stunbaton.dmi'
	damage_type = /damagetype/melee/club/stunbaton

	attack_delay = 5
	attack_delay_max = 10

	value = 20

/obj/item/weapon/melee/energy/stunbaton/click_self(var/atom/caller)
	. = ..()
	if(enabled)
		play('sound/weapons/energy/energy_on.ogg',src)
		damage_type = /damagetype/melee/club/stunbaton/on
	else
		play('sound/weapons/energy/energy_off.ogg',src)
		damage_type = /damagetype/melee/club/stunbaton

	return .
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
		play(pick('sound/effects/sparks/sparks1.ogg','sound/effects/sparks/sparks2.ogg','sound/effects/sparks/sparks3.ogg','sound/effects/sparks/sparks4.ogg'),src)
		damage_type = /damagetype/melee/club/stunbaton/on
	else
		damage_type = /damagetype/melee/club/stunbaton

	return .
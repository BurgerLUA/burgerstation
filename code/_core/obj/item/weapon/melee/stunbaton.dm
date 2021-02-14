/obj/item/weapon/melee/energy/stunbaton
	name = "stunbaton"
	desc = "A stunbaton, except the stun setting is stuck on lethal."
	desc_extended = "A baton used by Private Security and Space Police. Remember to turn it on before applying it to someone's head, or it will just be a weighty stick."
	icon = 'icons/obj/item/weapons/melee/clubs/stunbaton.dmi'
	damage_type = /damagetype/melee/club/stunbaton

	value = 20

	size = SIZE_2

/obj/item/weapon/melee/energy/stunbaton/click_self(var/mob/caller)

	. = ..()

	if(.)
		if(enabled)
			play_sound(pick('sound/effects/sparks/sparks1.ogg','sound/effects/sparks/sparks2.ogg','sound/effects/sparks/sparks3.ogg','sound/effects/sparks/sparks4.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
			damage_type = /damagetype/melee/club/stunbaton/on
		else
			damage_type = /damagetype/melee/club/stunbaton

	return .
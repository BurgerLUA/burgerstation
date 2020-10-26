/obj/item/weapon/melee/mezzaluna
	name = "mezzaluna"
	rarity = RARITY_UNCOMMON
	desc = "Haha, razor go schlurrk."
	desc_extended = "A massive razor blade-like sword, wielded from horozontal handles mounted on either sides of the blade. Devestating when used with chopping attacks, though nigh useless for any other swing."
	icon = 'icons/obj/item/weapons/melee/swords/mezzaluna.dmi'
	damage_type = /damagetype/melee/sword/mezzaluna

	can_wield = TRUE
	wield_only = TRUE

	value = 80

	drop_sound = 'sound/items/drop/axe.ogg'

	size = SIZE_4
	weight = 20

/obj/item/weapon/melee/mezzaluna/should_cleave(var/atom/attacker,var/atom/victim,var/list/params)

	if(wielded)
		return TRUE

	return ..()
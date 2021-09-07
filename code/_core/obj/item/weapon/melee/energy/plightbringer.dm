/obj/item/weapon/melee/energy/plightbringer
	name = "\improper Plightbringer's Sword"
	desc = "A large black steel straightsword with a decorated hilt."
	desc_extended = "A large decorated black steel straightsword. While black steel holds sorceries and magical infusions better than most metals, it is difficult to retain its sharpness. Because of this, Battlemages are the most common to use weapons made with the metal."
	icon = 'icons/obj/item/weapons/melee/swords/plightbringer.dmi'

	value = 2500
	rarity = RARITY_RARE

	damage_type = /damagetype/melee/sword/plightbringer
	damage_type_on = /damagetype/melee/sword/plightbringer/on

	size = SIZE_4
	weight = 25

/obj/item/weapon/melee/energy/plightbringer/click_self(var/mob/caller)

	. = ..()

	if(.)
		SPAM_CHECK(20)
		if(enabled)
			play_sound('sound/weapons/magic/ash.ogg',get_turf(src),range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/magic/ash.ogg',get_turf(src),range_max=VIEW_RANGE)

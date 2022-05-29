/obj/item/weapon/melee/energy/sword/
	name = "energy sword"
	desc = "A blade made out of ENERGY. Please do not sue."
	desc_extended = "A lightweight energy blade that has become the standard issue melee pretty much everywhere. It's main issue is that it's not usable as a bayonet due to it's lack of weight and it's complex mechanisms."
	icon = 'icons/obj/item/weapons/melee/laser/sword.dmi'

	value = 400

	damage_type = /damagetype/melee/sword/energy
	damage_type_on = /damagetype/melee/sword/energy/on

	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FFFFFF",
		"core" = "#FFFFFF"
	)

	weight = 5
	size = SIZE_2

/obj/item/weapon/melee/energy/sword/click_self(var/mob/caller)

	. = ..()

	if(.)
		SPAM_CHECK(20)
		if(enabled)
			play_sound('sound/weapons/energy/energy_on.ogg',get_turf(src),range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/energy/energy_off.ogg',get_turf(src),range_max=VIEW_RANGE)


/obj/item/weapon/melee/energy/sword/blue
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#0000FF",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/green
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#00FF00",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/red
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FF0000",
		"core" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/yellow
	polymorphs = list(
		"base" = "#FFFFFF",
		"blade" = "#FFFF00",
		"core" = "#FFFFFF"
	)
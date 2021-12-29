/obj/item/weapon/melee/energy/sword/katana
	name = "high frequency blade"
	icon = 'icons/obj/item/weapons/melee/laser/katana.dmi'
	color = "#FFFFFF"

	damage_type = /damagetype/melee/sword/energy_katana
	damage_type_on = /damagetype/melee/sword/energy_katana/on

	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#A5FF7F",
		"blade" = "#4CFF00"
	)

/obj/item/weapon/melee/energy/sword/katana/black
	polymorphs = list(
		"base" = "#FFFFFF",
		"core" = "#000000",
		"blade" = "#FFFFFF"
	)

/obj/item/weapon/melee/energy/sword/katana/merc
	polymorphs = list(
		"base" = "#415252",
		"core" = "#F9FDFE",
		"blade" = "#BACADC"
	)
	size = SIZE_3
	weight = 12

/obj/item/weapon/melee/energy/sword/katana/merc/click_self(var/mob/caller)
	return TRUE

/obj/item/weapon/melee/energy/sword/katana/merc/Initialize()
	enabled = TRUE
	update_sprite()
	. = ..()
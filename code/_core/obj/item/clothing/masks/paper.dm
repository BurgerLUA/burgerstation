/obj/item/clothing/mask/paper
	name = "paper mask"
	icon = 'icons/obj/item/clothing/masks/paper.dmi'
	desc = "For special people, like you!"
	desc_extended = "Can change the design by clicking on it in your hand."

	defense_rating = list(
		BLADE = 10,
		BLUNT = 10,
		PIERCE = 10,
		HOLY = -50,
		DARK = 50
	)

	size = SIZE_2


	value = 120

	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_WHITE,
		"1" = "#000000"

	)

/obj/item/clothing/mask/paper/Finalize()
	. = ..()
	update_inventory()

/obj/item/clothing/mask/paper/click_self(var/mob/caller)
	var/mob/C = caller
	if(C.attack_flags & CONTROL_MOD_DISARM && istype(src.loc,/obj/hud/inventory/organs/))
		INTERACT_CHECK
		var/choice = input("What do you want to change on \the [src.name]?","Design Selection") as null|anything in list("Logo")
		if(choice == "Logo")
			var/logomenu = list(
				"" = 0,
				"1" = 1,
				"2" = 2,
				"3" = 2,
				"4" = 4,
				"5" = 5,
				"6" = 6,
				"7" = 7,
				"8" = 8,
				"9" = 9,
				"10" = 10,
				"11" = 11,
				"12" = 12,
				"13" = 13,
				"14" = 14
			)
			INTERACT_CHECK
			choice = input("What do you want to change the design to?","Design Selection") as null|anything in logomenu
			if(choice)
				INTERACT_CHECK
				polymorphs = list(
				"base" = COLOR_WHITE,
				"[choice]" = "#000000"

				)
				caller.to_chat(span("notice","You change \the [src.name]'s logo."))
				update_icon()
		else
			caller.to_chat(span("notice","You decide not to change \the [src.name]'s design."))
			return TRUE
		update_sprite()
		return TRUE

	return ..()
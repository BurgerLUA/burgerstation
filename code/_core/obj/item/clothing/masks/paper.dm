/obj/item/clothing/mask/paper
	name = "paper mask"
	icon = 'icons/obj/item/clothing/masks/paper.dmi'
	desc = "For special people, like you!"
	desc_extended = "Can change the design by clicking on it in your hand."

	size = SIZE_2
	weight = 0

	value = 120

	dyeable = TRUE

	polymorphs = list(
		"base" = COLOR_WHITE,
		"1" = "#000000"
	)

/obj/item/clothing/mask/paper/Finalize()
	. = ..()
	update_sprite()

/obj/item/clothing/mask/paper/click_self(var/mob/caller,location,control,params)
	var/mob/C = caller
	if(C.attack_flags & CONTROL_MOD_DISARM && istype(src.loc,/obj/hud/inventory/organs/))
		INTERACT_CHECK
		var/choice = input("What do you want to change on \the [src.name]?","Design Selection") as null|anything in list("Logo") //removing this would make this not work
		if(choice == "Logo")
			var/logomenu = list( //lazy names, but...
				"blank" = 0,
				"neutral" = 1,
				"eyes" = 2,
				"closed" = 2,
				"heart" = 4,
				"0" = 5,
				"plus" = 6,
				"square" = 7,
				"target" = 8,
				"vertical" = 9,
				"horizontal" = 10,
				"x" = 11,
				"bug" = 12,
				"twoline" = 13,
				"mark" = 14
			)
			INTERACT_CHECK
			choice = input("What do you want to change the design to?","Design Selection") as null|anything in logomenu
			if(choice)
				INTERACT_CHECK
				polymorphs = list(
				"base" = COLOR_WHITE, //removing the colors from this would be a Bad Idea, and there's no point of reference for the colors
				"[choice]" = "#000000"

				)
				caller.to_chat(span("notice","You change \the [src.name]'s design."))
				update_icon() //what it doesn't do is remove the previous polymorphs until re-cryo. While the designs CAN look cool, this is unintended.
		else
			caller.to_chat(span("notice","You decide not to change \the [src.name]'s design."))
			return TRUE
		update_sprite()
		return TRUE

	return ..()

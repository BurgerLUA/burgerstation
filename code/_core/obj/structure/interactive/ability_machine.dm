/obj/structure/interactive/ability_machine
	name = "ability machine"
	desc = "It's science, I ain't gotta explain shit."
	desc_extended = "An almost magical genetic manipulation machine that practically grants the user superpowers. Customize your genetics here."

	icon = 'icons/obj/structure/ability_machine.dmi'
	icon_state = "ability_machine"

	density = TRUE

	pixel_x = -16

	pixel_y = 6

	var/debug = FALSE

/obj/structure/interactive/ability_machine/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	if(istype(object,/obj/item/disk/genetic/))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		SPAM_CHECK(10)
		if(!A.ckey)
			return TRUE //Weird but okay.

		var/obj/item/disk/genetic/D = object
		var/ability/B = D.data["ability"]
		if(!B)
			caller.to_chat(span("warning","\The [D.name] is empty..."))
			return TRUE

		var/savedata/client/globals/GD = GLOBALDATA(A.ckey)
		if(!GD.loaded_data["unlocked_abilities"])
			GD.loaded_data["unlocked_abilities"] = list()
		if("[B]" in GD.loaded_data["unlocked_abilities"]) //B is already a type.
			caller.to_chat(span("warning","You've already unlocked this ability!"))
			return TRUE

		GD.loaded_data["unlocked_abilities"] += "[B]" //B is already a type.
		caller.to_chat(span("notice","You have successfully unlocked [initial(B.name)]. It appears that the disk has vanished... darn anti-piracy lobbyists."))
		qdel(D)
		return TRUE

	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		SPAM_CHECK(10)
		show_ability_choices(caller,src)
		return TRUE

	. = ..()

/obj/structure/interactive/ability_machine/debug
	debug = TRUE
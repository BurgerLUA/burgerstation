/obj/item/tempering
	name = "tempering object"
	icon = 'icons/obj/item/tempering.dmi'
	icon_state = "error"

	var/obj/item/temper_whitelist //Type

	value = 0

	var/increase = 5
	var/minimum = 100
	var/maximum = 125

	var/uses_left = 1 //How many times can this object be used to improve something? Set to -1 for infinity.

	rarity = RARITY_UNCOMMON

/obj/item/tempering/save_item_data(var/mob/living/advanced/player/P, var/save_inventory=TRUE, var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("uses_left")

/obj/item/tempering/load_item_data_post(var/mob/living/advanced/player/P, var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("uses_left")

/obj/item/tempering/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Use alt+click to bypass confirmation prompts and to use on objects that hold inventory.")
	if(uses_left == -1)
		. += span("notice","There are <b>unlimited</b> uses left.")
	else if(uses_left <= 0)
		. += span("warning","There are no uses left.")
	else
		. += span("notice","There are <b>[uses_left]</b> uses left.")

/obj/item/tempering/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			if(can_temper(caller,object))
				on_temper(caller,object)
			return TRUE
		else if(!is_inventory(object))
			if(can_temper(caller,object))
				var/choice = input("Are you sure you want to temper \the [object.name]?","Alt+Click to skip this next time") as null|anything in list("Yes","No")
				if(choice == "Yes")
					INTERACT_CHECK
					INTERACT_CHECK_OBJECT
					on_temper(caller,object)
					return TRUE

	. = ..()

/obj/item/tempering/proc/can_temper(var/mob/caller,var/obj/item/I)

	//Check if there are uses.
	if(uses_left != -1 && uses_left <= 0)
		caller.to_chat(span("warning","The [src.name] has no uses left!"))
		return FALSE

	//Check if the object can save.
	if(!I.can_save)
		caller.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]! Try tempering the main part of this clothing set."))
		return FALSE

	//Check the type.
	var/is_valid_object = FALSE
	if(islist(temper_whitelist))
		for(var/k in temper_whitelist)
			if(!istype(I,k))
				continue
			is_valid_object = TRUE
			break
	else if(istype(I,temper_whitelist))
		is_valid_object = TRUE

	if(!is_valid_object)
		caller.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]!"))
		return FALSE

	return TRUE

/obj/item/tempering/proc/on_temper(var/mob/caller,var/obj/item/I)

	caller.visible_message(
		span("notice","\The [caller.name] improves \the [I.name] with \the [src.name]."),
		span("notice","You improve \the [I.name] with \the [src.name].")
	)

	if(is_clothing(I))
		var/obj/item/clothing/C = I
		C.sync_additional_clothing()

	if(uses_left > 0)
		uses_left--
		if(uses_left <= 0)
			qdel(src)

	return TRUE



/obj/item/tempering
	name = "tempering object"
	icon = 'icons/obj/item/tempering.dmi'
	icon_state = "error"

	var/obj/item/temper_whitelist //Type

	value = -1

	var/increase = 5
	var/limit = 125
	var/minimum = 100

	value_burgerbux = 1 //Prevents being sold in vendors.

	var/unlimited = FALSE
	var/left = 5 //How much qual can this item improve before breaking?

	rarity = RARITY_UNCOMMON

/obj/item/tempering/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object) && can_temper(caller,object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		if(caller.attack_flags & CONTROL_MOD_DISARM)
			on_temper(caller,object)
			return TRUE
		else
			var/choice = input("Do you want to temper \the [object.name]?","Alt+Click to skip this next time") as null|anything in list("Yes","No")
			if(choice == "Yes")
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				on_temper(caller,object)
				return TRUE

	return ..()

/obj/item/tempering/proc/can_temper(var/mob/caller,var/obj/item/I)

	if(!istype(I,temper_whitelist))
		caller.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]!"))
		return FALSE

	if(!I.can_save)
		caller.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]! Try tempering the main part of this clothing set."))
		return FALSE

	return TRUE

/obj/item/tempering/proc/on_temper(var/mob/caller,var/obj/item/I)
	visible_message("\The [caller.name] improves \the [I.name] with \the [src.name].")
	if(is_clothing(I))
		var/obj/item/clothing/C = I
		C.sync_additional_clothing()
	if(unlimited)
		left = increase
		return TRUE
	if(left <= 0)
		qdel(src)
	return TRUE

/obj/item/tempering/save_item_data(mob/living/advanced/player/P, save_inventory, died)
	. = ..()
	SAVEVAR("left")
	
/obj/item/tempering/load_item_data_post(mob/living/advanced/player/P, list/object_data)
	. = ..()
	LOADVAR("left")
	
	
	
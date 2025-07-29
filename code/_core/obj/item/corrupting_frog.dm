/obj/item/corrupting_frog
	name = "corrupting frog"
	icon = 'icons/obj/item/corrupting_frog.dmi'
	icon_state = "inventory"
	desc = "One frog was harmed in the making of this item."
	desc_extended = "A magical wooden frog doll that has the abiltity to turn a weapon or clothing item into another similiar object, with unpredictable results..."
	rarity = RARITY_LEGENDARY
	value = 6000
	value_burgerbux = 1
	var/can_use = TRUE

/obj/item/corrupting_frog/click_on_object(var/mob/activator, var/atom/object, location, control, params)

	if(!is_item(object))
		return ..()

	var/obj/item/I = object

	if(!can_corrupt_target(activator,object))
		return TRUE

	var/choice = input("Are you sure you want to corrupt \the [I.name]? This may have unpredictable effects...","Corrupting Frog") as null|anything in list("Yes","No","Cancel")
	if(choice != "Yes")
		return ..()

	PROGRESS_BAR(activator,src,30,src::try_corrupt(),activator,I)
	PROGRESS_BAR_CONDITIONS(activator,src,src::can_corrupt_target(),activator,I)

	return TRUE


/obj/item/corrupting_frog/proc/can_corrupt_target(var/mob/activator,var/obj/item/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!can_use) //Prevents race conditions.
		return FALSE

	if(target.no_drop || !target.can_save || !target.can_corrupt)
		activator.to_chat(span("warning","You can't use \the [src.name] on \the [target.name]... perhaps try a different object."))
		return FALSE

	if(!isturf(target.loc))
		activator.to_chat(span("warning","Put \the [src.name] on the ground before trying to corrupt it!"))
		return FALSE

	return TRUE


/obj/item/corrupting_frog/proc/try_corrupt(var/mob/activator,var/obj/item/target)

	can_use = FALSE

	var/obj/item/corruption_result = target.corrupt()

	if(corruption_result)
		corruption_result.visible_message(span("warning","\The [target.name] transforms into \the [corruption_result.name]!"))
		play_sound('sound/weapons/magic/zap_large.ogg',get_turf(corruption_result))
		qdel(src)
	else
		can_use = TRUE
		activator.to_chat(span("warning","Corruption failed... perhaps try using this on a different object."))

	can_use = TRUE
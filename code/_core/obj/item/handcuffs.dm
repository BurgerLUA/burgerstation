/obj/item/handcuffs
	name = "handcuffs"
	desc = "Restrain someone with these."
	desc_extended = "Cheaply made metal handcuffs that anyone can really break out of with enough strength. To handcuff someone, click on them while this is in your hands. Handcuff speed is increased if the target is laying down."
	icon = 'icons/obj/item/handcuffs.dmi'
	icon_state = "inventory"
	var/strength = 1 //Multiplier required to resist out of them.

	value = 10

	weight = 1

	size = SIZE_1

/obj/item/handcuffs/click_on_object(var/mob/activator as mob,var/atom/object,location,control,params)

	if(ismob(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(!is_advanced(object))
			activator.to_chat(span("warning","You can't cuff this!"))
			return TRUE
		var/mob/living/advanced/A = object
		if(can_cuff(activator,A))
			A.visible_message(span("warning","\The [activator.name] starts to cuff \the [A.name]..."),span("danger","\The [activator.name] starts cuffing you!"))
			PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(5),src::cuff(),activator,A)
			PROGRESS_BAR_CONDITIONS(activator,src,src::can_cuff(),activator,A)
		return TRUE

	return ..()

/obj/item/handcuffs/proc/cuff(var/mob/activator,var/mob/living/advanced/target)
	target.visible_message(span("warning","\The [activator.name] finishes cuffing \the [target.name]."),span("danger","\The [activator.name] cuffs you!"))
	target.set_handcuffs(TRUE,src)
	return TRUE

/obj/item/handcuffs/proc/can_cuff(var/mob/activator,var/mob/living/advanced/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(target.handcuffed)
		activator.to_chat(span("warning","\The [target.name] is already handcuffed!"))
		return FALSE

	if(!src.loc || !is_inventory(src.loc))
		activator.to_chat(span("warning","You need to be holding \the [src.name] in order to cuff \the [target.name]!"))
		return FALSE

	var/obj/hud/inventory/I = src.loc

	if(!I.click_flags)
		activator.to_chat(span("warning","You need to be holding \the [src.name] in order to cuff \the [target.name]!"))
		return FALSE

	if(is_living(activator))
		var/mob/living/L = activator
		if(!allow_hostile_action(L.loyalty_tag,target))
			activator.to_chat(span("warning","You can't handcuff allies!"))
			return FALSE

	return TRUE

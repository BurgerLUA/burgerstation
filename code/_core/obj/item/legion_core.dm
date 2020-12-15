/obj/item/legion_core
	name = "legion core"
	desc = "Portable healing power."
	desc_extended = "A special regenerative yet decaying core that can be used to near-instantly restore the health of the target by a significant amount. One time use, and decays 10 minutes after being created."

	icon = 'icons/obj/item/legion_core.dmi'
	icon_state = "active"

	var/expiry_time = -1

/obj/item/legion_core/Generate()
	expiry_time = SECONDS_TO_DECISECONDS(600)
	return ..()

/obj/item/legion_core/Finalize()
	if(expiry_time == -1)
		expire()
	else
		CALLBACK("expire_\ref[src]",expiry_time,src,.proc/expire)
	return ..()

/obj/item/legion_core/proc/expire()
	expiry_time = -1
	update_sprite()
	return TRUE

/obj/item/legion_core/get_examine_list(var/mob/examiner)

	. = ..()

	if(expiry_time == -1)
		. += div("warning","It has expired.")

	return .

/obj/item/legion_core/update_icon()

	if(expiry_time == -1)
		icon_state = "inactive"
		name = "dull legion core"
	else
		icon_state = "active"
		name = "active legion core"

	return ..()

/obj/item/legion_core/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OTHER(object)

	if(expiry_time == -1)
		caller.to_chat(span("warning","\The [src.name] has expired!"))
		return TRUE

	if(!is_living(object))
		caller.to_chat(span("warning","\The [src.name] only works on living targets!"))
		return TRUE

	var/mob/living/L = object

	if(L.dead || !L.health)
		caller.to_chat(span("warning","\The [src.name] only works on living targets!"))
		return TRUE

	visible_message(span("notice","\The [caller.name] uses \the [src.name] to heal the wounds of \the [L.name]."))
	L.health.adjust_loss_smart(brute=-100,burn=-100,tox=-100,oxy=-100,pain=-100)
	L.to_chat(span("notice","You feel refreshed."))

	expire()

	return TRUE
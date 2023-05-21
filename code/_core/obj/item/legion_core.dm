/obj/item/legion_core
	name = "legion core"
	desc = "Portable healing power."
	desc_extended = "A special regenerative yet decaying core that can be used to near-instantly restore the health of the target by a significant amount. One time use, and decays 10 minutes after being created."

	icon = 'icons/obj/item/legion_core.dmi'
	icon_state = "active"

	var/expiry_time = -1
	var/stabilized = FALSE

	value = 500

	rarity = RARITY_RARE

/obj/item/legion_core/get_base_value()
	. = initial(value)
	if(stabilized)
		. *= 2
	else if(expiry_time < 0)
		. *= 0.1

/obj/item/legion_core/Generate()
	expiry_time = SECONDS_TO_DECISECONDS(600)
	return ..()

/obj/item/legion_core/Finalize()
	if(stabilized == TRUE)
		return
	if(expiry_time == -1)
		expire()
	else
		CALLBACK("expire_\ref[src]",expiry_time,src,src::expire())
	return ..()

/obj/item/legion_core/proc/expire()
	if(stabilized == TRUE)
		return
	expiry_time = -1
	update_sprite()
	return TRUE

/obj/item/legion_core/get_examine_list(var/mob/examiner)

	. = ..()

	if(stabilized == TRUE)
		. += div("warning","It has been stabilized, preserving its healing abilities indefinitely.")

	if(expiry_time == -1)
		. += div("warning","It has expired.")


/obj/item/legion_core/update_icon()

	if(expiry_time == -1)
		icon_state = "inactive"
		name = "dull legion core"
	else
		icon_state = "active"
		name = "active legion core"

	return ..()

/obj/item/legion_core/click_self(var/mob/caller,location,control,params)
	click_on_object(caller,caller)
	return TRUE

/obj/item/legion_core/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_living(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)

		if(expiry_time == -1 && !stabilized)
			caller.to_chat(span("warning","\The [src.name] has expired!"))
			return TRUE

		var/mob/living/L = object
		if(L.dead || !L.health)
			caller.to_chat(span("warning","\The [src.name] only works on living beings!"))
			return TRUE

		if(caller == L)
			caller.visible_message(span("notice","\The [caller.name] uses \the [src.name] to heal their wounds."),span("notice","You use \the [src.name] to heal your wounds."))
		else
			caller.visible_message(span("notice","\The [caller.name] uses \the [src.name] to heal the wounds of \the [L.name]."),span("notice","You use \the [src.name] to heal the wounds of \the [L.name]."))

		L.health.adjust_loss_smart(brute=-100,burn=-100,tox=-100,oxy=-100,fatigue=-100,pain=-100,rad=-100,sanity=-100,mental=-100,organic=TRUE,robotic=FALSE)
		L.to_chat(span("notice","You feel rejuvenated!"))
		qdel(src)

		return TRUE

	. = ..()

/obj/item/legion_core_stabilizer
	name = "legion core stabilizer"
	desc = "The wonders of corrupt medicine is now."
	desc_extended = "A potent chemical compount capable of preserving legion cores indefinitely."
	value = 200
	icon = 'icons/obj/item/legion_core.dmi'
	icon_state = "stabilizer"

	rarity = RARITY_UNCOMMON

/obj/item/legion_core_stabilizer/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/legion_core))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/obj/item/legion_core/core = object
		core.stabilized = TRUE
		core.update_icon()
		core.name = "stable legion core"
		core.desc_extended = "A special regenerative yet decaying core that can be used to near-instantly restore the health of the target by a significant amount. One time use, and decays 10 minutes after being created. It has been preserved, keeping its healing abilities indefinitely."
		caller.to_chat(span("notice","You inject [core.name] with the [object.name], preserving its healing abilities indefinitely."))
		qdel(src)

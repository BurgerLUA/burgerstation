/obj/item/container/syringe
	name = "syringe"
	desc = "For when you want to poke holes into people and get away with it."
	desc_extended = "Holds reagents. Can be toggled to inject or draw."
	crafting_id = "syringe"

	icon = 'icons/obj/item/container/syringe.dmi'
	icon_state = "syringe"
	var/icon_count = 7

	reagents = /reagent_container/syringe/

	var/inject_amount_desired = 0 //Read only. Don't change this.
	var/injecting = FALSE //Read only. Don't change this.
	var/spam_fix_time = 0 //Read only. Don't change this.

	//Has special snowflake code that handles this. Don't change these.
	allow_reagent_transfer_to = FALSE
	allow_reagent_transfer_from = FALSE

	value = -1
	weight = 0.1

	var/injection_sound = null //Optional injection sound to use.
	var/injection_time = SECONDS_TO_DECISECONDS(1) //Time in deciseconds to take when performing an injection. Draws are double this. Self injections are half this.
	var/inject_amount_max = INFINITY //Set to a value other than infinity to add a hard limit to injections.
	var/can_inject = TRUE //Set to true if this can inject into other beings.
	var/can_draw = TRUE //Set to true if this can draw reagents from beings or objects.
	var/adjustable = TRUE //Set to true if the injection amount can change. Otherwise, uses inject_amount_max.
	var/stealthy = FALSE //Set to true if the injection doesn't alert the victim, other than the "tiny prick".
	var/quality_reduction_on_use = 15 //How much quality (out of 100) to take away per use.

/obj/item/container/syringe/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	if(adjustable)
		SAVEVAR("inject_amount_desired")
	if(can_inject && can_draw)
		SAVEVAR("injecting")

/obj/item/container/syringe/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(adjustable)
		LOADVAR("inject_amount_desired")
	if(can_inject && can_draw)
		LOADVAR("injecting")

/obj/item/container/syringe/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)

	if(!adjustable)
		return ..()

	INTERACT_CHECK

	var/fixed_delta = clamp(delta_y,-1,1)

	inject_amount_desired += fixed_delta
	if(inject_amount_desired > inject_amount_max)
		//Cannot go higher
		inject_amount_desired = inject_amount_max
	else if(inject_amount_desired < 1)
		//Cannot go lower
		inject_amount_desired = 1
	else
		//Normal operation.
		if(spam_fix_time <= world.time)
			caller.to_chat(span("notice","You change \the [src.name]'s injection limit to [inject_amount_desired]u..."))
		else
			caller.to_chat(span("notice","...[inject_amount_desired]u..."))

	spam_fix_time = world.time + 20

/obj/item/container/syringe/Initialize()
	. = ..()
	if(inject_amount_max > reagents.volume_max)
		inject_amount_max = reagents.volume_max
	if(!inject_amount_desired)
		inject_amount_desired = inject_amount_max

/obj/item/container/syringe/Finalize()
	. = ..()
	//Autocode.
	if(!can_inject && !can_draw)
		log_error("LOGIC ERROR: Syringe [src.get_debug_name()] couldn't inject or draw reagents!")
	else if(!can_inject)
		injecting = FALSE
	else if(!can_draw)
		injecting = TRUE
	update_sprite()

/obj/item/container/syringe/click_self(var/mob/caller,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	injecting = !injecting
	update_sprite()
	return TRUE

/obj/item/container/syringe/proc/can_inject(var/mob/caller,var/atom/target)

	if(!caller || !target)
		return FALSE

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(quality <= 0)
		caller.to_chat(span("warning","\The [src.name] is too broken to be used!"))
		return FALSE

	if(!target.reagents)
		caller.to_chat(span("warning","You can't target \the [target.name]!"))
		return FALSE

	if(is_living(caller))
		var/mob/living/attacker = caller

		var/mob/living/victim
		if(is_living(target))
			victim = target
		else if(is_living(target.loc))
			victim = target.loc

		if(victim != attacker)
			var/area/A = get_area(victim)
			if(!allow_hostile_action(victim.loyalty_tag,attacker.loyalty_tag,A))
				if(injecting)
					if(reagents.contains_lethal)
						attacker.to_chat(span("warning","Your loyalty tag prevents you from harming \the [victim.name]!"))
						return FALSE
				else
					if(!victim.blood_type || !victim.blood_volume_max)
						attacker.to_chat(span("notice","There is nothing to extract from \the [victim.name]!"))
						return FALSE

					if((victim.blood_volume-inject_amount_desired)/victim.blood_volume_max < 0.9)
						attacker.to_chat(span("warning","Your loyalty tag prevents you from harming \the [victim.name]!"))
						return FALSE


	return TRUE

/obj/item/container/syringe/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/atom/victim = object

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(caller,src,null,params,TRUE,TRUE)

	if(!object.reagents)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(istype(object,/obj/item/container/))
		inject(caller,object,injecting ? inject_amount_desired : -inject_amount_desired)
		return TRUE

	if(can_inject(caller,object))

		var/self_inject = FALSE

		var/real_object_name = object.name
		if(victim != object)
			real_object_name = "[victim.name]'s [object.name]"
			if(victim == caller)
				self_inject = TRUE

		var/transfer_amount = 0
		if(injecting)
			transfer_amount = inject_amount_desired
			if(!stealthy) caller.visible_message(span("danger","\The [caller.name] tries to inject \the [real_object_name] with \the [src.name]!"),span("warning","You try to inject \the [real_object_name] with \the [src.name]."))
		else
			transfer_amount = -inject_amount_desired
			if(!stealthy) caller.visible_message(span("danger","\The [caller.name] tries to draw blood from \the [real_object_name] with \the [src.name]!"),span("warnning","You try to draw blood from \the [real_object_name] with \the [src.name]."))

		if(injection_time > 0)
			var/injection_time_to_use = injection_time
			if(self_inject)
				injection_time_to_use *= 0.5
			if(!injecting)
				injection_time_to_use *= 2
			PROGRESS_BAR(caller,src,injection_time_to_use,.proc/inject,caller,object,transfer_amount)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_inject,caller,object)
		else
			inject(caller,object,transfer_amount)


	return TRUE

/obj/item/container/syringe/proc/inject(var/mob/caller,var/atom/object,var/amount=5)

	if(amount < 0) //Draw
		if(is_organ(object)) //Targeting an organ.
			if(is_living(object.loc)) //We're drawing, so just draw blood from the owner instead.
				var/mob/living/L = object.loc
				L.draw_blood(caller,src,-amount)
			else
				caller.to_chat(span("warning","You can't seem to find a way to draw anything from \the [object] with \the [src]!"))
		else if(is_living(object)) //Living object with blood, hopefully.
			var/mob/living/L = object
			L.draw_blood(caller,src,-amount)
		else if(object.reagents) //Non-organ object with reagents.
			var/transfer_amount = object.reagents.transfer_reagents_to(reagents,-amount, caller = caller)
			if(transfer_amount)
				caller.visible_message(span("warning","\The [caller.name] draws liquid from \the [object.name]."),span("notice","You draw [transfer_amount] units of liquid from \the [object.name]."))
		else
			caller.to_chat(span("warning","You can't seem to find a way to draw anything from \the [object.name] with \the [src.name]!"))

	else if(amount > 0) //Inject
		if(object.reagents && object.reagents.volume_current < object.reagents.volume_max) //We're not too picky about what we inject.
			var/transfer_amount = reagents.transfer_reagents_to(object.reagents,amount, caller = caller)
			if(transfer_amount)
				if(injection_sound)
					play_sound(injection_sound,get_turf(src))
				caller.visible_message(span("warning","\The [caller.name] injects \the [src.name] into \the [object.name]."),span("notice","You inject [transfer_amount] units of liquid into \the [object.name]."))
		else
			caller.to_chat(span("warning","You can't seem to find a way to inject \the [object.name] with \the [src.name]!"))

	if(is_organ(object))
		var/obj/item/organ/O = object
		var/mob/living/L = is_living(O.loc) ? O.loc : null
		L?.to_chat(span("warning","Your [O.name] feels a tiny prick."))
		var/damage_to_deal = quality > 50 ? 0 : min(1 - quality/100,1)*20
		if(damage_to_deal > 0 && object.health?.adjust_loss_smart(brute=damage_to_deal*0.25,pain=damage_to_deal) && O.send_pain_response(10) && !stealthy)
			L?.to_chat(span("danger","\The roughness of \the [src.name] hurts!"))
		adjust_quality(-quality_reduction_on_use)
	else if(is_living(object))
		var/mob/living/L = object
		L.to_chat(span("warning","You feel a tiny prick."))
		var/damage_to_deal = quality > 50 ? 0 : min(1 - quality/100,1)*20
		if(damage_to_deal > 0 && L.health?.adjust_loss_smart(brute=damage_to_deal*0.25,pain=damage_to_deal) && L.send_pain_response(10) && !stealthy)
			L.to_chat(span("danger","\The roughness of \the [src.name] hurts!"))

		adjust_quality(-quality_reduction_on_use)

	return FALSE
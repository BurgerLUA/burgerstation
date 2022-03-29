/obj/item/defib
	name = "defibrillator"
	icon = 'icons/obj/item/defib.dmi'
	desc = "A spaceman's last hope."
	desc_extended = "A heavy-duty auto-charging defibrillator designed to restart a patient's heart. Put it on your back to be able to take out the paddles, and then apply them to a recently dead person."

	var/obj/item/defib_paddle/paddle_left
	var/obj/item/defib_paddle/paddle_right

	worn_layer = LAYER_MOB_CLOTHING_BACK
	item_slot = SLOT_TORSO_BACK
	slot_icons = TRUE

	size = SIZE_3

	value = 200

	weight = 16

/obj/item/defib/belt
	name = "compact defibrillator"
	icon = 'icons/obj/item/clothing/belts/compact_defib.dmi'
	desc_extended = "A auto-charging defibrillator designed to restart a patient's heart. Put it on your belt slot to be able to take out the paddles, and then apply them to a recently dead person. Now in a smaller size!"

	size = SIZE_2
	item_slot = SLOT_GROIN_BELT

	weight = 8

	value = 1600

/obj/item/defib/Destroy()
	QDEL_NULL(paddle_left)
	QDEL_NULL(paddle_right)
	. = ..()

/obj/item/defib/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I,var/messages=FALSE)
	return TRUE

/obj/item/defib/Initialize(var/desired_loc) //Fill inventory handles the initializations here.
	paddle_left = new /obj/item/defib_paddle(src)
	paddle_left.linked_defib = src
	paddle_right = new /obj/item/defib_paddle(src)
	paddle_right.linked_defib = src
	return ..()

/obj/item/defib/proc/on_paddle(var/mob/caller)

	if(!paddle_left.placed_target_ref || !paddle_right.placed_target_ref || paddle_left.placed_target_ref != paddle_right.placed_target_ref)
		return FALSE

	var/mob/living/target = locate(paddle_left.placed_target_ref)
	if(!target)
		return FALSE

	var/turf/T = get_turf(target)

	caller.visible_message(span("danger","\The [caller.name] charges up \the [src.name]..."),span("warning","You charge up \the [src.name]..."))

	play_sound('sound/items/defib/defib_charge.ogg',T,range_max=VIEW_RANGE)
	create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)

	paddle_left.placed_target_ref = null
	paddle_right.placed_target_ref = null

	PROGRESS_BAR(caller,src,30,.proc/defib_target,caller,target)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_defib_target,caller,target)

	return TRUE

/obj/item/defib/proc/can_defib_target(var/mob/caller,var/mob/living/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	return TRUE

/obj/item/defib/proc/defib_target(var/mob/caller,var/mob/living/target)

	var/turf/T = get_turf(target)

	caller.visible_message(span("notice","\The [caller.name] shocks \the [target.name] with \the [src.name]!"),span("notice","You shock \the [target.name] with \the [src.name]!"))

	play_sound('sound/items/defib/defib_zap.ogg',T,range_max=VIEW_RANGE)
	create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)

	var/target_dead = target.dead || target.has_status_effect(CRIT)

	if(target_dead)
		target.add_status_effect(ADRENALINE,100,100)

	if(target.check_death() || (target.dead && !target.is_player_controlled()) || target.suicide)
		target.visible_message(span("warning","Nothing happens..."))
		play_sound('sound/items/defib/defib_failed.ogg',T,range_max=VIEW_RANGE)
		create_alert(VIEW_RANGE,T,caller,ALERT_LEVEL_NOISE)
		return FALSE

	play_sound('sound/items/defib/defib_ready.ogg',T,range_max=VIEW_RANGE*0.5)
	create_alert(VIEW_RANGE*0.5,T,caller,ALERT_LEVEL_NOISE)

	if(target_dead) //Was dead
		target.revive()
		caller.visible_message(span("danger","\The [target.name] jolts to life!"))
		/* TODO, CHECK THE JOB INSTEAD.
		if(money && is_player(caller) && is_player(target))
			var/mob/living/advanced/player/PC = caller
			var/mob/living/advanced/player/PT = target
			if(PC.loyalty_tag == PT.loyalty_tag)
				var/charged_amount = PT.adjust_currency(-500)
				if(charged_amount > 0)
					src.do_say("[charged_amount] credit(s) have been transfered from the patient's account into the practitioner's account for successful revival.")
					PC.adjust_currency(charged_amount)
		*/
	else
		target.do_emote("scream")
		target.add_status_effect(ADRENALINE,50,100)
		var/atom/target_to_damage = target
		if(is_advanced(target))
			var/mob/living/advanced/A = target
			if(A.labeled_organs[BODY_TORSO])
				target_to_damage = A.labeled_organs[BODY_TORSO]
		var/damage_to_deal = caller == target ? 50 : 20
		target_to_damage?.health?.adjust_loss_smart(pain=damage_to_deal,fatigue=damage_to_deal)
		target.add_status_effect(STUN,20,20)

	return TRUE

/obj/item/defib/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	if((is_inventory(object) && is_inventory(src.loc)) || (isturf(src.loc) && A.attack_flags & CONTROL_MOD_DISARM))
		var/obj/hud/inventory/I = src.loc
		if(src in I.contents)
			var/obj/hud/inventory/I2 = object
			if(paddle_left in src.contents)
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(1)
				I2.add_object(paddle_left)
				return TRUE
			else if(paddle_right in src.contents)
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(1)
				I2.add_object(paddle_right)
				return TRUE

	return ..()

/obj/item/defib/post_move(var/atom/old_loc)
	. = ..()
	if(paddle_left && paddle_left.loc != src)
		paddle_left.drop_item(src)
	if(paddle_right && paddle_right.loc != src)
		paddle_right.drop_item(src)

/obj/item/defib_paddle
	name = "defibrillator paddle"
	icon = 'icons/obj/item/defib_paddle.dmi'
	var/obj/item/defib/linked_defib
	var/placed_target_ref //While refs can be replaced by other objects, placing the last paddle with check if it's a valid ref.

	throwable = FALSE

	size = 9999

	size = SIZE_6

	weight = 2

	should_save = FALSE

/obj/item/defib_paddle/Destroy()
	linked_defib = null
	. = ..()

/obj/item/defib_paddle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(caller.is_busy())
		return TRUE

	if(!linked_defib)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.to_chat(span("danger","Paddle error detected. Tell burger how you encountered this bug."))
		return TRUE

	if(object == linked_defib)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		drop_item(get_turf(src))
		return TRUE

	if(is_living(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		if(placed_target_ref == "\ref[object]")
			caller.visible_message(span("notice","\The [caller.name] removes \a [src.name] from [object.name]'s chest..."),span("warning","You remove \the [src.name] from \the [object.name]'s chest..."))
			placed_target_ref = null
		else
			caller.visible_message(span("danger","\The [caller.name] places \a [src.name] on [object.name]'s chest..."),span("warning","You place \the [src.name] on \the [object.name]'s chest..."))
			placed_target_ref = "\ref[object]"
			linked_defib.on_paddle(caller)
		return TRUE

	return ..()

/obj/item/defib_paddle/post_move(var/atom/old_loc)

	. = ..()

	if(. && linked_defib && isturf(loc))
		placed_target_ref = null
		src.drop_item(linked_defib)

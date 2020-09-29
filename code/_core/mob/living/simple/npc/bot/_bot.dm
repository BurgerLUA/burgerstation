/mob/living/simple/bot
	name = "bot"
	desc = "It's a bot."
	desc_extended = "This is a bot."

/mob/living/simple/bot/medical
	name = "medical bot"
	desc = "I NEED HEALING."
	desc_extended = "A medical bot programmed to heal those in need. It's not afraid to defend itself."

	loyalty_tag = "NanoTrasen"
	iff_tag = "NanoTrasen"

	icon = 'icons/obj/item/storage/kits.dmi'
	icon_state = "firstaid"

	ai = /ai/bot/medical/

	var/healing_threshold = 10
	var/amount_to_inject = 10

	var/overlay_icon = 'icons/mob/living/simple/medibot.dmi'

	var/list/medicine = list(
		BRUTE = /reagent/medicine/bicaridine,
		BURN = /reagent/medicine/kelotane,
		TOX = /reagent/medicine/dylovene,
		OXY = /reagent/iron
	)

	stun_angle = 180

/mob/living/simple/bot/medical/Finalize()
	. = ..()
	update_sprite()
	return .

/mob/living/simple/bot/medical/update_overlays()

	. = ..()

	var/icon/I1 = new/icon(overlay_icon,"wheels")
	var/icon/I2 = new/icon(overlay_icon,"anal")
	var/icon/I3 = new/icon(overlay_icon,"arm")

	add_overlay(I1)
	add_overlay(I2)
	add_overlay(I3)

	return .

/mob/living/simple/bot/medical/proc/get_inject_amount(var/mob/living/target)

	. = list()

	for(var/DT in medicine)
		var/loss = target.health.get_loss(DT)
		if(loss < healing_threshold)
			continue
		var/reagent/R = REAGENT(medicine[DT])
		var/existing_reagent_amount = target.reagents.get_reagent_volume(medicine[DT])
		if(existing_reagent_amount)
			continue
		var/desired_amount = min(R.overdose_threshold,amount_to_inject)-existing_reagent_amount
		if(desired_amount > 0)
			.[medicine[DT]] = desired_amount

	return length(.) ? . : FALSE

/mob/living/simple/bot/medical/proc/treat(var/mob/living/target)

	var/inject_amount = get_inject_amount(target)

	if(inject_amount)
		for(var/k in inject_amount)
			var/v = inject_amount[k]
			target.reagents.add_reagent(k,v)

		target.to_chat(span("danger","\The [src.name] injects you with the hypospray."))

		switch(rand(1,2))
			if(1)
				play('sound/voice/medbot/feelbetter.ogg',get_turf(src))
				src.do_say("Feel better soon!")
			if(2)
				play('sound/voice/medbot/patchedup.ogg',get_turf(src))
				src.do_say("All patched up!")

	return TRUE

/mob/living/simple/bot/medical/proc/can_treat(var/mob/living/target)

	if(!target || target.qdeleting)
		return FALSE

	if(target == src)
		return FALSE

	if(!target.reagents)
		return FALSE

	if(!target.health)
		return FALSE

	if(target.dead)
		return FALSE

	if(get_dist(src,target) > 1)
		return FALSE

	if(!get_inject_amount(target))
		return FALSE

	return TRUE

/mob/living/simple/bot/medical/proc/try_treat(var/mob/living/target)

	if(get_inject_amount(target))
		PROGRESS_BAR(src,src,SECONDS_TO_DECISECONDS(5),.proc/treat,target)
		PROGRESS_BAR_CONDITIONS(src,src,.proc/can_treat,target)
		target.to_chat(span("danger","\The [src.name] is trying to inject you!"))
		if(target.has_status_effect(CRIT))
			play('sound/voice/medbot/no.ogg',get_turf(src))
			src.do_say("No, stay with me!")

		return TRUE

	return FALSE

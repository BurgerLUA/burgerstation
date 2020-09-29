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

	var/reagent_to_inject = /reagent/medicine/tricordrazine
	var/amount_to_inject = 10

	var/overlay_icon = 'icons/mob/living/simple/medibot.dmi'

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

	if(!target.reagents)
		return FALSE

	if(target.dead)
		return FALSE

	if(get_dist(target,src) > 1)
		return FALSE

	var/reagent/R = REAGENT(reagent_to_inject)

	var/final_inject = min(R.overdose_threshold,amount_to_inject)

	if(length(target.reagents.stored_reagents) && target.reagents.stored_reagents[reagent_to_inject])
		var/current_amount = target.reagents.stored_reagents[reagent_to_inject]
		final_inject = amount_to_inject - current_amount

	return final_inject

/mob/living/simple/bot/medical/proc/treat(var/mob/living/target)

	var/inject_amount = get_inject_amount(target)

	if(inject_amount)
		target.reagents.add_reagent(reagent_to_inject,inject_amount)
		world.log << "Added [inject_amount]u of [reagent_to_inject] to [target]."

		target.to_chat(span("notice","\The [src.name] injects you with the hypospray."))

		switch(rand(1,2))
			if(1)
				play('sound/voice/medbot/feelbetter.ogg',get_turf(src))
				src.say("Feel better soon!")
			if(2)
				play('sound/voice/medbot/patchedup.ogg',get_turf(src))
				src.say("All patched up!")

	return TRUE

/mob/living/simple/bot/medical/proc/try_treat(var/mob/living/target)

	if(get_inject_amount(target))
		PROGRESS_BAR(src,src,SECONDS_TO_DECISECONDS(3),.proc/treat,target)
		PROGRESS_BAR_CONDITIONS(src,src,.proc/get_inject_amount,target)
		target.to_chat(span("danger","\The [src.name] is trying to inject you!"))
		if(target.has_status_effect(CRIT))
			play('sound/voice/medbot/no.ogg',get_turf(src))
			src.say("No, stay with me!")

		return TRUE

	return FALSE

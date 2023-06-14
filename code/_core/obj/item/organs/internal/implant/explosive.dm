/obj/item/organ/internal/implant/groin/syndicate_explosive
	name = "explosive implant"
	desc = "Orgasm jokes here."
	desc_extended = "A special implant for syndicate agents that explodes when they leave the Area of Operations. Acts as a deterent for betraying the syndicate as well as getting captured."
	has_life = TRUE
	var/warnings_left = 5

/obj/item/organ/internal/implant/groin/syndicate_explosive/on_life()

	. = ..()

	if(!is_advanced(loc))
		return .

	var/mob/living/advanced/A = loc
	if(A.dead)
		return .

	var/turf/T = get_turf(src)
	var/area/R = T ? T.loc : null
	if(R && R.area_identifier == "Burgerstation")
		switch(warnings_left)
			if(5)
				A.to_chat(span("danger","\The [src.name] starts to beep with malicious intent! Get back to the mission area!"))
			if(3)
				A.to_chat(span("danger","You can feel the [src.name] spooling up the mini-uranium explosive charge! Get back to the mission area!"))
			if(2)
				A.to_chat(span("danger","You REALLY should get back to the mission area, or else your [src.name] will explode!"))
			if(1)
				A.to_chat(span("danger","This can't be good! You swear the [src.name] is getting hotter! Get back to the mission area NOW!"))
			if(0)
				A.to_chat(span("danger","Oh shi-"))
		if(warnings_left <= 0)
			A.health.adjust_loss_smart(brute=100,burn=100)
			explode(T,40,A,src)
			A.smite()
		else
			play_sound('sound/effects/terminal_alert.ogg',T)
			warnings_left--
	else
		warnings_left = initial(warnings_left)


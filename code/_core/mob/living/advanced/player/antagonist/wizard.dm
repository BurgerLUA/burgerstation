/mob/living/advanced/player/antagonist/wizard
	loadout_to_use = /loadout/wizard_federation
	loyalty_tag = "Wizard Federation"
	iff_tag = "Wizard Federation"

/mob/living/advanced/player/antagonist/wizard/setup_iff()
	return TRUE

/mob/living/advanced/player/antagonist/wizard/Finalize()
	. = ..()
	to_chat(span("danger","GREETINGS. YOU ARE THE WIZARD FROM THE WIZARD FEDERATION."))
	to_chat(span("danger","YOU ARE TASKED WITH PRANKING THE CREW BETTER THAN THE HONKMOTHER COULD. DO THIS BY BUYING STUFF WITH THE VENDORS. WORK WITH YOUR TEAM TO PULL OFF THE GREATEST PRANK OF ALL TIME."))

/mob/living/advanced/player/antagonist/wizard/setup_name()
	. = ..()
	name = "Great Wizard [real_name] the Almighty and Powerful, Jr."
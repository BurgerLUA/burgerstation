/mob/living/advanced/player/antagonist/wizard
	loadout_to_use = /loadout/wizard_federation


/mob/living/advanced/player/antagonist/wizard/default_appearance()
	. = ..()
	loyalty_tag = "Wizard Federation"
	iff_tag = "Wizard Federation"
	return.

/mob/living/advanced/player/antagonist/wizard/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","GREETINGS. YOU ARE THE WIZARD FROM THE WIZARD FEDERATION."))
	to_chat(span("danger","YOU ARE TASKED WITH PRANKING THE CREW BETTER THAN THE HONKMOTHER COULD. DO THIS BY BUYING STUFF WITH THE VENDORS. WORK WITH YOUR TEAM TO PULL OFF THE GREATEST PRANK OF ALL TIME."))

/mob/living/advanced/player/antagonist/wizard/setup_name()
	. = ..()
	name = "Great Wizard [real_name] the Almighty and Powerful, Jr."
	return TRUE
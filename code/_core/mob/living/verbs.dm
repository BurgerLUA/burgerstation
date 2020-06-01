/mob/living/add_inherent_verbs()

	verbs += /mob/living/verb/cycle_intent_clockwise
	verbs += /mob/living/verb/cycle_intent_counter_clockwise
	verbs += /mob/living/verb/sneak
	verbs += /mob/living/verb/set_intent_harm
	verbs += /mob/living/verb/set_intent_disarm
	verbs += /mob/living/verb/set_intent_grab
	verbs += /mob/living/verb/set_intent_help
	verbs += /mob/living/verb/suicide

	return ..()

/mob/living/verb/sneak()
	set hidden = TRUE
	toggle_sneak(!is_sneaking)


/mob/living/verb/suicide()
	set name = "Suicide"
	set category = "Game"

	var/choice = input("Are you sure you want to kill yourself?","Suicide","Cancel") in list("Yes","No","Cancel")

	if(dead)
		to_chat("You are already dead!")
		return FALSE

	if(choice == "Yes")
		health.adjust_loss_smart(brute = 1000, burn = 1000, oxy = 1000, tox = 1000)
		visible_message("[src.name] kills themselves!")


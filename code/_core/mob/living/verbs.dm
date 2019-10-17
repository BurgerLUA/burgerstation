/mob/living/verb/suicide()
	set category = "In Character"
	set name = "Suicide"

	var/response = input("Are you sure you want to kill yourself?") in list("Yes","fuck go back")

	if(response == "Yes")
		death()

/mob/living/verb/test_damage()
	set category = "Debug"
	set name = "Test Damage"

	health_regen_buffer -= 50


	to_chat(span("notice",health_regen_buffer))


mob/living/verb/get_gud()
	set category = "Cheat"
	set name = "Get Gud"

	for(var/experience/attribute/A in attributes)
		A.set_level(50)

	for(var/experience/skill/S in skills)
		S.set_level(50)

	to_chat("All skills and attributes set to 50.")
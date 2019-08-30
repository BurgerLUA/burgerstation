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
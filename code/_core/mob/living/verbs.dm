/mob/living/verb/suicide()
	set category = "In Character"
	set name = "Suicide"

	var/response = input("Are you sure you want to kill yourself?") in list("Yes","fuck go back")

	if(response == "Yes")
		death()
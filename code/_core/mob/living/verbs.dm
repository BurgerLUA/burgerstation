/mob/living/verb/suicide()
	set category = "In Character"
	set name = "Suicide"

	var/response = input("Are you sure you want to kill yourself?") in list("fuck go back","Yes")

	if(response == "Yes")
		death()
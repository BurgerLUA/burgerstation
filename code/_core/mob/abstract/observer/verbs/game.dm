/mob/abstract/observer/verb/adjust_darkvision()
	set name = "Adjust Darkvision"
	set category = "Game"

	var/desired_value = input("What is your desired darkvision strength? (0 to 255, high values is better vision.)","Adjust Darkvision",255 - plane_master_lighting.alpha) as null|num

	if(isnum(desired_value))
		plane_master_lighting.alpha = clamp(255 - desired_value,0,255)


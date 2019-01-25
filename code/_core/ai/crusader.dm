/ai/crusader/
	name = "Crusader"
	desc = "Aim for the head because that's the meta."
	target_distribution = list(32)


/ai/crusader/hostile_message()
	owner.say("DEUS VULT!")
	var/area/A = get_area(owner)
	play_sound('sounds/voice/deusvult.ogg',all_mobs,vector(owner.x,owner.y,owner.z),environment = A.sound_environment)
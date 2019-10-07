world/Reboot()
	return ..()


world/Del()

	for(var/mob/living/advanced/player/P in world)
		if(!P.qdeleting)
			world.log << "HELLO [P]"

	return ..()
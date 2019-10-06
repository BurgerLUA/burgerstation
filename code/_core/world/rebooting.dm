world/Reboot()

	world.log << "REBOOTING DA WORLD!"

	return ..()


world/Del()

	for(var/mob/living/advanced/player/P in world)
		world.log << "HELLO [P]"

	return ..()
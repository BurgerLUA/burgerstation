/dialogue/npc/chargen_computer/

/dialogue/npc/chargen_computer/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	var/list/dialogue_options = list()

	dialogue_options["hello"] = list(
		"Welcome to IMB v0.6.3 work edition. You are currently logged in as [P.real_name].NEWLINE\
		Select #1 to view mission briefing.NEWLINE\
		Select #2 to view avaiable loadouts.NEWLINE\
		Select #3 to generate and view your secret doorcode.",
		"*mission briefing",
		"*loadout information",
		"*doorcode passphrase"
	)

	dialogue_options["*mission briefing"] = list(
		"NanoTrasen has discovered a new planet with possible hostile lifeforms in the location. \
		You are tasked with setting up a base of operations and defending it until the NanoTrasen Private Military arive.NEWLINE\
		Autocloning is enabled for this mission.NEWLINE\
		You and the crew have been auto-implanted with a loyalty implant and IFF features that prevent intentional friendly fire."
	)

	dialogue_options["*loadout information"] = list(
		"You have several basic loadout options to choose from, provided free of charge from NanoTrasen.\
		Note that this is not your final loadout, and you are heavily encouraged to visit various supply areas of the station before heading down for your mission.NEWLINE\
		The current options are:NEWLINE\
		#1 NEWLINE\
		#2 NEWLINE\
		#3 NEWLINE\
		#4 NEWLINE\
		#5 NEWLINE\
		Please click on the above links to view more information about the loadout. To select a loadout, please use the gear autolathe located inside the room."
	)

	var/obj/structure/interactive/computer/console/old/station_job/SJ = P.dialogue_target

	dialogue_options["*doorcode passphrase"] = list(
		"Your temporary doorcode passphrase for unit number is [SJ.unit_number] is [SJ.door_code].NEWLINE\
		Please do not misplace this information as you cannot re-enter if you do not know the correct passphrase."
	)






	return dialogue_options
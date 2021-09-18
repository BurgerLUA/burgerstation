var/global/list/possible_merc_loadouts = list(
	/loadout/mercenary/rat,
	/loadout/mercenary/virtual_suit,
	/loadout/mercenary/stealth_suit,
	/loadout/mercenary/olive_drab
)


/mob/living/advanced/player/antagonist/merc
	loadout_to_use = null //Chosen based on the above list

	damage_received_multiplier = 0.25 //Take way less damage, but if they kill a player, it resets to 0.75 (25% penalty, as players get 50% resist)!

	known_cqc = list(
		/cqc/boss/fast_grab,
		/cqc/boss/grab_slam,
		/cqc/boss/staggering_punch,
		/cqc/boss/stunning_punch,
		/cqc/boss/disarm_theft,
		/cqc/boss/tactical_hug
	)


/mob/living/advanced/player/antagonist/merc/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/merc)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/merc)
	return.

/mob/living/advanced/player/antagonist/merc/prepare()

	loadout_to_use = pick(possible_merc_loadouts)
	possible_merc_loadouts -= loadout_to_use

	. = ..()

	if(length(SStext.first_codenames) && length(SStext.last_codenames))
		var/codename_first = pick(SStext.first_codenames)
		SStext.first_codenames -= codename_first
		var/codename_last = pick(SStext.last_codenames)
		SStext.last_codenames -= codename_last
		name = "[codename_first] [codename_last]"
	else
		name = "Generic Merc #[rand(1,90000)]"

	setup_name()

	to_chat(span("danger","You are a trained Mercenary hired by the Solarian Government tasked with securing owed taxes from NanoTrasen, non-lethally."))
	to_chat(span("danger","Work with your team, if any, to fulton extract NanoTrasen Soldiers and equipment. Note that they must be laying on the floor alive in order to extract them. You are given lethal and non-lethal equipment to defend yourself."))
	to_chat(span("danger","<h1>Killing NanoTrasen operatives is not recommended as it is considered an act of war. We will disable the damage-resistant NanoMachines in your body if we witness you kill a NanoTrasen soldier.</h1>"))

	do_say("; This is [name]. Kept you waiting, huh?")

/mob/living/advanced/player/antagonist/merc/setup_name() //Don't do anything special
	return TRUE

/mob/living/advanced/player/antagonist/merc/on_kill_player(var/mob/living/advanced/player/P)

	if(P.loyalty_tag == "NanoTrasen")
		damage_received_multiplier = 1 //Act like an antag, get treated like one :)

	. = ..()
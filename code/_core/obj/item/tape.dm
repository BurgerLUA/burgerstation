/obj/item/tape
	name = "tape"
	desc = "Finally, some good fucking music."
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for yourself to hear, or turn the currently playing song off."
	icon = 'icons/obj/item/tape.dmi'
	icon_state = "inventory"
	value = 1250
	value_burgerbux = 1
	rarity = RARITY_RARE
	weight = 0.25
	size = SIZE_1
	var/song_to_play = null

/obj/item/tape/click_self(var/mob/caller,var/atom/object)

	INTERACT_CHECK
	INTERACT_DELAY(20)

	if(icon_state == "inventory")
		play_sound(song_to_play,get_turf(caller),range_min=1, range_max = SOUND_RANGE,30,SOUND_SETTING_FX,1,1,0,0,SOUND_CHANNEL_FX,0,0,0)
		icon_state = "playing"
		caller.to_chat(span("notice","You turn on the player."))
		return TRUE
	else
		stop_sound(song_to_play,caller)
		icon_state = "inventory"
		caller.to_chat(span("notice","You turn off the player."))
		return FALSE

/obj/item/tape/napalm
	name = "fireproof tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. This one smells faintly of napalm."
	song_to_play = 'sound/music/tape/napalm_sticks_to_kids.ogg'

/obj/item/tape/monday
	name = "cold tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. This one's magnet opposites seem to be at cold war with each other."
	song_to_play = 'sound/music/tape/blue_monday.ogg'

/obj/item/tape/world
	name = "ruling tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. Holding this one in your hands gives you a certain need of conquering the region."
	song_to_play = 'sound/music/tape/rule_the_world.ogg'

/obj/item/tape/putana
	name = "butterfly tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. This one makes you feel nostalgic about neo-Siberian labor camps."
	song_to_play = 'sound/music/tape/putana.ogg'

/obj/item/tape/afghan
	name = "sandy tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. This one smells faintly of cosmoline and helicopter fuel."
	song_to_play = 'sound/music/tape/swallowing_dust.ogg'

/obj/item/tape/vladivostok
	name = "harbor tape"
	desc_extended = "Old tape with a single pre-recorded song. Use it in hand to start playing it for everyone around to hear, or turn the currently playing song off. This one smells of salty water and crabs."
	song_to_play = 'sound/music/tape/vladivostok_2000.ogg'
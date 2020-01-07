
#define ANNOUNCEMENT_STATION "station" //Send to all on the station.
#define ANNOUNCEMENT_ZOMBIE "zombie" //Send to all zombies.
#define ANNOUNCEMENT_XENO "xeno" //Send to all xenos


/proc/announce(var/announcement_sender = "Unknown", var/announcement_title = "Untitled",var/annoumcent_text = "NULL",var/announcement_type = ANNOUNCEMENT_STATION,var/sound_to_play = null)
	var/text_to_send = "<div class='announcement [announcement_type]'><h1>[announcement_sender]</h1><h2>[announcement_title]</h2><p>[annoumcent_text]</p></div>"
	switch(announcement_type)
		if(ANNOUNCEMENT_STATION)
			var/list/valid_players = list()
			for(var/mob/living/advanced/player/P in all_players)
				P.to_chat(text_to_send)
				valid_players += P
			if(sound_to_play)
				play_sound(sound_to_play,valid_players)


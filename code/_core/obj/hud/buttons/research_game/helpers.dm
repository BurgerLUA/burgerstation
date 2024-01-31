/mob/living/proc/toggle_research_game(var/allow_disable=TRUE,var/allow_enable = TRUE)

	var/obj/hud/button/research/board/B

	for(var/obj/hud/button/research/board/F in buttons)
		B = F
		break

	if(B && allow_disable)
		clear_research_pieces()
		B.update_owner(null)
		show_hud(TRUE,FLAG_HUD_MOB,FLAG_HUD_SPECIAL,SECONDS_TO_DECISECONDS(1))
		client.disable_controls = FALSE
	else if(!B && allow_enable)
		client.update_zoom(2)
		client.disable_controls = TRUE
		show_hud(FALSE,FLAG_HUD_MOB,FLAG_HUD_NONE,SECONDS_TO_DECISECONDS(1))
		B = new
		B.update_owner(src)

/mob/living/proc/clear_research_pieces()
	for(var/obj/hud/button/research/piece/P in buttons)
		P.update_owner(null)
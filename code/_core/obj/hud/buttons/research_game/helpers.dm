/mob/living/proc/toggle_research_game(var/allow_disable=TRUE,var/allow_enable = TRUE)

	var/obj/hud/button/research/board/B

	for(var/obj/hud/button/research/board/F in buttons)
		B = F
		break

	if(B && allow_disable)
		clear_research_pieces()
		B.update_owner(null)
		show_hud(TRUE,FLAGS_HUD_MOB,FLAGS_HUD_SPECIAL,1)
		client.view = VIEW_RANGE
		client.disable_controls = FALSE
	else if(!B && allow_enable)
		client.disable_controls = TRUE
		client.view = (RESEARCH_BOARD_SIZE+1)/2
		show_hud(FALSE,FLAGS_HUD_MOB,FLAGS_HUD_NONE,1)
		B = new
		B.update_owner(src)


/mob/living/proc/clear_research_pieces()
	for(var/obj/hud/button/research/piece/P in buttons)
		P.update_owner(null)
obj/structure/interactive/computer/console/old/research
	name = "bluespace research computer"
	computer_type = "library"
	keyboard_type = ""

obj/structure/interactive/computer/console/old/research/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return ..()

	var/mob/living/L = caller
	L.toggle_research_game(FALSE,TRUE)

	return TRUE


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
		show_hud(FALSE,FLAGS_HUD_MOB,FLAGS_HUD_NONE,1)
		client.disable_controls = TRUE
		B = new
		B.update_owner(src)
		client.view = (RESEARCH_BOARD_SIZE+1)/2
		for(var/x_pos=1,x_pos<=RESEARCH_BOARD_SIZE,x_pos++)
			for(var/y_pos=1,y_pos<=RESEARCH_BOARD_SIZE,y_pos++)
				var/obj/hud/button/research/piece/P = new
				P.update_owner(src)
				P.x_p = x_pos
				P.y_p = y_pos
				B.pieces[x_pos][y_pos] = P
				P.linked_board = B
				P.update_icon()
				var/matrix/M = matrix()
				P.transform.Scale(0.1,0.1)
				animate(P,transform = M,time = 10,easing = ELASTIC_EASING)
				P.update_piece()
		for(var/x_pos=1,x_pos<=RESEARCH_BOARD_SIZE,x_pos++)
			for(var/y_pos=1,y_pos<=RESEARCH_BOARD_SIZE,y_pos++)
				var/obj/hud/button/research/piece/P = B.pieces[x_pos][y_pos]
				P.check_clear(TRUE)


/mob/living/proc/clear_research_pieces()
	for(var/obj/hud/button/research/piece/P in buttons)
		P.update_owner(null)
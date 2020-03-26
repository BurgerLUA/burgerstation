#define RESEARCH_BOARD_SIZE 9
#define RESEARCH_POSSIBLE_COLORS list(COLOR_RED,COLOR_GREEN,COLOR_BLUE)
#define RESEARCH_POSSIBLE_COLORS_BONUS list(COLOR_PURPLE,COLOR_CYAN,COLOR_YELLOW)

/obj/hud/button/research/
	flags = FLAGS_HUD_SPECIAL
	has_quick_function = FALSE


/obj/hud/button/research/info
	name = "info"
	icon = 'icons/hud/new.dmi'
	icon_state = "square_round"
	maptext = "<center>Info</center>"

/obj/hud/button/research/info/time
	name = "time left"
	screen_loc = "LEFT,TOP"
	maptext = "<center>Time:<br>0:00</center>"

/obj/hud/button/research/info/score
	name = "score"
	screen_loc = "LEFT,TOP-1"
	maptext = "<center>Score:<br>0</center>"

/obj/hud/button/research/info/text
	name = "text"
	screen_loc = "CENTER,CENTER"
	icon_state = "none"
	maptext = "Start!"

	maptext_x = -(TILE_SIZE*VIEW_RANGE) + 16
	maptext_width = TILE_SIZE*VIEW_RANGE*2
	maptext_height = TILE_SIZE*VIEW_RANGE
	maptext = "<center><font size=10>START!</font></center>"

	mouse_opacity = 0

	layer = 100 //I don't give a fuck.

/obj/hud/button/research/board
	name = "research"
	desc = "Yes, this is research."

	icon = 'icons/hud/game_border.dmi'
	icon_state = "game_border"

	screen_loc = "LEFT,BOTTOM"

	var/list/pieces = new/list(RESEARCH_BOARD_SIZE,RESEARCH_BOARD_SIZE)

	var/list/cleared_pieces = list()

	var/points = 0

	var/time_left = 300

	var/obj/hud/button/research/info/time/linked_time
	var/obj/hud/button/research/info/score/linked_score
	var/obj/hud/button/research/info/text/linked_text

/obj/hud/button/research/board/think()
	if(linked_time)
		linked_time.maptext = "<center>Time:<br>[get_clock_time(CEILING(time_left/10,1))]</center>"
		if(time_left <= 0)
			linked_text.maptext = "<center><font size=10>TIMES UP!</font></center>"

	time_left--
	return ..()

/obj/hud/button/research/board/proc/add_points(var/points_to_add)
	points += points_to_add
	time_left += (points_to_add)*10
	if(linked_score)
		linked_score.maptext = "<center>Score:<br>[points]</center>"
	if(linked_text)
		linked_text.maptext = "<center><font size=[10 + points_to_add]>+[points_to_add]!</font></center>"

	return TRUE

/obj/hud/button/research/board/Destroy()

	for(var/x_pos=1,x_pos<=RESEARCH_BOARD_SIZE,x_pos++)
		for(var/y_pos=1,y_pos<=RESEARCH_BOARD_SIZE,y_pos++)
			var/obj/hud/button/research/piece/P = pieces[x_pos][y_pos]
			if(P)
				qdel(P)
			P = null
		pieces[x_pos].Cut()
	pieces.Cut()

	qdel(linked_time)
	linked_time = null

	qdel(linked_score)
	linked_score = null

	qdel(linked_text)
	linked_text = null

	return ..()

/obj/hud/button/research/board/update_owner(var/desired_owner)

	. = ..()

	if(desired_owner == null)
		stop_thinking(src)
	else
		start_thinking(src)

	if(linked_time)
		linked_time.update_owner(desired_owner)
		if(desired_owner == null)
			qdel(linked_time)
			linked_time = null
	else if(desired_owner != null)
		linked_time = new
		linked_time.update_owner(desired_owner)

	if(linked_score)
		linked_score.update_owner(desired_owner)
		if(desired_owner == null)
			qdel(linked_score)
			linked_score = null
	else if(desired_owner != null)
		linked_score = new
		linked_score.update_owner(desired_owner)

	if(linked_text)
		linked_text.update_owner(desired_owner)
		if(desired_owner == null)
			qdel(linked_text)
			linked_text = null
	else if(desired_owner != null)
		linked_text = new
		linked_text.update_owner(desired_owner)

	return .

/obj/hud/button/research/piece
	name = "research piece"
	desc = "It's a piece"
	icon = 'icons/hud/game_piece.dmi'
	icon_state = "piece"

	var/color_01 = 0
	var/color_02 = 0
	var/color_03 = 0
	var/color_04 = 0

	mouse_opacity = 2

	user_colors = FALSE

	var/turning = FALSE

	var/fake_dir = 0

	var/list/piece_storage

	var/x_p
	var/y_p

	var/obj/hud/button/research/board/linked_board

	var/times_cleared = 0

/obj/hud/button/research/piece/Destroy()

	if(linked_board)
		linked_board.pieces[x_p][y_p] = null
		linked_board = null

	return ..()

/obj/hud/button/research/piece/proc/update_piece()

	if(fake_dir >= 360)
		fake_dir -= 360
	else if(fake_dir < 0)
		fake_dir += 360

	switch(fake_dir)
		if(0)
			piece_storage = list(color_01,color_02,color_03,color_04)
		if(90)
			piece_storage = list(color_04,color_01,color_02,color_03)
		if(180)
			piece_storage = list(color_03,color_04,color_01,color_02)
		if(270)
			piece_storage = list(color_02,color_03,color_04,color_01)


	return TRUE

/obj/hud/button/research/piece/proc/check_clear(var/no_score = FALSE)

	var/obj/hud/button/research/piece/left = 	x_p-1 >= 1 ? linked_board.pieces[x_p-1][y_p] : null
	var/obj/hud/button/research/piece/right = 	x_p+1 <= RESEARCH_BOARD_SIZE ? linked_board.pieces[x_p+1][y_p] : null
	var/obj/hud/button/research/piece/up = 		y_p+1 <= RESEARCH_BOARD_SIZE ? linked_board.pieces[x_p][y_p+1] : null
	var/obj/hud/button/research/piece/down = 	y_p-1 >= 1 ? linked_board.pieces[x_p][y_p-1] : null

	// 1 2   1 2   1 2
	// 4 3   4 3   4 3

	// 1 2   1 2   1 2
	// 4 3   4 3   4 3

	// 1 2   1 2   1 2
	// 4 3   4 3   4 3

	var/left_changed = FALSE
	var/right_changed = FALSE
	var/up_changed = FALSE
	var/down_changed = FALSE

	if(left && (should_destroy(left.piece_storage[2], piece_storage[1]) && should_destroy(left.piece_storage[3], piece_storage[4])))
		left_changed = TRUE
		left.clear_piece()

	if(right && (should_destroy(right.piece_storage[1], piece_storage[2]) && should_destroy(right.piece_storage[4], piece_storage[3])))
		right_changed = TRUE
		right.clear_piece()

	if(up && (should_destroy(up.piece_storage[3], piece_storage[2]) && should_destroy(up.piece_storage[4], piece_storage[1])))
		up_changed = TRUE
		up.clear_piece()

	if(down && (should_destroy(down.piece_storage[1], piece_storage[4]) && should_destroy(down.piece_storage[2], piece_storage[3])))
		down_changed = TRUE
		down.clear_piece()

	if(left_changed || right_changed || down_changed || up_changed)
		clear_piece()

	return left_changed + right_changed + down_changed + up_changed

/obj/hud/button/research/piece/proc/clear_piece()
	color_01 = COLOR_BLACK
	color_02 = COLOR_BLACK
	color_03 = COLOR_BLACK
	color_04 = COLOR_BLACK
	update_piece()
	update_icon()
	times_cleared++
	linked_board.cleared_pieces += src
	return TRUE

/obj/hud/button/research/piece/proc/restore_piece()
	color_01 = times_cleared >= 1 ? pick(RESEARCH_POSSIBLE_COLORS_BONUS) : pick(RESEARCH_POSSIBLE_COLORS)
	color_02 = times_cleared >= 2 ? pick(RESEARCH_POSSIBLE_COLORS_BONUS) : pick(RESEARCH_POSSIBLE_COLORS)
	color_03 = times_cleared >= 3 ? pick(RESEARCH_POSSIBLE_COLORS_BONUS) : pick(RESEARCH_POSSIBLE_COLORS)
	color_04 = times_cleared >= 4 ? pick(RESEARCH_POSSIBLE_COLORS_BONUS) : pick(RESEARCH_POSSIBLE_COLORS)
	update_piece()
	update_icon()
	linked_board.cleared_pieces -= src
	check_clear()
	return TRUE

/obj/hud/button/research/piece/proc/should_destroy(var/color_A,var/color_B)

	if(!color_A || !color_B)
		return FALSE

	if(color_A == COLOR_BLACK || color_B == COLOR_BLACK)
		return FALSE

	if(color_A != color_B)
		return FALSE

	return TRUE


/obj/hud/button/research/piece/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(turning)
		return FALSE

	if(linked_board.time_left <= 0)
		return FALSE

	. = ..()

	turning = TRUE

	var/matrix/M = transform
	var/desired_dir = 0

	if(params["left"])
		desired_dir = 90
	else if(params["right"])
		desired_dir = -90
	M.Turn(desired_dir)
	animate(src,transform = M,time = 5, easing = ELASTIC_EASING)
	sleep(3)
	fake_dir += desired_dir
	turning = FALSE
	update_piece()

	var/points = check_clear() ** 3
	if(points)
		for(var/i=1,i<=max(1,(points-1)*2),i++)
			var/obj/hud/button/research/piece/P = pick(linked_board.cleared_pieces)
			if(!P)
				break
			P.restore_piece()
		linked_board.add_points(points)

	return .

/obj/hud/button/research/piece/MouseEntered(location,control,params)
	var/image/I = new/image(icon,"border")
	overlays += I
	return ..()

/obj/hud/button/research/piece/MouseExited(location,control,params)
	overlays.Cut()
	return ..()

/obj/hud/button/research/piece/New(var/desired_loc)
	color_01 = pick(RESEARCH_POSSIBLE_COLORS)
	color_02 = pick(RESEARCH_POSSIBLE_COLORS)
	color_03 = pick(RESEARCH_POSSIBLE_COLORS)
	color_04 = pick(RESEARCH_POSSIBLE_COLORS)
	return ..()

/obj/hud/button/research/piece/update_icon()

	screen_loc = "LEFT+[x_p],BOTTOM+[y_p]"

	icon_state = "piece_static"

	underlays.Cut()

	var/image/I1 = new(icon,"1")
	I1.color = color_01
	underlays += I1

	var/image/I2 = new(icon,"2")
	I2.color = color_02
	underlays += I2

	var/image/I3 = new(icon,"3")
	I3.color = color_03
	underlays += I3

	var/image/I4 = new(icon,"4")
	I4.color = color_04
	underlays += I4

	return ..()


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

/obj/hud/button/research/piece/proc/clear_piece(var/add_points = FALSE)
	color_01 = COLOR_BLACK
	color_02 = COLOR_BLACK
	color_03 = COLOR_BLACK
	color_04 = COLOR_BLACK
	update_piece()
	update_sprite()
	linked_board.cleared_pieces += src
	return TRUE

/obj/hud/button/research/piece/proc/restore_piece()

	var/list/possible_colors = RESEARCH_POSSIBLE_COLORS
	var/level = linked_board.level
	if(level >= 3)
		possible_colors += COLOR_YELLOW
	if(level >= 5)
		possible_colors += COLOR_CYAN
	if(level >= 10)
		possible_colors += COLOR_PURPLE

	color_01 = pick(possible_colors)
	color_02 = pick(possible_colors)
	color_03 = pick(possible_colors)
	color_04 = pick(possible_colors)
	update_piece()
	update_sprite()
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

	. = ..()

	if(!.)
		return FALSE

	if(turning)
		return FALSE

	if(linked_board.time_left <= 0)
		return FALSE

	if(!linked_board.game_initialized)
		return FALSE

	turning = TRUE

	var/matrix/M = transform
	var/desired_dir = 0

	if(params["left"])
		desired_dir = 90
	else if(params["right"])
		desired_dir = -90
	M.Turn(desired_dir)
	animate(src,transform = M,time = 5, easing = ELASTIC_EASING)
	play('sound/ui/game/rotate_piece.ogg',caller, sound_setting = SOUND_SETTING_UI)
	sleep(3)
	fake_dir += desired_dir
	turning = FALSE
	update_piece()

	var/points = check_clear() ** 2
	if(points)
		play('sound/ui/game/score_piece.ogg',caller, sound_setting = SOUND_SETTING_UI)
		for(var/i=1,i<=points,i++)
			if(!length(linked_board.cleared_pieces))
				break
			var/obj/hud/button/research/piece/P = pick(linked_board.cleared_pieces)
			if(!P)
				break
			P.restore_piece()
		linked_board.add_points(points)
		var/obj/hud/button/research/info/effect/E = new
		E.update_owner(owner)
		E.do_effect(src,points)

	return TRUE

/obj/hud/button/research/piece/MouseEntered(location,control,params)
	var/image/I = new/image(icon,"border")
	add_overlay(I)
	return ..()

/obj/hud/button/research/piece/MouseExited(location,control,params)
	overlays.Cut()
	return ..()

/obj/hud/button/research/piece/New(var/desired_loc)
	color_01 = COLOR_BLACK
	color_02 = COLOR_BLACK
	color_03 = COLOR_BLACK
	color_04 = COLOR_BLACK
	return ..()

/obj/hud/button/research/piece/proc/initialize_colors(var/list/desired_colors = RESEARCH_POSSIBLE_COLORS)

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


	var/final_01 = desired_colors.Copy()
	var/final_02 = desired_colors.Copy()
	var/final_03 = desired_colors.Copy()
	var/final_04 = desired_colors.Copy()

	if(up) final_01 -= up.color_04
	if(left) final_01 -= left.color_02

	if(up) final_02 -= up.color_03
	if(right) final_02 -= right.color_01

	if(down) final_03 -= down.color_02
	if(right) final_03 -= right.color_04

	if(down) final_04 -= down.color_01
	if(left) final_04 -= left.color_03

	color_01 = pick(final_01)
	color_02 = pick(final_02)
	color_03 = pick(final_03)
	color_04 = pick(final_04)

	return TRUE

/obj/hud/button/research/piece/update_sprite()
	. = ..()
	screen_loc = "CENTER+[x_p-RESEARCH_BOARD_SIZE*0.5],CENTER+[y_p-RESEARCH_BOARD_SIZE*0.5]"
	return .


/obj/hud/button/research/piece/update_icon()
	. = ..()
	icon_state = "piece_static"
	return .

/obj/hud/button/research/piece/update_underlays()

	. = ..()
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

	return .
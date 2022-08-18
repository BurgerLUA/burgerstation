/mob/living/simple/chess_piece
	name = "chess piece"
	icon = 'icons/mob/living/simple/chess.dmi'

/mob/living/simple/chess_piece/proc/get_valid_move_turfs() //Returns a list.
	return list()

/mob/living/simple/chess_piece/proc/is_valid_turf(var/turf/T,var/ignore_pieces=FALSE,var/can_attack_enemies=TRUE,var/enemy_only=FALSE)
	//ignore_pieces: knights would ignore some pieces
	//can_attack_enemies: pawns wouldn't be able to attack straight ahead
	//enemy_only: pawns can only attack diagonally, but can't move normally that way.
	if(!T) return FALSE
	if(!ignore_pieces)
		var/found_enemy = FALSE
		var/found_ally = FALSE
		for(var/mob/living/L in T.contents)
			if(L.loyalty_tag == src.loyalty_tag)
				found_ally = TRUE
			else
				found_enemy = TRUE
		if(found_enemy)
			if(!can_attack_enemies)
				return FALSE
			else
				return T.is_safe_teleport(check_contents=FALSE) ? "enemy" : null
		else if(enemy_only)
			return FALSE
		if(found_ally)
			return FALSE
	return T.is_safe_teleport(check_contents=FALSE) ? "unoccupied" : null
	//returns either null, "enemy", or "unoccupied"



/mob/living/simple/chess_piece/pawn
	name = "pawn"
	var/black=FALSE
	var/times_moved = 0
	icon_state = "pawn_w"

/mob/living/simple/chess_piece/pawn/black
	icon_state = "pawn_b"
	black = TRUE

/mob/living/simple/chess_piece/pawn/get_valid_move_turfs()

	. = ..()

	if(black)
		for(var/d in list(SOUTHWEST,SOUTHEAST))
			var/turf/T = get_step(src,d)
			if(is_valid_turf(T,enemy_only=TRUE))
				. += T
		if(length(.))
			return .
		var/turf/T = get_step(src,SOUTH)
		if(T && is_valid_turf(T,can_attack_enemies=FALSE))
			. += T
			if(!times_moved)
				T = get_step(T,SOUTH)
				if(is_valid_turf(T,can_attack_enemies=FALSE))
					. += T
	else
		for(var/d in list(NORTHWEST,NORTHEAST))
			var/turf/T = get_step(src,d)
			if(is_valid_turf(T,enemy_only=TRUE))
				. += T
		if(length(.))
			return .
		var/turf/T = get_step(src,NORTH)
		if(T && is_valid_turf(T,can_attack_enemies=FALSE))
			. += T
			if(!times_moved)
				T = get_step(T,NORTH)
				if(is_valid_turf(T,can_attack_enemies=FALSE))
					. += T



/mob/living/simple/chess_piece/knight
	name = "knight"
	icon_state = "knight_w"

/mob/living/simple/chess_piece/knight/black
	icon_state = "knight_b"

/mob/living/simple/chess_piece/knight/get_valid_move_turfs()

	for(var/d1 in DIRECTIONS_CARDINAL)
		var/move_amount = 0
		var/turf/T = get_turf(src)
		for(var/i=1,i<=2,i++)
			if(!T)
				break
			T = get_step(T,d1)
			move_amount++
		if(T && move_amount == 2)
			for(var/d2 in turn(d1,90),turn(d1,-90))
				var/turf/TL = get_step(T,d2)
				if(is_valid_turf(TL))
					. += TL

/mob/living/simple/chess_piece/rook
	name = "rook"
	icon_state = "rook_w"

/mob/living/simple/chess_piece/rook/black
	icon_state = "rook_b"

/mob/living/simple/chess_piece/rook/get_valid_move_turfs()

	var/list/enemy_turfs = list()
	var/list/move_turfs = list()

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_turf(src)
		var/found_enemy = FALSE
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(!result)
				break
			if(result == "enemy")
				found_enemy = TRUE
				break
		if(found_enemy)
			enemy_turfs += T
		else
			move_turfs += T

	if(length(enemy_turfs))
		return enemy_turfs

	return move_turfs

/mob/living/simple/chess_piece/bishop
	name = "bishop"
	icon_state = "bishop_w"

/mob/living/simple/chess_piece/bishop/black
	icon_state = "bishop_b"

/mob/living/simple/chess_piece/bishop/get_valid_move_turfs()

	var/list/enemy_turfs = list()
	var/list/move_turfs = list()

	for(var/d in DIRECTIONS_INTERCARDINAL)
		var/turf/T = get_turf(src)
		var/found_enemy = FALSE
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(!result)
				break
			if(result == "enemy")
				found_enemy = TRUE
				break
		if(found_enemy)
			enemy_turfs += T
		else
			move_turfs += T

	if(length(enemy_turfs))
		return enemy_turfs

	return move_turfs

/mob/living/simple/chess_piece/queen
	name = "queen"
	icon_state = "queen_w"

/mob/living/simple/chess_piece/queen/black
	icon_state = "queen_b"

/mob/living/simple/chess_piece/queen/get_valid_move_turfs()

	var/list/enemy_turfs = list()
	var/list/move_turfs = list()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_turf(src)
		var/found_enemy = FALSE
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(!result)
				break
			if(result == "enemy")
				found_enemy = TRUE
				break
		if(found_enemy)
			enemy_turfs += T
		else
			move_turfs += T

	if(length(enemy_turfs))
		return enemy_turfs

	return move_turfs

/mob/living/simple/chess_piece/king
	name = "king"
	icon_state = "king_w"

/mob/living/simple/chess_piece/king/black
	icon_state = "king_b"

/mob/living/simple/chess_piece/king/get_valid_move_turfs()

	var/list/enemy_turfs = list()
	var/list/move_turfs = list()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_step(src,d)
		var/result = is_valid_turf(T)
		if(result == "enemy")
			enemy_turfs += T
		else if(result == "unoccupied")
			move_turfs += T

	if(length(enemy_turfs))
		return enemy_turfs

	return move_turfs
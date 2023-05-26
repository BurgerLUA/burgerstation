/mob/living/simple/chess_piece
	name = "chess piece"
	icon = 'icons/mob/living/simple/chess.dmi'
	ai = null //Custom AI embedded in mob life.

	stun_angle = 90

	damage_type = /damagetype/chess/

	var/mob/living/simple/chess_piece/king/linked_king

	pixel_z = 4

/mob/living/simple/chess_piece/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!processing)
		return FALSE

	. = ..()

/mob/living/simple/chess_piece/post_move(var/atom/old_loc)

	. = ..()

	if(!loc || !old_loc)
		return .

	if(loc.z != old_loc.z || get_dist(loc,old_loc) <= 1)
		return .

	pixel_x = (old_loc.x - loc.x)*TILE_SIZE
	pixel_y = (old_loc.y - loc.y)*TILE_SIZE

	animate(src,pixel_x=0,pixel_y=0,time=2)


/mob/living/simple/chess_piece/proc/get_valid_move_turfs() //Returns a list.
	return list()

/mob/living/simple/chess_piece/proc/is_valid_turf(var/turf/T,var/ignore_pieces=FALSE,var/can_attack_enemies=TRUE,var/enemy_only=FALSE)
	//ignore_pieces: knights would ignore some pieces
	//can_attack_enemies: pawns wouldn't be able to attack straight ahead
	//enemy_only: pawns can only attack diagonally, but can't move normally that way.
	if(!T) return FALSE
	if(!ignore_pieces)
		var/found_enemy = FALSE
		var/found_player = FALSE
		var/found_ally = FALSE
		for(var/mob/living/L in T.contents)
			if(L.dead)
				continue
			if(L.loyalty_tag == src.loyalty_tag)
				found_ally = TRUE
				continue
			found_enemy = TRUE
			if(is_player(L))
				found_player = TRUE
		if(found_enemy)
			if(!can_attack_enemies)
				return FALSE
			if(!T.is_safe() || !T.can_move_to(check_contents=FALSE))
				return FALSE
			if(found_player)
				return 100 //Player.
			return 10 //Piece.
		else if(enemy_only)
			return FALSE
		if(found_ally)
			return FALSE
	return T.is_safe() && T.can_move_to(check_contents=FALSE) ? 1 : null
	//returns either FALSE, "enemy", or "unoccupied"



/mob/living/simple/chess_piece/pawn
	name = "pawn"
	var/black=FALSE
	var/times_moved = 0
	icon_state = "pawn_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

	health_base = 100

/mob/living/simple/chess_piece/pawn/black
	icon_state = "pawn_b"
	black = TRUE
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

/mob/living/simple/chess_piece/pawn/get_valid_move_turfs()

	. = list()

	var/score
	var/turf/T
	if(black)
		for(var/d in list(SOUTHWEST,SOUTHEAST))
			T = get_step(src,d)
			if(T)
				score = is_valid_turf(T,enemy_only=TRUE)
				if(score)
					.[T] = score
		if(length(.))
			return .
		T = get_step(src,SOUTH)
		if(T)
			score = is_valid_turf(T,can_attack_enemies=FALSE)
			if(score)
				.[T] = score
				if(!times_moved)
					T = get_step(T,SOUTH)
					score = is_valid_turf(T,can_attack_enemies=FALSE)
					if(score)
						.[T] = score
	else
		for(var/d in list(NORTHWEST,NORTHEAST))
			T = get_step(src,d)
			if(T)
				score = is_valid_turf(T,enemy_only=TRUE)
				if(score)
					.[T] = score
		if(length(.))
			return .
		T = get_step(src,NORTH)
		if(T)
			score = is_valid_turf(T,can_attack_enemies=FALSE)
			if(score)
				.[T] = score
				if(!times_moved)
					T = get_step(T,NORTH)
					score = is_valid_turf(T,can_attack_enemies=FALSE)
					if(score)
						.[T] = score



/mob/living/simple/chess_piece/knight
	name = "knight"
	icon_state = "knight_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

	health_base = 300

/mob/living/simple/chess_piece/knight/black
	icon_state = "knight_b"
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

/mob/living/simple/chess_piece/knight/get_valid_move_turfs()

	. = list()

	var/turf/T
	var/score
	for(var/d1 in DIRECTIONS_CARDINAL)
		var/move_amount = 0
		T = get_turf(src)
		for(var/i=1,i<=2,i++)
			if(!T)
				break
			T = get_step(T,d1)
			move_amount++
		if(T && move_amount == 2)
			for(var/d2 in list(turn(d1,90),turn(d1,-90)))
				var/turf/TL = get_step(T,d2)
				if(TL)
					score = is_valid_turf(TL)
					if(score)
						.[TL] = score

/mob/living/simple/chess_piece/rook
	name = "rook"
	icon_state = "rook_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

/mob/living/simple/chess_piece/rook/black
	icon_state = "rook_b"
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

	health_base = 500

/mob/living/simple/chess_piece/rook/get_valid_move_turfs()

	. = list()

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_turf(src)
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(result)
				.[T] = result
			if(result != 1)
				break

/mob/living/simple/chess_piece/bishop
	name = "bishop"
	icon_state = "bishop_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

	health_base = 400

/mob/living/simple/chess_piece/bishop/black
	icon_state = "bishop_b"
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

/mob/living/simple/chess_piece/bishop/get_valid_move_turfs()

	. = list()

	for(var/d in DIRECTIONS_INTERCARDINAL)
		var/turf/T = get_turf(src)
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(result)
				.[T] = result
			if(result != 1)
				break

/mob/living/simple/chess_piece/queen
	name = "queen"
	icon_state = "queen_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

	health_base = 300

	var/debug = FALSE

/mob/living/simple/chess_piece/queen/black
	icon_state = "queen_b"
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

/mob/living/simple/chess_piece/queen/get_valid_move_turfs()

	. = list()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_turf(src)
		for(var/i=1,i<=8,i++)
			T = get_step(T,d)
			var/result = is_valid_turf(T)
			if(result)
				.[T] = result
			if(result != 1)
				break


/mob/living/simple/chess_piece/king
	name = "king"
	icon_state = "king_w"
	iff_tag = "ChessWhite"
	loyalty_tag = "ChessWhite"

	health_base = 800

	var/list/mob/living/simple/chess_piece/linked_pieces = list()

	listener = TRUE

var/global/regex/bad_opinion = regex(@"en *passant *is *n[^f]*forced")

/mob/living/simple/chess_piece/king/proc/give_response()
	var/list/what_text = list(
		"fucking what",
		"dude what",
		"ok what",
		"shut your mouth",
		"????? what????",
		"ok???? idiot????"
	)
	src.do_say(pick(what_text))
	PROCESS_LIVING(src)
	return TRUE

/mob/living/simple/chess_piece/king/on_listen(var/atom/speaker,var/datum/source,var/text,var/raw_text,var/language_text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(talk_type == TEXT_RADIO) //Don't listen to other radio signals. This prevents spam.
		return ..()

	if(get_dist(source,src) > VIEW_RANGE)
		return ..()

	if(!src.processing && !CALLBACK_EXISTS("\ref[src]_response") && length(raw_text) && bad_opinion.Find(raw_text))
		CALLBACK("\ref[src]_response",rand(10,20),src,src::give_response())

	. = ..()


/mob/living/simple/chess_piece/king/on_life()
	. = ..()
	var/list/piece_to_score = list()
	var/list/piece_to_turf = list()

	for(var/k in linked_pieces + src)
		var/mob/living/simple/chess_piece/P = k
		if(P.dead)
			continue
		var/list/results = P.get_valid_move_turfs()
		if(length(results))
			var/turf/picked_turf = pickweight(results)
			var/score = results[picked_turf]
			piece_to_score[P] = score
			piece_to_turf[P] = picked_turf

	if(length(piece_to_turf))
		var/mob/living/simple/chess_piece/desired_piece = pickweight(piece_to_score)
		var/turf/desired_move = piece_to_turf[desired_piece]
		desired_piece.force_move(desired_move)
		for(var/mob/living/L in desired_move.contents)
			if(L.dead)
				continue
			if(L.loyalty_tag == src.loyalty_tag)
				continue
			desired_piece.attack(desired_piece,L)
			break

/mob/living/simple/chess_piece/king/black
	icon_state = "king_b"
	iff_tag = "ChessBlack"
	loyalty_tag = "ChessBlack"

/mob/living/simple/chess_piece/king/PostInitialize()
	. = ..()
	for(var/mob/living/simple/chess_piece/P in range(8,src)) //Link all the pieces.
		if(P.loyalty_tag != src.loyalty_tag)
			continue
		if(P == src)
			continue
		src.link_piece(P)

/mob/living/simple/chess_piece/king/proc/link_piece(var/mob/living/simple/chess_piece/P)

	if(!P)
		CRASH("Invalid piece!")

	if(P.loyalty_tag != src.loyalty_tag)
		CRASH("Bad loyalty tag!")

	if(P.linked_king)
		return FALSE

	src.linked_pieces += P
	P.linked_king = src

	return TRUE

/mob/living/simple/chess_piece/king/proc/unlink_piece(var/mob/living/simple/chess_piece/P)

	if(!P)
		CRASH("Invalid piece!")

	if(P.linked_king != src)
		return FALSE

	src.linked_pieces -= P
	P.linked_king = null

	return TRUE

/mob/living/simple/chess_piece/king/get_valid_move_turfs()

	var/list/enemy_turfs = list()
	var/list/move_turfs = list()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_step(src,d)
		var/result = is_valid_turf(T)
		if(result)
			if(result > 1)
				enemy_turfs[T] = result
			else
				move_turfs[T] = result

	if(length(enemy_turfs))
		return enemy_turfs

	return move_turfs
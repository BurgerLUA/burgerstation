/obj/item/ball
	name = "ball"

	icon = 'icons/obj/item/ball.dmi'

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/north_momentum = 0
	var/east_momentum = 0

	var/bounciness = 0.75

	movement_delay = 1

	density = TRUE

	var/dribbling = FALSE
	var/dribble_counter = 0

	var/balling = FALSE //If it's in the all_balls list

	value = 500

/obj/item/ball/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[initial(icon_state)]_shading")
	add_overlay(I)

/obj/item/ball/proc/set_balling(var/desired_balling=TRUE)

	if(desired_balling == balling)
		return FALSE

	balling = desired_balling
	if(balling)
		SSball.all_balls += src
	else
		SSball.all_balls -= src


	return TRUE


/obj/item/ball/Finalize()
	. = ..()
	update_sprite()
	set_balling(src.z ? TRUE : FALSE)

/obj/item/ball/PreDestroy()
	set_balling(FALSE)
	. = ..()

/obj/item/ball/post_move(var/atom/old_loc)
	. = ..()
	set_balling(src.z ? TRUE : FALSE)

/obj/item/ball/proc/ball_think(var/tick_rate=1)

	var/desired_move_dir = 0x0

	if(north_momentum > 0)
		desired_move_dir |= NORTH
		if(next_move <= 0)
			north_momentum -= 1
	else if(north_momentum < 0)
		desired_move_dir |= SOUTH
		if(next_move <= 0)
			north_momentum += 1
	if(east_momentum > 0)
		desired_move_dir |= EAST
		if(next_move <= 0)
			east_momentum -= 1
	else if(east_momentum < 0)
		desired_move_dir |= WEST
		if(next_move <= 0)
			east_momentum += 1

	north_momentum = FLOOR(north_momentum,1)
	east_momentum = FLOOR(east_momentum,1)

	if(!dribbling)
		movement_delay = max(1,10 - max(abs(north_momentum),abs(east_momentum))*4)

	move_dir = desired_move_dir

	if(move_dir)
		set_dir(move_dir)

	handle_movement(tick_rate)

	return TRUE


/obj/item/ball/soccer
	name = "soccer ball"
	desc = "Also known as a football."
	desc_extended = "You kick this. I guess you can throw this too."
	icon_state = "soccer"

/obj/item/ball/soccer/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","Hold ALT to move over the ball without kicking it.<br>Hold SPACE to triple your kicking power.<br>Hold SHIFT while running into the ball to double your kicking power.")

/obj/item/ball/soccer/Cross(atom/movable/O,atom/oldloc)
	return TRUE

/obj/item/ball/soccer/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	on_kick(O)

/obj/item/ball/soccer/Uncrossed(atom/movable/O)
	. = ..()
	on_kick(O,pull=TRUE)

/obj/item/ball/soccer/proc/on_kick(var/atom/movable/O,var/pull=FALSE)
	if(is_living(O))
		var/mob/living/L = O
		if(L.horizontal)
			return .
		if(L.attack_flags & CONTROL_MOD_DISARM)
			return .

		var/bump_dir = get_dir(src,O)

		var/move_mod = max(1,(L.move_mod-1)**2)

		if(pull)
			bump_dir = L.dir //Push back.
			move_mod *= 2
		else if(L.attack_flags & CONTROL_MOD_KICK)
			move_mod *= 3

		if(bump_dir & NORTH)
			if(north_momentum > 0)
				north_momentum = FLOOR(-north_momentum*bounciness,1)
			north_momentum -= move_mod
		else if(bump_dir & SOUTH)
			if(north_momentum < 0)
				north_momentum = FLOOR(-north_momentum*bounciness,1)
			north_momentum += move_mod
		if(bump_dir & EAST)
			if(east_momentum > 0)
				east_momentum = FLOOR(-east_momentum*bounciness,1)
			east_momentum -= move_mod
		else if(bump_dir & WEST)
			if(east_momentum < 0)
				east_momentum = FLOOR(-east_momentum*bounciness,1)
			east_momentum += move_mod

		if(move_mod == 1 && O.next_move > 0)
			movement_delay = max(1,O.next_move - 1)
			dribbling = TRUE
			dribble_counter = !dribble_counter
		else
			dribbling = FALSE
			dribble_counter = 0

		if(!dribble_counter)
			play_sound('sound/effects/ball_kick.ogg',get_turf(src),volume=30+move_mod*10,pitch=RAND_PRECISE(0.95,1.05)+move_mod*0.05)

	return TRUE

/obj/item/ball/soccer/Bump(atom/Obstacle)

	var/bump_dir = get_dir(src,Obstacle)

	if(bump_dir & NORTH)
		if(north_momentum > 0)
			north_momentum = FLOOR(-north_momentum*bounciness,1)
	else if(bump_dir & SOUTH)
		if(north_momentum < 0)
			north_momentum = FLOOR(-north_momentum*bounciness,1)

	if(bump_dir & EAST)
		if(east_momentum > 0)
			east_momentum = FLOOR(-east_momentum*bounciness,1)
	else if(bump_dir & WEST)
		if(east_momentum < 0)
			east_momentum = FLOOR(-east_momentum*bounciness,1)

	var/momentum = max(abs(north_momentum),abs(east_momentum))

	play_sound('sound/effects/ball_kick.ogg',get_turf(src),volume=20+momentum*10,pitch=RAND_PRECISE(0.8,0.9)+momentum*0.05)

	. = ..()




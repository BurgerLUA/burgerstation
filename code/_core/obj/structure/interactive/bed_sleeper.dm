#define SLEEPER_OPENED "open"
#define SLEEPER_OPENING "opening"

#define SLEEPER_CLOSED "closed"
#define SLEEPER_CLOSING "closing"


obj/structure/interactive/bed/sleeper
	name = "sleeper"
	icon_state = "sleeper"
	icon = 'icons/obj/structure/sleeper.dmi'
	icon_state = "sleeper"

	var/door_state = SLEEPER_CLOSED

	var/base_color = "#FFFFFF"
	secondary_color = "#FFFFFF"

	var/open_sound
	var/close_sound

	var/open_time = 10
	var/close_time = 10

	pixel_offset_x = 8
	layer = LAYER_MOB_ABOVE
	plane = PLANE_MOB

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

obj/structure/interactive/bed/sleeper/Initialize()
	new /obj/structure/interactive/blocker(get_step(loc,EAST),src)
	update_sprite()
	check_collisions()
	return ..()

obj/structure/interactive/bed/sleeper/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),initial(icon_state))
	I.layer = LAYER_MOB_BELOW
	I.color = base_color
	underlays += I
	return .

obj/structure/interactive/bed/sleeper/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(!.)
		if(door_state == SLEEPER_CLOSED)
			open()
		else if(door_state == SLEEPER_OPENED)
			close()

		return TRUE

	return .

/obj/structure/interactive/bed/sleeper/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	. = ..()

	if(. && door_state == SLEEPER_OPENED)
		close()

	return .

obj/structure/interactive/bed/sleeper/unbuckle(var/mob/caller,var/silent=FALSE)

	if(door_state == SLEEPER_CLOSED)
		open()
		return FALSE
	else if(door_state != SLEEPER_OPENED)
		return FALSE

	return ..()

obj/structure/interactive/bed/sleeper/proc/open()
	if(open_sound)
		play(open_sound,src)
	door_state = SLEEPER_OPENING
	update_icon()
	spawn(open_time)
		door_state = SLEEPER_OPENED
		opened_time = 0
		update_icon()
		check_collisions()
	start_thinking(src)

obj/structure/interactive/bed/sleeper/proc/close()
	if(close_sound)
		play(close_sound,src)
	door_state = SLEEPER_CLOSING
	update_icon()
	spawn(close_time)
		door_state = SLEEPER_CLOSED
		opened_time = 0
		update_icon()
		check_collisions()
	stop_thinking(src)

obj/structure/interactive/bed/sleeper/think()

	if(buckled)
		return TRUE

	for(var/mob/living/L in loc.contents)
		return TRUE

	if(door_state == SLEEPER_OPENED && opened_time >= 100)
		close()
		return FALSE

	opened_time++

	return TRUE

obj/structure/interactive/bed/sleeper/proc/check_collisions()

	collision_flags = initial(collision_flags)
	collision_bullet_flags = initial(collision_flags)

	switch(door_state)
		if(SLEEPER_OPENED)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
			set_light(FALSE)
		if(SLEEPER_CLOSED)
			set_light(2, 0.5, secondary_color)
		if(SLEEPER_OPENING)
			set_light(2, 0.25, secondary_color)
		if(SLEEPER_CLOSING)
			set_light(2, 0.25, secondary_color)

	update_collisions(collision_flags,collision_bullet_flags) //Dumb way of doing this but it werks.

	return TRUE


obj/structure/interactive/bed/sleeper/update_icon()
	var/icon/I = new/icon(initial(icon),door_state)
	I.Blend(secondary_color,ICON_MULTIPLY)
	icon = I
	return TRUE

obj/structure/interactive/bed/sleeper/backup
	name = "spare hypersleep chamber"
	base_color = "#AAAAAA"
	secondary_color = "#00FF00"

var/global/list/obj/structure/interactive/bed/sleeper/backup/backup_spawnpoints = list()

obj/structure/interactive/bed/sleeper/backup/New(var/desired_loc)
	backup_spawnpoints += src
	return ..()

obj/structure/interactive/bed/sleeper/cryo
	name = "hypersleep chamber"
	base_color = "#AAAAAA"
	secondary_color = "#00FF00"

var/global/list/obj/structure/interactive/bed/sleeper/cryo/cryo_spawnpoints = list()

obj/structure/interactive/bed/sleeper/cryo/New(var/desired_loc)
	cryo_spawnpoints += src
	return ..()

obj/structure/interactive/bed/sleeper/medical
	name = "medical sleeper"
	base_color = "#FFFFFF"
	secondary_color = "#0094FF"

obj/structure/interactive/bed/sleeper/syndicate
	name = "syndicate sleeper"
	base_color = "#303030"
	secondary_color = "#7F0000"

obj/structure/interactive/bed/sleeper/chef
	name = "chef sleeper"
	base_color = "#AAAAAA"
	secondary_color = "#00FF00"
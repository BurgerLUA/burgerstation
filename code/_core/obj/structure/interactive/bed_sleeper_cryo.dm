var/global/list/obj/structure/interactive/bed/sleeper/cryo/cryo_spawnpoints = list()


/obj/structure/interactive/bed/sleeper/cryo
	name = "hypersleep chamber"
	base_color = "#AAAAAA"
	desc = "Ah shit, i gotta cryo."
	desc_extended = "Move inside here in order to save your character and log out."
	secondary_color = "#00FF00"
	var/spawnpoint = TRUE

/obj/structure/interactive/bed/sleeper/cryo/New(var/desired_loc)
	if(spawnpoint) cryo_spawnpoints += src
	return ..()

/obj/structure/interactive/bed/sleeper/can_buckle(var/mob/living/advanced/A,var/mob/caller)

	if(!is_player(A))
		return FALSE

	return ..()

/obj/structure/interactive/bed/sleeper/cryo/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	. = ..()

	if(.)
		cryo_spawnpoints -= src //Occupied!

	return .

/obj/structure/interactive/bed/sleeper/cryo/on_close(var/mob/caller)

	. = ..()

	if(.)

		if(is_player(buckled) && !buckled.dead && buckled.ckey_last && !buckled.ckey)
			var/mob/living/advanced/player/P = buckled
			var/area/A = get_area(P)
			if(P.can_save(A))
				P.logout()

		if(!buckled)
			cryo_spawnpoints |= src //Unoccupied!

	return .

/obj/structure/interactive/bed/sleeper/cryo/no_spawn
	spawnpoint = FALSE


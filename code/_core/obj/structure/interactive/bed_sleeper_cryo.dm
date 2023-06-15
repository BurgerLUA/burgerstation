var/global/list/obj/structure/interactive/bed/sleeper/cryo/cryo_spawnpoints = list()


/obj/structure/interactive/bed/sleeper/cryo
	name = "hypersleep chamber"
	base_color = "#AAAAAA"
	desc = "Ah shit, I gotta cryo."
	desc_extended = "Buckle yourself into this <u>and press the \"LOG OUT\" button</u> to safely exit the game."
	secondary_color = "#00FF00"
	tertiary_color = "#008800"
	var/spawnpoint = TRUE

/obj/structure/interactive/bed/sleeper/cryo/New(var/desired_loc)
	if(spawnpoint) cryo_spawnpoints += src
	return ..()

/obj/structure/interactive/bed/sleeper/can_buckle(var/mob/living/advanced/A,var/mob/caller)

	if(!is_player(A))
		return FALSE

	. = ..()

/obj/structure/interactive/bed/sleeper/cryo/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	. = ..()

	if(.)
		cryo_spawnpoints -= src //Occupied!


/obj/structure/interactive/bed/sleeper/cryo/think()
	. = ..()
	if(is_player(buckled) && !buckled.client && !buckled.dead)
		var/mob/living/advanced/player/P = buckled
		var/area/A = get_area(P)
		if(P.can_save(A))
			P.try_logout()
	if(buckled)
		return TRUE

/obj/structure/interactive/bed/sleeper/cryo/on_close(var/mob/caller)

	. = ..()

	if(.)
		if(!buckled)
			cryo_spawnpoints |= src //Unoccupied!


/obj/structure/interactive/bed/sleeper/cryo/no_spawn
	spawnpoint = FALSE


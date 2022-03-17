/obj/structure/interactive/blob/wall
	name = "blob wall"
	icon_state = "wall"
	health_states = 4


/obj/structure/interactive/blob/wall/Finalize()
	. = ..()
	if(!prob(80)) //Blob optimization
		make_spore()
	CALLBACK("make_spore_\ref[src]",SECONDS_TO_DECISECONDS(2),src,.proc/make_spore)

/obj/structure/interactive/blob/wall/proc/make_spore()
	if(qdeleting || !isturf(src.loc))
		return FALSE
	var/mob/living/simple/blob_spore/BS = new(src.loc)
	INITIALIZE(BS)
	GENERATE(BS)
	FINALIZE(BS)
	BS.idle = TRUE
	BS.icon_state = "blobpod_idle"
	return TRUE
/obj/structure/interactive/blob/wall
	name = "blob wall"
	desc_extended = "A segment of the ever-expanding blob. May create blob spores."
	icon_state = "wall"
	health_states = 4

/obj/structure/interactive/blob/wall/Finalize()
	. = ..()
	if(prob(10)) //Blob optimization
		CALLBACK("make_spore_\ref[src]",2 SECONDS,src,src::make_spore())

/obj/structure/interactive/blob/wall/proc/make_spore()
	if(qdeleting || !src.z)
		return FALSE
	var/mob/living/simple/blob_spore/BS = new(src.loc)
	INITIALIZE(BS)
	GENERATE(BS)
	FINALIZE(BS)
	BS.idle = TRUE
	BS.icon_state = "blobpod_idle"
	return TRUE

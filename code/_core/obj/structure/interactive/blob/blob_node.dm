/obj/structure/interactive/blob/node
	name = "blob node"
	icon_state = "node"
	has_damaged_state = TRUE
	health_base = 250

	health_states = 1

	var/mob/living/simple/blobbernaught/linked_blobbernaught

	var/next_jug = 0

/obj/structure/interactive/blob/node/proc/check_jugs()

	if(!initialized || qdeleting)
		return FALSE

	if(!linked_blobbernaught)
		if(next_jug <= world.time)
			linked_blobbernaught = new(get_turf(src),null,1,src)
			INITIALIZE(linked_blobbernaught)
			FINALIZE(linked_blobbernaught)
			return TRUE
	else if(linked_blobbernaught.dead)
		linked_blobbernaught = null
		next_jug = world.time + SECONDS_TO_DECISECONDS(60)

	return FALSE

/obj/structure/interactive/blob/node/New(var/desired_loc,var/obj/structure/interactive/blob/core/desired_owner)

	. = ..()

	if(desired_owner)
		desired_owner.linked_nodes += src

	return .

/obj/structure/interactive/blob/node/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"node_overlay")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	add_overlay(I)
	return .
/obj/structure/interactive/blob/node
	name = "blob node"
	icon_state = "node"
	desc_extended = "A segment of the ever-expanding blob. This one creates and deploys blobbernaughts if the blob's expanse is hindered by the living."
	has_damaged_state = TRUE
	health_base = 250

	health_states = 2

	var/mob/living/simple/blobbernaught/linked_blobbernaught

	var/next_spawn = 0

/obj/structure/interactive/blob/node/Destroy()
	. = ..()
	linked_blobbernaught = null

/obj/structure/interactive/blob/node/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)
	. = ..()
	if(.)
		check_jugs()

/obj/structure/interactive/blob/node/proc/check_jugs()

	if(!finalized || qdeleting)
		return FALSE

	if(!linked_blobbernaught)
		if(next_spawn <= world.time)
			linked_blobbernaught = new(get_turf(src),null,1,src)
			INITIALIZE(linked_blobbernaught)
			GENERATE(linked_blobbernaught)
			FINALIZE(linked_blobbernaught)
			return TRUE
	else if(linked_blobbernaught.dead || linked_blobbernaught.qdeleting)
		linked_blobbernaught = null
		next_spawn = world.time + 60 SECONDS

	return FALSE

/obj/structure/interactive/blob/node/New(desired_loc,obj/structure/interactive/blob/core/desired_owner)

	. = ..()

	if(desired_owner)
		desired_owner.linked_nodes += src


/obj/structure/interactive/blob/node/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"node_overlay")
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	add_overlay(I)

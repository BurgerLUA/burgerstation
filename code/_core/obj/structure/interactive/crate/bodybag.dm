/obj/structure/interactive/crate/bodybag
    name = "body bag"
    desc = "You were loud and ugly and now your dead!"
    desc_extended = "A plastic bag to transport corpse."
    icon = 'icons/obj/structure/crates.dmi'
    icon_state = "bodybag"

    value = 100 //same value as /obj/item/deployable/bodybag to avoid money dubing
    anchored = FALSE
    collision_flags = FLAG_COLLISION_NONE //Not wall because crawling.
    collision_bullet_flags = FLAG_COLLISION_BULLET_NONE //you'd always shoot OVER the body bag no?
    density = TRUE
    layer = LAYER_OBJ_CRATE
    size = SIZE_HUMAN

/obj/structure/interactive/crate/bodybag/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)


	if(caller.attack_flags & CONTROL_MOD_ALT)
		if(can_pack_up(caller))
			caller.visible_message(span("warning","\The [caller.name] starts to pack up \the [src.name]..."),span("notice","You start to pack up \the [src.name]..."))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/pack_up,caller)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)
		return TRUE

	return ..()


/obj/structure/interactive/crate/bodybag/proc/can_pack_up(var/mob/caller)
    INTERACT_CHECK_NO_DELAY(src)

    if(length(src.contents))
        caller.to_chat(span("warning","You can't pack up \the [src.name] while its full!"))
        return FALSE

    if(qdeleting || !isturf(src.loc))
        caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
        return FALSE

    return TRUE

/obj/structure/interactive/crate/bodybag/proc/pack_up(var/mob/caller)

	caller.visible_message(span("warning","\The [caller.name] packs up \the [src.name]."),span("notice","You pack up \the [src.name]."))

	var/obj/item/deployable/bodybag/S = new(get_turf(src))
	INITIALIZE(S)
	FINALIZE(S)

	qdel(src)

	return TRUE


/obj/item/deployable/bodybag
    name = "bodybag"
    desc = "Why would you carry these, not like you can bag yourself. Unless...."
    desc_extended = "A plastic bag meant to transport corpses."
    structure_to_deploy = /obj/structure/interactive/crate/bodybag
    icon = 'icons/obj/item/deployable/bodybag.dmi'
    value = 100
    weight = 3

    item_count_max = 5

    size = SIZE_3

/obj/item/deployable/bodybag/get_deploy_time(var/mob/caller)
	return SECONDS_TO_DECISECONDS(1)

/obj/item/deployable/bodybag/can_deploy_to(var/mob/caller,var/turf/T)

    if(item_count_current <= 0)
        qdel(src)
        return FALSE

    return TRUE //to deploy structures it checks if the turf allows construction, but this would mean you cant place it on the station so not even medbay

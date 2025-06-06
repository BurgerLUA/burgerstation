/obj/structure/interactive/crate/bodybag
	name = "body bag"
	desc = "You were loud and ugly and now your dead!"
	desc_extended = "A plastic bag to transport corpses."
	icon = 'icons/obj/structure/crates.dmi'
	icon_state = "bodybag"

	collision_flags = FLAG_COLLISION_WALKING //Not wall because crawling.
	collision_bullet_flags = FLAG_COLLISION_BULLET_SPECIFIC

	value = 100 //same value as /obj/item/deployable/bodybag to avoid money duping
	anchored = FALSE
	bullet_block_chance = 0

	pixel_y = 2

	density = TRUE

/obj/structure/interactive/crate/bodybag/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","ALT+Click this with an empty hand to pack up and retrieve.")

/obj/structure/interactive/crate/bodybag/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)


	if(activator.attack_flags & CONTROL_MOD_DISARM)
		if(can_pack_up(activator))
			activator.visible_message(span("warning","\The [activator.name] starts to pack up \the [src.name]..."),span("notice","You start to pack up \the [src.name]..."))
			PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(5),src::pack_up(),activator)
			PROGRESS_BAR_CONDITIONS(activator,src,src::can_pack_up(),activator)
		return TRUE

	return ..()


/obj/structure/interactive/crate/bodybag/proc/can_pack_up(var/mob/activator)
    INTERACT_CHECK_NO_DELAY(src)

    if(length(src.contents))
        activator.to_chat(span("warning","You can't pack up \the [src.name] while its full!"))
        return FALSE

    if(qdeleting || !src.z)
        activator.to_chat(span("warning","You can't pack up \the [src.name] here!"))
        return FALSE

    return TRUE

/obj/structure/interactive/crate/bodybag/proc/pack_up(var/mob/activator)

	activator.visible_message(span("warning","\The [activator.name] packs up \the [src.name]."),span("notice","You pack up \the [src.name]."))

	var/obj/item/deployable/bodybag/S = new(get_turf(src))
	INITIALIZE(S)
	FINALIZE(S)

	qdel(src)

	return TRUE


/obj/item/deployable/bodybag
    name = "bodybag"
    desc = "Why would you carry these, not like you can bag yourself. Unless...."
    desc_extended = "A plastic bag meant to transport corpses. Use to deploy."
    structure_to_deploy = /obj/structure/interactive/crate/bodybag
    icon = 'icons/obj/item/deployable/bodybag.dmi'
    value = 100
    weight = 3

    amount_max = 5

    size = SIZE_3

/obj/item/deployable/bodybag/get_deploy_time(var/mob/activator)
	return SECONDS_TO_DECISECONDS(1)

/obj/item/deployable/bodybag/can_deploy_to(var/mob/activator,var/turf/T)

    if(amount <= 0)
        qdel(src)
        return FALSE

    return TRUE //to deploy structures it checks if the turf allows construction, but this would mean you cant place it on the station so not even medbay

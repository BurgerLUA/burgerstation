var/global/datum/dark_shadow = new /atom/movable/openspace_backdrop

/atom/movable/openspace_backdrop
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"
    anchored = TRUE
    vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

/turf/simulated/floor/openspace
    name = "openspace"
    desc = "Down the rabbit hole you go!"
    desc_extended = "A hole that leads to a lower level, be careful as they can hurt."
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"
    destruction_turf = /turf/simulated/floor/openspace
    var/turf/belowTurf

/turf/simulated/floor/openspace/Initialize()
    . = ..()
    vis_contents += dark_shadow
    belowTurf = locate(x,y,z-1)
    if(belowTurf)
        vis_contents += belowTurf

/turf/simulated/floor/openspace/Entered(atom/movable/O, atom/new_loc)
    . = ..()
    if(is_observer(O))
        return
    if(!istype(belowTurf, /turf/simulated/floor/stair))
        if(is_living(O))
            var/mob/living/livingO = O
            livingO.add_status_effect(STUN,10,10)
            livingO.health.adjust_loss_smart(brute = 75)
    O.force_move(belowTurf)
    if(O.grabbing_hand.grabbed_object)
        O.grabbing_hand.grabbed_object.force_move(belowTurf)

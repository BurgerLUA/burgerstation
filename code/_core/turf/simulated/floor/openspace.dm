var/global/datum/openspace_backdrop = new /atom/movable/openspace_backdrop

/atom/movable/openspace_backdrop
    name			= "openspace_backdrop"
    anchored		= TRUE
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"

/turf/simulated/floor/openspace
    name = "openspace"
    desc = "Down the rabbit hole you go!"
    desc_extended = "A hole that leads to a lower level, be careful as they can hurt."
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"
    plane = PLANE_OPENSPACE
    destruction_turf = /turf/simulated/floor/openspace

/turf/simulated/floor/openspace/Finalize()
    . = ..()
    vis_contents += openspace_backdrop
    update_multiz()

/turf/simulated/floor/openspace/update_icon()
    var/turf/belowTurf = locate(x,y,z-1)
    icon = belowTurf.icon
    icon_state = belowTurf.icon_state
    return ..()


/turf/simulated/floor/openspace/proc/update_multiz(prune_on_fail = FALSE, init = FALSE)
    var/turf/belowTurf = locate(x,y,z-1)
    if(!belowTurf)
        vis_contents.len = 0
        change_turf(/turf/simulated/floor/plating)
        return
    update_icon()
    vis_contents += belowTurf

/turf/simulated/floor/openspace/Entered(atom/movable/O, atom/new_loc)
    . = ..()
    var/turf/belowTurf = locate(x,y,z-1)
    if(!istype(belowTurf, /turf/simulated/floor/stair))
        if(is_living(O))
            var/mob/living/livingO = O
            livingO.add_status_effect(STUN,10,10)
            livingO.health.adjust_loss_smart(brute = 75)
    O.force_move(belowTurf)

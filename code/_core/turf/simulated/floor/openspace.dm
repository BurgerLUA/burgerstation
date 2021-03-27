var/global/datum/dark_shadow = new /atom/movable/openspace_backdrop

/atom/movable/openspace_backdrop
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"
    anchored = TRUE
    plane = PLANE_OPENSPACE_FLOOR
    layer = LAYER_OPENSPACE

/turf/simulated/floor/openspace
    name = "openspace"
    desc = "Down the rabbit hole you go!"
    desc_extended = "A hole that leads to a lower level, be careful as they can hurt."
    icon = 'icons/turf/floor/openspace.dmi'
    icon_state = "openspace_background"
    destruction_turf = /turf/simulated/floor/openspace

/turf/simulated/floor/openspace/Finalize()
    . = ..()
    update_icon()
    vis_contents += dark_shadow

/turf/simulated/floor/openspace/update_icon()
    var/turf/belowTurf = locate(x,y,z-1)
    icon = belowTurf.icon
    icon_state = belowTurf.icon_state
    dir = belowTurf.dir
    color = belowTurf.color
    return ..()

/turf/simulated/floor/openspace/Entered(atom/movable/O, atom/new_loc)
    . = ..()
    if(is_observer(O))
        return
    var/turf/belowTurf = locate(x,y,z-1)
    if(!istype(belowTurf, /turf/simulated/floor/stair))
        if(is_living(O))
            var/mob/living/livingO = O
            livingO.add_status_effect(STUN,10,10)
            livingO.health.adjust_loss_smart(brute = 75)
    O.force_move(belowTurf)

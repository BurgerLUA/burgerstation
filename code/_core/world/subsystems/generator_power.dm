SUBSYSTEM_DEF(generator_power)
    name = "Generator Power Subsystem"
    desc = "The system for turning off/on lights, and deciding if there is station power."
    priority = SS_ORDER_NORMAL

    var/list/stationside_lights = list()
    var/station_power = TRUE

/subsystem/generator_power/proc/turn_off_lights()
    for(var/obj/structure/interactive/lighting/fixture/L in stationside_lights)
        if(!L.on)
            continue
        L.on = FALSE
        L.update_atom_light()
        L.update_sprite()

/subsystem/generator_power/proc/turn_on_lights()
    for(var/obj/structure/interactive/lighting/fixture/L in stationside_lights)
        if(L.on)
            continue
        L.on = TRUE
        L.update_atom_light()
        L.update_sprite()

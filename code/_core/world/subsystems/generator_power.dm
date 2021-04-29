SUBSYSTEM_DEF(generator_power)
    name = "Generator Power Subsystem"
    desc = "The system for turning off/on lights, and deciding if there is station power."
    priority = SS_ORDER_NORMAL

    var/list/stationside_lights = list()
    var/station_power = TRUE
    var/obj/structure/interactive/fusion_generator/linked_gen

    tick_rate = SECONDS_TO_TICKS(10) //we check every minute, but the gens are 5 minutes

/subsystem/generator_power/on_life()
    linked_gen.power_think()
    return TRUE

/subsystem/generator_power/proc/turn_off_lights()
    for(var/obj/structure/interactive/lighting/fixture/L in stationside_lights)
        if(!L.on)
            continue
        L.on = FALSE
        L.update_atom_light()
        L.update_sprite()

/subsystem/generator_power/proc/turn_on_lights()
    for(var/k in stationside_lights)
        var/obj/structure/interactive/lighting/fixture/L = k
        if(L.on)
            continue
        L.on = TRUE
        L.update_atom_light()
        L.update_sprite()

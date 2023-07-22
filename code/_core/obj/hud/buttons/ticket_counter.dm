var/global/list/hud_ticket_counters = list()
/obj/hud/button/ticket_counter
    name = "tickets"
    desc = "Counts the tickets for a certain team."
    flags = FLAGS_HUD_MOB
    icon = 'icons/halo/hud/fucking.dmi'
    icon_state = "tickets"
    is_static = TRUE
    screen_loc = "CENTER,TOP"
    maptext_height = 16
    maptext_width = 128
    maptext_y = 21
    mouse_opacity = 1
    var/team = "FUCK"

/obj/hud/button/ticket_counter/New(desired_loc)
    . = ..()
    hud_ticket_counters += src

/obj/hud/button/ticket_counter/Destroy()
    . = ..()
    hud_ticket_counters -= src

/obj/hud/button/ticket_counter/update_owner(mob/desired_owner)
    var/gamemode/gamemode = SSgamemode.active_gamemode
    // if our team is gone we are fucking useless
    if(!team || isnull(gamemode.team_points[team]))
        qdel(src)
        return FALSE
    . = ..()
    update_maptext()

/obj/hud/button/ticket_counter/proc/update_maptext()
    maptext = TICKET_COUNTER_TEXT(team, get_points())

/obj/hud/button/ticket_counter/proc/get_points()
    var/points = SSgamemode.active_gamemode.team_points[team]
    if(isnull(points))
        return 0
    return points

/obj/hud/button/ticket_counter/unsc
    name = "unsc tickets"
    team = TEAM_UNSC
    screen_loc = "CENTER,TOP"

/obj/hud/button/ticket_counter/covenant
    name = "covenant tickets"
    team = TEAM_COVENANT
    screen_loc = "CENTER,TOP:-12"

/obj/hud/button/ticket_counter/urf
    name = "urf tickets"
    team = TEAM_URF
    screen_loc = "CENTER,TOP:-24"

/obj/hud/button/ticket_counter/urf/update_maptext()
    . = ..()
    var/gamemode/gamemode = SSgamemode.active_gamemode
    //stupid snowflake code i don't care
    if(isnull(gamemode.team_points[TEAM_COVENANT]))
        screen_loc = "CENTER,TOP:-12"

var/global/list/obj/structure/interactive/supermatter/known_supermatters = list()

/obj/structure/interactive/supermatter
	name = "supermatter crystal"
	desc = "Looks valuable!"
	desc_extended = "An extremely important and extremely unstable shard of supermatter. You should protect this at all costs if you're NanoTrasen..."
	icon = 'icons/obj/structure/supermatter.dmi'
	icon_state = "supermatter"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	value = 1000

	density = TRUE

	var/last_warning_percent = 1
	var/last_warning_time = 0

	health = /health/construction/
	health_base = 2000

	desired_light_power = 0.75
	desired_light_range = 6
	desired_light_color = "#FFFF00"

/obj/structure/interactive/supermatter/New(var/desired_loc)
	known_supermatters += src
	return ..()

/obj/structure/interactive/supermatter/Destroy()
	known_supermatters -= src
	return ..()

/obj/structure/interactive/supermatter/on_destruction(var/mob/caller,var/damage = FALSE)
	var/turf/T = get_turf(src)
	qdel(src)
	. = ..()
	explode(T,VIEW_RANGE,src,src)
	return .

/obj/structure/interactive/supermatter/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	var/health_percent = health.health_current/health.health_max
	var/threshold = health_percent*0.2
	if((last_warning_percent - health_percent) >= threshold && last_warning_time + SECONDS_TO_DECISECONDS(5) <= world.time)
		trigger_warning()

	return .

/obj/structure/interactive/supermatter/unanchored
	anchored = FALSE

/obj/structure/interactive/supermatter/proc/trigger_warning()
	var/health_percent = health.health_current/health.health_max
	var/message = "Warning: Supermatter Crystal at [FLOOR(health_percent*100,1)]% integrity."
	last_warning_percent = health_percent
	if(health_percent <= 0.2)
		message = "[message] DELAMINATION IMMINENT!!"
	use_radio(src,src,message,LANGUAGE_BASIC,TEXT_RADIO,RADIO_FREQ_COMMON,LANGUAGE_BASIC,TALK_RANGE)
	last_warning_percent = health_percent
	last_warning_time = world.time
	return TRUE
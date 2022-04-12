var/global/list/obj/structure/interactive/supermatter/known_supermatters = list()

/obj/structure/interactive/supermatter
	name = "supermatter crystal"
	desc = "Looks valuable!"
	desc_extended = "An extremely rare and mysterious cluster of supermatter crystals. Emits radioactive energy while at the same time providing an insane amount of energy when charged."
	icon = 'icons/obj/structure/supermatter.dmi'
	icon_state = "sm_map"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = 0x0 //Special stuff.

	value = 10000

	density = TRUE
	anchored = TRUE

	var/last_warning_percent = 1
	var/last_warning_time = 0

	health = /health/construction/
	health_base = 2000

	var/charge = 0
	var/charge_max = SECONDS_TO_DECISECONDS(60)

	var/sound_spam = 0
	var/display_spam = 0

	wire_powered = TRUE

	desired_light_power = 1
	desired_light_range = VIEW_RANGE*0.5
	desired_light_color = "#FFFF00"

	pixel_x = -16

	var/queue_power_update = FALSE

/obj/structure/interactive/supermatter/Finalize()
	. = ..()
	update_sprite()
	queue_power_update = TRUE

/obj/structure/interactive/supermatter/power_process(var/power_multiplier=1)

	if(queue_power_update)
		update_power_supply(get_power_supply())
		update_icon()
		queue_power_update = FALSE

	var/charge_to_take = min(10,charge)
	if(charge_to_take > 0)
		add_charge(-charge_to_take)
		if(charge >= charge_max*0.25 && charge <= charge_max*0.5) //Healing sweet spot.
			health.adjust_loss_smart(burn=-charge_to_take,brute=-charge_to_take)

	. = ..()

/obj/structure/interactive/supermatter/get_power_supply()
	return FLOOR( (0.1 + (charge/charge_max)*0.9)*INFINITY, 1) //Not actually infinity

/obj/structure/interactive/supermatter/update_underlays()
	. = ..()
	var/image/I	= new/image(icon,"sm_base")
	I.appearance_flags = src.appearance_flags | RESET_COLOR
	add_underlay(I)

/obj/structure/interactive/supermatter/update_icon()
	. = ..()
	icon = initial(icon)
	if(!charge)
		icon_state = "sm_off"
	else
		icon_state = "sm_on"

	if(health)
		var/health_co = health.health_current/health.health_max
		color = rgb(255,255*health_co,255*health_co)

/obj/structure/interactive/supermatter/Cross(var/atom/movable/O,var/atom/oldloc)
	if(istype(O,/obj/structure/interactive/supermatter))
		return FALSE
	. = ..()

/obj/structure/interactive/supermatter/Crossed(var/atom/movable/O)

	. = ..()

	if(O.density && O.dust(src))
		var/turf/T = get_turf(src)
		add_charge(O.health ? max(1,O.health.health_max*0.1) : 1)

		if(sound_spam <= world.time)
			play_sound('sound/effects/supermatter_dust.ogg',T)
			sound_spam = world.time + 5
			display_spam = 0
		if(display_spam <= world.time)
			src.visible_message(span("danger","\The [O.name] flashes in a brilliant light as the [src.name]'s energy swallows it!"))
			display_spam = world.time + 1

/obj/structure/interactive/supermatter/proc/add_charge(var/charge_amount=0)
	if(charge_max <= 0)
		return FALSE
	if(!charge_amount)
		return FALSE
	charge += charge_amount
	queue_power_update = TRUE
	if(charge >= charge_max)
		var/turf/T = get_turf(src)
		health.adjust_loss(BURN,health.health_max*0.1)
		charge_amount = charge_max*0.9
		visible_message(span("danger","\The [src.name] flashes  violently!"))
		use_radio(src,src,"WARNING: Supermatter overcharge detected! Dumping excess energy!",LANGUAGE_BASIC,TEXT_RADIO,RADIO_FREQ_COMMON,LANGUAGE_BASIC,TALK_RANGE)
		explode(T,1000,T,T,"Supermatter")
	else if(charge < 0)
		var/turf/T = get_turf(src)
		health.adjust_loss(BRUTE,health.health_max*0.1)
		charge_amount = charge_max*0.1
		use_radio(src,src,"WARNING: Supermatter negative charge detected! Implosion detected!",LANGUAGE_BASIC,TEXT_RADIO,RADIO_FREQ_COMMON,LANGUAGE_BASIC,TALK_RANGE)
		visible_message(span("danger","\The [src.name] creaks violently!"))
		explode(T,1000,T,T,"Supermatter")

	return TRUE

/obj/structure/interactive/supermatter/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)
	. = ..()

	if(damage_amount > 0) add_charge(FLOOR(damage_amount*0.1,1))

	if(health)
		var/health_percent = health.health_current/health.health_max
		var/threshold = max(0.01,health_percent*0.2)
		if((last_warning_percent - health_percent) >= threshold && last_warning_time + SECONDS_TO_DECISECONDS(3) <= world.time)
			trigger_warning()
		//update_map_text()

/obj/structure/interactive/supermatter/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)
	if(source == src)
		return FALSE
	. = ..()

/obj/structure/interactive/supermatter/on_destruction(var/mob/caller,var/damage = FALSE)
	charge = 0
	var/turf/T = get_turf(src)
	qdel(src)
	. = ..()
	if(is_living(caller))
		var/mob/living/L = caller
		if(L.is_player_controlled())
			log_admin("Player [L.get_debug_name()] belonging to [L.loyalty_tag] destroyed the supermatter.")
	explode(T,10000,T,T,"Supermatter")

/*
/obj/structure/interactive/supermatter/proc/update_map_text()
	if(!health)
		return FALSE
	maptext = "<div style='font-size: 2;color:green;text-outline:1px black solid'>[FLOOR(100*(health.health_current/health.health_max),1)]%</div>"
	return TRUE
*/

/obj/structure/interactive/supermatter/proc/trigger_warning()
	var/health_percent = health.health_current/health.health_max
	if(health_percent <= 0.9)
		var/message = "Warning: Supermatter Crystal at [FLOOR(health_percent*100,1)]% integrity."
		last_warning_percent = health_percent
		if(health_percent <= 0.2)
			message = "[message] DELAMINATION IMMINENT!!"
		use_radio(src,src,message,LANGUAGE_BASIC,TEXT_RADIO,RADIO_FREQ_COMMON,LANGUAGE_BASIC,TALK_RANGE)
		last_warning_percent = health_percent
		last_warning_time = world.time
	return TRUE


/obj/structure/interactive/supermatter/station
	health_base = 100000
	charge_max = SECONDS_TO_DECISECONDS(60) //60 seconsd of power.

/obj/structure/interactive/supermatter/defense
	name = "unstable supermatter crystal"
	desc_extended = "An extremely important and extremely unstable shard of supermatter. You should protect this at all costs if you're NanoTrasen."
	health_base = 3000
	charge_max = SECONDS_TO_DECISECONDS(900) //15 minutes

/obj/structure/interactive/supermatter/defense/Finalize()
	known_supermatters += src
	. = ..()

/obj/structure/interactive/supermatter/defense/Destroy()
	known_supermatters -= src
	. = ..()

/obj/structure/interactive/supermatter/defense/add_charge(var/charge_amount=0)
	. = ..()
	if(. && charge >= charge_max)
		src.visible_message(span("notice","\The [src.name] disappears in a vibrant flash!"))
		qdel(src)

/obj/structure/interactive/supermatter/defense/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(is_living(attacker))
		var/mob/living/L = attacker
		if(L.loyalty_tag == "NanoTrasen")
			return FALSE

	. = ..()

/obj/structure/interactive/supermatter/defense/projectile_should_collide(var/obj/projectile/P,var/turf/new_turf,var/turf/old_turf)

	if(is_living(P.owner))
		var/mob/living/L = P.owner
		if(L.iff_tag == "NanoTrasen")
			return FALSE
	. = ..()

/obj/structure/interactive/supermatter/defense/get_examine_list(var/mob/examiner)
	. = ..()
	. += div("notice","It is [FLOOR(charge,1)]/[charge_max]([FLOOR(100*(charge/charge_max),1)]%) charged.")
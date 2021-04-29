/*
So this generator is supposed to be for the station and is a very basic power system.
As long as it is powered, the station will be powered. The moment it is no longer powered, no power on station.
No power? no doors, vendors, lights, etc.
*/

/obj/structure/interactive/fusion_generator
	name = "fusion generator"
	desc = "Behold the almighty Atom!"
	desc_extended = "An engine that fuses atoms together to create energy. Make sure it is always powered!"
	icon = 'icons/obj/structure/generator.dmi'
	icon_state = "gen_small_4"
	density = TRUE
	anchored = TRUE

	var/stage = 4 //4 to 0, 4 is max power, 0 is no power
	var/cooldown_time = 0 //the timer basically
	var/add_cooldown = 10 //how many seconds are checked (5 minutes) 300

/obj/structure/interactive/fusion_generator/Initialize()
	. = ..()
	SSgenerator_power.linked_gen = src

/obj/structure/interactive/fusion_generator/proc/power_think()
	if(stage <= 0)
		return
	if(world.time < cooldown_time)
		return
	cooldown_time = world.time + SECONDS_TO_DECISECONDS(add_cooldown)
	if(prob(50)) //50 percent chance to not degrade!
		return
	stage--
	icon_state = "gen_small_[stage]"
	update_icon()
	if(stage <= 0) //if stage is 0
		SSgenerator_power.station_power = FALSE
		SSgenerator_power.turn_off_lights()
	return

/obj/structure/interactive/fusion_generator/clicked_on_by_object(mob/caller, atom/object, location, control, params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(is_item(object))
		var/obj/item/objectI = object
		if(stage == 0 && objectI.flags_tool & FLAG_TOOL_CROWBAR)
			tool_repair(caller)
			SSgenerator_power.station_power = TRUE
			return
		if(stage == 1 && objectI.flags_tool & FLAG_TOOL_WRENCH)
			tool_repair(caller)
			return
		if(stage == 2 && objectI.flags_tool & FLAG_TOOL_WIRECUTTER)
			tool_repair(caller)
			return
		if(stage == 3 && objectI.flags_tool & FLAG_TOOL_SCREWDRIVER)
			tool_repair(caller)
			SSgenerator_power.turn_on_lights()
			return

/obj/structure/interactive/fusion_generator/proc/tool_repair(mob/caller)
	caller.to_chat(span("notice", "You finish repairing the generator."))
	cooldown_time = world.time + SECONDS_TO_DECISECONDS(add_cooldown)
	stage++
	icon_state = "gen_small_[stage]"
	update_icon()

/obj/structure/interactive/fusion_generator/get_examine_list(mob/examiner)
	. = ..()
	. += div("notice","Current Stage: [stage]")
	switch(stage)
		if(0)
			. += div("warning","Requires Crowbar!")
		if(1)
			. += div("warning","Requires Wrench!")
		if(2)
			. += div("warning","Requires Wirecutter!")
		if(3)
			. += div("warning","Requires Screwdriver!")

/obj/item/weapon/melee/slaughterclaws
	name = "slaughter claws"

	desc = "HELL IS EMPTY, BLOOD IS FUEL!"
	desc_extended = "Use Harm intent to rip your enemies a new one! Use disarm intent to punch from afar! Click on a turf on grab intent to bloodcrawl! Then replenish your blood by Helping a corpse!"
	// var/user_intent = 1 //will need a more elegant way to change this Later(TM), but it could provide a framework for other intent checks
	icon = 'icons/obj/item/weapons/unarmed/slaughterclaws.dmi' //thx Nzzy!
	damage_type = /damagetype/unarmed/slaughter
	size = SIZE_2
	weight = 10

	value = 5000
	value_burgerbux = 1
	var/next_teleport_command = 0
	var/next_blood_attack = 0

	rarity = RARITY_RARE

/obj/item/weapon/melee/slaughterclaws/click_on_object(var/mob/caller,var/atom/object,location,control,params) //All blood costs are made with a level 50 VIT char in mind.

	var/mob/living/L = caller
	if(!istype(L))
		return FALSE

	var/turf/T = get_turf(object)
	var/area/A = get_area(T)
	if(!T)
		return FALSE

	var/target_distance = get_dist(L,T)


	if(L.intent == INTENT_GRAB && next_teleport_command <= world.time)
		if(!T.can_move_to()) //Alright, that's it. No more water-walking!
			L.to_chat(span("danger","You can't bloodcrawl there!"))
			return TRUE
		if(A.flags_area & FLAG_AREA_NO_TELEPORT) // No bloodcrawling into vaults for you!
			L.to_chat(span("danger","Some sort of forcefield stops you!"))
			return TRUE
		if (target_distance > VIEW_RANGE)
			L.to_chat(span("danger","It's too far to crawl to!"))
			return TRUE
		L.blood_volume = max(0,L.blood_volume - target_distance*5) //Max distance costs 50. Jumping this far would only be for snacking or retreating, though.
		QUEUE_HEALTH_UPDATE(L)
		L.force_move(T)
		new/obj/effect/temp/impact/blood(T,desired_color = COLOR_BLOOD)
		play_sound(pick('sound/weapons/magic/bloody_impact.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
		next_teleport_command = world.time + SECONDS_TO_DECISECONDS(2)
		return TRUE

	if(L.intent == INTENT_DISARM && next_blood_attack <= world.time && target_distance <= 10) //hacky solution to the range problem
		new/obj/effect/temp/hazard/bubblefist(T,desired_owner = L)
		L.blood_volume = max(0,L.blood_volume - 20) //10% HP. I sure hope the blood cost disincentivises spam.
		QUEUE_HEALTH_UPDATE(L)
		next_blood_attack = world.time + SECONDS_TO_DECISECONDS(2)
		. = TRUE

	else return FALSE

/obj/item/weapon/melee/slaughterclaws
	name = "slaughter claws"
	rarity = RARITY_LEGENDARY
	desc = "HELL IS EMPTY, BLOOD IS FUEL!"
	desc_extended = "Use Harm intent to rip your enemies a new one! Use disarm intent to punch from afar! Click on a turf on grab intent to bloodcrawl! Then replenish your blood by Helping a corpse!"
	var/user_intent = 1 //will need a more elegant way to change this Later(TM), but it could provide a framework for other intent checks
	icon = 'icons/obj/item/weapons/unarmed/slaughterclaws.dmi' //thx Nzzy!
	damage_type = /damagetype/unarmed/slaughter
	var/damage_type_harm = /damagetype/unarmed/slaughter_heavy
	size = SIZE_2
	weight = 10

	value = 5000
	value_burgerbux = 1
	var/next_teleport_command = 0
	var/next_blood_attack = 0

/obj/item/weapon/melee/slaughterclaws/update_icon() //borrowed from e-sword code, seems to do the job for switching damage types when needed
	if (user_intent == 4)
		damage_type = damage_type_harm
	else
		damage_type = initial(damage_type)

/obj/item/weapon/melee/slaughterclaws/click_on_object(var/mob/caller,var/atom/object,location,control,params) //All blood costs are made with a level 50 VIT char in mind.
	var/mob/living/self = caller //thank you based AdrienTheMan
	var/turf/T = object
	var/area/A = T.loc
	var/target_distance = get_dist(self,T)

	if(self.intent == INTENT_HARM)
		user_intent = 4
		update_sprite()

	else
		user_intent = 1
		update_sprite()

	if(self.intent == INTENT_GRAB && isturf(T) && next_teleport_command <= world.time)
		if(!T.is_safe_teleport()||A.flags_area & FLAGS_AREA_NO_TELEPORT) //Alright, that's it. No more water-walking!
			caller.to_chat(span("danger","Can't bloodcrawl there!"))
			return TRUE
		if (target_distance > 10)
			caller.to_chat(span("danger","It's too far to crawl to!"))
			return TRUE
		self.blood_volume -= (target_distance*5) //Max distance costs 50. Jumping this far would only be for snacking or retreating, though.
		self.health.adjust_loss_smart(oxy = target_distance*5) //instant feedback
		self.force_move(T)
		new/obj/effect/temp/impact/blood(T,desired_color = COLOR_BLOOD)
		play_sound(pick('sound/weapons/magic/bloody_impact.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
		next_teleport_command = world.time + SECONDS_TO_DECISECONDS(2)
		return TRUE

	if(self.intent == INTENT_DISARM && isturf(T) && next_blood_attack <= world.time && target_distance <= 10) //hacky solution to the range problem
		var/turf/simulated/B = get_turf(T)
		new/obj/effect/temp/hazard/bubblefist(B,desired_owner = self)
		self.blood_volume -= (20) //10% HP. I sure hope the blood cost disincentivises spam.
		self.health.adjust_loss_smart(oxy = 20)
		next_blood_attack = world.time + SECONDS_TO_DECISECONDS(2)
		. = TRUE

	else return FALSE

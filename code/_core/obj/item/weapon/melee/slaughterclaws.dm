/obj/item/weapon/melee/slaughterclaws
	name = "slaughter claws"
	rarity = RARITY_LEGENDARY //TO DO: ponder rarity
	desc = "HELL IS EMPTY, BLOOD IS FUEL!"
	desc_extended = "Use Harm intent to rip your enemies a new one! Click on a turf on grab intent to bloodcrawl! Replenish your blood by Helping a corpse!"

	icon = 'icons/obj/item/weapons/unarmed/powerfist.dmi' //TO DO: beg for a sprite

	damage_type = /damagetype/unarmed/slaughter //TO DO: add heavy attack (curse you stalkeros)
	size = SIZE_2
	weight = 10

	value = 5000
	value_burgerbux = 1
	var/next_teleport_command = 0
	//var/next_ranged_punch = 0

/obj/item/weapon/melee/slaughterclaws/click_on_object(var/mob/caller,var/atom/object,location,control,params) //pain
	var/mob/living/self = caller //thank you based AdrienTheMan
	if(self.intent != INTENT_GRAB) //that's grab down
		return FALSE
	if(isturf(object) && next_teleport_command <= world.time)
		var/turf/T = object
		var/area/A = T.loc
		var/target_distance = get_dist(self,T)
		if(A.flags_area & FLAGS_AREA_NO_TELEPORT) //thing you can do: trap yourself, it's funny...
			caller.to_chat(span("danger","Can't bloodcrawl there!"))
			return TRUE
		if (target_distance > 10)
			caller.to_chat(span("danger","It's too far to crawl to!"))
			return TRUE
		self.blood_volume -= (target_distance*5) //I sure hope some wacky abuse doesn't happen, tee-hee!
		self.force_move(T)
		play_sound(pick('sound/effects/demon_attack1.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
		next_teleport_command = world.time + SECONDS_TO_DECISECONDS(2)
		return TRUE

	return ..()

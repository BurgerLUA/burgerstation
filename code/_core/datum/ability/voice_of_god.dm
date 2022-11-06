/ability/voice_of_god/harm
	name = "Command: Harm"
	desc = "Damages all enemies within 8 tiles, and makes them susceptable to further damage."
	icon_state = "dash"

	resource_type = MANA
	var/damagetype/damage_type
	var/atom/caller
	var/word = "DIE"
	category = "Voice Of God"

/ability/voice_of_god/harm/proc/get_params(var/atom/victim)
	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,32)

/ability/voice_of_god/harm/proc/do_damage(var/atom/victim,var/atom/caller)

	if(is_living(victim) && is_living(caller) && caller != victim)
		var/mob/living/L = victim
		var/mob/living/L2 = caller
		if(!allow_hostile_action(L2.loyalty_tag,L))
			return FALSE
	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(caller,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(caller,src,damage_type,params,TRUE,TRUE)
	return DT.process_damage(caller,victim,src,object_to_damage,caller,1)

/ability/voice_of_god/harm/on_cast(var/mob/caller,var/atom/target,var/atom/victim,location,params)

	var/mob/living/L = caller
	var/turf/T = get_turf(L)
	play_sound('sound/effects/invoke_general.ogg',T, range_max = SOUND_RANGE)
	L.do_say("<font color='#DD1C1F' size='4'>[word]</font>",FALSE)

	for(var/mob/living/L2 in oview(T,8))
		if(L2.dead)
			continue
		if(L2.loyalty_tag == L.loyalty_tag)
			continue
		do_damage(L2,L)

/ability/voice_of_god/harm/bleed
	name = "Command: Bleed"
	desc = "Open wounds in all enemies within 8 tiles."
	cost = 50
	cooldown = SECONDS_TO_DECISECONDS(10)
	damage_type = /damagetype/ranged/magic/voice_of_god/bleed
	word = "BLEED"

/ability/voice_of_god/live
	name = "Command: Live"
	desc = "Heal all allied listeners within 8 tiles, as well as staving off death for 5 seconds."
	cost = 50
	cooldown = SECONDS_TO_DECISECONDS(15)
	category = "Voice Of God"
	var/word = "LIVE" //Is there possibly a way to switch what a specific ability does? Well, seeing as this one's the area buff while the others are area debuffs...
	var/leveled_effect = 0

/ability/voice_of_god/live/on_cast(var/mob/caller,var/atom/target,var/atom/victim,location,params)

	var/mob/living/L = caller
	var/turf/T = get_turf(L)

	for(var/mob/living/L2 in oview(T,4))
		if(L2.dead)
			continue
		if(L2.loyalty_tag != L.loyalty_tag)
			continue
		L2.add_status_effect(TEMP_REGEN,2,SECONDS_TO_DECISECONDS(5))
		L2.add_status_effect(UNDYING,SECONDS_TO_DECISECONDS(5))

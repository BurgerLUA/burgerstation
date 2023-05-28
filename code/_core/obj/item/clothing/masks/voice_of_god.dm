/obj/item/clothing/mask/voice_of_god

	name = "voice of god"
	icon = 'icons/obj/item/clothing/masks/god_voice.dmi'

	rarity = RARITY_LEGENDARY

	desc = "God is here and he's bald."
	desc_extended = "A terrible brass molding of a deity with the vocal cords of a Colossus attached. Wearing this allows the user to augment their voice with magic. Horrifying."

	flags_clothing = FLAG_CLOTHING_NOBEAST_HEAD

	armor = /armor/reward

	var/static/list/text_to_proc = list(
		"stop" = .proc/power_word_stop,
		"halt" = .proc/power_word_stop,
		"hold" = .proc/power_word_stop,

		"drop" = .proc/power_word_drop,
		"down" = .proc/power_word_drop,
		"fall" = .proc/power_word_drop,

		"mend" = .proc/power_word_heal,
		"heal" = .proc/power_word_heal,
		"cure" = .proc/power_word_heal,

		"harm" = .proc/power_word_harm,
		"hinder" = .proc/power_word_harm,
		"wilt" = .proc/power_word_harm,

		"gore" = .proc/power_word_bleed,
		"leak" = .proc/power_word_bleed,
		"loss" = .proc/power_word_bleed,

		"burn" = .proc/power_word_burn,
		"fire" = .proc/power_word_burn,
		"heat" = .proc/power_word_burn,

		"kill" = .proc/power_word_kill,
		"die" = .proc/power_word_kill,
		"perish" = .proc/power_word_kill

		/*
		"begone"
		"flee"
		"repulse"
		"come"
		"attract"
		*/
	)

	var/static/list/proc_to_harmful = list(
		.proc/power_word_stop = TRUE,
		.proc/power_word_drop = TRUE,
		.proc/power_word_heal = FALSE,
		.proc/power_word_harm = TRUE,
		.proc/power_word_bleed = TRUE,
		.proc/power_word_burn = TRUE,
		.proc/power_word_kill = TRUE
	)

	var/next_voice = 0

/obj/item/clothing/mask/voice_of_god/get_base_value()
	. = ..()
	. += 18000


/obj/item/clothing/mask/voice_of_god/get_examine_details_list(var/mob/caller)
	. = ..()
	. += div("notice bold underline","Available commands:")
	. += div("notice","<b>Stop, Halt, Hold</b>: Paralyzes all enemies in range for 2 seconds.")
	. += div("notice","<b>Drop, Down, Fall</b>: Stuns all enemies in range for 4 seconds.")
	. += div("notice","<b>Mend, Heal, Cure</b>: Grants 50 health to all allies in range over 10 seconds.")
	. += div("notice","<b>Harm, Hinder, Wilt</b>: Deals 50 dark damage to all enemies in range.")
	. += div("notice","<b>Kill, Die, Perish</b>: Deals 250 dark damage to all enemies in critical condition in range.")
	. += div("notice","<b>Gore, Leak, Loss</b>: Drains 50 units of blood from all enemies in range.")
	. += div("notice","<b>Burn, Fire, Heat</b>: Ignites all enemies in range for 6 seconds.")
	. += div("notice","All commands share a cooldown of 8 seconds, and require 50 mana and stamina to cast.")

/obj/item/clothing/mask/voice_of_god/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn && I.item_slot & SLOT_FACE)
		var/mob/living/advanced/A = I.owner
		if(!A.voice_modifiers)
			A.voice_modifiers = list()
		A.voice_modifiers[src] = src::search_for_voice()

/obj/item/clothing/mask/voice_of_god/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE)
	. = ..()
	if(old_inventory.worn && old_inventory.item_slot & SLOT_FACE)
		var/mob/living/advanced/A = old_inventory.owner
		if(A.voice_modifiers)
			A.voice_modifiers -= src
		if(!length(A.voice_modifiers))
			A.voice_modifiers = null

/obj/item/clothing/mask/voice_of_god/proc/search_for_voice(var/atom/speaker, var/atom/source, var/text_to_say, var/raw_text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(next_voice > world.time)
		return text_to_say

	if(!is_advanced(speaker))
		return text_to_say

	if(speaker.health && (speaker.health.stamina_current < 50 || speaker.health.mana_current < 50))
		return text_to_say

	var/turf/T = get_turf(speaker)

	if(!T)
		return text_to_say

	var/text_to_search = remove_non_letters(lowertext(raw_text_to_say))

	var/list/words = splittext(text_to_search," ")

	for(var/word in words)
		if(!text_to_proc[word])
			continue
		do_voice_effect(speaker,text_to_proc[word],proc_to_harmful[text_to_proc[word]])
		text_to_say = "<font color='#DD1C1F' size='4'>[text_to_say]</font>"
		play_sound('sound/effects/invoke_general.ogg',T, range_max = SOUND_RANGE * 3)
		next_voice = world.time + SECONDS_TO_DECISECONDS(8)
		create_alert(SOUND_RANGE * 3,T,speaker,ALERT_LEVEL_COMBAT)
		if(speaker.health)
			speaker.health.adjust_stamina(-50)
			speaker.health.adjust_mana(-50)
		break

	return text_to_say

/obj/item/clothing/mask/voice_of_god/proc/do_voice_effect(var/mob/living/advanced/caller,var/proc_effect,var/harmful=FALSE)

	for(var/k in viewers(VIEW_RANGE,caller))
		var/mob/M = k
		if(M == caller)
			continue
		if(!is_living(M))
			continue
		var/mob/living/L = M
		if(harmful)
			if(allow_hostile_action(caller.loyalty_tag,L))
				call(src,proc_effect)(caller,L)
		else
			if(!allow_hostile_action(caller.loyalty_tag,L))
				call(src,proc_effect)(caller,L)

/obj/item/clothing/mask/voice_of_god/proc/power_word_stop(var/mob/living/advanced/caller,var/mob/living/victim)
	return victim.add_status_effect(PARALYZE,20,20,source=caller)

/obj/item/clothing/mask/voice_of_god/proc/power_word_drop(var/mob/living/advanced/caller,var/mob/living/victim)
	return victim.add_status_effect(STUN,40,40,source=caller)

/obj/item/clothing/mask/voice_of_god/proc/power_word_heal(var/mob/living/advanced/caller,var/mob/living/victim)
	return victim.add_status_effect(TEMP_REGEN,5,100,source=caller) //5 health per second for 10 seconds.

/obj/item/clothing/mask/voice_of_god/proc/power_word_harm(var/mob/living/advanced/caller,var/mob/living/victim)
	var/damagetype/DT = all_damage_types[/damagetype/voice_of_god/harm]
	var/atom/object_to_damage = victim.get_object_to_damage(caller,src,damage_type,null,TRUE,TRUE)
	return DT.process_damage(caller,victim,src,object_to_damage,caller,1)

/obj/item/clothing/mask/voice_of_god/proc/power_word_kill(var/mob/living/advanced/caller,var/mob/living/victim)
	if(victim.dead || !victim.has_status_effect(CRIT))
		return FALSE
	var/damagetype/DT = all_damage_types[/damagetype/voice_of_god/kill]
	var/atom/object_to_damage = victim.get_object_to_damage(caller,src,damage_type,null,TRUE,TRUE)
	return DT.process_damage(caller,victim,src,object_to_damage,caller,1)

/obj/item/clothing/mask/voice_of_god/proc/power_word_bleed(var/mob/living/advanced/caller,var/mob/living/victim)
	if(!victim.blood_type)
		return FALSE
	var/bleed_amount = 50
	var/reagent/R = REAGENT(victim.blood_type)
	var/turf/T = get_turf(victim)
	if(T) create_blood(/obj/effect/cleanable/blood,T,R.color,victim.pixel_x + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1),victim.pixel_y + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1))
	victim.blood_volume = clamp(victim.blood_volume - bleed_amount,0,victim.blood_volume_max)
	QUEUE_HEALTH_UPDATE(victim)
	return TRUE

/obj/item/clothing/mask/voice_of_god/proc/power_word_burn(var/mob/living/advanced/caller,var/mob/living/victim)
	victim.ignite(60,source=caller)
	return TRUE
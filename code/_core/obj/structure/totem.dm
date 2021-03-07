/obj/structure/totem
	name = "totem"
	desc = "None."
	desc_extended = "A totem that will produce a buff for the caster and their allies."
	icon = 'icons/obj/structure/totem.dmi'

	var/next_fire = 0
	var/cooldown_fire = SECONDS_TO_DECISECONDS(1)

	var/mob/living/owner //the object's owner
	var/totem_remove_time = 0

	var/leveled_effect = 0

	var/affecting_faction //which faction it should affect

/obj/structure/totem/Finalize()
	. = ..()
	start_thinking(src)

/obj/structure/totem/Destroy()
	if(owner)
		owner.totem = null
	return ..()

/obj/structure/totem/think()
	if(world.time >= totem_remove_time)
		Destroy()
		return FALSE
	if(world.time <= next_fire)
		return TRUE
	next_fire = world.time + cooldown_fire
	totemic_effect()
	return TRUE

/obj/structure/totem/proc/totemic_effect()
	return

/*******************
*******TOTEMS*******
*******************/

/obj/structure/totem/health_heal
	name = "totem of health regeneration"
	desc_extended = "A totem that will restore the caster's and their allies' health."
	icon_state = "health"

/obj/structure/totem/health_heal/totemic_effect() //copy paste from staff of healing's think, with slight modifications
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(5,T))
		if(L.dead)
			continue
		if(L.loyalty_tag != affecting_faction)
			continue
		if(!istype(L.health))
			continue
		if(L.health.health_current >= L.health.health_max)
			continue
		if(L.health.get_loss(BRUTE))
			L.health.adjust_loss()
			L.brute_regen_buffer += (3 + (3 * leveled_effect))
		if(L.health.get_loss(BURN))
			L.burn_regen_buffer += (3 + (3 * leveled_effect))
		if(L.health.get_loss(TOX))
			L.tox_regen_buffer += (3 + (3 * leveled_effect))
		var/obj/effect/temp/healing/H = new(L.loc,10,COLOR_RED)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)

/obj/structure/totem/stamina_heal
	name = "totem of stamina regeneration"
	desc_extended = "A totem that will restore the caster's and their allies' stamina."
	icon_state = "stamina"

/obj/structure/totem/stamina_heal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(5,T))
		if(L.dead)
			continue
		if(L.loyalty_tag != affecting_faction)
			continue
		if(!istype(L.health))
			continue
		if(L.health.stamina_current >= L.health.stamina_max)
			continue
		if(L.health.get_stamina_loss())
			L.stamina_regen_buffer += (3 + (3 * leveled_effect))
		var/obj/effect/temp/healing/H = new(L.loc,10,COLOR_GREEN)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)

/obj/structure/totem/mana_heal
	name = "totem of mana regeneration"
	desc_extended = "A totem that will restore the caster's and their allies' mana."
	icon_state = "mana"

/obj/structure/totem/mana_heal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(5,T))
		if(L.dead)
			continue
		if(L.loyalty_tag != affecting_faction)
			continue
		if(!istype(L.health))
			continue
		if(L.health.mana_current >= L.health.mana_max)
			continue
		if(L.health.get_mana_loss())
			L.mana_regen_buffer += (3 + (3 * leveled_effect))
		var/obj/effect/temp/healing/H = new(L.loc,10,COLOR_BLUE)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)

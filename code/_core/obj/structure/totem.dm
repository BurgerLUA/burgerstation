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
	owner = null
	return ..()

/obj/structure/totem/think()
	if(world.time >= totem_remove_time)
		qdel(src)
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
	desc = "Patch them up, they said. Don't make me cry, they said."
	desc_extended = "A totem that will restore the caster's and their allies' health."
	icon_state = "health"

/obj/structure/totem/health_heal/totemic_effect() //copy paste from staff of healing's think, with slight modifications
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.loyalty_tag != affecting_faction) //!= because we want to only affect allies
			continue
		if(!istype(L.health))
			continue
		if(L.health.health_current >= L.health.health_max)
			continue
		if(L.health.get_loss(BRUTE))
			L.brute_regen_buffer += (3 + (3 * leveled_effect))
		if(L.health.get_loss(BURN))
			L.burn_regen_buffer += (3 + (3 * leveled_effect))
		if(L.health.get_loss(TOX))
			L.tox_regen_buffer += (3 + (3 * leveled_effect))
		CREATE(/obj/effect/temp/healing,L.loc)

/obj/structure/totem/health_deal
	name = "totem of health degeneration"
	desc = "Pain and Suffering, two of my favorite toys!"
	desc_extended = "A totem that will damage the caster's enemies' health."
	icon_state = "healthloss"

/obj/structure/totem/health_deal/totemic_effect() //copy paste from staff of healing's think, with slight modifications
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.loyalty_tag == affecting_faction) //== because we dont want to affect allies
			continue
		if(!istype(L.health))
			continue
		L.brute_regen_buffer -= (3 + (3 * leveled_effect))
		L.burn_regen_buffer -= (3 + (3 * leveled_effect))
		L.tox_regen_buffer -= (3 + (3 * leveled_effect))
		CREATE(/obj/effect/temp/electricity,L.loc)

/obj/structure/totem/stamina_heal
	name = "totem of stamina regeneration"
	desc = "Someone hasn't been working out, they'd rather drug up..."
	desc_extended = "A totem that will restore the caster's and their allies' stamina."
	icon_state = "stamina"

/obj/structure/totem/stamina_heal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
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
		CREATE(/obj/effect/temp/healing,L.loc)

/obj/structure/totem/stamina_deal
	name = "totem of stamina degeneration"
	desc = "It is a fast acting paralyzing agent that will render them useless!"
	desc_extended = "A totem that will damage the caster's enemies' stamina."
	icon_state = "staminaloss"

/obj/structure/totem/stamina_deal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.loyalty_tag == affecting_faction)
			continue
		if(!istype(L.health))
			continue
		L.stamina_regen_buffer -= (3 + (3 * leveled_effect))
		CREATE(/obj/effect/temp/electricity,L.loc)

/obj/structure/totem/mana_heal
	name = "totem of mana regeneration"
	desc = "Don't ask how many years it took for me to reach this state of wizardry."
	desc_extended = "A totem that will restore the caster's and their allies' mana."
	icon_state = "mana"

/obj/structure/totem/mana_heal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
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
		CREATE(/obj/effect/temp/healing,L.loc)

/obj/structure/totem/mana_deal
	name = "totem of mana degeneration"
	desc = "I'm melting, I'm melting!"
	desc_extended = "A totem that will damage the caster's enemies' mana."
	icon_state = "manaloss"

/obj/structure/totem/mana_deal/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.loyalty_tag == affecting_faction)
			continue
		if(!istype(L.health))
			continue
		L.mana_regen_buffer -= (3 + (3 * leveled_effect))
		CREATE(/obj/effect/temp/electricity,L.loc)

/obj/structure/totem/sacred_flame
	name = "totem of sacred flame"
	desc = "Can you hear the voice of god through this bush flame?"
	desc = "Someone thought to take a book and stick it inside the totem."
	desc_extended = "A totem that will set ablaze the caster's enemies."
	icon_state = "flame"

/obj/structure/totem/sacred_flame/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.loyalty_tag == affecting_faction)
			continue
		if(!istype(L.health))
			continue
		L.ignite(SECONDS_TO_DECISECONDS(1.5))
		CREATE(/obj/effect/temp/electricity,L.loc)

/obj/structure/totem/repelling
	name = "totem of repelling"
	desc = "They thought it meant aggro, what suckers."
	desc_extended = "A totem that will repel the caster's enemies."
	icon_state = "magnet"

/obj/structure/totem/repelling/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.boss) //yea, no repelling bosses, sorry
			continue
		if(L.loyalty_tag == affecting_faction)
			continue
		if(!isturf(L.loc)) //if a living thing is somewhere that isnt in a turf, skip them
			continue
		if(L.loc == loc) //if they are on the same turf, skip them
			continue
		L.Move(get_step(L.loc,get_dir(src,L)))
		CREATE(/obj/effect/temp/electricity,L.loc)

/obj/structure/totem/attracting
	name = "totem of attracting"
	desc = "They thought it meant aggro, what suckers."
	desc_extended = "A totem that will attract the caster's enemies."
	icon_state = "magnet"

/obj/structure/totem/attracting/totemic_effect() //will need testing and help to balance this
	var/turf/T = get_turf(src)
	for(var/mob/living/L in viewers(4,T))
		if(L.dead)
			continue
		if(L.boss) //yea, no attracting bosses, sorry
			continue
		if(L.loyalty_tag == affecting_faction)
			continue
		if(!isturf(L.loc)) //if a living thing is somewhere that isnt in a turf, skip them
			continue
		if(L.loc == loc) //if they are on the same turf, skip them
			continue
		L.Move(get_step(L.loc,get_dir(L,src)))
		CREATE(/obj/effect/temp/electricity,L.loc)

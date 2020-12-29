/obj/item/weapon/melee/staff_of_healing
	name = "staff of healing"
	desc = "Who needs medicine when you have PASSIVE ARCANE?"
	desc_extended = "A glowing magical staff that passively radiates health to all nearby living beings, except the caster, when activated. Also makes for a good blunt force weapon."
	rarity = RARITY_RARE

	icon = 'icons/obj/item/weapons/melee/clubs/staff_of_healing.dmi'

	damage_type = /damagetype/melee/club/mace/

	size = SIZE_4

	weight = 15

	value = 1200

	var/next_heal= 0


/obj/item/weapon/melee/staff_of_healing/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!SSthinking.all_thinkers[src])
		start_thinking(src)
		caller.to_chat(span("notice","You activate \the [src.name]'s passive healing effect."))
	else
		caller.to_chat(span("notice","You deactivate \the [src.name]'s passive healing effect."))
		stop_thinking(src)

	return TRUE


/obj/item/weapon/melee/staff_of_healing/think()

	if(next_heal > world.time)
		return TRUE

	if(!istype(loc,/obj/hud/inventory))
		return FALSE

	var/obj/hud/inventory/I = loc

	if(!I.click_flags)
		return FALSE

	var/turf/T = get_turf(src)

	for(var/mob/living/L in oview(T,4))
		if(L.dead)
			continue
		if(!istype(L.health))
			continue
		if(L.health.health_current >= L.health.health_max)
			continue
		if(L.health.get_loss(BRUTE))
			L.brute_regen_buffer += 3
		if(L.health.get_loss(BURN))
			L.burn_regen_buffer += 3
		if(L.health.get_loss(TOX))
			L.tox_regen_buffer += 3
		var/obj/effect/temp/healing/H = new(L.loc,10,COLOR_MEDICAL)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)

	next_heal = world.time + SECONDS_TO_DECISECONDS(1)

	return TRUE
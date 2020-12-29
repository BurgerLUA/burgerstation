/obj/item/weapon/melee/sacred_flame
	name = "book of the sacred flame"
	desc = "Hot!"
	desc_extended = "A very dangerous tome that periodically ignites all hostile living beings in view while active. Also makes foor a good book for pummeling."
	rarity = RARITY_MYTHICAL

	icon = 'icons/obj/item/weapons/ranged/magic/tomes/inferno.dmi'

	damage_type = /damagetype/melee/club/mace/

	size = SIZE_3

	weight = 8

	value = 1800

	var/next_fire = 0


/obj/item/weapon/melee/sacred_flame/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!SSthinking.all_thinkers[src])
		start_thinking(src)
		caller.to_chat(span("notice","You activate \the [src.name]'s passive igniting effect."))
	else
		caller.to_chat(span("notice","You deactivate \the [src.name]'s passive igniting effect."))
		stop_thinking(src)

	return TRUE


/obj/item/weapon/melee/sacred_flame/think()

	if(next_fire > world.time)
		return TRUE

	if(!istype(loc,/obj/hud/inventory))
		return FALSE

	var/obj/hud/inventory/I = loc

	if(!I.click_flags)
		return FALSE

	var/mob/living/advanced/owner = I.owner

	var/turf/T = get_turf(src)

	for(var/mob/living/L in oview(T,4))
		if(L.dead)
			continue
		if(L.loyalty_tag == owner.loyalty_tag)
			continue
		L.ignite(SECONDS_TO_DECISECONDS(1.5))
		var/obj/effect/temp/electricity/H = new(owner,10,COLOR_MEDICAL)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)
		H.Move(get_step(owner,get_dir(owner,L)))

	next_fire = world.time + SECONDS_TO_DECISECONDS(1)

	return TRUE
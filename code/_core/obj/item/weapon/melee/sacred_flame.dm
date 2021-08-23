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

	var/leveled_effect = 0


/obj/item/weapon/melee/sacred_flame/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(!SSthinking.all_thinkers[src])
		start_thinking(src)
		caller.to_chat(span("notice","You activate \the [src.name]'s passive igniting effect."))
		if(is_living(caller))
			var/mob/living/liveCaller = caller
			leveled_effect = round((liveCaller.get_skill_power(SKILL_MAGIC_DEFENSIVE,0,1,2)*5) + (liveCaller.get_skill_power(SKILL_PRAYER,0,1,2)*5) + ((quality - 100)/5)) //15 is the "max" when 100 skill is your max
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
		var/ignite_effect = 1.5 + (0.1 * leveled_effect)
		L.ignite(SECONDS_TO_DECISECONDS(ignite_effect),owner) //min of 1.5 sec, max of 3.0 sec
		L.health.adjust_loss_smart(burn = ignite_effect * 6) //min of 9 damage, max of 18 damage

		CREATE(/obj/effect/temp/electricity,get_turf(L))

	next_fire = world.time + SECONDS_TO_DECISECONDS(1)

	return TRUE

/obj/item/clothing/overwear/hardsuit/exosuit
	name = "Russian exosuit"
	icon = 'icons/obj/item/clothing/suit/exosuit.dmi'
	desc = "RIP Tachenko."
	desc_extended = "An experimental sample of a military exoskeleton. Was never mass-produced due to extraordinary cost and some design flaws. Despite this, it is in demand due to its ability to take on the weight of all carried equipment, and therefore small batches are made in underground facilities."
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO_ARMOR

	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 40,
		BLUNT = 75,
		PIERCE = 50,
		LASER = 40,
		ARCANE = -90,
		HEAT = 20,
		COLD = 60,
		BOMB = 75
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/exosuit)

	value = 750 //Extraordinary cost. :P

	loyalty_tag = "Revolutionary"


/obj/item/clothing/overwear/hardsuit/skat
	name = "SKAT-9"
	icon = 'icons/obj/item/clothing/suit/skat.dmi'
	desc = "RIP Stingray."
	desc_extended = "This modern military armored suit is designed for assault operations in anomalous areas. Comprises a PSZ-12p heavy military armored suit, built-in compensation suit, and an anomalous protection bodysuit. The armor provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer's mobility. Does not come with an artifact container, as there's literally no artifacts anywhere. You know, different universe."
	rarity = RARITY_UNCOMMON

	item_slot = SLOT_TORSO_ARMOR
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 50,
		BLUNT = 40,
		PIERCE = 75,
		LASER = 60,
		ARCANE = -100,
		HEAT = 20,
		COLD = 20,
		BOMB = 50
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/skat)

	value = 1050

	loyalty_tag = "Revolutionary"

/obj/item/clothing/overwear/hardsuit/skat/antag
	name = "SKAT-10"
	icon = 'icons/obj/item/clothing/suit/skat_antag.dmi'
	desc = "I am out of S.T.A.L.K.E.R. references, really."
	desc_extended = "Completely redesigned version of SKAT-9 combined suit, made from ground up in joint forces by the Syndicate's and Space Russia's scientists under an unnamed unofficial peace treaty agreement, yet never went into mass production due to immense cost. Comprises a PSZ-15b ultra-heavy military armored suit, built-in semi-solid frag suit, and an enhanced anomalous protection bodysuit. The armor provides one of the best protections against bullet and fragmentation damage, without greatly reducing the wearer's mobility. Has a built-in wound tending system that passively treats its user's wounds when out of combat."
	rarity = RARITY_RARE

	item_slot = SLOT_TORSO_ARMOR
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	defense_rating = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 90,
		LASER = 60,
		ARCANE = -50,
		HEAT = 40,
		COLD = 40,
		BOMB = 70,
		RAD = 60,
		FATIGUE = 40,
		BIO = 70,
		PAIN = 40
	)

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/hardsuit/skat/antag)

	value = 2050

	loyalty_tag = "Revolutionary"

	var/cooldown_effect = 0

/obj/item/clothing/overwear/hardsuit/skat/antag/post_move(atom/old_loc)
	. = ..()
	if(istype(loc, /obj/hud/inventory/organs/torso))
		start_thinking(src)
	else
		stop_thinking(src)

/obj/item/clothing/overwear/hardsuit/skat/antag/think()
	if(cooldown_effect > world.time)
		return TRUE
	cooldown_effect = world.time + SECONDS_TO_DECISECONDS(1)
	var/turf/T = get_turf(src)
	for(var/mob/living/affectLiving in T)
		if(affectLiving.dead)
			continue
		if(affectLiving.health.get_total_loss(include_fatigue = FALSE,include_pain=FALSE,include_sanity=FALSE))
			affectLiving.brute_regen_buffer += rand(1,5)
			affectLiving.burn_regen_buffer += rand(1,5)
			affectLiving.tox_regen_buffer += rand(1,5)
			affectLiving.rad_regen_buffer += rand(1,5)
			affectLiving.queue_health_update = TRUE
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
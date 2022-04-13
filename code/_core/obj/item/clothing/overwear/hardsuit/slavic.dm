/obj/item/clothing/overwear/hardsuit/exosuit
	name = "Slavic exosuit"
	icon = 'icons/obj/item/clothing/suit/exosuit.dmi'
	desc = "RIP Tachenko."
	desc_extended = "An experimental sample of a military exoskeleton. Was never mass-produced due to extraordinary cost and some design flaws. Despite this, it is in demand due to its ability to take on the weight of all carried equipment, and therefore small batches are made in underground facilities."


	item_slot = SLOT_TORSO_ARMOR

	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	armor = /armor/hardsuit/combat/slavic

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/exosuit)

	value = 750 //Extraordinary cost. :P


/obj/item/clothing/overwear/hardsuit/skat
	name = "SKAT-9"
	icon = 'icons/obj/item/clothing/suit/skat.dmi'
	desc = "RIP Stingray."
	desc_extended = "This modern military armored suit is designed for assault operations in anomalous areas. Comprises a PSZ-12p heavy military armored suit, built-in compensation suit, and an anomalous protection bodysuit. The armor provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer's mobility. Does not come with an artifact container, as there's literally no artifacts anywhere. You know, different universe."


	item_slot = SLOT_TORSO_ARMOR
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	armor = /armor/hardsuit/combat/slavic

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/skat)

	value = 1050

/obj/item/clothing/overwear/hardsuit/skat/antag
	name = "SKAT-10"
	icon = 'icons/obj/item/clothing/suit/skat_antag.dmi'
	desc = "I am out of S.T.A.L.K.E.R. references, really."
	desc_extended = "Completely redesigned version of SKAT-9 combined suit, made from ground up in joint forces by the Syndicate's and Space Slav Federation's scientists under an unnamed unofficial peace treaty agreement, yet never went into mass production due to immense cost. Comprises a PSZ-15b ultra-heavy military armored suit, built-in semi-solid frag suit, and an enhanced anomalous protection bodysuit. The armor provides one of the best protections against bullet and fragmentation damage, without greatly reducing the wearer's mobility. Has a built-in wound tending system that passively treats its user's wounds when out of combat."


	item_slot = SLOT_TORSO_ARMOR
	worn_layer = LAYER_MOB_CLOTHING_HARDSUIT

	armor = /armor/hardsuit/combat/slavic/plus

	size = SIZE_7


	additional_clothing = list(/obj/item/clothing/head/helmet/full/hardsuit/skat/antag)

	value = 2050

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
		affectLiving.brute_regen_buffer += 1
		affectLiving.burn_regen_buffer += 1
		affectLiving.tox_regen_buffer += 1
		affectLiving.rad_regen_buffer += 1
		CREATE(/obj/effect/temp/healing,affectLiving.loc)
	return TRUE
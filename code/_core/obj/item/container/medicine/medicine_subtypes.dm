/obj/item/container/healing/bandage
	name = "bandages"
	desc = "Stop the bleeding, and you stop death - or delay it, at least."
	desc_extended = "Folks here believe that any affliction can be smothered in bandages, and any decently soft cloth can serve as one. Makes one wonder how people with such advanced medical knowledge even get sick at all."
	icon_state = "brutepack"
	treatment_time_mul = 1
	heal_brute = 50
	heal_brute_percent = 0
	heal_bleeding = TRUE
	amount_max = 10

	value = 5

/obj/item/container/healing/bandage/prank
	name = "badages"
	desc = "Fucking puns."
	desc_extended = "A pair of bandages with spikes on them. This will hurt..."
	heal_brute = -25
	value = 100

/obj/item/container/healing/bandage/advanced
	name = "infused bandages (styptic powder)"
	desc = "Allows wounds to recover further than simple cloth."
	desc_extended = "Bandages infused with styptic power. Close wounds faster than normal bandages if pressed well against the skin."

/obj/item/container/healing/bandage/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/healing/ointment
	name = "ointment"
	desc = "Nothing like salving an itching burn."
	desc_extended = "Applied topically to burns to heal the skin and relieve pain. Standard ointment bottles used to have Silver Sulfadiazine in them, but were deemed too expensive to keep buying in bulk."
	icon_state = "ointment"
	treatment_time_mul = 1
	heal_burn = 50
	heal_burn_percent = 0
	value = 5

/obj/item/container/healing/ointment/advanced
	name = "infused ointment (silver sulfadiazine)"
	desc = "Sometimes you have to prepare your own medicine."
	desc_extended = "Ointment whose gel has been mixed with Silver Sufadiazine.  Far more effective at both healing burnt skin and relieving pain."
/obj/item/container/healing/ointment/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/healing/trauma_kit
	name = "trauma kit"
	desc = "Each kit contains a set of bandaging equipment:bandages, splits, and antiseptics."
	desc_extended = "Very useful for recovery after traumatic injury. Allows to stop bleeding, disinfect wounds, support injured joints and damaged tissue."
	icon_state = "traumakit"
	treatment_time_mul = 1.25
	heal_brute = 80
	heal_brute_percent = 10
	heal_bleeding = TRUE
	amount_max = 10

	value = 20

/obj/item/container/healing/trauma_kit/advanced
	name = "infused trauma kit (styptic powder)"
	desc = "I knew something was missing."
	desc_extended = "Trauma Kits with added styptic powder to the bandages and antiseptics, allowing for even better recovery."

/obj/item/container/healing/trauma_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/healing/nanopaste
	name = "nanopaste"
	desc = "Nanomachines, son!"
	desc_extended = "A tube of healing nanites that heals any mechanical limb of any brute and burn damage."
	icon_state = "nanopaste"
	treatment_time_mul = 2
	heal_brute = 80
	heal_brute_percent = 10
	heal_burn = 80
	heal_burn_percent = 10
	heal_bleeding = TRUE
	amount_max = 4

	value = 80

	organic = FALSE

/obj/item/container/healing/nanopaste/treat(var/mob/caller,var/atom/A)

	. = ..()

	if(. && is_organ(A))
		var/obj/item/organ/O = A
		if(O.health.organic == organic && O.broken)
			O.broken = FALSE

/obj/item/container/healing/bone_gel
	name = "bone gel"
	desc = "Oof ouch my bones."
	desc_extended = "An advanced gel substance that encourages broken bone growth instantly when applied. Some tissue damage is a side effect."
	icon_state = "bone_gel"
	treatment_time_mul = 4
	heal_brute = 0
	heal_brute_percent = -2
	amount_max = 3

	value = 120

	organic = TRUE

/obj/item/container/healing/bone_gel/treat(var/mob/caller,var/atom/A)

	. = ..()

	if(. && is_organ(A))
		var/obj/item/organ/O = A
		if(O.health.organic == organic && O.broken)
			O.broken = FALSE


/obj/item/container/healing/burn_kit
	name = "burn kit"
	desc = "Each kit contains a set of ointments and antiseptics."
	desc_extended = "The major problems with burns aren't as much the burns themselves, but the infections. These kits have antiseptics, lowering infection. Of course, the best way to avoid infection is still to be dead."
	icon_state = "burnkit"
	treatment_time_mul = 1.25
	heal_burn = 80
	heal_burn_percent = 10
	amount_max = 10

	value = 20

/obj/item/container/healing/burn_kit/advanced
	name = "infused burn kit (silver sulfadiazine)"
	desc = "I can't believe they still cheaped out on the silver sulfadiazine."
	desc_extended = "Burn kits whose contents have been infused with Silver Sulfadiazine. A great lesson in how Capitalism will never provide to your needs."

/obj/item/container/healing/burn_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/healing/cable
	name = "cable"
	desc = "I prefer satellite"
	desc_extended = "Cable for construction purposes and fixing robotic limbs."
	icon_state = "cable"
	treatment_time_mul = 1.25
	heal_burn = 70
	amount_max = 10

	value = 20

	organic = FALSE

/obj/item/container/healing/patch
	name = "medical patch"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch"
	treatment_time_mul = 0.5
	amount_max = 3

	value = 5

/obj/item/container/healing/patch/brute
	name = "brute patch (Styptic Powder)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch_brute"

/obj/item/container/healing/patch/brute/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,60)
	return ..()

/obj/item/container/healing/patch/burn
	name = "burn patch (Silver Sulfadiazine)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch_burn"

/obj/item/container/healing/patch/burn/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,60)
	return ..()

/obj/item/container/healing/patch/synthflesh
	name = "regeneration patch (Synthflesh)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch"

/obj/item/container/healing/patch/synthflesh/Generate()
	reagents.add_reagent(/reagent/medicine/synthflesh,60)
	return ..()

/obj/item/container/healing/gauze
	name = "gauze"
	desc = "Stop the bleeding. And that's it."
	desc_extended = "Folks here believe that any affliction can be smothered in bandages, and any decently soft cloth can serve as one. Makes one wonder how people with such advanced medical knowledge even get sick at all."
	icon_state = "gauze"
	treatment_time_mul = 1
	heal_brute = 0
	heal_brute_percent = 0
	heal_bleeding = TRUE
	amount_max = 10

	value = 10
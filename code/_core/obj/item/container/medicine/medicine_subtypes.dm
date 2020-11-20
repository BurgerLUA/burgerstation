/obj/item/container/medicine/bandage
	name = "bandages"
	desc = "Stop the bleeding, and you stop death - or delay it, at least."
	desc_extended = "Folks here believe that any affliction can be smothered in bandages, and any decently soft cloth can serve as one. Makes one wonder how people with such advanced medical knowledge even get sick at all."
	icon_state = "brutepack"
	treatment_time_mul = 1
	heal_brute = 30
	heal_brute_percent = 0
	heal_bleeding = TRUE
	item_count_current = 5
	item_count_max = 10

	value = 10

/obj/item/container/medicine/bandage/advanced
	name = "infused bandages (styptic powder)"
	desc = "Allows wounds to recover further than simple cloth."
	desc_extended = "Bandages infused with styptic power. Close wounds faster than normal bandages if pressed well against the skin."

/obj/item/container/medicine/bandage/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/medicine/ointment
	name = "ointment"
	desc = "Nothing like salving an itching burn."
	desc_extended = "Applied topically to burns to heal the skin and relieve pain. Standard ointment bottles used to have Silver Sulfadiazine in them, but were deemed too expensive to keep buying in bulk."
	icon_state = "ointment"
	treatment_time_mul = 1
	heal_burn = 30
	heal_burn_percent = 0
	value = 10

/obj/item/container/medicine/ointment/advanced
	name = "infused ointment (silver sulfadiazine)"
	desc = "Sometimes you have to prepare your own medicine."
	desc_extended = "Ointment whose gel has been mixed with Silver Sufadiazine.  Far more effective at both healing burnt skin and relieving pain."
/obj/item/container/medicine/ointment/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/medicine/trauma_kit
	name = "trauma kit"
	desc = "Each kit contains a set of bandaging equipment:bandages, splits, and antiseptics."
	desc_extended = "Very useful for recovery after traumatic injury. Allows to stop bleeding, disinfect wounds, support injured joints and damaged tissue."
	icon_state = "traumakit"
	treatment_time_mul = 1.25
	heal_brute = 80
	heal_brute_percent = 10
	heal_bleeding = TRUE
	item_count_current = 5
	item_count_max = 10

	value = 20

/obj/item/container/medicine/trauma_kit/advanced
	name = "infused trauma kit (styptic powder)"
	desc = "I knew something was missing."
	desc_extended = "Trauma Kits with added styptic powder to the bandages and antiseptics, allowing for even better recovery."

/obj/item/container/medicine/trauma_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,50)
	return ..()

/obj/item/container/medicine/nanopaste
	name = "nanopaste"
	desc = "Nanomachines, son!"
	desc_extended = "A tube of healing nanites that heals any mechanical limb of any brute and burn damage."
	icon_state = "nanopaste"
	treatment_time_mul = 1.25
	heal_brute = 80
	heal_brute_percent = 10
	heal_burn = 80
	heal_burn_percent = 10
	heal_bleeding = TRUE
	item_count_current = 5
	item_count_max = 10

	value = 80

	robotic = TRUE



/obj/item/container/medicine/burn_kit
	name = "burn kit"
	desc = "Each kit contains a set of ointments and antiseptics."
	desc_extended = "The major problems with burns aren't as much the burns themselves, but the infections. These kits have antiseptics, lowering infection. Of course, the best way to avoid infection is still to be dead."
	icon_state = "burnkit"
	treatment_time_mul = 1.25
	heal_burn = 80
	heal_burn_percent = 10
	item_count_current = 5
	item_count_max = 10

	value = 20

/obj/item/container/medicine/burn_kit/advanced
	name = "infused burn kit (silver sulfadiazine)"
	desc = "I can't believe they still cheaped out on the silver sulfadiazine."
	desc_extended = "Burn kits whose contents have been infused with Silver Sulfadiazine. A great lesson in how Capitalism will never provide to your needs."

/obj/item/container/medicine/burn_kit/advanced/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,50)
	return ..()

/obj/item/container/medicine/cable
	name = "cable"
	desc = "I prefer satellite"
	desc_extended = "Cable for construction purposes and fixing robotic limbs."
	icon_state = "cable"
	treatment_time_mul = 1.25
	heal_burn = 70
	item_count_current = 5
	item_count_max = 10

	value = 20

	robotic = TRUE

/obj/item/container/medicine/patch
	name = "medical patch"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch"
	treatment_time_mul = 0.5
	item_count_current = 3
	item_count_max = 3

	value = 5

/obj/item/container/medicine/patch/brute
	name = "brute patch (Styptic Powder)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch_brute"

/obj/item/container/medicine/patch/brute/Generate()
	reagents.add_reagent(/reagent/medicine/styptic_powder,60)
	return ..()

/obj/item/container/medicine/patch/burn
	name = "burn patch (Silver Sulfadiazine)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch_burn"

/obj/item/container/medicine/patch/burn/Generate()
	reagents.add_reagent(/reagent/medicine/silver_sulfadiazine,60)
	return ..()

/obj/item/container/medicine/patch/synthflesh
	name = "regeneration patch (Synthflesh)"
	desc = "For when you can't be bothered to use a syringe."
	desc_extended = "Patches like these can't be used to cover wounds on their own, but can administer a great quantity of medicines really fast. Of course, giving too much medicines can be a way to speed up death rather than delay it, so be careful."
	icon_state = "patch"

/obj/item/container/medicine/patch/synthflesh/Generate()
	reagents.add_reagent(/reagent/medicine/synthflesh,60)
	return ..()




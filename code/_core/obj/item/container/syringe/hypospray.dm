/obj/item/container/syringe/hypospray
	name = "hypospray"
	desc = ";CMO IS A CHANGELING!!"
	desc_extended = "A bulky, sterile, reusuable air-needle autoinjector for rapid administration of drugs to patients. Injects up to 15 units at a time, almost instantly."

	value = 800
	icon = 'icons/obj/item/container/hypospray.dmi'
	icon_state = "hypo"

	injection_sound = 'sound/effects/stimpack.ogg'

	quality_reduction_on_use = 0
	injection_time = SECONDS_TO_DECISECONDS(0.25)
	inject_amount_max = 15
	reagents = /reagent_container/syringe/medipen/hypospray // holds 60u
	adjustable = TRUE

	size = SIZE_3

	icon_count = 13

/obj/item/container/syringe/hypospray/combat
	name = "combat hypospray"
	desc = ";CMO IS A CHANGELING!!"
	desc_extended = "A sterile, reusuable air-needle autoinjector for rapid administration of drugs to patients. About half the size of a regular hypospray, and just as powerful. Injects up to 30 units at a time, instantly."

	value = 1600
	icon = 'icons/obj/item/container/hypospray_combat.dmi'
	icon_state = "combat_hypo"

	injection_sound = 'sound/effects/stimpack.ogg'

	quality_reduction_on_use = 0
	injection_time = 0
	inject_amount_max = 30
	reagents = /reagent_container/syringe/medipen/hypospray/combat // holds 30u
	adjustable = TRUE

	size = SIZE_2

	icon_count = 5

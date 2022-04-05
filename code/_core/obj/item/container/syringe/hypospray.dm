/obj/item/container/syringe/hypospray
	name = "hypospray"
	desc = ";CMO IS A CHANGELING!!"
	desc_extended = "A sterile, reusuable air-needle autoinjector for rapid administration of drugs to patients."

	value = 800
	icon = 'icons/obj/item/container/hypospray.dmi'
	icon_state = "combat_hypo"

	injection_sound = 'sound/effects/stimpack.ogg'

	quality_reduction_on_use = 0
	injection_time = 0
	inject_amount_max = 15
	reagents = /reagent_container/syringe/medipen/hypospray // holds 60u
	adjustable = TRUE

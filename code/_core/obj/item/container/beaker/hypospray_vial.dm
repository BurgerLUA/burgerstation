/obj/item/container/simple/beaker/bottle/hypospray
	name = "hypospray vial"
	desc = "Reagents in a semi-compressed bottle."

	icon = 'icons/obj/item/container/cup/bottle_hypo.dmi'
	icon_state = "bottle"
	icon_count = 10

	reagents = /reagent_container/beaker/bottle/

	var/spent = FALSE

	size = SIZE_1

/obj/item/container/simple/beaker/bottle/hypospray/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("spent")

/obj/item/container/simple/beaker/bottle/hypospray/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("spent")

/obj/item/container/simple/beaker/bottle/hypospray/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"compress[spent ? "_spent" : ""]")
	add_overlay(I)




/obj/item/container/simple/beaker/bottle/hypospray/brute_mix
	name = "syndicate hypospray brute prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/brute_mix/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine_plus,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/percardone,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/mitogen,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/hypospray/burn_mix
	name = "syndicate hypospray burn prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/burn_mix/Generate()
	reagents.add_reagent(/reagent/medicine/arentane,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/kenotone,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/hypospray/toxin_mix
	name = "syndicate hypospray toxin prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/toxin_mix/Generate()
	reagents.add_reagent(/reagent/medicine/charcoal,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/adrenaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/antihol,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/hypospray/death_mix
	name = "syndicate hypospray death prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/death_mix/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/dexalin,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/hypospray/rad_mix
	name = "syndicate hypospray radiation prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/rad_mix/Generate()
	reagents.add_reagent(/reagent/medicine/rad_b_gone,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/medicine/charcoal,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/space_prussian_blue,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/potassium_iodide,reagents.volume_max*0.15)
	return ..()


/obj/item/container/simple/beaker/bottle/hypospray/combat_mix
	name = "syndicate hypospray combat mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/hypospray/combat_mix/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/stamina_potion,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/health_potion,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/mana_potion,reagents.volume_max*0.2)
	return ..()
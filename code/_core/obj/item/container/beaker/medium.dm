/obj/item/container/simple/beaker/bottle/medium
	name = "medium bottle"
	desc = "Remember to read the label before drinking."
	desc_extended = "A bottle used by chemists to contain medicines and other reagents."
	icon = 'icons/obj/item/container/cup/bottle_medium.dmi'
	icon_state = "bottle"
	icon_count = 10

	reagents = /reagent_container/beaker/bottle/medium

	value = 5

	size = SIZE_2


/obj/item/container/simple/beaker/bottle/medium/bicaridine
	name = "bottle of bicaridine"

/obj/item/container/simple/beaker/bottle/medium/bicaridine/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/kelotane
	name = "bottle of kelotane"

/obj/item/container/simple/beaker/bottle/medium/kelotane/Generate()
	reagents.add_reagent(/reagent/medicine/kelotane,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/dylovene
	name = "bottle of dylovene"

/obj/item/container/simple/beaker/bottle/medium/dylovene/Generate()
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/epinephrine
	name = "bottle of epinephrine"

/obj/item/container/simple/beaker/bottle/medium/epinephrine/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/morphine
	name = "bottle of morphine"

/obj/item/container/simple/beaker/bottle/medium/morphine/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/calomel
	name = "bottle of calomel"

/obj/item/container/simple/beaker/bottle/medium/calomel/Generate()
	reagents.add_reagent(/reagent/medicine/purge,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/inaprovaline
	name = "bottle of inaprovaline"

/obj/item/container/simple/beaker/bottle/medium/inaprovaline/Generate()
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/brute_mix
	name = "syndicate brute prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/brute_mix/Generate()
	reagents.add_reagent(/reagent/medicine/bicaridine_plus,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/percardone,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/mitogen,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/burn_mix
	name = "syndicate burn prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/burn_mix/Generate()
	reagents.add_reagent(/reagent/medicine/arentane,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/kenotone,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/toxin_mix
	name = "syndicate toxin prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/toxin_mix/Generate()
	reagents.add_reagent(/reagent/medicine/charcoal,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/dylovene,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/adrenaline,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/antihol,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/death_mix
	name = "syndicate death prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/death_mix/Generate()
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/omnizine,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/medicine/dexalin,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/inaprovaline,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/adrenaline/epinephrine,reagents.volume_max*0.15)
	return ..()

/obj/item/container/simple/beaker/bottle/medium/rad_mix
	name = "syndicate radiation prevention mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/rad_mix/Generate()
	reagents.add_reagent(/reagent/medicine/rad_b_gone,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/medicine/charcoal,reagents.volume_max*0.20)
	reagents.add_reagent(/reagent/medicine/space_prussian_blue,reagents.volume_max*0.15)
	reagents.add_reagent(/reagent/medicine/potassium_iodide,reagents.volume_max*0.15)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/combat_mix
	name = "syndicate combat mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/combat_mix/Generate()
	reagents.add_reagent(/reagent/medicine/adrenaline,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/painkiller/morphine,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/stamina_potion,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/health_potion,reagents.volume_max*0.2)
	reagents.add_reagent(/reagent/medicine/mana_potion,reagents.volume_max*0.2)
	return ..()


/obj/item/container/simple/beaker/bottle/medium/poison
	name = "syndicate poison mix"
	rarity = RARITY_RARE

/obj/item/container/simple/beaker/bottle/medium/poison/Generate()
	reagents.add_reagent(/reagent/toxin/polypnium_toxin,reagents.volume_max*0.5)
	reagents.add_reagent(/reagent/nutrition/ethanol/absinthe/premium,reagents.volume_max*0.25)
	reagents.add_reagent(/reagent/drug/lithium,reagents.volume_max*0.25)
	return ..()
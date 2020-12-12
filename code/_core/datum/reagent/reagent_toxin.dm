/reagent/toxin/
	name = "toxin"
	desc = "A common toxin found nearly everywhere."
	color = "#FF8411"
	alpha = 200

	var/damage_per_unit = 1

	lethal = TRUE

	liquid = 0.5

/reagent/toxin/New(var/desired_loc)

	value *= 1+(damage_per_unit*2)

	return ..()

/reagent/toxin/on_metabolize_stomach(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*damage_per_unit*0.75,robotic=FALSE)

	return .

/reagent/toxin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	. = ..()

	if(owner && owner.health)
		owner.health.adjust_loss_smart(tox=.*damage_per_unit,robotic=FALSE)

	return .



/reagent/toxin/angel_toxin
	name = "angel toxin"
	desc = "An incredibly lethal toxin. Injecting this will make you see angels."

	damage_per_unit = 15

	flavor = "mushroom"


/reagent/toxin/fly_amanita_toxin
	name = "fly amanita toxin"
	desc = "An moderately lethal toxin."

	damage_per_unit = 4

	flavor = "mushroom"

/reagent/toxin/xeno_acid
	name = "xeno acid"
	desc = "Literal fucking acid."

	damage_per_unit = 2

	flavor = "pain"

/reagent/toxin/spider_toxin
	name = "spider toxin"
	desc = "Toxins bad."

	damage_per_unit = 3

	flavor = "arachnophobia"


/reagent/toxin/zombie_toxin
	name = "zombie toxin"
	desc = "Toxins from a zombie. Doesn't go away when metabolized in the bloodstream and deals constant toxic damage based on the volume."

	damage_per_unit = 1


/reagent/toxin/zombie_toxin/on_metabolize_blood(var/atom/owner,var/reagent_container/container,var/starting_volume=0,var/multiplier=1)

	if(container.get_reagent_volume(/reagent/medicine/zombie_antidote) >= container.get_reagent_volume(src.type))
		return 0

	..()

	return 0


/reagent/toxin/sulfur_dioxide
	name = "Sulfur Dioxide"
	desc = "Toxic fumes from burning sulfur with coal."

	damage_per_unit = 1

	heated_reagent = /reagent/acid/sulphuric
	heated_reagent_temp = 600
	heated_reagent_amount = 1
	heated_reagent_mul = 0.01
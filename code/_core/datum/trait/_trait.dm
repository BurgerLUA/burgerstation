/trait/
	var/name = "Trait"
	var/desc = "Description"
	var/category
	var/add_message
	var/remove_message

/trait/proc/on_add(var/mob/living/L)
	if(add_message)
		L.to_chat(span("notice",add_message))
	return TRUE

/trait/proc/on_remove(var/mob/living/L)
	if(remove_message)
		L.to_chat(span("notice",remove_message))
	return TRUE

/trait/unarmed/
	category = /trait/unarmed/ //TODO: Make this just add damage to all unarmed attacks.
	var/damagetype/damage_type

/trait/unarmed/shocking_touch
	name = "Shocking Touch"
	desc = "Basic unarmed harmful strikes deal pure shock damage, and have a chance to stun."

	add_message = "Electricity flows through your hands."
	remove_message = "Your hands no longer flow with energy..."

	damage_type = /damagetype/unarmed/fists/shock_touch

/trait/metabolism/
	category = /trait/metabolism/
	var/metabolism_multiplier = 1
	var/hunger_multiplier = 1

/trait/metabolism/fast
	name = "Fast Metabolism"
	desc = "Reagents metabolize twice as fast in the bloodstream, but you are hungry more often."
	metabolism_multiplier = 2
	hunger_multiplier = 1.5

/trait/metabolism/slow
	name = "Slow Metabolism"
	desc = "Reagents metabolize twice as slow in the bloodstream, but you are hungrier less often."
	metabolism_multiplier = 0.5
	hunger_multiplier = 0.75

/trait/pain_tolerant/
	name = "Pain Tolerant"
	desc = "You do not scream when experiencing pain."

/trait/block_runner/
	name = "Block Runner"
	desc = "You can block while running, but you can't block while standing still."

/trait/flamability/
	category = /trait/flamability
	var/fire_stack_multiplier = 1

/trait/flamability/fire_retardant
	name = "Fire Retardant"
	desc = "You seem to be less flammable than normal."
	fire_stack_multiplier = 0.75

/trait/flamability/flammable
	name = "Flammable"
	desc = "You seem to get set on fire easily."
	fire_stack_multiplier = 1.25

/trait/death_check
	category = /trait/death_check
	var/extra_health = 0

/trait/death_check/tenacious
	name = "Tenacious"
	desc = "You never seem to give up, even on death's door."
	extra_health = 50

/trait/death_check/quitter
	name = "Quitter"
	desc = "You seem to give up easily, especially when about to die."
	extra_health = -50

/trait/bleed_multiplier
	category = /trait/bleed_multiplier
	var/bleed_multiplier

/trait/bleed_multiplier/paper_skin
	name = "Paper Skin"
	desc = "You seem to bleed easier than most."
	bleed_multiplier = 1.5

/trait/bleed_multiplier/hard_skin
	name = "Tough Skin"
	desc = "Your skin seems to bleed harder than most."
	bleed_multiplier = 0.75

/trait/blood_regen/
	category = /trait/blood_regen/
	var/regen_multiplier = 0

/trait/blood_regen/blood_degen
	name = "Anemia"
	desc = "You body regenerates blood much slower, consuming less nutrition over time while at low blood."
	regen_multiplier = 0.25

/trait/blood_regen/blood_regen
	name = "Polycythemia Vera"
	desc = "Your bodyt regenerates blood at a increased rate, consuming more nutrition over time while at low blood."
	regen_multiplier = 1.5


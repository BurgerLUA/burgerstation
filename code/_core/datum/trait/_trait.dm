#define TRAIT_POSITIVE "positive"
#define TRAIT_NEGATIVE "negative"
#define TRAIT_NEUTRAL "neutral"

/trait/
	var/name
	var/desc
	var/category
	var/add_message
	var/remove_message

	var/trait_tag = TRAIT_NEUTRAL

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

	trait_tag = TRAIT_POSITIVE

/trait/metabolism/
	category = /trait/metabolism/
	var/metabolism_multiplier = 1
	var/hunger_multiplier = 1

/trait/metabolism/fast
	name = "Fast Metabolism"
	desc = "Reagents metabolize twice as fast in the bloodstream, but you are hungry more often."
	metabolism_multiplier = 2
	hunger_multiplier = 1.5
	trait_tag = TRAIT_NEUTRAL

/trait/metabolism/slow
	name = "Slow Metabolism"
	desc = "Reagents metabolize twice as slow in the bloodstream, but you are hungrier less often."
	metabolism_multiplier = 0.5
	hunger_multiplier = 0.75
	trait_tag = TRAIT_NEUTRAL

/trait/pain_tolerant/
	name = "Pain Tolerant"
	desc = "You do not scream when experiencing pain."
	trait_tag = TRAIT_POSITIVE

/trait/block_runner/
	name = "Block Runner"
	desc = "You can block while running, but you can't block while standing still."
	trait_tag = TRAIT_NEUTRAL

/trait/flamability/
	category = /trait/flamability
	var/fire_stack_multiplier = 1

/trait/flamability/fire_retardant
	name = "Fire Retardant"
	desc = "You seem to be less flammable than normal."
	fire_stack_multiplier = 0.75
	trait_tag = TRAIT_POSITIVE

/trait/flamability/flammable
	name = "Flammable"
	desc = "You seem to get set on fire easily."
	fire_stack_multiplier = 1.25
	trait_tag = TRAIT_NEGATIVE

/trait/death_check
	category = /trait/death_check
	var/extra_health = 0

/trait/death_check/tenacious
	name = "Tenacious"
	desc = "You never seem to give up, even on death's door."
	extra_health = 50
	trait_tag = TRAIT_POSITIVE

/trait/death_check/quitter
	name = "Quitter"
	desc = "You seem to give up easily, especially when about to die."
	extra_health = -50
	trait_tag = TRAIT_NEGATIVE

/trait/bleed_multiplier
	category = /trait/bleed_multiplier
	var/bleed_multiplier

/trait/bleed_multiplier/paper_skin
	name = "Paper Skin"
	desc = "You seem to bleed easier than most."
	bleed_multiplier = 1.5
	trait_tag = TRAIT_NEGATIVE

/trait/bleed_multiplier/hard_skin
	name = "Tough Skin"
	desc = "Your skin seems to bleed harder than most."
	bleed_multiplier = 0.75
	trait_tag = TRAIT_POSITIVE

/trait/blood_regen/
	category = /trait/blood_regen/
	var/regen_multiplier = 1

/trait/blood_regen/blood_degen
	name = "Anemia"
	desc = "You body regenerates blood much slower, consuming less nutrition over time while at low blood."
	regen_multiplier = 0.25
	trait_tag = TRAIT_NEGATIVE

/trait/blood_regen/blood_regen
	name = "Polycythemia Vera"
	desc = "Your body regenerates blood at a increased rate, consuming more nutrition over time while at low blood."
	regen_multiplier = 1.5
	trait_tag = TRAIT_POSITIVE

/trait/intoxication_regen/
	category = /trait/intoxication_regen/
	var/alcohol_threshold_multiplier = 1
	var/intoxication_removal_multiplier = 1
	var/should_apply_drunk_status_effects = TRUE

/trait/intoxication_regen/light_drinker
	name = "Light Drinker"
	desc = "You can't hold your liquor, and don't sober up as quick."
	alcohol_threshold_multiplier = 0.75
	intoxication_removal_multiplier = 0.5
	should_apply_drunk_status_effects = TRUE
	trait_tag = TRAIT_NEGATIVE

/trait/intoxication_regen/seasoned_drinker
	name = "Seasoned Drinker"
	desc = "You can hold your liquor well, but don't sober up as quick."
	alcohol_threshold_multiplier = 2
	intoxication_removal_multiplier = 0.5
	should_apply_drunk_status_effects = FALSE
	trait_tag = TRAIT_POSITIVE

/trait/general_regen/
	category = /trait/general_regen/
	var/health_regen_mul = 1
	var/stamina_regen_mul = 1
	var/mana_regen_mul = 1

/trait/general_regen/mind_over_matter
	name = "Mind Over Matter"
	desc = "You regenerate mana twice as much, but regenerate health half as much."
	health_regen_mul = 0.5
	mana_regen_mul = 2
	trait_tag = TRAIT_NEUTRAL

/trait/general_regen/jock
	name = "Jock"
	desc = "You regenerate stamina twice as much, but regenerate mana half as much."
	stamina_regen_mul = 2
	mana_regen_mul = 0.5
	trait_tag = TRAIT_NEUTRAL

/trait/general_regen/nerd
	name = "Nerd"
	desc = "You regenerate mana twice as much, but regenerate stamina half as much."
	stamina_regen_mul = 0.5
	mana_regen_mul = 2
	trait_tag = TRAIT_NEUTRAL

/trait/speed/
	category = /trait/speed/
	var/move_delay_mul = 1

/trait/speed/overweight
	name = "Overweight"
	desc = "You have a habbit for eating too much, and thus suffer a movement speed penalty."
	move_delay_mul = 0.9
	trait_tag = TRAIT_NEGATIVE

/trait/speed/quick
	name = "Quick"
	desc = "You're quite athletic and are quick to move with a bonus to movement speed."
	move_delay_mul = 1.1
	trait_tag = TRAIT_POSITIVE

/trait/nutrition/
	category = /trait/nutrition/
	var/nutrition_multiplier = 1

/trait/nutrition/malnutrition
	name = "Malnutrition"
	desc = "You have a poor diet and suffer a penalty to nutritional quality."
	nutrition_multiplier = 0.9
	trait_tag = TRAIT_NEGATIVE

/trait/nutrition/vigorous
	name = "Vigorous"
	desc = "You have a good diet and gain a bonus to nutritional quality."
	nutrition_multiplier = 1.1
	trait_tag = TRAIT_POSITIVE


/trait/handcuffs/
	category = /trait/handcuffs
	var/handcuff_escape_multiplier = 1

/trait/handcuffs/escape_artist
	name = "Escape Artist"
	desc = "You can escape handcuffs quicker and easier."
	handcuff_escape_multiplier = 2
	trait_tag = TRAIT_POSITIVE

/trait/handcuffs/unsmooth_criminal
	name = "Unsmooth Criminal"
	desc = "You seem to have a difficult time removing handcuffs."
	handcuff_escape_multiplier = 0.75
	trait_tag = TRAIT_NEGATIVE
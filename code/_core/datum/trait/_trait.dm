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

/trait/proc/on_add(var/mob/living/L,var/messages=TRUE)

	if(messages)
		if(add_message)
			L.to_chat(span("notice [trait_tag]",add_message))

		L.to_chat(span("notice [trait_tag]","<b>New Trait Gained:</b> [name]!"))
		L.to_chat(span("notice","[desc]"))

	return TRUE

/trait/proc/on_remove(var/mob/living/L,var/messages=TRUE)


	if(messages)
		var/inverse = TRAIT_NEUTRAL
		if(trait_tag == TRAIT_POSITIVE)
			inverse = TRAIT_NEGATIVE
		else if(trait_tag == TRAIT_NEGATIVE)
			inverse = TRAIT_POSITIVE

		if(remove_message)
			L.to_chat(span("notice [inverse]",remove_message))

		L.to_chat(span("notice [inverse]","<b>Trait Lost:</b> [name]!"))

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
	var/thirst_multiplier = 1

/trait/metabolism/fast
	name = "Fast Metabolism"
	desc = "Reagents metabolize twice as fast in the bloodstream, but you are hungry more often."

	add_message = "You feel your metabolic energy increase."
	remove_message = "Your metabolism no longer feels as active..."

	metabolism_multiplier = 2
	hunger_multiplier = 1.5
	trait_tag = TRAIT_NEUTRAL

/trait/metabolism/none
	name = "No Metabolism"
	desc = "You have no metabolism; you don't get hungry and reagents don't process in your system."

	add_message = "You somehow feel like you have no metabolism..."
	remove_message = "You now have a metabolism."

	metabolism_multiplier = 0
	hunger_multiplier = 0
	thirst_multiplier = 0
	trait_tag = TRAIT_NEUTRAL

/trait/metabolism/slow
	name = "Slow Metabolism"
	desc = "Reagents metabolize twice as slow in the bloodstream, but you are hungrier less often."

	add_message = "You feel your metabolic energy decrease."
	remove_message = "Your metabolism no longer feels as slow..."

	metabolism_multiplier = 0.5
	hunger_multiplier = 0.75
	trait_tag = TRAIT_NEUTRAL

/trait/pain_tolerant/
	name = "Pain Tolerant"
	desc = "You do not scream when experiencing pain."

	add_message = "You don't feel the need to scream while in pain."
	remove_message = "You feel the need to scream while in pain..."

	trait_tag = TRAIT_POSITIVE

/trait/block_runner/
	name = "Block Runner"
	desc = "You can block while running, but you can't block while standing still."
	trait_tag = TRAIT_NEUTRAL

	add_message = "Wait... what if I hold the shield up while I run?"
	remove_message = "You now forget that you can run with a shield."

/trait/flamability/
	category = /trait/flamability
	var/fire_stack_multiplier = 1

/trait/flamability/fire_retardant
	name = "Fire Retardant"
	desc = "You seem to be less flammable than normal."
	fire_stack_multiplier = 0.75
	trait_tag = TRAIT_POSITIVE

	add_message = "Your skin gets a little moist. This should be useful if I'm ever set on fire..."
	remove_message = "Your skin no longer feels as moist."

/trait/flamability/flammable
	name = "Flammable"
	desc = "You seem to get set on fire easily."

	add_message = "Your skin feels very dry and very flammable..."
	remove_message = "Your skin no longer feels as dry."

	fire_stack_multiplier = 1.25
	trait_tag = TRAIT_NEGATIVE

/trait/death_check
	category = /trait/death_check
	var/extra_health = 0

/trait/death_check/tenacious
	name = "Tenacious"
	desc = "You never seem to give up, even on death's door."

	add_message = "You are filled with determination."
	remove_message = "You no longer feel as determined as before."


	extra_health = 50
	trait_tag = TRAIT_POSITIVE

/trait/death_check/quitter
	name = "Quitter"
	desc = "You seem to give up easily, especially when about to die."

	add_message = "You feel like there really isn't any point to hanging in there while dying, especially when you can get cloned and all..."
	remove_message = "You don't seem to give up on life as easy as before."

	extra_health = -50
	trait_tag = TRAIT_NEGATIVE

/trait/bleed_multiplier
	category = /trait/bleed_multiplier
	var/bleed_multiplier

/trait/bleed_multiplier/paper_skin
	name = "Paper Skin"
	desc = "You seem to bleed easier than most."

	add_message = "Your skin feels as fragile as paper..."
	remove_message = "Your skin no longer feels as fragile."

	bleed_multiplier = 1.5
	trait_tag = TRAIT_NEGATIVE

/trait/bleed_multiplier/hard_skin
	name = "Tough Skin"
	desc = "Your skin seems to bleed harder than most."

	add_message = "Your skin gets considerably tougher."
	remove_message = "Your skin no longer feels as tough."

	bleed_multiplier = 0.75
	trait_tag = TRAIT_POSITIVE

/trait/blood_regen/
	category = /trait/blood_regen/
	var/regen_multiplier = 1

/trait/blood_regen/none
	name = "Blood Degeneration"
	desc = "Your body doesn't generate any blood at all."
	add_message = "You feel anemic..."
	remove_message = "You no longer feel anemic."
	regen_multiplier = 0
	trait_tag = TRAIT_NEGATIVE


/trait/blood_regen/blood_degen
	name = "Anemia"
	desc = "You body regenerates blood much slower, consuming less nutrition over time while at low blood."
	add_message = "You feel anemic..."
	remove_message = "You no longer feel anemic."
	regen_multiplier = 0.25
	trait_tag = TRAIT_NEGATIVE

/trait/blood_regen/blood_regen
	name = "Polycythemia Vera"
	add_message = "Your veins get larger, and your heart pounds... guess I make a lot more blood now."
	remove_message = "You no longer feel like your body can produce more blood."
	desc = "Your body regenerates blood at a increased rate, consuming more nutrition over time while at low blood."
	regen_multiplier = 1.5
	trait_tag = TRAIT_POSITIVE

/trait/intoxication_regen/
	category = /trait/intoxication_regen/
	var/alcohol_threshold_multiplier = 1
	var/intoxication_removal_multiplier = 1
	var/should_apply_drunk_status_effects = TRUE
	var/reverse_intoxication = FALSE

/trait/intoxication_regen/reverse
	name = "Reverse Intoxication"
	desc = "You need alcohol to sustain yourself. A lack of alcohol makes you more intoxicated, somehow."
	add_message = "You feel like you rely on alcohol."
	remove_message = "You don't feel like you have a dependence on alcohol anymore."
	alcohol_threshold_multiplier = 2
	should_apply_drunk_status_effects = TRUE
	reverse_intoxication = TRUE
	trait_tag = TRAIT_NEGATIVE


/trait/intoxication_regen/light_drinker
	name = "Light Drinker"
	desc = "You can't hold your liquor, and don't sober up as quick."
	add_message = "You feel like you can't hold your liqour well..."
	remove_message = "You feel like you can hold your liquor normally."
	alcohol_threshold_multiplier = 0.75
	intoxication_removal_multiplier = 0.5
	should_apply_drunk_status_effects = TRUE
	trait_tag = TRAIT_NEGATIVE

/trait/intoxication_regen/seasoned_drinker
	name = "Seasoned Drinker"
	desc = "You can hold your liquor well, but don't sober up as quick."
	add_message = "You feel like you can hold your liquor very well."
	remove_message = "You feel like you can hold your liqour normally."
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
	add_message = "Your brain feels focused, but your heart... not so much."
	remove_message = "Your mind and body feel back in sync."
	health_regen_mul = 0.5
	mana_regen_mul = 2
	trait_tag = TRAIT_NEUTRAL

/trait/general_regen/jock
	name = "Physically Focused"
	desc = "You regenerate stamina twice as much, but regenerate mana half as much."
	add_message = "Your stamina feels better, but your mind is... uh... what's that word... huh... hm..."
	remove_message = "Your mind and body feel back in sync."
	stamina_regen_mul = 2
	mana_regen_mul = 0.5
	trait_tag = TRAIT_NEUTRAL

/trait/general_regen/nerd
	name = "Mentally Focused"
	desc = "You regenerate mana twice as much, but regenerate stamina half as much."
	add_message = "Your brain feels focused, but your body... not so much."
	remove_message = "Your mind and body feel back in sync."
	stamina_regen_mul = 0.5
	mana_regen_mul = 2
	trait_tag = TRAIT_NEUTRAL

/trait/speed/
	category = /trait/speed/
	var/move_delay_mul = 1

/trait/speed/slow
	name = "Slow"
	desc = "You prefer to take things a little more slowly."
	add_message = "You feel like everything moves too fast... why not walk once in a while?"
	remove_message = "You feel like you're comfortable moving normally."
	move_delay_mul = 1.1
	trait_tag = TRAIT_NEGATIVE

/trait/speed/quick
	name = "Quick"
	desc = "You're quite athletic and are quick to move with a bonus to movement speed."
	add_message = "You feel the need for speed."
	remove_message = "You no longer feel like speed is a good thing."
	move_delay_mul = 0.9
	trait_tag = TRAIT_POSITIVE

/trait/nutrition/
	category = /trait/nutrition/
	var/nutrition_multiplier = 1

/trait/nutrition/malnutrition
	name = "Malnutrition"
	desc = "You have a poor diet and suffer a penalty to nutritional quality."
	add_message = "You feel weak and tired..."
	remove_message = "You feel better now."
	nutrition_multiplier = 0.9
	trait_tag = TRAIT_NEGATIVE

/trait/nutrition/vigorous
	name = "Vigorous"
	desc = "You have a good diet and gain a bonus to nutritional quality."
	add_message = "Your body feels like it's full of life and vigor."
	remove_message = "Eh, you feel average now."
	nutrition_multiplier = 1.1
	trait_tag = TRAIT_POSITIVE


/trait/handcuffs/
	category = /trait/handcuffs
	var/handcuff_escape_multiplier = 1

/trait/handcuffs/escape_artist
	name = "Escape Artist"
	desc = "You can escape handcuffs quicker and easier."
	add_message = "I can break these cuffs."
	remove_message = "You can't break those cuffs."
	handcuff_escape_multiplier = 2
	trait_tag = TRAIT_POSITIVE


/trait/vitality
	category = /trait/vitality
	var/health_add = 0
	var/health_mul = 1

/trait/vitality/strong
	name = "Strong"
	desc = "You have +20 to health, and a 5% health increase."
	add_message = "You feel stronger."
	remove_message = "You feel average."
	health_add = 20
	health_mul = 1.05
	trait_tag = TRAIT_POSITIVE

/trait/vitality/fragile
	name = "Fragile"
	desc = "You have a -20 penalty to health, and a 5% health decrease."
	add_message = "You feel weaker."
	remove_message = "You feel average."
	health_add = 20
	health_mul = 1.05
	trait_tag = TRAIT_NEGATIVE

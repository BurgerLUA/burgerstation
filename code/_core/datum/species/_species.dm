/species/
	var/name = "Species Name"
	var/desc = "Short species description."
	var/desc_extended = "Extended species description."
	var/id = null

	var/dna/dna = null

	var/bite_size = 5 //How large bites are.

	var/flags_flavor_love = 0x0
	var/flags_flavor_hate = 0x0

	var/flags_species = SPECIES_NONE //The identifier of the species.
	var/flags_chargen = CHARGEN_NONE

	var/default_color_eye = "#FF0000"

	var/default_color_skin = "#0000FF"
	var/default_color_detail = "#FFFFFF"
	var/default_color_glow = "#FFFFFF"
	var/default_color_hair = "#00FF00"

	var/default_icon_hair = 'icons/mob/living/advanced/hair/human_hair_head.dmi'
	var/default_icon_state_hair = "none"

	var/default_icon_hair_face = 'icons/mob/living/advanced/hair/human_hair_face.dmi'
	var/default_icon_state_hair_face = "none"

	var/default_hairstyle_chargen_male = 2
	var/default_hairstyle_chargen_female = 3

	var/genderless = FALSE

	var/list/languages = list(
		LANGUAGE_BASIC
	)

	var/health/health = /health/mob/living/advanced

	var/list/emote_sounds_male = list(
		"laugh" = list('sound/voice/human/human_male_laugh_1.ogg','sound/voice/human/human_male_laugh_2.ogg'),
		"cough" = list('sound/voice/human/human_male_cough_1.ogg','sound/voice/human/human_male_cough_2.ogg'),
		"deathgasp" = list('sound/voice/human/human_male_deathgasp_1.ogg','sound/voice/human/human_male_deathgasp_2.ogg'),
		"gasp" = list('sound/voice/human/human_male_gasp_1.ogg','sound/voice/human/human_male_gasp_2.ogg','sound/voice/human/human_male_gasp_3.ogg'),
		"grenade" = list('sound/voice/human/human_male_grenadethrow_1.ogg','sound/voice/human/human_male_grenadethrow_2.ogg','sound/voice/human/human_male_grenadethrow_3.ogg'),
		"medic" = list('sound/voice/human/human_male_medic_1.ogg'),
		"pain" = list('sound/voice/human/human_male_pain_1.ogg','sound/voice/human/human_male_pain_2.ogg','sound/voice/human/human_male_pain_3.ogg','sound/voice/human/human_male_pain_4.ogg','sound/voice/human/human_male_pain_5.ogg','sound/voice/human/human_male_pain_6.ogg','sound/voice/human/human_male_pain_7.ogg','sound/voice/human/human_male_pain_8.ogg'),
		"scream" = list('sound/voice/human/human_male_scream_1.ogg','sound/voice/human/human_male_scream_2.ogg','sound/voice/human/human_male_scream_3.ogg','sound/voice/human/human_male_scream_4.ogg','sound/voice/human/human_male_scream_5.ogg','sound/voice/human/human_male_scream_6.ogg')
	)

	var/list/emote_sounds_male_meme = list(
		"scream" = list('sound/voice/human/human_male_scream_special_1.ogg','sound/voice/human/human_male_scream_special_2.ogg','sound/voice/human/human_male_scream_special_3.ogg','sound/voice/human/human_male_scream_special_4.ogg'),
		"pain" = list('sound/voice/human/human_male_pain_special_1.ogg','sound/voice/human/human_male_pain_special_2.ogg'),
		"deathgasp" = list('sound/voice/human/human_male_deathgasp_special_1.ogg','sound/voice/human/human_male_deathgasp_special_2.ogg'),
		"medic" = list('sound/voice/human/human_male_medic_special_1.ogg')
	)

	var/list/emote_sounds_female = list(
		"laugh" = list('sound/voice/human/human_female_laugh_1.ogg'),
		"cough" = list('sound/voice/human/human_female_cough_1.ogg','sound/voice/human/human_female_cough_2.ogg'),
		"deathgasp" = list('sound/voice/human/human_female_deathgasp_1.ogg','sound/voice/human/human_female_deathgasp_2.ogg'),
		"gasp" = list('sound/voice/human/human_female_gasp_1.ogg','sound/voice/human/human_female_gasp_2.ogg'),
		"grenade" = list('sound/voice/human/human_female_grenadethrow_1.ogg','sound/voice/human/human_female_grenadethrow_2.ogg','sound/voice/human/human_female_grenadethrow_3.ogg'),
		"medic" = list('sound/voice/human/human_female_medic_1.ogg'),
		"pain" = list('sound/voice/human/human_female_pain_1.ogg','sound/voice/human/human_female_pain_2.ogg','sound/voice/human/human_female_pain_3.ogg'),
		"scream" = list('sound/voice/human/human_female_scream_1.ogg','sound/voice/human/human_female_scream_2.ogg','sound/voice/human/human_female_scream_3.ogg','sound/voice/human/human_female_scream_4.ogg','sound/voice/human/human_female_scream_5.ogg')
	)

	var/list/emote_sounds_female_meme = list(

	)

	var/list/accent = null

	var/list/obj/item/organ/spawning_organs_male = list()

	var/list/obj/item/organ/spawning_organs_female = list()

	var/list/obj/hud/button/spawning_buttons = list(
		/obj/hud/button/hide_show_inventory,
		/obj/hud/button/move,
		/obj/hud/button/targeting_new,
		/obj/hud/button/intent/harm,
		/obj/hud/button/intent/help,
		/obj/hud/button/intent/disarm,
		/obj/hud/button/intent/grab,
		/obj/hud/button/sneak,

		/obj/hud/button/cash_money,
		/obj/hud/button/microstransactions,

		/obj/hud/button/crafting/craft,
		/obj/hud/button/crafting/close,

		/obj/hud/button/widget/experience,
		/obj/hud/button/widget/logout,
		/obj/hud/button/widget/change_theme,
		/obj/hud/button/widget/view_map,

		/obj/hud/button/squad/main,

		/obj/hud/button/message,

		/obj/hud/button/rest,

		/obj/hud/button/hunger,
		/obj/hud/button/thirst,
		/obj/hud/button/mood,

		/obj/hud/button/boss_health

	)

	var/list/obj/hud/button/spawning_ability_buttons = list(
		/obj/hud/button/ability/A,
		/obj/hud/button/ability/B,
		/obj/hud/button/ability/C,
		/obj/hud/button/ability/D
	)

	var/list/valid_blood_types = list(
		/reagent/blood/human/ab_negative,
		/reagent/blood/human/b_negative,
		/reagent/blood/human/ab_positive,
		/reagent/blood/human/a_negative,
		/reagent/blood/human/o_negative,
		/reagent/blood/human/b_positive,
		/reagent/blood/human/a_positive,
		/reagent/blood/human/o_positive
	)

	var/has_blood_toxicity = TRUE

/species/proc/process_accent(var/atom/speaker, var/atom/source, var/text_to_say, var/raw_text_to_say, var/text_type, var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)

	if(!accent || !length(accent))
		return text_to_say

	for(var/k in accent)
		var/v = accent[k]
		text_to_say = replacetextEx(text_to_say,k,v)

	return text_to_say


/species/proc/generate_blood_type()

	var/list/blood_types = list(
		/reagent/blood/human/ab_negative = 6,
		/reagent/blood/human/b_negative = 15,
		/reagent/blood/human/ab_positive = 34,
		/reagent/blood/human/a_negative = 63,
		/reagent/blood/human/o_negative = 66,
		/reagent/blood/human/b_positive = 85,
		/reagent/blood/human/a_positive = 357,
		/reagent/blood/human/o_positive = 374,
	)

	return pickweight(blood_types)
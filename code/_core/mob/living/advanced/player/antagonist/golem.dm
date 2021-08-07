var/global/list/possible_materials = list(
	"Platinum",
	"Gold",
	"Silver",
	"Bronze"
)


/mob/living/advanced/player/antagonist/golem
	loadout_to_use = /loadout/golem

/mob/living/advanced/player/antagonist/golem/default_appearance()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/golem)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/golem)

	var/chosen_material = possible_materials[1]
	if(length(possible_materials) > 1)
		possible_materials -= chosen_material

	var/skin_color = "#FFFFFF"
	switch(chosen_material)
		if("Bronze")
			real_name = "Bronze Golem"
			skin_color = COLOR_BRONZE
		if("Silver")
			real_name = "Silver Golem"
			skin_color = COLOR_SILVER
		if("Gold")
			real_name = "Gold Golem"
			skin_color = COLOR_GOLD
		if("Platinum")
			real_name = "Platinum Golem"
			skin_color = COLOR_PLATINUM

	var/species/S = SPECIES(species)
	handle_hairstyle_chargen(sex == MALE ? S.default_hairstyle_chargen_male : S.default_hairstyle_chargen_female,S.default_color_hair,FALSE)
	handle_beardstyle_chargen(1,S.default_color_hair,FALSE)
	handle_skincolor_chargen(skin_color,FALSE)
	handle_eyecolor_chargen(S.default_color_eye,FALSE)
	handle_detail_chargen(S.default_color_detail,FALSE)
	handle_glow_chargen(S.default_color_glow,FALSE)
	update_all_blends()

	return TRUE

/mob/living/advanced/player/antagonist/golem/add_species_languages()
	. = ..()
	known_languages[LANGUAGE_CANADIAN] = TRUE //lmao

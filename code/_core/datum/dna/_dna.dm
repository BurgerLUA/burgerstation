//Not like other server's DNA.
//This controls appearance generation for humanoids.

/dna/

	var/list/eye_color_rarity = list(

	)

	var/list/skin_color_rarity = list(

	)

	var/list/hair_color_rarity = list(

	)

	var/list/beard_color_rarity = list(

	)

	var/list/hair_style_rarity_male = list(

	)

	var/list/hair_style_rarity_female = list(

	)

	var/list/beard_style_rarity_male = list(

	)

	var/list/beard_style_rarity_female = list(

	)

	var/hair_color_same_as_skin_color = FALSE
	var/beard_color_same_as_skin_color = FALSE
	var/has_seperate_beard_color = FALSE

/dna/proc/generate_eye_color(var/fallback="#FFFFFF")

	if(!length(eye_color_rarity))
		return fallback

	var/chosen_color_01 = pickweight(eye_color_rarity)
	var/chosen_color_02 = pickweight(eye_color_rarity)
	var/final_color = blend_colors(chosen_color_01,chosen_color_02,rand())
	var/brightness = rand(10,245)
	var/tint_mod = rgb(brightness+rand(-10,10),brightness+rand(-10,10),brightness+rand(-10,10))
	return blend_colors(final_color,tint_mod,0.1)

/dna/proc/generate_skin_color(var/fallback="#FFFFFF")

	if(!length(skin_color_rarity))
		return fallback

	var/chosen_color_01 = pickweight(skin_color_rarity)
	var/chosen_color_02 = pickweight(skin_color_rarity)
	var/final_color = blend_colors(chosen_color_01,chosen_color_02,rand())
	var/brightness = rand(10,245)
	var/tint_mod = rgb(brightness+rand(-10,10),brightness+rand(-10,10),brightness+rand(-10,10))
	return blend_colors(final_color,tint_mod,0.1)

/dna/proc/generate_hair_color(var/fallback="#FFFFFF")

	if(!length(hair_color_rarity))
		return fallback

	var/chosen_color_01 = pickweight(hair_color_rarity)
	var/chosen_color_02 = pickweight(hair_color_rarity)
	var/final_color = blend_colors(chosen_color_01,chosen_color_02,rand())
	var/brightness = rand(10,245)
	var/tint_mod = rgb(brightness+rand(-10,10),brightness+rand(-10,10),brightness+rand(-10,10))
	return blend_colors(final_color,tint_mod,0.1)

/dna/proc/generate_beard_color(var/fallback="#FFFFFF")

	if(!length(beard_color_rarity))
		return generate_hair_color(fallback)

	var/chosen_color_01 = pickweight(beard_color_rarity)
	var/chosen_color_02 = pickweight(beard_color_rarity)
	var/final_color = blend_colors(chosen_color_01,chosen_color_02,rand())
	var/brightness = rand(10,245)
	var/tint_mod = rgb(brightness+rand(-10,10),brightness+rand(-10,10),brightness+rand(-10,10))
	return blend_colors(final_color,tint_mod,0.1)


/dna/proc/generate_hair_style(var/gender=NEUTER,var/fallback="#FFFFFF")

	switch(gender)
		if(MALE)
			return length(hair_style_rarity_male) ? pickweight(hair_style_rarity_male) : fallback
		if(FEMALE)
			return length(hair_style_rarity_female) ? pickweight(hair_style_rarity_female) : fallback
		if(NEUTER)
			if(prob(50))
				return length(hair_style_rarity_male) ? pickweight(hair_style_rarity_male) : fallback
			else
				return length(hair_style_rarity_female) ? pickweight(hair_style_rarity_female) : fallback

	return "error"


/dna/proc/generate_beard_style(var/gender=NEUTER,var/fallback="#FFFFFF")

	switch(gender)
		if(MALE)
			return length(beard_style_rarity_male) ? pickweight(beard_style_rarity_male) : fallback
		if(FEMALE)
			return length(beard_style_rarity_female) ? pickweight(beard_style_rarity_female) : fallback
		if(NEUTER)
			if(prob(50))
				return length(beard_style_rarity_male) ? pickweight(beard_style_rarity_male) : fallback
			else
				return length(beard_style_rarity_female) ? pickweight(beard_style_rarity_female) : fallback

	return "none"




//Eye color weights: https://www.behance.net/gallery/47218527/Eye-Color-Around-the-World
//Skin color weights: https://www.quora.com/What-is-the-most-common-skin-color-on-earth-today
//Hair color weights: https://youprobablyneedahaircut.com/what-is-the-most-common-hair-color/
//Hair style weights: based on what I've seen in my time in ss13 servers as well as irl.

//Look, I get that certain skin tones have a higher chance to have certain eye colors, but this is the future.
//As long as stuff looks natural and is naturally possible, I cannot be bothered to be super race focused with this.

/dna/human

	eye_color_rarity = list(
		"#2DA3DA" = 8,
		"#36AB6E" = 2,
		"#134C2C" = 8,
		"#1D1300" = 55
	)

	skin_color_rarity = list(
		"#FADCBC" = 196,
		"#E0BB95" = 293,
		"#BF8F68" = 274,
		"#9B643D" = 213,
		"#594539" = 24
	)

	hair_color_rarity = list(
		"#1E1E1E" = 85,
		"#603C1E" = 11,
		"#F8E4AA" = 2,
		"#AD3720" = 1,
		"#727272" = 1,
		"#C6C6C6" = 1
	)

	hair_style_rarity_male = list(
		"hair_a" = 100,
		"hair_c" = 50,
		"hair_d" = 25,
		"hair_e" = 10,
		"hair_f" = 10,
		"hair_boss" = 50,
		"hair_bedhead" = 100,
		"hair_bedheadv2" = 100,
		"hair_dreads" = 20,
		"hair_jensen" = 50,
		"hair_skinhead" = 10,
		"hair_ponytail" = 25,
		"hair_spikey" = 25,
		"hair_bigafro" = 25,
		"hair_afro" = 50,
		"hair_gelled" = 50,
		"hair_bowlcut" = 50,
		"hair_buzzcut" = 50,
	)

	hair_style_rarity_female = list(
		"hair_b" = 100,
		"hair_vlong" = 75,
		"hair_halfbang" = 50,
		"hair_kusanagi" = 50,
		"hair_ponytail" = 100,
		"hair_ponytail2" = 100,
		"hair_halfbang5" = 50,
		"hair_longfringe" = 25,
		"hair_bedheadv3" = 50,
		"hair_longest" = 50,
		"hair_longest2" = 50,
		"hair_bigafro" = 50,
		"hair_afro" = 25,
		"hair_afro2" = 50,
		"hair_beehive" = 25,
		"hair_bobcurl" = 200,
		"hair_bobcut" = 200
	)

	beard_style_rarity_male = list(
		"none" = 400,
		"facial_fullbeard" = 25,
		"facial_chin" = 25,
		"facial_gt" = 25,
		"facial_3oclock" = 100,
		"facial_fiveoclock" = 100,
		"facial_7oclock" = 100,
		"facial_fullbeard_s" = 50,
	)

/dna/human/wizard

	hair_color_rarity = list(
		"#FFFFFF" = 100
	)

	beard_style_rarity_male = list(
		"facial_wise" = 100
	)
	hair_style_rarity_female = list(
		"hair_drillhairextended" = 100,
		"hair_long_bedhead" = 100,
		"hair_floorlength_bedhead" = 100,
		"hair_wisp" = 100
	)

/dna/beef
	skin_color_rarity = list(
		"#C42F36" = 1,
		"#A02518" = 1,
		"#742210" = 1,
		"#541900" = 1,
		"#261007" = 1
	)


/dna/goblin
	skin_color_rarity = list(
		"#3D6300" = 1,
		"#425125" = 1,
		"#4E5B0E" = 1,
		"#686342" = 1
	)


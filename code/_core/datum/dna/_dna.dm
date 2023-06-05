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

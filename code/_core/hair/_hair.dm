/hair/
	var/name = "Hair Data"
	var/desc = "Basically contains all the hairstyles"
	var/id

	var/gender = NEUTER //Hair of the person
	var/degenercy = 0 //Degenercy rating of the hairtype

	var/icon_state = "bald" //Icon state of the hair.

	var/masculinity = 0 //Masculinity of the hair. Negative means more femninineineine

/hair/bald
	name = "bald"
	id = "bald"
	desc = "BALD!"
	icon_state = "bald"
	masculinity = 10

/hair/greytide
	name = "the greytide"
	id = "greytide"
	desc = "The ultimate hairstyle for men. You will be drowning in a river of pussy if you choose this hairstyle."
	icon_state = "hair_a"
	masculinity = 20

/hair/afro
	name = "the afro"
	id = "afro"
	desc = "An afro."
	icon_state = "hair_afro"
	masculinity = 10

/hair/floor_length_braid
	name = "the floor length braid"
	id = "flb"
	desc = "If you listen closely, you can hear pacmandevil wheeping in the distance."
	icon_state = "hair_braid"
	masculinity = -100
	degenercy = 100



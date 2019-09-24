/experience/attribute/
	experience_power = 1
	experience_multiplier = 1
	default_level = ATTRIBUTE_STARTING_NONE
	chargen_min_level = 5
	chargen_max_level = 20
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 0,
			"Curator"= 0,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

//Warrior
/experience/attribute/strength/
	name = "Strength"
	id = ATTRIBUTE_STRENGTH
	desc = "A measure of how strong you are in this world. Affects damage with some weapons as well as the ability to perform certain actions."
	flags = ATTRIBUTE_DAMAGE
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 4,
			"Cargo Technician"= 4,

			//INT
			"Engineer"= 2,
			"Botanist"= 2,
			"Quartermaster"=2,
			//AGI
			"Cook"= 2,
			"Janitor"=2,
			"Shaft Miner"= 2,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 1,
			"Bartender"=1,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/attribute/vitality/
	name = "Vitality"
	id = ATTRIBUTE_VITALITY
	desc = "A measure of how long your life can last in this world. Affects maximum health and health regeneration."
	flags = ATTRIBUTE_STAT
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 4,
			"Cargo Technician"= 4,

			//INT
			"Engineer"= 2,
			"Botanist"= 2,
			"Quartermaster"=2,
			//AGI
			"Cook"= 2,
			"Janitor"= 2,
			"Shaft Miner"= 2,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 1,
			"Bartender"= 1,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

/experience/attribute/fortitude/
	name = "Fortitude"
	id = ATTRIBUTE_FORTITUDE
	desc = "A measure of how resistant you are to the troubles of this world. Affects pain tolerance and physical damage resistance."
	flags = ATTRIBUTE_RESISTANCE
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 4,
			"Cargo Technician"= 4,

			//INT
			"Engineer"= 2,
			"Botanist"= 2,
			"Quartermaster"=2,
			//AGI
			"Cook"= 2,
			"Janitor"= 2,
			"Shaft Miner"= 2,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 1,
			"Roboticist"= 1,
			"Geneticist"= 1,

			//AGI
			"Atmospheric Technician"= 0,
			"Chemist"= 0,
			"Virologist"= 0,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 1,
			"Bartender"= 1,
			"Ninja"= 1,

			//INT
			"Detective"= 0,
			"Curator"= 0,
			"Medical Doctor"= 0,

		"Assistant"= 0
	)

//Wizard
/experience/attribute/intelligence/
	name = "Intelligence"
	id = ATTRIBUTE_INTELLIGENCE
	desc = "A measure of how effective you are at using magic. Affects damage with some weapons and magic as well as the ability to perform certain actions."
	flags = ATTRIBUTE_DAMAGE
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 1,
			"Quartermaster"=1,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 4,
			"Lawyer"= 4,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 2,
			"Geneticist"= 2,

			//AGI
			"Atmospheric Technician"= 2,
			"Chemist"= 2,
			"Virologist"= 2,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 1,
			"Curator"= 1,
			"Medical Doctor"= 1,

		"Assistant"= 0
	)

/experience/attribute/willpower/
	name = "Willpower"
	id = ATTRIBUTE_WILLPOWER
	desc = "A measure of how long your mind can last in this world. Affects maximum mana and mana regeneration."
	flags = ATTRIBUTE_RESISTANCE
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 1,
			"Quartermaster"=1,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 4,
			"Lawyer"= 4,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 2,
			"Geneticist"= 2,

			//AGI
			"Atmospheric Technician"= 2,
			"Chemist"= 2,
			"Virologist"= 2,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 1,
			"Curator"= 1,
			"Medical Doctor"=1,

		"Assistant"= 0
	)



/experience/attribute/resolve/
	name = "Resolve"
	id = ATTRIBUTE_RESOLVE
	desc = "A measure of how conductive you are to the magic of this world. Affects magic resistance."
	flags = ATTRIBUTE_STAT
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 1,
			"Botanist"= 1,
			"Quartermaster"=1,
			//AGI
			"Cook"= 0,
			"Janitor"= 0,
			"Shaft Miner"= 0,

		//INT
			//PURE
			"Scientist"= 4,
			"Lawyer"= 4,

			//STR
			"Chaplain"= 2,
			"Roboticist"= 2,
			"Geneticist"= 2,

			//AGI
			"Atmospheric Technician"= 2,
			"Chemist"= 2,
			"Virologist"= 2,

		//AGI
			//PURE
			"Mime"= 0,
			"Clown"= 0,

			//STR
			"Warden"= 0,
			"Bartender"= 0,
			"Ninja"= 0,

			//INT
			"Detective"= 1,
			"Curator"= 1,
			"Medical Doctor"= 1,

		"Assistant"= 0
	)


//Rogue
/experience/attribute/dexterity/
	name = "Dexterity"
	id = ATTRIBUTE_DEXTERITY
	desc = "A measure of how well you can control your body. Affects damage with some weapons as well as the speed of performing actions."
	flags = ATTRIBUTE_DAMAGE
	combat_level_mul = 1
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 1,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 4,
			"Clown"= 4,

			//STR
			"Warden"= 2,
			"Bartender"= 2,
			"Ninja"= 2,

			//INT
			"Detective"= 2,
			"Curator"= 2,
			"Medical Doctor"= 2,

		"Assistant"= 0
	)

/experience/attribute/agility/
	name = "Agility"
	id = ATTRIBUTE_AGILITY
	desc = "A measure of how agile you are in the world. Affects maximum stamina and stamina regeneration."
	flags = ATTRIBUTE_STAT
	combat_level_mul = 0.75
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 1,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 4,
			"Clown"= 4,

			//STR
			"Warden"= 2,
			"Bartender"= 2,
			"Ninja"= 2,

			//INT
			"Detective"= 2,
			"Curator"= 2,
			"Medical Doctor"= 2,

		"Assistant"= 0
	)

/experience/attribute/endurance/
	name = "Endurance"
	id = ATTRIBUTE_ENDURANCE
	desc = "A measure of how long your body can last in this world. Affects resistance to poison, disease, fatigue, and stamina damage."
	flags = ATTRIBUTE_RESISTANCE
	combat_level_mul = 0.5
	associated_classes = list(
		//STR
			//PURE
			"Security Officer" = 0,
			"Cargo Technician"= 0,

			//INT
			"Engineer"= 0,
			"Botanist"= 0,
			"Quartermaster"=0,
			//AGI
			"Cook"= 1,
			"Janitor"= 1,
			"Shaft Miner"= 1,

		//INT
			//PURE
			"Scientist"= 0,
			"Lawyer"= 0,

			//STR
			"Chaplain"= 0,
			"Roboticist"= 0,
			"Geneticist"= 0,

			//AGI
			"Atmospheric Technician"= 1,
			"Chemist"= 1,
			"Virologist"= 1,

		//AGI
			//PURE
			"Mime"= 4,
			"Clown"= 4,

			//STR
			"Warden"= 2,
			"Bartender"= 2,
			"Ninja"= 2,

			//INT
			"Detective"= 2,
			"Curator"= 2,
			"Medical Doctor"= 2,

		"Assistant"= 0
	)

//None. Everyone starts with 50.
/experience/attribute/luck/
	name = "Luck"
	id = ATTRIBUTE_LUCK
	combat_level_mul = 1
	desc = "A measure of how gosh darn lucky you are to be alive. Luck affects everything you do in small or, sometimes big, ways."
	flags = ATTRIBUTE_STAT
	chargen_min_level = 40
	chargen_max_level = 50
	default_level = 50
	counts_towards_level = FALSE


/experience/attribute/karma/
	name = "Karma"
	id = ATTRIBUTE_KARMA
	combat_level_mul = -0.1
	desc = "A measure of how rightous you are. Karma affects the strength of some weapons and your moral standing in this world. Remember, it's easier to lose karma than it is to gain it."
	chargen_min_level = 50
	chargen_max_level = 50
	default_level = 50
	counts_towards_level = FALSE

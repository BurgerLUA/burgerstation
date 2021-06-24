/job/
	var/name = "Job Name."
	var/desc = "Job Description."

	var/list/current_players = list()
	var/maximimum_players = 0

	var/passive_income = 0

	var/station_only = FALSE


/job/mercenary
	name = "Mercenary"
	desc = "Mercenaries are tasked with exploring outside the station and eliminating any threats that are present. Mercenaries gain income by selling any items they find on their journey to station merchants."
	station_only = FALSE

/job/engineer
	name = "Engineer"
	desc = "Engineers are tasked with of keeping the station in order by maintaining the main source of station power as well as repairing any broken structures or objects on the station."
	station_only = TRUE

/job/janitor
	name = "Janitor"
	desc = "Janitors are tasked with keeping the station clean and orderly by mopping up any spills and disposing of any stray items."
	station_only = TRUE

/job/emt
	name = "Emergency Medical Technician"
	desc = "EMTs are tasked with keeping the station's crewmembers alive and well by treating any wounds and reviving any dead crewmembers."
	station_only = FALSE

/job/investor
	name = "Investor"
	desc = "Investors are tasked with investing their own funds into purchasing high value and rare items for Mercenaries."
	station_only = TRUE

/job/security_officer
	name = "Security Officer"
	desc = "Security Officers are tasked with protecting the station from any external threats as well as tracking down and retriving any crewmembers that are supposed to be on station."
	station_only = FALSE

/job/cook
	name = "Cook"
	desc = "Cooks are tasked with creating consumable nutrients and selling it to the crew."
	station_only = TRUE


/job/bartender
	name = "Bartender"
	desc = "Bartenders are tasked with creating consumable drinks and selling it to the crew."
	station_only = TRUE

/job/botanist
	name = "Botanist"
	desc = "Botanists are tasked with growing plants and selling it to the crew."
	station_only = TRUE

/job/chemist
	name = "Chemist"
	desc = "Chemists are tasked with mixing chemicals and selling it to the crew."
	station_only = TRUE
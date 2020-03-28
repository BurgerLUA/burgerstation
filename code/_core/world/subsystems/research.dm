#define RESEARCH_SCORES_QUADRANTS "data/server/highscores/quadrants.json"

SUBSYSTEM_DEF(research)
	name = "Research Subsystem"
	desc = "Constrols research."
	priority = SS_ORDER_LAST

	var/list/quadrant_high_scores = list(
		list("Diamond with Flaw (BurgerBB)",100),
		list("Bar Shaleez (BurgerBB)",90),
		list("Marcus Burgs (BurgerBB)",80),
		list("Chad Thundercock (BurgerBB)",70),
		list("Ileaza Marwani (BurgerBB)",60),
		list("Pedro Johnson (BurgerBB)",50)
	)

/subsystem/research/Initialize()
	var/quadrants_file = file2text(RESEARCH_SCORES_QUADRANTS)
	if(!quadrants_file)
		log_subsystem(name,"Found no quadrants high score file... creating new one.")
		text2file(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)
	else
		quadrant_high_scores = json_decode(quadrants_file)
	return TRUE

/subsystem/research/proc/add_quadrants_score(var/mob/living/advanced/player/P ,var/score)
	quadrant_high_scores.Add(list(list(P.real_name,score)))
	fdel(RESEARCH_SCORES_QUADRANTS)
	text2file(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)
	return FALSE
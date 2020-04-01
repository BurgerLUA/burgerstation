#define RESEARCH_SCORES_QUADRANTS "data/server/highscores/quadrants.json"

SUBSYSTEM_DEF(research)
	name = "Research Subsystem"
	desc = "Constrols research."
	priority = SS_ORDER_LAST
	var/list/quadrant_high_scores = list(
		list("Marcus Burgs",80),
		list("Pedro Johnson",50),
		list("Diamond with Flaw",100),
		list("Bar Shaleez",90),
		list("Chad Thundercock",70),
		list("Ileaza Marwani",60),
		list("Trash McTrash",10)
	)
	var/research_points = 0

/subsystem/research/Initialize()
	var/quadrants_file = file2text(RESEARCH_SCORES_QUADRANTS)
	if(!quadrants_file)
		log_subsystem(name,"Found no quadrants high score file... creating new one.")
		sortTim(quadrant_high_scores,/proc/cmp_highscore)
		quadrant_high_scores = quadrant_high_scores.Copy(1,min(length(quadrant_high_scores),5)+1)
		text2file(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)
	else
		quadrant_high_scores = json_decode(quadrants_file)

	return TRUE

/subsystem/research/proc/add_quadrants_score(var/mob/living/advanced/player/P ,var/score)
	quadrant_high_scores.Add(list(list(P.real_name,score)))
	fdel(RESEARCH_SCORES_QUADRANTS)
	sortList(quadrant_high_scores,/proc/cmp_highscore)
	quadrant_high_scores = quadrant_high_scores.Copy(1,min(length(quadrant_high_scores),5))
	text2file(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)
	var/added_currency = P.adjust_currency(score*5)
	P.to_chat("You were given [added_currency] credits for your research efforts.")
	return FALSE

/proc/cmp_highscore(var/list/a,var/list/b)
	return b[2] - a[2]
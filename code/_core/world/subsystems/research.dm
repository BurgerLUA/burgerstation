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
	var/quadrants_file = rustg_file_read(RESEARCH_SCORES_QUADRANTS)
	if(!quadrants_file)
		log_subsystem(name,"Found no quadrants high score file... creating new one.")
		sortTim(quadrant_high_scores,/proc/cmp_highscore)
		quadrant_high_scores = quadrant_high_scores.Copy(1,min(length(quadrant_high_scores),5)+1)
		rustg_file_append(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)
	else
		quadrant_high_scores = json_decode(quadrants_file)

	return ..()

/subsystem/research/proc/add_quadrants_score(var/mob/living/advanced/player/P ,var/score)
	quadrant_high_scores.Add(list(list(P.real_name,score)))
	sortList(quadrant_high_scores,/proc/cmp_highscore)
	quadrant_high_scores = quadrant_high_scores.Copy(1,min(length(quadrant_high_scores),5))
	rustg_file_write(json_encode(quadrant_high_scores),RESEARCH_SCORES_QUADRANTS)

	var/obj/item/currency/prize_ticket/PT = new(P.loc)
	PT.item_count_current = CEILING(score,1)
	INITIALIZE(PT)
	GENERATE(PT)
	FINALIZE(PT)
	P.put_in_hands(PT)
	P.to_chat(span("notice","The arcade machine vends [PT.item_count_current] prize tickets!"))

	return FALSE

/proc/cmp_highscore(var/list/a,var/list/b)
	return b[2] - a[2]
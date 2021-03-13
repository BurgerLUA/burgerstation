/obj/burger_star_test_start
	name = "start point"
	var/mob/living/simple/spider/linked_spider
	var/obj/burger_star_test_end/linked_end
	invisibility = 101

/obj/burger_star_test_start/proc/activate(var/mob/caller,var/atom/object,location,control,params)

	if(!linked_spider)
		linked_spider = new(get_turf(src))
		linked_spider.ai = null
		INITIALIZE(linked_spider)
		GENERATE(linked_spider)
		FINALIZE(linked_spider)

	if(!linked_end)
		linked_end = locate(/obj/burger_star_test_end) in world
		if(linked_end) linked_end = get_turf(linked_end)

	if(!linked_end)
		return TRUE

	burger_star(linked_spider,linked_end, debug = TRUE)

	return TRUE

/obj/burger_star_test_end
	name = "end point"
	invisibility = 101



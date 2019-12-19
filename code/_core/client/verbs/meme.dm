#define FILE_DEBUG "data/debug/wew.json"

/client/verb/run_file_test()

	while(TRUE)
		for(var/i=1,i<=25,i++)
			run_file_test_segment()
		sleep(10)

proc/run_file_test_segment()
	var/list/loaded_data = list("penis"=1,"butts"=-1)

	if(!fexists(FILE_DEBUG))
		text2file(json_encode(loaded_data),FILE_DEBUG)
	else
		var/file_data = file2text(FILE_DEBUG)
		loaded_data = json_decode(file_data)

	var/new_data = json_encode(loaded_data)

	world.log << new_data

	fdel(FILE_DEBUG)
	text2file(new_data,FILE_DEBUG)


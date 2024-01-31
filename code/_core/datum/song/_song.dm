//#define MUSICIAN_HEARCHECK_MINDELAY 4
#define MUSIC_MAXLINES 300
#define MUSIC_MAXLINECHARS 50

/song/
	var/list/lines = list()
	var/tempo = 5

	var/is_playing = FALSE

	var/instrument_directory = "piano"

	var/atom/movable/instrument_atom

	var/list/temp_hearers = list()
	var/next_hear_check = 0


	var/list/processed_lines = list()


	var/repeat = 0


//Base code stolen from Fulpstation
//A lot of it has been reworked. About 50% of this code is new.

/song/New(var/desired_loc)
	instrument_atom = desired_loc
	return ..()

/song/proc/interact(var/mob/caller)

	if(!is_playing)
		var/desired_song = input(caller,"What song would you like to play?","Song Selection") as message|null
		if(!desired_song)
			caller.to_chat("No song selected!")
			return FALSE
		parse_song(caller,desired_song)
		repeat = 1
		spawn play_song(caller)
		is_playing = TRUE
	else
		caller.to_chat("You stop playing \the [instrument_atom].")
		is_playing = FALSE

	return TRUE


/song/proc/check_hearers()

	if(next_hear_check > world.time)
		return

	temp_hearers.Cut()
	for(var/mob/M in range(SOUND_RANGE,get_turf(instrument_atom)))
		temp_hearers += M

	next_hear_check = world.time + SECONDS_TO_DECISECONDS(3)

	return

/song/proc/play_note(var/mob/caller,var/note,var/acc,var/oct)

	// handle accidental -> B<>C of E<>F
	if(acc == "b" && (note == 3 || note == 6)) // C or F
		if(note == 3)
			oct--
		note--
		acc = "n"
	else if(acc == "#" && (note == 2 || note == 5)) // B or E
		if(note == 2)
			oct++
		note++
		acc = "n"
	else if(acc == "#" && (note == 7)) //G#
		note = 1
		acc = "b"
	else if(acc == "#") // mass convert all sharps to flats, octave jump already handled
		acc = "b"
		note++

	// check octave, C is allowed to go to 9
	if(oct < 1 || (note == 3 ? oct > 9 : oct > 8))
		return

	var/sound_path = "sounds/instruments/[instrument_directory]/[ascii2text(note+64)][acc][oct].ogg"
	if(!fexists(sound_path))
		//log_error("Error: Sound file [sound_path] does not exist.")
		return FALSE

	var/sound_file = file(sound_path)

	check_hearers()

	play(sound_file,temp_hearers,get_turf(instrument_atom),range_min=SOUND_RANGE*0.5,range_max=SOUND_RANGE)

	return TRUE

/song/proc/sanitize_tempo(var/desired_tempo)
	desired_tempo = abs(desired_tempo)
	return max(round(desired_tempo, TICK_LAG), TICK_LAG)

/song/proc/play_song(var/mob/caller)

	var/cur_oct[7]
	var/cur_acc[7]
	for(var/i = 1 to 7)
		cur_oct[i] = 3
		cur_acc[i] = "n"

	for(var/line_num in processed_lines)
		var/list/beats = processed_lines[line_num]
		for(var/beat_num in beats)
			var/list/notes = beats[beat_num]
			for(var/note_num in notes)
				var/note = notes[note_num]
				var/cur_note = text2ascii(note) - 96
				if(cur_note < 1 || cur_note > 7)
					continue
				if(!is_playing)
					temp_hearers = list()
					repeat = 0
					return FALSE
				for(var/i=2 to length(note))
					var/ni = copytext(note,i,i+1)
					if(!text2num(ni))
						if(ni == "#" || ni == "b" || ni == "n")
							cur_acc[cur_note] = ni
						else if(ni == "s")
							cur_acc[cur_note] = "#" // so shift is never required
					else
						cur_oct[cur_note] = text2num(ni)
				play_note(caller, cur_note, cur_acc[cur_note], cur_oct[cur_note])

			if(length(notes) >= 2 && text2num(notes["2"]))
				sleep(sanitize_tempo(tempo / text2num(notes["2"])))
			else
				sleep(tempo)

	temp_hearers = list()
	is_playing = FALSE
	repeat = 0

/song/proc/parse_song(var/mob/caller,var/text)

	text = lowertext(text)
	var/list/lines = splittext(text,"\n")
	if(!lines.len)
		caller.to_chat("No sound found!")
		return FALSE

	if(copytext(lines[1],1,6) == "bpm: ")
		var/BPM = text2num(copytext(lines[1],6))
		tempo = sanitize_tempo(600 / BPM)
	else
		tempo = sanitize_tempo(5) // default 120 BPM
	lines.Cut(1,2)

	if(length(lines) > MUSIC_MAXLINES)
		caller.to_chat("Too many lines!")
		lines.Cut(MUSIC_MAXLINES + 1)

	processed_lines = list()
	var/linenum = 1
	for(var/line in lines)
		if(length(line) > MUSIC_MAXLINECHARS)
			caller.to_chat("Line [linenum] is too long!")
			continue
		processed_lines["[linenum]"] = list()
		var/list/beats = splittext(line, ",")
		var/beatnum = 1
		for(var/beat in beats)
			processed_lines["[linenum]"]["[beatnum]"] = list()
			var/notes = splittext(beat, "/")
			var/notenum = 1
			for(var/note in splittext(notes[1], "-"))
				CHECK_TICK
				processed_lines["[linenum]"]["[beatnum]"]["[notenum]"] = note
				notenum++
			beatnum++
		linenum++

	return TRUE
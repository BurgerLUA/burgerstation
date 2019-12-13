/obj/structure/interactive/piano
	name = "piano"
	var/song/song


	var/playing = FALSE


/obj/structure/interactive/piano/proc/playnote(var/note as text)
	return TRUE

/obj/structure/interactive/piano/proc/play_song() //Stolen from Aurora's Piano Code

	spawn()
		var/cur_oct[7]
		var/cur_acc[7]

		for(var/i = 1 to 7)
			cur_oct[i] = "3"
			cur_acc[i] = "n"

		for(var/line in song.lines)
			for(var/beat in text2list(lowertext(line), ","))
				var/list/notes = text2list(beat, "/")
				for(var/note in text2list(notes[1], "-"))
					if(!playing || !anchored)//If the piano is playing, or is loose
						playing = 0
						return
					if(length(note) == 0)
						continue
					var/cur_note = text2ascii(note) - 96
					if(cur_note < 1 || cur_note > 7)
						continue
					for(var/i=2 to length(note))
						var/ni = copytext(note,i,i+1)
						if(!text2num(ni))
							if(ni == "#" || ni == "b" || ni == "n")
								cur_acc[cur_note] = ni
							else if(ni == "s")
								cur_acc[cur_note] = "#" // so shift is never required
						else
							cur_oct[cur_note] = ni
					playnote(uppertext(copytext(note,1,2)) + cur_acc[cur_note] + cur_oct[cur_note])
				if(notes.len >= 2 && text2num(notes[2]))
					sleep(song.tempo / text2num(notes[2]))
				else
					sleep(song.tempo)
		playing = FALSE

	return TRUE

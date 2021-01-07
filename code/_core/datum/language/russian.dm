/language/russian
	name = "Russian"
	id = LANGUAGE_RUSSIAN

	var/list/possible_replacements = list(
		"zhena", "reb", "kot", "tvoy", "vodka", "blyad", "verbovka", "ponimat", "zhit", "kley", "sto", "yat", "si", "det",
		"re", "be", "nok", "chto", "techno", "kak", "govor", "navernoe", "da", "net", "horosho", "pochemu", "privet","lubov",
		"ebat", "krovat", "stol", "za", "ryad", "ka", "voyna", "dumat", "patroni", "tarakanu", "zdorovie", "day", "dengi",
		"pizdec", "mat", "tvoyu", "suka", "ayblya", "uebok", "sosi", "ebi", "huyar", "trahat", "pizda", "uebu", "zaebal", "zgorela",
		"pizduy", "srat", "naydu", "ubyi", "uebishe", "blyadina", "priebali", "prosrali", "suche", "voituyay", "tupoy", "daun", "churka",
		"nelez", "sovershenstvo", "viju", "stradaniye", "smusl", "spaseniye", "pomosh", "zvezdu", "kosmos", "pokorim", "lublu", "bereza",
		"zashishu", "luna", "planeta", "voshod", "mercaet", "smeshno", "razum", "trud", "mucheniya", "chudo", "borba", "sudba", "svoboda",
		"provodimost", "inicializaciya", "compilaciya", "izolaciya", "teplootdacha", "izlucheniye", "osnasheniye",
		"vidimost", "indukciya", "ionizaciya", "laser", "svyaz", "provodka", "atmosfera", "davleniye", "temperatura",
		"obyem", "massa", "scorost", "uskoreniye", "radiaciya", "ves", "neobhodimost", "dokozatelstvo", "teorema", "kipeniye",
		"inovaciya", "proruv", "turbulentnost", "zashita", "pitaniye", "zamukaniye", "korotkoye", "dlennoye", "verticalno",
		"portal", "systema", "electronika", "nigilizm", "anarhizm", "communistu", "tupuye", "sopla", "obshivka", "obtekaemost",
		"dinamica", "statica", "organizacuya", "yeyenet", "radio", "peredacha", "priem", "slushno", "chastota", "gerts", "stantiya",
		"suda", "huyar", "odin", "dva", "tri", "holod", "granata", "ne", "re", "ru", "korabl"
	)

/language/russian/process_text(var/speaker,var/text)

	. = ""

	for(var/word in splittext(text," "))
		. = "[.][pick(possible_replacements)] "

	. = trim(.)

	if(prob(50)) . = "[.], tovarish-drug"

	return "[capitalize(.)]!"

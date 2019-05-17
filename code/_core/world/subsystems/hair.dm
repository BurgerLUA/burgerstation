var/global/list/hair_head_types = list()
var/global/list/hair_head_ids = list()
var/global/list/hair_head_names = list()
var/global/list/hair_head_icons = list()

var/global/list/hair_face_types = list()
var/global/list/hair_face_ids = list()
var/global/list/hair_face_names = list()
var/global/list/hair_face_icons = list()

/subsystem/hair/
	name = "Hair Subsystem"
	desc = "Yes, there is a fucking subsystem dedicated to hair."
	priority = SS_ORDER_NORMAL

/subsystem/hair/Initialize()

	for(var/k in icon_states('icons/mob/living/advanced/hair/head.dmi'))
		if(!k || k=="")
			continue

		var/hair/head/H = new
		H.id = k
		H.icon_state = k
		H.icon = 'icons/mob/living/advanced/hair/head.dmi'

		var/icon/I = new /icon(H.icon,H.icon_state)
		I.Shift(SOUTH,9)
		I.Scale(128, 128)
		I.Crop(64-32,64-32,64+32,64+32)
		I.Blend("#888888",ICON_MULTIPLY)

		hair_head_icons[H.id] = I
		hair_head_ids += H.id
		hair_head_names += H.name

	LOG_SERVER("Initialized [length(hair_head_ids)] hairstyles.")

	for(var/k in icon_states('icons/mob/living/advanced/hair/face.dmi'))
		if(!k || k == "")
			continue

		var/hair/face/H = new
		H.id = k
		H.icon_state = k
		H.icon = 'icons/mob/living/advanced/hair/face.dmi'

		var/icon/I = new /icon(H.icon,H.icon_state)
		I.Shift(SOUTH,9)
		I.Scale(128, 128)
		I.Crop(64-32,64-32,64+32,64+32)
		I.Blend("#888888",ICON_MULTIPLY)

		hair_face_icons[H.id] = I
		hair_face_ids += H.id
		hair_face_names += H.name

	LOG_SERVER("Initialized [length(hair_face_ids)] beardstyles.")
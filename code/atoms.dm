#include "setup.dm"
//#include "data\stylesheet.dm"

/atom
	layer = 2
	var/level = 2
	var/flags = FPRINT
	var/fingerprints = null
	var/blood = null
	var/zombieblood = null
	var/hitpoints = 100

/atom/movable
	layer = 3
	var/last_move = null
	var/anchored = 0
	var/weight = 25000
	var/elevation = 2
	var/move_speed = 10
	var/l_move_time = 1
	var/m_flag = 1
	var/throwing = 0
	var/throw_speed = 2
	var/throw_range = 7
	var/moved_recently = 0

/atom/movable/overlay
	var/atom/master = null
	anchored = 1

//////////// Yeah this doesnt belong here but its better than a seperate file.
/atom/proc/burn(fi_amount)
	return

/atom/movable/Move()
	var/atom/A = src.loc
	. = ..()
	src.move_speed = world.time - src.l_move_time
	src.l_move_time = world.time
	src.m_flag = 1
	if ((A != src.loc && A && A.z == src.z))
		src.last_move = get_dir(A, src.loc)
		src.moved_recently = 1
	return
////////////

/mob
	density = 1
	layer = 4.0
	var/achievements = list()
	var/oldachievements = list()
	var/already_placed = 0.0
	var/obj/machinery/machine = null
	var/obj/item/weapon/weapon = null
	var/other_mobs = null
	var/memory = ""
	var/poll_answer = 0.0
	var/sdisabilities = 0.0
	var/disabilities = 0.0
	var/atom/movable/pulling = null
	var/stat = 0.0
	var/next_move = null
	var/prev_move = null
	var/monkeyizing = null
	var/other = 0.0
	var/hand = null
	var/eye_blind = null
	var/eye_blurry = null
	var/ear_deaf = null
	var/ear_damage = null
	var/stuttering = null
	var/rname = null
	var/blinded = null
	var/rejuv = null
	var/r_epil = null
	var/r_fever = null
	var/r_ch_cou = null
	var/b_mercury = null
	var/b_acid = null
	var/druggy = null
	var/r_Tourette = null
	var/antitoxs = null
	var/plasma = null
	var/virus = 0.0
	var/sleeping = 0.0
	var/resting = 0.0
	var/lying = 0.0
	var/canmove = 1.0
	var/eye_stat = null
	var/oxyloss = 0.0
	var/toxloss = 0.0
	var/fireloss = 0.0
	var/timeofdeath = 0.0
	var/bruteloss = 0.0
	var/cpr_time = 1.0
	var/health = 100.0
	var/bodytemperature = 310.055	//98.7 F
	var/drowsyness = 0.0
	var/paralysis = 0.0
	var/stunned = 0.0
	var/weakened = 0.0
	var/losebreath = 0.0
	var/muted = null
	var/intent = null
	var/shakecamera = 0
	var/a_intent = "disarm"
	var/m_int = null
	var/m_intent = "run"
	var/lastDblClick = 0
	var/lastKnownIP = null
	var/lastKnownID = null
	var/obj/stool/chair/buckled = null
	var/obj/dna/primary = null
	var/obj/item/weapon/handcuffs/handcuffed = null
	var/obj/item/weapon/l_hand = null
	var/obj/item/weapon/r_hand = null
	var/obj/item/weapon/back = null
	var/obj/item/weapon/tank/internal = null
	var/obj/item/weapon/storage/s_active = null
	var/obj/item/weapon/clothing/mask/wear_mask = null
	var/obj/screen/throw_icon = null
	var/obj/screen/flash = null
	var/obj/screen/blind = null
	var/obj/screen/hands = null
	var/obj/screen/mach = null
	var/obj/screen/sleep = null
	var/obj/screen/rest = null
	var/obj/screen/pullin = null
	var/obj/screen/internals = null
	var/obj/screen/oxygen = null
	var/obj/screen/i_select = null
	var/obj/screen/m_select = null
	var/obj/screen/toxin = null
	var/obj/screen/fire = null
	var/obj/screen/bodytemp = null
	var/obj/screen/healths = null
	var/obj/screen/zone_sel/zone_sel = null
	var/obj/hud/hud_used = null
	var/start = null

	var/list/organs = list(  )
	var/list/grabbed_by = list(  )
	var/list/requests = list(  )

	var/list/mapobjs = list()

	var/in_throw_mode = 0

	var/coughedtime = null

	var/inertia_dir = 0

	var/be_music = 0
	var/music_lastplayed = "null"

	var/be_nudist = 0
	var/be_syndicate = 1
	var/const/blindness = 1
	var/const/deafness = 2
	var/const/muteness = 4
	var/is_rev = -1
	var/obj/dna/primarynew = null
	var/radiation = 0.0
	var/isslime = 0
	var/telekinesis = 0
	var/firemut = 0
	var/xray = 0
	var/ishulk = 0
	var/clumsy = 0
	var/nodamage = 0
	var/airmut = 0
	var/total = 0
	var/besound = 1
	var/zombie = 0
	var/becoming_zombie = 0
	var/oldckey = null
	//[glasses][hulk][epi][slime][cough][invis][tour][xray][stutter][fire][blind][tele][deaf][monkey]
	//1=hulk,2=slime,3=invis,4=xray,5=fire,6=tele,7=monkey
	var/lastx = 0
	var/lasty = 0
	var/lastz = 0
	var/hadclient

/mob/human
	name = "human"
	icon = 'mob.dmi'
	icon_state = "m-none"
	gender = MALE
	var/jacksparrow = 0
	var/gentleman = 0
	var/occupation1 = "No Preference"
	var/occupation2 = "No Preference"
	var/occupation3 = "No Preference"
	var/need_gl = 0.0
	var/be_epil = 0.0
	var/be_cough = 0.0
	var/be_tur = 0.0
	var/be_stut = 0.0
	var/r_hair = 0.0
	var/g_hair = 0.0
	var/b_hair = 0.0
	var/h_style = "Short Hair"
	var/r_facial = 0.0
	var/g_facial = 0.0
	var/b_facial = 0.0
	var/f_style = "Shaved"
	var/nr_hair = 0.0
	var/ng_hair = 0.0
	var/nb_hair = 0.0
	var/nr_facial = 0.0
	var/ng_facial = 0.0
	var/nb_facial = 0.0
	var/ns_tone = 0.0
	var/r_eyes = 0.0
	var/g_eyes = 0.0
	var/b_eyes = 0.0
	var/s_tone = 0.0
	var/age = 30.0
	var/b_type = "A+"
	var/obj/item/weapon/clothing/suit/wear_suit = null
	var/obj/item/weapon/clothing/under/w_uniform = null
	var/obj/item/weapon/radio/w_radio = null
	var/obj/item/weapon/clothing/shoes/shoes = null
	var/obj/item/weapon/belt = null
	var/obj/item/weapon/clothing/gloves/gloves = null
	var/obj/item/weapon/clothing/glasses/glasses = null
	var/obj/item/weapon/clothing/head/head = null
	var/obj/item/weapon/clothing/ears/ears = null
	var/obj/item/weapon/card/id/wear_id = null
	var/obj/item/weapon/r_store = null
	var/obj/item/weapon/l_store = null

	var/icon/stand_icon = null
	var/icon/lying_icon = null

	var/now_pushing = null
	var/t_plasma = 0.0
	var/t_oxygen = 0.0
	var/last_b_state = 1.0

	var/image/face_standing = null
	var/image/face_lying = null

	var/h_style_r = "hair_a"
	var/f_style_r = "bald"

	weight = 2500000.0
	var/cameraFollow = null

	var/list/body_standing = list(  )
	var/list/body_lying = list(  )

/mob/monkey
	name = "monkey"
	icon = 'monkey.dmi'
	icon_state = "monkey1"
	gender = MALE
	var/t_plasma = null
	var/t_oxygen = null
	var/t_sl_gas = null
	var/t_n2 = null
	var/now_pushing = null
	flags = FPRINT|TABLEPASS
	var/cameraFollow = null

/mob/observer
	icon = 'observer.dmi'
	icon_state = "ghost"
	layer = 1		//	not used
	density = 0		//	not used
	stat = 2
	canmove = 0		//	not used
	blinded = 0
	anchored = 1	//  don't get pushed around
	var/mob/corpse = null	//	observer mode
	var/datum/hud/carbon/hud = null // hud
	start = 1

/mob/ai
	name = "AI"
	icon = 'power.dmi'
	icon_state = "ai"
	gender = MALE
	var/network = "AI Satellite"
	var/obj/machinery/camera/current = null
	var/t_plasma = null
	var/t_oxygen = null
	var/t_sl_gas = null
	var/t_n2 = null
	var/now_pushing = null
	var/aiRestorePowerRoutine = 0
	var/list/laws = list()
	flags = FPRINT|TABLEPASS
	var/cameraFollow = null
	var/alarms = list("Motion"=list(), "Fire"=list(), "Atmosphere"=list(), "Power"=list())
	var/viewalerts = 0
	var/obj/machinery/AIconnector/connectora
	var/obj/machinery/connector = null
	var/list/connectors = list()

/obj
	var/datum/module/mod
	var/pathweight = 1

/obj/mark
		var/mark = ""
		icon = 'mark.dmi'
		icon_state = "blank"
		anchored = 1
		layer = 99
		mouse_opacity = 0


/obj/blob
		icon = 'blob.dmi'
		icon_state = "bloba0"
		var/health = 30
		var/attempt = 0
		var/idle = 0
		density = 1
		opacity = 0
		anchored = 1

/obj/admins
	name = "admins"
	var/rank = null
	var/a_level = 0.0
	var/screen = 1.0
	var/owner = null
	var/stealthmode = 0
/obj/barrier
	name = "barrier"
	icon = 'stationobjs.dmi'
	icon_state = "barrier"
	opacity = 1
	density = 1
	anchored = 1.0
/obj/beam
	name = "beam"
/obj/beam/a_laser
	name = "a laser"
	icon = 'weap_sat.dmi'
	icon_state = "laser"
	density = 1
	var/yo = null
	var/xo = null
	var/current = null
	var/life = 50.0
	anchored = 1.0
	flags = TABLEPASS
/obj/beam/i_beam
	name = "i beam"
	icon = 'weap_sat.dmi'
	icon_state = "laser"
	var/obj/beam/i_beam/next = null
	var/obj/item/weapon/infra/master = null
	var/limit = null
	var/visible = 0.0
	var/left = null
	anchored = 1.0
	flags = TABLEPASS
/obj/bedsheetbin
	name = "linen bin"
	desc = "A bin for containing bedsheets."
	icon = 'Icons.dmi'
	icon_state = "bedbin"
	var/amount = 23.0
	anchored = 1.0
/obj/begin
	name = "begin"
	icon = 'stationobjs.dmi'
	icon_state = "begin"
	anchored = 1.0
/obj/bomb
	name = "bomb"
	icon = 'screen1.dmi'
	icon_state = "x"
	var/btype = 0  //0 = radio, 1= prox, 2=time
	var/explosive = 1	// 0= firebomb
	var/btemp = 500	// bomb temperature (degC)
	var/active = 0
/obj/bomb/radio
	btype = 0
/obj/bomb/proximity
	btype = 1
/obj/bomb/timer
	btype = 2
/obj/bomb/timer/syndicate
	btemp = 1000
/obj/bomb/suicide
	btype = 3
/obj/bullet
	name = "bullet"
	icon = 'weap_sat.dmi'
	icon_state = "bullet"
	density = 1
	var/yo = null
	var/xo = null
	var/current = null
	anchored = 1.0
	flags = TABLEPASS
/obj/bullet/electrode
	name = "electrode"
	icon_state = "u_laser"

/obj/d_girders
	name = "displaced girders"
	icon = 'stationobjs.dmi'
	icon_state = "d_girders"
	density = 1
	anchored = 0.0
	weight = 1.0E8
/obj/datacore
	name = "datacore"

	var/list/medical = list(  )
	var/list/general = list(  )
	var/list/security = list(  )

/obj/dna
	name = "dna"
	var/spec_identity = null
	var/r_spec_identity = null
	var/use_enzyme = null
	var/struc_enzyme = null
	var/uni_identity = null
	var/n_chromo = null
/obj/effects
	name = "effects"
	mouse_opacity = 0
	flags = TABLEPASS
/obj/effects/smoke
	name = "smoke"
	icon = 'water.dmi'
	icon_state = "smoke"
	opacity = 1
	anchored = 0.0
	mouse_opacity = 0
	var/amount = 6.0
/obj/effects/sparks
	name = "sparks"
	icon = 'water.dmi'
	icon_state = "sparks"
	var/amount = 6.0
	anchored = 0.0
	mouse_opacity = 0
/obj/effects/sparks/ion_trails
	name = "ion trails"
	icon_state = "ion_trails"
	anchored = 1.0
/obj/effects/water
	name = "water"
	icon = 'water.dmi'
	icon_state = "extinguish"
	var/life = 10.0
	var/amount = 5.0
	flags = TABLEPASS
	mouse_opacity = 0
/obj/equip_e
	name = "equip e"
	var/mob/source = null
	var/s_loc = null
	var/t_loc = null
	var/obj/item/item = null
	var/place = null
/obj/equip_e/human
	name = "human"
	var/mob/human/target = null
/obj/equip_e/monkey
	name = "monkey"
	var/mob/monkey/target = null
/obj/grille
	desc = "A piece of metal with evenly spaced gridlike holes in it. Blocks large object but lets small items, gas, or energy beams through."
	name = "grille"
	icon = 'turfs2.dmi'
	icon_state = "grille"
	density = 1
	var/health = 10.0
	var/destroyed = 0.0
	anchored = 1.0
	flags = FPRINT
	weight = 500000	// added
	layer = 2.8
/obj/securearea
	desc = "A warning sign which reads 'SECURE AREA'"
	name = "SECURE AREA"
	icon = 'Icons.dmi'
	icon_state = "securearea"
	anchored = 1.0
	opacity = 0
	density = 0

/obj/hud
	name = "hud"
	layer = 52
	var/adding = null
	var/other = null
	var/intents = null
	var/mov_int = null
	var/mon_blo = null
	var/m_ints = null
	var/obj/screen/druggy = null
	var/vimpaired = null
	var/obj/screen/g_dither = null
	var/obj/screen/blurry = null
	var/h_type = /obj/screen
	var/list/darkMask = null
/obj/hud/hud2
	layer = 52
	name = "hud2"
	h_type = /obj/screen/screen2
/obj/item
	name = "item"
	var/w_class = 3.0
/obj/item/weapon
	name = "weapon"
	icon = 'items.dmi'
	var/icon_old = null
	var/abstract = 0.0
	var/force = null
	var/s_istate = null
	var/damtype = "brute"
	var/throwforce = null
	var/r_speed = 1.0
	var/mob/human/whoseblood = null
	var/health = null
	var/burn_point = null
	var/burning = null
	var/obj/item/weapon/master = null
	var/custom_sound = 0
	var/material = 1 // 1 is metal, 2 is glass. (These deal with what the sound should be when attacking)
	flags = FPRINT|TABLEPASS
	weight = 500000.0
/obj/item/weapon/a_gift
	name = "gift"
	icon_state = "gift"
	s_istate = "gift"
	weight = 1.0E7
/obj/item/weapon/ammo
	name = "ammo"
	icon = 'ammo.dmi'
	var/amount_left = 0.0
	flags = FPRINT|TABLEPASS
	s_istate = "syringe_kit"
/obj/item/weapon/ammo/a357
	desc = "There are 7 bullets left!"
	name = "ammo-357"
	icon_state = "357-7"
	amount_left = 7.0
/obj/item/weapon/analyzer
	desc = "A hand-held environmental scanner which reports current gas levels."
	name = "analyzer"
	icon_state = "analyzer"
	w_class = 2.0
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly
	name = "assembly"
	icon = 'assemblies.dmi'
	s_istate = "assembly"
	w_class = 3.0
	var/status = 0.0
/obj/item/weapon/assembly/a_i_a
	name = "Health-Analyzer/Igniter/Armor Assembly"
	desc = "A health-analyzer, igniter and armor assembly."
	icon_state = "a_i_a"
	var/obj/item/weapon/healthanalyzer/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	var/obj/item/weapon/clothing/suit/armor/part3 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/m_i_ptank
	desc = "A very intricate igniter and proximity sensor electrical assembly mounted onto top of a plasma tank."
	name = "Proximity/Igniter/Plasma Tank Assembly"
	icon_state = "m_i_ptank0"
	var/obj/item/weapon/prox_sensor/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	var/obj/item/weapon/tank/plasmatank/part3 = null
	status = 0.0
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/prox_ignite
	name = "Proximity/Igniter Assembly"
	desc = "A proximity-activated igniter assembly."
	icon_state = "prox_igniter0"
	var/obj/item/weapon/prox_sensor/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/r_i_ptank
	desc = "A very intricate igniter and signaller electrical assembly mounted onto top of a plasma tank."
	name = "Radio/Igniter/Plasma Tank Assembly"
	icon_state = "r_i_ptank"
	var/obj/item/weapon/radio/signaler/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	var/obj/item/weapon/tank/plasmatank/part3 = null
	status = 0.0
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/anal_ignite
	name = "Health-Analyzer/Igniter Assembly"
	desc = "A health-analyzer igniter assembly."
	icon_state = "time_igniter0"
	var/obj/item/weapon/healthanalyzer/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"
/obj/item/weapon/assembly/time_ignite
	name = "Timer/Igniter Assembly"
	desc = "A timer-activated igniter assembly."
	icon_state = "time_igniter0"
	var/obj/item/weapon/timer/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/t_i_ptank
	desc = "A very intricate igniter and timer assembly mounted onto top of a plasma tank."
	name = "Timer/Igniter/Plasma Tank Assembly"
	icon_state = "t_i_ptank0"
	var/obj/item/weapon/timer/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	var/obj/item/weapon/tank/plasmatank/part3 = null
	status = 0.0
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/rad_ignite
	name = "Radio/Igniter Assembly"
	desc = "A radio-activated igniter assembly."
	icon_state = "rad_igniter"
	var/obj/item/weapon/radio/signaler/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/rad_infra
	name = "Signaller/Infrared Assembly"
	desc = "An infrared-activated radio signaller"
	icon_state = "infrared0"
	var/obj/item/weapon/radio/signaler/part1 = null
	var/obj/item/weapon/infra/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/rad_prox
	name = "Signaller/Prox Sensor Assembly"
	desc = "A proximity-activated radio signaller."
	icon_state = "motion0"
	var/obj/item/weapon/radio/signaler/part1 = null
	var/obj/item/weapon/prox_sensor/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/rad_time
	name = "Signaller/Timer Assembly"
	desc = "A radio signaller activated by a count-down timer."
	icon_state = "time_sig"
	var/obj/item/weapon/radio/signaler/part1 = null
	var/obj/item/weapon/timer/part2 = null
	status = null
	flags = FPRINT|TABLEPASS
/obj/item/weapon/assembly/shock_kit
	name = "Shock Kit"
	icon_state = "shock_kit"
	var/obj/item/weapon/clothing/head/helmet/part1 = null
	var/obj/item/weapon/radio/electropack/part2 = null
	status = 0.0
	w_class = 5.0
	flags = FPRINT|TABLEPASS

/obj/item/weapon/axe
	name = "Axe"
	desc = "An energised battle axe."
	icon_state = "axe0"
	var/active = 0.0
	force = 40.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 5.0
	flags = FPRINT|DEADLY

/obj/item/weapon/pickaxe
	name = "Pickaxe"
	desc = "A pickaxe. Used for mining."
	icon_state = "pickaxe"
	force = 25.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 5.0


/obj/item/weapon/baton
	name = "Stun Baton"
	desc = "A stun baton for hitting people with."
	icon = 'stun_baton.dmi'
	icon_state = "baton"
	flags = FPRINT | ONBELT | TABLEPASS
	force = 15
	throwforce = 7
	w_class = 3
	var/charges = 10.0
	var/maximum_charges = 10.0
	var/status = 1
/obj/item/weapon/bedsheet
	name = "bedsheet"
	icon = 'Icons.dmi'
	icon_state = "sheet"
	layer = 4.0
	s_istate = "w_suit"
/obj/item/weapon/bottle
	name = "bottle"
	var/obj/substance/chemical/chem = null
	throw_speed = 4
	throw_range = 20
	w_class = 1.0
/obj/item/weapon/bottle/antitoxins
	name = "antitoxins"
	icon_state = "atoxinbottle"
/obj/item/weapon/bottle/r_ch_cough
	name = "cough remedy"
	icon_state = "medibottle"
/obj/item/weapon/bottle/r_epil
	name = "epileptic remedy"
	icon_state = "medibottle"
/obj/item/weapon/bottle/r_fever
	name = "epileptic remedy"
	icon_state = "medibottle"
/obj/item/weapon/bottle/rejuvenators
	name = "rejuvenators"
	icon_state = "rejuvbottle"
/obj/item/weapon/bottle/s_tox
	name = "sleep toxins"
	icon_state = "toxinbottle"
/obj/item/weapon/bottle/toxins
	name = "toxins"
	icon_state = "toxinbottle"
/obj/item/weapon/brutepack
	name = "bruise pack"
	desc = "A pack designed to treat blunt-force trauma."
	icon_state = "brutepack"
	var/amount = 5.0
	w_class = 1.0
	throw_speed = 4
	throw_range = 20
/obj/item/weapon/spraygel
	name = "bandage gel"
	desc = "A new medical gel designed to speed the healing rate of broken limbs."
	icon_state = "medgel"
	var/amount = 5
	w_class = 1.0
	throw_speed = 4
	throw_range = 20
	s_istate = "medigel"
/obj/item/weapon/c_tube
	name = "cardboard tube"
	icon_state = "c_tube"
/obj/item/weapon/camera
	name = "camera"
	icon_state = "camera"
	var/last_pic = 1.0
	s_istate = "wrench"
	w_class = 2.0
/obj/item/weapon/card
	name = "card"
	w_class = 1.0

	var/list/files = list(  )

/obj/item/weapon/card/data
	name = "data disk"
	icon_state = "card-data"
	var/function = "storage"
	var/data = "null"
	var/special = null
	s_istate = "card-id"
/obj/item/weapon/card/emag
	desc = "It's a card with a magnetic strip attached to some circuitry."
	name = "emag"
	icon_state = "emag-card"
	s_istate = "card-id"
/obj/item/weapon/card/id
	name = "identification card"
	icon_state = "card-id"
	var/access = list()
	var/registered = null
	var/assignment = null
	var/hide = 0
/obj/item/weapon/card/id/syndicate
	name = "Syndicates's ID Card (Syndicate)"
	registered = "Syndicate"
	hide = 1
	assignment = "Syndicate"

/obj/item/weapon/card/id/captains_spare
	name = "Captain's spare ID"
	icon_state = "card-id"
	registered = "Captain"
	assignment = "Captain"
	New()
		access = get_access("Captain")
		..()

/obj/item/weapon/bucket
	desc = "It's a bucket."
	name = "bucket"
	icon_state = "bucket"
	force = 3.0
	var/water = 0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/cleaner
	desc = "Space Cleaner! Just add water."
	name = "space cleaner"
	icon_state = "cleaner"
	var/water = 8
	s_istate = "cleaner"
/obj/item/weapon/clipboard
	name = "clipboard"
	icon_state = "clipboard00"
	var/obj/item/weapon/pen/pen = null
	s_istate = "clipboard"
/obj/item/weapon/cloaking_device
	name = "cloaking device"
	icon_state = "shield0"
	var/active = 0.0
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	var/battery = 120
/obj/item/weapon/clothing
	name = "clothing"
	var/a_filter = 0.0
	var/fb_filter = 0.0
	var/h_filter = 0.0
	var/s_fire = 0.0
	var/see_face = 1.0
	var/color = null
	var/brute_protect = 0
	var/fire_protect = 0
	var/chem_protect = 0
/obj/item/weapon/clothing/ears
	name = "ears"
	w_class = 2.0
/obj/item/weapon/clothing/ears/earmuffs
	name = "earmuffs"
	icon_state = "earmuffs"
	s_fire = 1.875E7
	s_istate = "earmuffs"
/obj/item/weapon/clothing/glasses
	name = "glasses"
	w_class = 2.0
	flags = GLASSESCOVERSEYES
	s_fire = 7.5E7
/obj/item/weapon/clothing/glasses/blindfold
	name = "blindfold"
	icon_state = "blindfold"
	s_istate = "blindfold"
/obj/item/weapon/clothing/glasses/meson
	name = "Optical Meson Scanner"
	icon_state = "m_glasses"
	s_istate = "glasses"
/obj/item/weapon/clothing/glasses/regular
	name = "Prescription Glasses"
	icon_state = "p_glasses"
	s_istate = "glasses"
/obj/item/weapon/clothing/glasses/sunglasses
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks many flashes."
	name = "Sunglasses"
	icon_state = "s_glasses"
	s_istate = "s_glasses"
/obj/item/weapon/clothing/glasses/thermal
	name = "Optical Thermal Scanner"
	icon_state = "t_glasses"
	s_istate = "glasses"
/obj/item/weapon/clothing/glasses/monocle
	name = "Monocle"
	desc = "A jolly good monocle."
	icon_state = "monocle"
	s_istate = "monocle"
/obj/item/weapon/clothing/gloves
	name = "gloves"
	w_class = 2.0
	s_fire = 1.875E7
	var/elec_protect = 1
	var/elecgen = 0
	var/uses = 0
/obj/item/weapon/clothing/gloves/black
	desc = "These gloves are somewhat fire-resistant."
	name = "Black Gloves"
	icon_state = "bgloves"
	s_istate = "bgloves"
	h_filter = 4.0
	s_fire = 7.5E7
	fire_protect = 16
/obj/item/weapon/clothing/gloves/latex
	name = "Latex Gloves"
	icon_state = "lgloves"
	s_istate = "lgloves"
	h_filter = 5.0
	elec_protect = 2
/obj/item/weapon/clothing/gloves/robot
	desc = "These gloves are somewhat fire-resistant."
	name = "Robot Gloves"
	icon_state = "r_hands"
	s_istate = "r_hands"
	h_filter = 4.0
	fire_protect = 16
	elec_protect = 0
/obj/item/weapon/clothing/gloves/swat
	desc = "These gloves are somewhat fire-resistant."
	name = "SWAT Gloves"
	icon_state = "swat_gl"
	s_istate = "swat_gl"
	h_filter = 4.0
	fire_protect = 16
	brute_protect = 16
	elec_protect = 2
	chem_protect = 5
/obj/item/weapon/clothing/gloves/stungloves/
	name = "Stungloves"
	desc = "These gloves are electrically charged."
	icon_state = "swat_gl"
	s_istate = "swat_gl"
	h_filter = 4.0
	fire_protect = 16
	brute_protect = 16
	elec_protect = 2
	elecgen = 1
	uses = 10
/obj/item/weapon/clothing/gloves/yellow
	desc = "These gloves are electrically insulated."
	name = "insulated gloves"
	icon_state = "ygloves"
	s_istate = "ygloves"
	h_filter = 4.0
	fire_protect = 16
	elec_protect = 10
	chem_protect = 5


/obj/item/weapon/clothing/head
	name = "head"
/obj/item/weapon/clothing/head/bio_hood
	name = "bio hood"
	icon_state = "bio_hood"
	fb_filter = 9.0
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH|PLASMAGUARD
	see_face = 0.0
	s_fire = 1.875E7
	fire_protect = 1
	chem_protect = 40
/obj/item/weapon/clothing/head/cakehat
	name = "cakehat"
	icon_state = "cakehat0"
	var/onfire = 0.0
	fb_filter = 9.0
	var/status = 0
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES
	s_fire = 7.5E7	//75000000 :O
	fire_protect = 126
	var/fire_resist = T0C+1300	//this is the max temp it can stand before you start to cook. although it might not burn away, you take damage
/obj/item/weapon/clothing/head/helmet
	name = "helmet"
	icon_state = "helmet"
	flags = FPRINT|TABLEPASS|SUITSPACE|HEADCOVERSEYES
	s_istate = "helmet"
	s_fire = 6.75E7
	fire_protect = 1
	brute_protect = 1
	chem_protect = 5
/obj/item/weapon/clothing/head/helmet/fire_hel
	name = "fire helmet"
	icon_state = "fire_hel"
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH
	s_istate = "fire_hel"
	fire_protect = 5
	chem_protect = 5
/obj/item/weapon/clothing/head/s_helmet
	name = "space helmet"
	icon_state = "s_helmet"
	flags = FPRINT|TABLEPASS|HEADSPACE|HEADCOVERSEYES|HEADCOVERSMOUTH
	see_face = 0.0
	s_istate = "s_helmet"
	s_fire = 5.625E7
	fire_protect = 1
	chem_protect = 5

/obj/item/weapon/clothing/head/s_helmet/syndicate
	icon_state = "space_helmet_syndicate"
	s_istate = "space_helmet_syndicate"

/obj/item/weapon/clothing/head/helmet/swat_hel
	name = "swat hel"
	icon_state = "swat_hel"
	flags = FPRINT|TABLEPASS|SUITSPACE|HEADSPACE|HEADCOVERSEYES
	s_istate = "swat_hel"
	chem_protect = 5
/obj/item/weapon/clothing/head/helmet/tdhelm
	name = "Thunderdome helmet"
	icon_state = "tdhelm"
	flags = FPRINT|TABLEPASS|SUITSPACE|HEADSPACE|HEADCOVERSEYES
	s_istate = "tdhelm"
/obj/item/weapon/clothing/head/that
	name = "hat"
	desc = "An amish looking hat"
	icon_state = "that"
/obj/item/weapon/clothing/head/wig
	name = "wig"
/obj/item/weapon/clothing/head/wizhat
	name = "hat"
	desc = "A hat that seems to radiate power"
	icon_state = "wizhat"
/obj/item/weapon/clothing/mask
	name = "mask"
	var/vchange = 0
/obj/item/weapon/clothing/mask/gasmask
	name = "gasmask"
	desc = "A close-fitting mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "mask"
	flags = FPRINT|TABLEPASS|SUITSPACE|MASKCOVERSMOUTH|MASKCOVERSEYES
	w_class = 3.0
	fb_filter = 5.0
	a_filter = 6.0
	see_face = 0.0
	s_istate = "gas_mask"
	s_fire = 7.5E7
	fire_protect = 1
	chem_protect = 10
/obj/item/weapon/clothing/mask/m_mask
	desc = "This mask does not work very well in low pressure environments."
	name = "Medical Mask"
	icon_state = "m_mask"
	flags = FPRINT|TABLEPASS|SUITSPACE|HEADSPACE|MASKCOVERSMOUTH
	w_class = 3.0
	fb_filter = 4.0
	a_filter = 6.0
	s_istate = "m_mask"
	s_fire = 1.875E7
/obj/item/weapon/clothing/mask/muzzle
	name = "muzzle"
	icon_state = "muzzle"
	flags = FPRINT|TABLEPASS|MASKCOVERSMOUTH
	w_class = 2.0
	a_filter = 3.0
	s_istate = "muzzle"
	s_fire = 1.875E7
/obj/item/weapon/clothing/mask/robot
	name = "Robot Mask"
	icon_state = "r_head"
	flags = FPRINT|TABLEPASS|SUITSPACE|MASKCOVERSMOUTH|MASKCOVERSEYES
	w_class = 3.0
	fb_filter = 5.0
	a_filter = 6.0
	see_face = 0.0
	s_istate = "r_head"
	s_fire = 7.5E7
	brute_protect = 1
	fire_protect = 1
	chem_protect = 5
/obj/item/weapon/clothing/mask/robot/swat
	name = "SWAT Mask"
/obj/item/weapon/clothing/mask/surgical
	name = "Sterile Mask"
	icon_state = "s_mask"
	w_class = 1.0
	flags = FPRINT|TABLEPASS|HEADSPACE|MASKCOVERSMOUTH
	fb_filter = 5.0
	a_filter = 6.0
	s_istate = "s_mask"
	s_fire = 1.875E7
/obj/item/weapon/clothing/mask/voicemask
	name = "gasmask"
	desc = "A close-fitting mask that can filter some environmental toxins or be connected to an air supply."
	icon_state = "mask"
	flags = FPRINT|TABLEPASS|SUITSPACE|MASKCOVERSMOUTH|MASKCOVERSEYES
	w_class = 3.0
	fb_filter = 5.0
	a_filter = 6.0
	see_face = 0.0
	s_istate = "gas_mask"
	s_fire = 7.5E7
	fire_protect = 1
	vchange = 1
	chem_protect = 10
/obj/item/weapon/clothing/shoes
	name = "shoes"
	var/chained = 0.0
	fb_filter = 1.0
	s_fire = 3.75E7
	brute_protect = 64
	fire_protect = 64
/obj/item/weapon/clothing/shoes/black
	name = "Black Shoes"
	icon_state = "bl_shoes"
/obj/item/weapon/clothing/shoes/brown
	name = "Brown Shoes"
	icon_state = "b_shoes"
/obj/item/weapon/clothing/shoes/orange
	name = "Orange Shoes"
	icon_state = "o_shoes"
/obj/item/weapon/clothing/shoes/robot
	name = "Robot Shoes"
	icon_state = "r_feet"
/obj/item/weapon/clothing/shoes/swat
	name = "SWAT shoes"
	icon_state = "swat_sh"
	chem_protect = 5
/obj/item/weapon/clothing/shoes/white
	name = "White Shoes"
	icon_state = "w_shoes"
	fb_filter = 5.0
/obj/item/weapon/clothing/shoes/sandal
	name = "sandals"
	icon_state = "wizshoe"
	fb_filter = 5.0
/obj/item/weapon/clothing/suit
	name = "suit"
	var/fire_resist = T0C+100
/obj/item/weapon/clothing/suit/armor
	name = "armor"
	desc = "A suit that protects against some damage."
	icon_state = "armor"
	s_istate = "armor"
	s_fire = 1.875E7
	brute_protect = 6
	chem_protect = 15
/obj/item/weapon/clothing/suit/a_i_a_ptank/
	desc = "A wearable bomb with a health analyzer attached."
	name = "Analyzer/Igniter/Armor/Plasmatank Assembly"
	icon_state = "bombvest"
	s_istate = "bombvest"
	var/obj/item/weapon/healthanalyzer/part1 = null
	var/obj/item/weapon/igniter/part2 = null
	var/obj/item/weapon/tank/plasmatank/part4 = null
	var/obj/item/weapon/clothing/suit/armor/part3 = null
	var/status = 0.0
	flags = FPRINT|TABLEPASS
	s_fire = 1.875E7
	brute_protect = 6
/obj/item/weapon/clothing/suit/heavy_armor
	name = "heavy armor"
	desc = "A suit that protects against some damage."
	icon_state = "swat_suit"
	s_istate = "swat_suit"
	s_fire = 1.875E7
	brute_protect = 6
	chem_protect = 75
/obj/item/weapon/clothing/suit/bio_suit
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon_state = "bio_suit"
	fb_filter = 9.0
	a_filter = 9.0
	h_filter = 9.0
	s_istate = "bio_suit"
	flags = FPRINT | TABLEPASS | PLASMAGUARD
	s_fire = 1350000.0
	fire_protect = 126
	chem_protect = 50
/obj/item/weapon/clothing/suit/firesuit
	name = "firesuit"
	desc = "A suit that protects against fire and heat."
	icon_state = "firesuit"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "fire_suit"
	flags = FPRINT | TABLEPASS
	s_fire = 7.5E7	//75000000 :O
	fire_protect = 126
	fire_resist = T0C+1300	//this is the max temp it can stand before you start to cook. although it might not burn away, you take damage
	chem_protect = 20
/obj/item/weapon/clothing/suit/black_firesuit
	name = "firesuit"
	desc = "A suit that protects against extreme fire and heat."
	icon_state = "ro_suit"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "ro_suit"
	flags = FPRINT | TABLEPASS
	s_fire = 7.5E7
	fire_protect = 126
	fire_resist = T0C+2600
	chem_protect = 20
obj/item/weapon/clothing/suit/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	s_istate = "labcoat"
	flags = FPRINT | TABLEPASS
	s_fire = 1000000.0
	fire_protect = 126
	chem_protect = 25
/obj/item/weapon/clothing/suit/robot_suit
	name = "robot suit"
	icon_state = "ro_suit"
	fb_filter = 9.0
	a_filter = 9.0
	h_filter = 9.0
	s_istate = "ro_suit"
	flags = FPRINT | TABLEPASS
	s_fire = 1.875E7
	fire_protect = 126
	fire_resist = T0C+5200

/obj/item/weapon/clothing/suit/sp_suit
	name = "space suit"
	desc = "A suit that protects against low pressure environments."
	icon_state = "s_suit"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "s_suit"
	flags = FPRINT | TABLEPASS | SUITSPACE
	s_fire = 6.75E7
	fire_protect = 126
	chem_protect = 30
/obj/item/weapon/clothing/suit/santa
	name = "Santa's suit"
	desc = "Festive!"
	icon_state = "santa"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "santa"
	flags = FPRINT | TABLEPASS
	s_fire = 6.75E7
	fire_protect = 126

/obj/item/weapon/clothing/suit/sp_suit/syndicate
	icon_state = "space_suit_syndicate"
	s_istate = "space_suit_syndicate"

/obj/item/weapon/clothing/suit/straight_jacket
	name = "straight jacket"
	desc = "A suit that totally restrains an individual"
	icon_state = "straight_jacket"
	s_istate = "straight_jacket"
	s_fire = 1.875E7
	fire_protect = 126
/obj/item/weapon/clothing/suit/swat_suit
	name = "swat suit"
	icon_state = "swat_suit"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "swat_suit"
	flags = FPRINT | TABLEPASS
	s_fire = 6.75E7
	brute_protect = 126
	fire_protect = 126
	chem_protect = 30
/obj/item/weapon/clothing/suit/swat_suit/tdred
	name = "Thunderdome suit (red)"
	icon_state = "tdred"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "tdred"
	flags = FPRINT | TABLEPASS
	brute_protect = 126
	fire_protect = 25
/obj/item/weapon/clothing/suit/swat_suit/tdgreen
	name = "Thunderdome suit (green)"
	icon_state = "tdgreen"
	fb_filter = 6.0
	h_filter = 6.0
	a_filter = 4.0
	s_istate = "tdgreen"
	flags = FPRINT | TABLEPASS
	brute_protect = 126
	fire_protect = 25
/obj/item/weapon/clothing/suit/wcoat
	name = "waistcoat"
	icon_state = "wcoat"
	fb_filter = 9.0
	a_filter = 9.0
	h_filter = 9.0
	s_istate = "wcoat"
	flags = FPRINT | TABLEPASS
/obj/item/weapon/clothing/suit/wizrobe
	name = "robe"
	desc = "A magnificant blue robe that seems to radiate power"
	icon_state = "wizrobe"
	fb_filter = 9.0
	a_filter = 9.0
	h_filter = 9.0
	s_istate = "wizrobe"
	flags = FPRINT | TABLEPASS
/obj/item/weapon/clothing/under
	name = "under"
	s_fire = 1.875E7
	fb_filter = 1.0
	fire_protect = 46

/obj/item/weapon/clothing/under/black
	name = "Black Jumpsuit"
	icon_state = "bl_suit"
	color = "black"
/obj/item/weapon/clothing/under/chaplain_black
	desc = "It has a religion rank stripe on it."
	name = "Black Jumpsuit"
	icon_state = "bl_suit"
	color = "chapblack"
/obj/item/weapon/clothing/under/sl_suit
	desc = "A very amish looking suit"
	name = "Amish Suit"
	icon_state = "sl_suit"
	color = "sl_suit"
/obj/item/weapon/clothing/under/blue
	name = "Blue Jumpsuit"
	icon_state = "b_suit"
	color = "blue"

/obj/item/weapon/clothing/under/bartender
	name = "Suit"
	icon_state = "ba_suit"
	color = "ba_suit"
/obj/item/weapon/clothing/under/janitor
	desc = "Official clothing of the station's poopscooper."
	name = "Janitor's Jumpsuit"
	icon_state = "janitor"
	color = "janitor"
	chem_protect = 5
/obj/item/weapon/clothing/under/green
	name = "Green Jumpsuit"
	icon_state = "g_suit"
	color = "green"
/obj/item/weapon/clothing/under/hor_green
	desc = "It has a Head of Research rank stripe on it."
	name = "Green Jumpsuit"
	icon_state = "g_suit"
	color = "horgreen"
/obj/item/weapon/clothing/under/hop_green
	desc = "It has a Head of Personnel rank stripe on it."
	name = "Green Jumpsuit"
	icon_state = "g_suit"
	color = "hopgreen"
/obj/item/weapon/clothing/under/hos_green
	desc = "It has a Head of Security rank stripe on it."
	name = "Green Jumpsuit"
	icon_state = "g_suit"
	color = "hosgreen"
/obj/item/weapon/clothing/under/hom_green
	desc = "It has a Head of Maintenance rank stripe on it."
	name = "Green Jumpsuit"
	icon_state = "g_suit"
	color = "homgreen"

/obj/item/weapon/clothing/under/grey
	name = "Grey Jumpsuit"
	icon_state = "gy_suit"
	color = "grey"

/obj/item/weapon/clothing/under/orange
	name = "Orange Jumpsuit"
	icon_state = "o_suit"
	color = "orange"

/obj/item/weapon/clothing/under/pink
	name = "Pink Jumpsuit (F)"
	icon_state = "p_suit"
	color = "pink"

/obj/item/weapon/clothing/under/red
	name = "Red Jumpsuit"
	icon_state = "r_suit"
	color = "red"
/obj/item/weapon/clothing/under/forensics_red
	desc = "It has a Forensics rank stripe on it."
	name = "Red Jumpsuit"
	icon_state = "r_suit"
	color = "forensicsred"
/obj/item/weapon/clothing/under/firefighter_red
	desc = "It has a Fire Fighter rank stripe on it."
	name = "Red Jumpsuit"
	icon_state = "r_suit"
	color = "ffred"
/obj/item/weapon/clothing/under/network
	desc = "It has Network Technician rank stripes on it"
	name = "Network Technician Suit"
	icon_state = "network"
	color = "network"
/obj/item/weapon/clothing/under/white
	desc = "Made of a special fiber that gives special protection against biohazards."
	name = "White Jumpsuit"
	icon_state = "w_suit"
	color = "white"
	fb_filter = 5.0
	chem_protect = 5
/obj/item/weapon/clothing/under/genetics_white
	desc = "Made of a special fiber that gives special protection against biohazards. Has a genetics rank stripe on it."
	name = "White Jumpsuit"
	icon_state = "w_suit"
	color = "geneticswhite"
	fb_filter = 5.0
	chem_protect = 5
/obj/item/weapon/clothing/under/toxins_white
	desc = "Made of a special fiber that gives special protection against biohazards. Has a toxins rank stripe on it."
	name = "White Jumpsuit"
	icon_state = "w_suit"
	color = "toxinswhite"
	fb_filter = 5.0
	chem_protect = 5
/obj/item/weapon/clothing/under/yellow
	name = "Yellow Jumpsuit"
	icon_state = "y_suit"
	color = "yellow"
/obj/item/weapon/clothing/under/atmospherics_yellow
	desc = "It has an Atmospherics rank stripe on it."
	name = "Yellow Jumpsuit"
	icon_state = "y_suit"
	color = "atmosyellow"
/obj/item/weapon/clothing/under/engineering_yellow
	desc = "It has an Engineering rank stripe on it."
	name = "Yellow Jumpsuit"
	icon_state = "y_suit"
	color = "engineyellow"

/obj/item/weapon/clothing/under/darkgreen
	desc = "It has a Captains rank stripe on it."
	name = "Dark Green Jumpsuit"
	icon_state = "dg_suit"
	color = "darkgreen"

#define MAXCOIL 30
/obj/item/weapon/cable_coil
	name = "cable coil"
	var/amount = MAXCOIL
	icon = 'power.dmi'
	icon_state = "coil"
	desc = "A coil of power cable."
	w_class = 2
	flags = TABLEPASS|USEDELAY|FPRINT
	s_istate = "coil"

/obj/item/weapon/cable_coil/cut
	icon = 'power.dmi'
	icon_state = "coil2"

/obj/item/weapon/crowbar
	name = "crowbar"
	icon_state = "crowbar"
	flags = FPRINT|TABLEPASS
	force = 5.0
	throwforce = 7.0
	s_istate = "wrench"
	w_class = 2.0
/obj/item/weapon/cane
	name = "cane"
	icon_state = "cane"
	desc = "A Household medical cane."
	flags = FPRINT|TABLEPASS
	force = 6.0
	throwforce = 7.0
	s_istate = "cane"
	w_class = 2.0
	var/flaming = 0
/obj/item/weapon/disk
	name = "disk"
/obj/item/weapon/disk/nuclear
	name = "Nuclear Authentication Disk"
	icon_state = "nucleardisk"
	s_istate = "card-id"
	w_class = 1.0
/obj/item/weapon/dropper
	name = "dropper"
	desc = "A dropper that can hold a small amount of liquid."
	icon_state = "dropper_0"
	var/obj/substance/chemical/chem = null
	var/mode = "inject"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
/obj/item/weapon/drink
	var/s_time = 1.0
	var/amount = 0
/obj/item/weapon/drink/beer
	name = "Space Beer"
	icon_state = "beer"
	amount = 10
	s_time = 1.0
/obj/item/weapon/drink/sleepbeer
	name = "Space Beer"
	icon_state = "beer"
	amount = 3
	s_time = 1.0
/obj/item/weapon/drink/killbeer
	name = "Space Beer"
	icon_state = "beer"
	amount = 3
	s_time = 1.0
/obj/item/weapon/dummy
	name = "dummy"
	invisibility = 101.0
	anchored = 1.0
	flags = TABLEPASS
/obj/item/weapon/extinguisher
	name = "Fire Extinguisher"
	icon_state = "fire_extinguisher0"
	var/waterleft = 20.0
	var/last_use = 1.0
	flags = FPRINT|TABLEPASS|USEDELAY
	w_class = 2.0
	force = 15.0
	s_istate = "fire_extinguisher"
/obj/item/weapon/f_card
	name = "Finger Print Card"
	icon_state = "f_print_card0"
	var/amount = 10.0
	s_istate = "paper"
	w_class = 1.0
/obj/item/weapon/f_print_scanner
	name = "Finger Print Scanner"
	desc = "Used to scan objects for fingerprints."
	icon_state = "f_print_scanner0"
	var/amount = 20.0
	var/printing = 0.0
	w_class = 2.0
	s_istate = "electronic"
	flags = FPRINT|ONBELT|TABLEPASS
/obj/item/weapon/fcardholder
	name = "Finger Print Case"
	icon_state = "fcardholder0"
	s_istate = "clipboard"
	w_class = 3.0
/obj/item/weapon/flash
	name = "flash"
	icon_state = "flash"
	var/l_time = 1.0
	var/shots = 5.0
	w_class = 1.0
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"
	throw_speed = 4
	throw_range = 20
	var/status = 1
	var/rickroll = 0
	var/open = 0
/obj/item/weapon/flashbang
	desc = "It is set to detonate in 3 seconds."
	name = "flashbang"
	icon_state = "flashbang"
	var/state = null
	var/det_time = 30.0
	w_class = 2.0
	s_istate = "flashbang"
	throw_speed = 4
	throw_range = 20
	flags = FPRINT|TABLEPASS|ONBELT|USEDELAY
/obj/item/weapon/flasks
	name = "flask"
	icon = 'Cryogenic2.dmi'
	var/oxygen = 0.0
	var/plasma = 0.0
	var/coolant = 0.0
/obj/item/weapon/flasks/coolant
	name = "light blue flask"
	icon_state = "coolant-c"
	coolant = 1000.0
/obj/item/weapon/flasks/oxygen
	name = "blue flask"
	icon_state = "oxygen-c"
	oxygen = 500.0
/obj/item/weapon/flasks/plasma
	name = "orange flask"
	icon_state = "plasma-c"
	plasma = 500.0

/obj/item/weapon/flashlight
	name = "flashlight"
	desc = "A hand-held emergency light."
	icon_state = "flight0"
	var/on = 0
	w_class = 2
	s_istate = "flight"
	var/image/img
	var/lastHolder = null

/obj/item/weapon/game_kit
	name = "Gaming Kit"
	icon_state = "game_kit"
	var/selected = null
	var/board_stat = null
	var/data = ""
	var/base_url = "http://svn.slurm.us/public/spacestation13/misc/game_kit"
	s_istate = "sheet-metal"
	w_class = 5.0
/obj/item/weapon/gift
	name = "gift"
	icon_state = "gift3"
	var/size = 3.0
	var/obj/item/gift = null
	s_istate = "gift"
	w_class = 4.0
/obj/item/weapon/grab
	name = "grab"
	icon = 'screen1.dmi'
	icon_state = "grabbed"
	var/obj/screen/grab/hud1 = null
	var/mob/affecting = null
	var/mob/assailant = null
	var/state = 1.0
	var/killing = 0.0
	var/allow_upgrade = 1.0
	var/last_suffocate = 1.0
	abstract = 1.0
	s_istate = "nothing"
	w_class = 5.0
/obj/item/weapon/gun
	name = "gun"
	flags = FPRINT|TABLEPASS|ONBELT|USEDELAY
	s_istate = "gun"
/obj/item/weapon/gun/energy
	name = "energy"
	var/charges = 5
	var/maximum_charges = 5
	s_istate = "gun"

/obj/item/weapon/gun/energy/taser_gun
	name = "taser gun"
	icon_state = "t_gun5"
	w_class = 3.0
	force = 10.0
	throw_speed = 2
	throw_range = 10

/obj/item/weapon/gun/energy/laser_gun
	name = "laser gun"
	icon_state = "l_gun5"
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 7.0
/obj/item/weapon/gun/revolver
	desc = "There are 0 bullets left. Uses 357"
	name = "revolver"
	icon_state = "revolver"
	var/bullets = 0.0
	w_class = 3.0
	throw_speed = 2
	throw_range = 10
	force = 60.0
/obj/item/weapon/hand_tele
	name = "hand tele"
	icon_state = "hand_tele"
	s_istate = "electronic"
	w_class = 2.0
/obj/item/weapon/handcuffs
	name = "handcuffs"
	icon_state = "handcuff"
	flags = FPRINT|TABLEPASS|ONBELT
	w_class = 2.0
/obj/item/weapon/healthanalyzer
	name = "Health Analyzer"
	icon_state = "healthanalyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject."
	flags = FPRINT|TABLEPASS|ONBELT
	w_class = 1.0
/obj/item/weapon/geneticsanalyzer
	name = "Genetics Analyzer"
	icon_state = "healthanalyzer"
	desc = "A genetics scanner, used to take the genetic code of someone and analyze their genetic status."
	flags = FPRINT|TABLEPASS|ONBELT
	w_class = 1.0
/obj/item/weapon/igniter
	name = "igniter"
	desc = "A small electronic device able to ignite combustable substances."
	icon_state = "igniter"
	var/status = 1.0
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"
/obj/item/weapon/implant
	name = "implant"
	var/implanted = null
	var/color = "b"
/obj/item/weapon/implant/freedom
	name = "freedom"
	var/uses = 1.0
	color = "r"
	var/activation_emote = "chuckle"

/obj/item/weapon/implant/tracking
	name = "tracking"
	var/freq = 145.1
	var/id = 1.0

/obj/item/weapon/implant/lawchip
	name = "Law chip"
	var/Laws = "Never harm humans"
/obj/item/weapon/implant/escape
	name = "law"
	var/uses = 1
	var/activation_emote = "deathgasp"
/obj/item/weapon/implant/stun
	name = "stun"
	var/uses = 1
	var/freq = 147.3
/obj/item/weapon/implant/chat
	name = "chat"


/obj/item/weapon/implantcase
	name = "Glass Case"
	icon_state = "implantcase-0"
	var/obj/item/weapon/implant/imp = null
	s_istate = "implantcase"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
/obj/item/weapon/implantcase/tracking
	name = "Glass Case- 'Tracking'"
	icon_state = "implantcase-b"
/obj/item/weapon/implanter
	name = "implanter"
	icon_state = "implanter0"
	var/obj/item/weapon/implant/imp = null
	s_istate = "syringe_0"
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/implantpad
	name = "implantpad"
	icon_state = "implantpad-0"
	var/obj/item/weapon/implantcase/case = null
	var/broadcasting = null
	var/listening = 1.0
	s_istate = "electronic"
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/infra
	name = "Infrared Beam (Security)"
	desc = "Emits a visible or invisible beam and is triggered when the beam is interrupted."
	icon_state = "infrared0"
	var/obj/beam/i_beam/first = null
	var/state = 0.0
	var/visible = 0.0
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "electronic"
/obj/item/weapon/infra_sensor
	name = "Infrared Sensor"
	desc = "Scans for infrared beams in the vicinity."
	icon_state = "infra_sensor"
	var/passive = 1.0
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"

/obj/item/weapon/t_scanner
	name = "T-ray scanner"
	desc = "A terahertz-ray emitter and scanner used to detect underfloor objects such as cables and pipes."
	icon_state = "t-scanner0"
	var/on = 0
	flags = FPRINT|ONBELT|TABLEPASS
	w_class = 2
	s_istate = "electronic"

/obj/item/weapon/locator
	name = "locator"
	icon_state = "locator"
	var/temp = null
	var/freq = 145.1
	var/broadcasting = null
	var/listening = 1.0
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "electronic"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/pinpointer
	name = "pinpointer"
	icon_state = "locator"
	var/temp = null
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "electronic"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/pipe
	name = "straight pipe"
	icon_state = "item_straight"
	icon = 'pipes.dmi'
	throw_speed = 2
	throw_range = 6
	s_istate = "pipe"
	w_class = 3.0
/obj/item/weapon/pipe/corner
	name = "corner pipe"
	icon_state = "item_corner"
/obj/item/weapon/pipe/he
	name = "heat exchange pipe"
	icon_state = "item_he"
/obj/item/weapon/pipe/he/corner
	name = "heat exchange corner pipe"
	icon_state = "item_he_corner"
/obj/item/weapon/pipe/manifold
	name = "Manifold"
	icon_state = "item_manifold"
/obj/item/weapon/pipe/connector
	name = "Connector"
	icon_state = "item_connector"
/obj/item/weapon/pipe/valve
	name = "Manual Valve"
	icon_state = "item_mvalve"
/obj/item/weapon/pipe/valve/digital
	name = "Digital Valve"
	icon_state = "item_dvalve"
/obj/item/weapon/pipe/vent
	name = "Vent"
	icon_state = "item_vent"
/obj/item/weapon/pipe/inlet
	name = "Inlet"
	icon_state = "item_inlet"
/obj/item/weapon/pipe/junction
	name = "Junction"
	icon_state = "item_junction"
/obj/item/weapon/pipe/filter
	name = "Filter"
	icon_state = "item_filter"
/obj/item/weapon/pipe/oneway
	name = "One-way pipe"
	icon_state = "item_oneway"
/obj/item/weapon/pipe/oneway/pump
	name = "Pump"
	icon_state = "item_pump"

/obj/item/weapon/m_pill
	name = "pill"
	icon_state = "pill"
	var/amount = 1.0
	var/s_time = 1.0
	w_class = 1.0
	s_istate = "pill"
	throw_speed = 4
	throw_range = 20
/obj/item/weapon/m_pill/Tourette
	name = "green pill"
	icon_state = "pill2"
/obj/item/weapon/m_pill/antitoxin
	name = "red/blue pill"
/obj/item/weapon/m_pill/cough
	name = "red pill"
	icon_state = "pill4"
/obj/item/weapon/m_pill/cyanide
	name = "orange pill"
	icon_state = "pill5"
/obj/item/weapon/m_pill/epilepsy
	name = "blue pill"
	icon_state = "pill3"
/obj/item/weapon/m_pill/sleep
	name = "red/blue pill"
/obj/item/weapon/m_pill/superpill
	name = "red/blue pill"
/obj/item/weapon/mop
	desc = "The world of janitalia wouldn't be complete without a mop."
	name = "mop"
	icon_state = "mop"
	var/wet = 0
	var/chloro = 0
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/shamwow
	desc = "Its like a towel, its like a chamois!"
	name = "shamwow"
	icon_state = "shamwow"
	s_istate = "shamwow"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/caution
	desc = "Caution! Wet Floor!"
	name = "wet floor sign"
	icon_state = "caution"
	force = 1.0
	throwforce = 3.0
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
/obj/item/weapon/ointment
	name = "ointment"
	icon_state = "ointment"
	var/amount = 5.0
	throw_speed = 4
	throw_range = 20
	w_class = 1.0
/obj/item/weapon/organ
	name = "organ"
	var/owner = null
	s_istate = "bio_orange"
/obj/item/weapon/organ/external
	name = "external"
	icon = 'human.dmi'
	var/d_i_state = ""
	var/brute_dam = 0.0
	var/burn_dam = 0.0
	var/max_damage = 0.0
	var/broken = 0.0
	var/r_name = "chest"
	var/wound_size = 0.0
	var/max_size = 0.0
	var/list/organs = list(  )
/obj/item/weapon/organ/external/chest
	name = "chest"
	icon_state = "chest"
	max_damage = 150.0
	d_i_state = "00"
/obj/item/weapon/organ/external/diaper
	name = "diaper"
	icon_state = "diaper"
	r_name = "diaper"
	max_damage = 115.0
	d_i_state = "00"
/obj/item/weapon/organ/external/head
	name = "head"
	icon_state = "head"
	r_name = "head"
	max_damage = 125.0
	d_i_state = "00"
/obj/item/weapon/organ/external/l_arm
	name = "l arm"
	icon_state = "l_arm"
	r_name = "l_arm"
	max_damage = 75.0
	d_i_state = "00"
/obj/item/weapon/organ/external/l_foot
	name = "l foot"
	icon_state = "l_foot"
	r_name = "l_foot"
	max_damage = 40.0
	d_i_state = "00"
/obj/item/weapon/organ/external/l_hand
	name = "l hand"
	icon_state = "l_hand"
	r_name = "l_hand"
	max_damage = 40.0
	d_i_state = "00"
/obj/item/weapon/organ/external/l_leg
	name = "l leg"
	icon_state = "l_leg"
	r_name = "l_leg"
	max_damage = 75.0
	d_i_state = "00"
/obj/item/weapon/organ/external/r_arm
	name = "r arm"
	icon_state = "r_arm"
	r_name = "r_arm"
	max_damage = 75.0
	d_i_state = "00"
/obj/item/weapon/organ/external/r_foot
	name = "r foot"
	icon_state = "r_foot"
	r_name = "r_foot"
	max_damage = 40.0
	d_i_state = "00"
/obj/item/weapon/organ/external/r_hand
	name = "r hand"
	icon_state = "r_hand"
	r_name = "r_hand"
	max_damage = 40.0
	d_i_state = "00"
/obj/item/weapon/organ/external/r_leg
	name = "r leg"
	icon_state = "r_leg"
	r_name = "r_leg"
	max_damage = 75.0
	d_i_state = "00"
/obj/item/weapon/organ/internal
	name = "internal"
	health = 100
/obj/item/weapon/organ/internal/blood_vessels
	name = "blood vessels"
	var/heart = null
	var/lungs = null
	var/kidneys = null
/obj/item/weapon/organ/internal/brain
	name = "brain"
	var/head = null
/obj/item/weapon/organ/internal/excretory
	name = "excretory"
	var/excretory = 7.0
	var/blood_vessels = null
/obj/item/weapon/organ/internal/heart
	name = "heart"
/obj/item/weapon/organ/internal/heart/artificial
	name = "artificial heart"
	health = 50
/obj/item/weapon/organ/internal/immune_system
	name = "immune system"
	var/blood_vessels = null
	var/isys = null
/obj/item/weapon/organ/internal/intestines
	name = "intestines"
	var/intestines = 3.0
	var/blood_vessels = null
/obj/item/weapon/organ/internal/liver
	name = "liver"
	var/intestines = null
	var/blood_vessels = null
/obj/item/weapon/organ/internal/lungs
	name = "lungs"
	var/lungs = 3.0
	var/throat = null
	var/blood_vessels = null
/obj/item/weapon/organ/internal/stomach
	name = "stomach"
	var/intestines = null
/obj/item/weapon/organ/internal/throat
	name = "throat"
	var/lungs = null
	var/stomach = null
/obj/item/weapon/paint
	name = "Paint Can"
	icon_state = "paint_neutral"
	var/color = "neutral"
	s_istate = "paintcan"
	w_class = 3.0
/obj/item/weapon/paper
	name = "Paper"
	icon_state = "paper"
	var/info = null
	w_class = 1.0
	throw_speed = 3
	throw_range = 15
///obj/item/weapon/paper/chaplain/
//	name = "paper- 'Internal Atmosphere Operating Instructions'"
//	info = "
/obj/item/weapon/paper/prototype/
	name = "paper- 'X86 Firebird Instruction Booklet'"
	info = "Congratulations on your purchase of the latest in space station engines, the X86 Firebird Plasma Reactor.  We here at NanoTrasen take pride in having the latest in plasma-based technologies, for the lowest prices in the galaxy.<br>The X86 Firebird comes with a revolutionary variable reactor module, allowing you produce the perfect amount of energy your station demands.  See Page 5 for instructions on how to use the variable reactor module system.<br>The X86 Firebird is designed with size in mind, so even your ministation can be equipped with this top-of-the-line reactor.  And it's so easy to run, even a child could do it!<br><br><b>---WARNING---</b><br>Please take note that there is an occasional chance of catastrophic reactor overload occuring spontaneously during operation.  Our top engineers are looking into the cause of this problem, but in the event that your reactor begines to go nova, exercize the following:<br>Step 1.  IMMEDIAT---<br>(The rest of the instructions are missing.  You feel a bit worried about that last part.)"
/obj/item/weapon/paper/Internal
	name = "paper- 'Internal Atmosphere Operating Instructions'"
	info = "Equipment:<BR>\n\t1+ Tank(s) with appropriate atmosphere<BR>\n\t1 Gas Mask w regulator (standard issue)<BR>\n<BR>\nProcedure:<BR>\n\t1. Wear mask<BR>\n\t2. Attach oxygen tank pipe to regulater (automatic))<BR>\n\t3. Set internal!<BR>\n<BR>\nNotes:<BR>\n\tDon't forget to stop internal when tank is low by<BR>\n\tremoving internal!<BR>\n<BR>\n\tDo not use a tank that has a high concentration of toxins.<BR>\n\tThe filters shut down on internal mode!<BR>\n<BR>\n\tWhen exiting a high danger environment it is advised<BR>\n\tthat you exit through a decontamination zone!<BR>\n<BR>\n\tRefill a tank at a oxygen canister by equiping the tank (Double Click)<BR>\n\tthen 'attacking' the canister (Double Click the canister)."
/obj/item/weapon/paper/Map
	name = "paper- 'Station Blueprint'"
	var/map_graphic = 'map.png'
	info = {"<IMG SRC="ss13mapd.png">
<BR>
CQ: Crew Quarters<BR>
L: Lounge<BR>
CH: Chapel<BR>
ENG: Engine Area<BR>
EC: Engine Control<BR>
ES: Engine Storage<BR>
GR: Generator Room<BR>
MB: Medical Bay<BR>
MR: Medical Research<BR>
TR: Toxin Research<BR>
TS: Toxin Storage<BR>
AC: Atmospheric Control<BR>
SEC: Security<BR>
SB: Shuttle Bay
SA: Shuttle Airlock<BR>
S: Storage<BR>
CR: Control Room<BR>
EV: EVA Storage<BR>
AE: Aux. Engine<BR>
P: Podbay<BR>
NA: North Airlock<BR>
SC: Solar Control<BR>
ASC: Aux. Solar Control<BR>
"}

/obj/item/weapon/paper/Toxin
	name = "paper- 'Chemical Information'"
	info = "Known Onboard Toxins:<BR>\n\tGrade A Semi-Liquid Plasma:<BR>\n\t\tHighly poisonous. You cannot sustain concentrations above 15 units.<BR>\n\t\tA gas mask fails to filter plasma after 50 units.<BR>\n\t\tWill attempt to diffuse like a gas.<BR>\n\t\tFiltered by scrubbers.<BR>\n\t\tThere is a bottled version which is very different<BR>\n\t\t\tfrom the version found in canisters!<BR>\n<BR>\n\t\tWARNING: Highly Flammable. Keep away from heat sources<BR>\n\t\texcept in a enclosed fire area!<BR>\n\t\tWARNING: It is a crime to use this without authorization.<BR>\nKnown Onboard Anti-Toxin:<BR>\n\tAnti-Toxin Type 01P: Works against Grade A Plasma.<BR>\n\t\tBest if injected directly into bloodstream.<BR>\n\t\tA full injection is in every regular Med-Kit.<BR>\n\t\tSpecial toxin Kits hold around 7.<BR>\n<BR>\nKnown Onboard Chemicals (other):<BR>\n\tRejuvenation T#001:<BR>\n\t\tEven 1 unit injected directly into the bloodstream<BR>\n\t\t\twill cure paralysis and sleep toxins.<BR>\n\t\tIf administered to a dying patient it will prevent<BR>\n\t\t\tfurther damage for about units*3 seconds.<BR>\n\t\t\tit will not cure them or allow them to be cured.<BR>\n\t\tIt can be administeredd to a non-dying patient<BR>\n\t\t\tbut the chemicals disappear just as fast.<BR>\n\tSleep Toxin T#054:<BR>\n\t\t5 units wilkl induce precisely 1 minute of sleep.<BR>\n\t\t\tThe effects are cumulative.<BR>\n\t\tWARNING: It is a crime to use this without authorization"
/obj/item/weapon/paper/Court
	name = "paper- 'A Crash Course in Legal SOP on SS13'"
	info = "<B>Roles:</B><BR>\nThe Forensic Technician is basically the investigator and prosecutor.<BR>\nThe Staff Assistant can perform these functions with written authority from the Forensic Technician.<BR>\nThe Captain/HoP/Warden is ct as the judicial authority.<BR>\nThe Security Officers are responsible for executing warrants, security during trial, and prisoner transport.<BR>\n<BR>\n<B>Investigative Phase:</B><BR>\nAfter the crime has been committed the Forensic Technician's job is to gather evidence and try to ascertain not only who did it but what happened. He must take special care to catalogue everything and don't leave anything out. Write out all the evidence on paper. Make sure you take an appropriate number of fingerprints. IF he must ask someone questions he has permission to confront them. If the person refuses he can ask a judicial authority to write a subpoena for questioning. If again he fails to respond then that person is to be jailed as insubordinate and obstructing justice. Said person will be released after he cooperates.<BR>\n<BR>\nONCE the FT has a clear idea as to who the criminal is he is to write an arrest warrant on the piece of paper. IT MUST LIST THE CHARGES. The FT is to then go to the judicial authority and explain a small version of his case. If the case is moderately acceptable the authority should sign it. Security must then execute said warrant.<BR>\n<BR>\n<B>Pre-Pre-Trial Phase:</B><BR>\nNow a legal representative must be presented to the defendant if said defendant requests one. That person and the defendant are then to be given time to meet (in the jail IS ACCEPTABLE). The defendant and his lawyer are then to be given a copy of all the evidence that will be presented at trial (rewriting it all on paper is fine). THIS IS CALLED THE DISCOVERY PACK. With a few exceptions, THIS IS THE ONLY EVIDENCE BOTH SIDES MAY USE AT TRIAL. IF the prosecution will be seeking the death penalty it MUST be stated at this time. ALSO if the defense will be seeking not guilty by mental defect it must state this at this time to allow ample time for examination.<BR>\nNow at this time each side is to compile a list of witnesses. By default, the defendant is on both lists regardless of anything else. Also the defense and prosecution can compile more evidence beforehand BUT in order for it to be used the evidence MUST also be given to the other side.\nThe defense has time to compile motions against some evidence here.<BR>\n<B>Possible Motions:</B><BR>\n1. <U>Invalidate Evidence-</U> Something with the evidence is wrong and the evidence is to be thrown out. This includes irrelevance or corrupt security.<BR>\n2. <U>Free Movement-</U> Basically the defendant is to be kept uncuffed before and during the trial.<BR>\n3. <U>Subpoena Witness-</U> If the defense presents god reasons for needing a witness but said person fails to cooperate then a subpoena is issued.<BR>\n4. <U>Drop the Charges-</U> Not enough evidence is there for a trial so the charges are to be dropped. The FT CAN RETRY but the judicial authority must carefully reexamine the new evidence.<BR>\n5. <U>Declare Incompetent-</U> Basically the defendant is insane. Once this is granted a medical official is to examine the patient. If he is indeed insane he is to be placed under care of the medical staff until he is deemed competent to stand trial.<BR>\n<BR>\nALL SIDES MOVE TO A COURTROOM<BR>\n<B>Pre-Trial Hearings:</B><BR>\nA judicial authority and the 2 sides are to meet in the trial room. NO ONE ELSE BESIDES A SECURITY DETAIL IS TO BE PRESENT. The defense submits a plea. If the plea is guilty then proceed directly to sentencing phase. Now the sides each present their motions to the judicial authority. He rules on them. Each side can debate each motion. Then the judicial authority gets a list of crew members. He first gets a chance to look at them all and pick out acceptable and available jurors. Those jurors are then called over. Each side can ask a few questions and dismiss jurors they find too biased. HOWEVER before dismissal the judicial authority MUST agree to the reasoning.<BR>\n<BR>\n<B>The Trial:</B><BR>\nThe trial has three phases.<BR>\n1. <B>Opening Arguments</B>- Each side can give a short speech. They may not present ANY evidence.<BR>\n2. <B>Witness Calling/Evidence Presentation</B>- The prosecution goes first and is able to call the witnesses on his approved list in any order. He can recall them if necessary. During the questioning the lawyer may use the evidence in the questions to help prove a point. After every witness the other side has a chance to cross-examine. After both sides are done questioning a witness the prosecution can present another or recall one (even the EXACT same one again!). After prosecution is done the defense can call witnesses. After the initial cases are presented both sides are free to call witnesses on either list.<BR>\nFINALLY once both sides are done calling witnesses we move onto the next phase.<BR>\n3. <B>Closing Arguments</B>- Same as opening.<BR>\nThe jury then deliberates IN PRIVATE. THEY MUST ALL AGREE on a verdict. REMEMBER: They mix between some charges being guilty and others not guilty (IE if you supposedly killed someone with a gun and you unfortunately picked up a gun without authorization then you CAN be found not guilty of murder BUT guilty of possession of illegal weaponry.). Once they have agreed they present their verdict. If unable to reach a verdict and feel they will never they call a deadlocked jury and we restart at Pre-Trial phase with an entirely new set of jurors.<BR>\n<BR>\n<B>Sentencing Phase:</B><BR>\nIf the death penalty was sought (you MUST have gone through a trial for death penalty) then skip to the second part. <BR>\nI. Each side can present more evidence/witnesses in any order. There is NO ban on emotional aspects or anything. The prosecution is to submit a suggested penalty. After all the sides are done then the judicial authority is to give a sentence.<BR>\nII. The jury stays and does the same thing as I. Their sole job is to determine if the death penalty is applicable. If NOT then the judge selects a sentence.<BR>\n<BR>\nTADA you're done. Security then executes the sentence and adds the applicable convictions to the person's record.<BR>\n"
/obj/item/weapon/paper/flag
	icon_state = "flag_neutral"
	s_istate = "paper"
	anchored = 1.0
/obj/item/weapon/paper/jobs
	name = "paper- 'Job Information'"
	info = "Information on all formal jobs that can be assigned on Space Station 13 can be found on this document.<BR>\nThe data will be in the following form.<BR>\nGenerally lower ranking positions come first in this list.<BR>\n<BR>\n<B>Job Name</B>   general access>lab access-engine access-systems access (atmosphere control)<BR>\n\tJob Description<BR>\nJob Duties (in no particular order)<BR>\nTips (where applicable)<BR>\n<BR>\n<B>Research Assistant</B> 1>1-0-0<BR>\n\tThis is probably the lowest level position. Anyone who enters the space station after the initial job\nassignment will automatically receive this position. Access with this is restricted. Head of Personnel should\nappropriate the correct level of assistance.<BR>\n1. Assist the researchers.<BR>\n2. Clean up the labs.<BR>\n3. Prepare materials.<BR>\n<BR>\n<B>Staff Assistant</B> 2>0-0-0<BR>\n\tThis position assists the security officer in his duties. The staff assisstants should primarily br\npatrolling the ship waiting until they are needed to maintain ship safety.\n(Addendum: Updated/Elevated Security Protocols admit issuing of low level weapons to security personnel)<BR>\n1. Patrol ship/Guard key areas<BR>\n2. Assist security officer<BR>\n3. Perform other security duties.<BR>\n<BR>\n<B>Technical Assistant</B> 1>0-0-1<BR>\n\tThis is yet another low level position. The technical assistant helps the engineer and the statian\ntechnician with the upkeep and maintenance of the station. This job is very important because it usually\ngets to be a heavy workload on station technician and these helpers will alleviate that.<BR>\n1. Assist Station technician and Engineers.<BR>\n2. Perform general maintenance of station.<BR>\n3. Prepare materials.<BR>\n<BR>\n<B>Medical Assistant</B> 1>1-0-0<BR>\n\tThis is the fourth position yet it is slightly less common. This position doesn't have much power\noutside of the med bay. Consider this position like a nurse who helps to upkeep medical records and the\nmaterials (filling syringes and checking vitals)<BR>\n1. Assist the medical personnel.<BR>\n2. Update medical files.<BR>\n3. Prepare materials for medical operations.<BR>\n<BR>\n<B>Research Technician</B> 2>3-0-0<BR>\n\tThis job is primarily a step up from research assistant. These people generally do not get their own lab\nbut are more hands on in the experimentation process. At this level they are permitted to work as consultants to\nthe others formally.<BR>\n1. Inform superiors of research.<BR>\n2. Perform research alongside of official researchers.<BR>\n<BR>\n<B>Forensic Technician</B> 3>2-0-0<BR>\n\tThis job is in most cases slightly boring at best. Their sole duty is to\nperform investigations of crine scenes and analysis of the crime scene. This\nalleviates SOME of the burden from the security officer. This person's duty\nis to draw conclusions as to what happened and testify in court. Said person\nalso should stroe the evidence safely.<BR>\n1. Perform crime-scene investigations/draw conclusions.<BR>\n2. Store and catalogue evidence properly.<BR>\n3. Testify to superiors/inquieries on findings.<BR>\n<BR>\n<B>Station Technician</B> 2>0-2-3<BR>\n\tPeople assigned to this position must work to make sure all the systems aboard Space Station 13 are operable.\nThey should primarily work in the computer lab and repairing faulty equipment. They should work with the\natmospheric technician.<BR>\n1. Maintain SS13 systems.<BR>\n2. Repair equipment.<BR>\n<BR>\n<B>Atmospheric Technician</B> 3>0-0-4<BR>\n\tThese people should primarily work in the atmospheric control center and lab. They have the very important\njob of maintaining the delicate atmosphere on SS13.<BR>\n1. Maintain atmosphere on SS13<BR>\n2. Research atmospheres on the space station. (safely please!)<BR>\n<BR>\n<B>Engineer</B> 2>1-3-0<BR>\n\tPeople working as this should generally have detailed knowledge as to how the propulsion systems on SS13\nwork. They are one of the few classes that have unrestricted access to the engine area.<BR>\n1. Upkeep the engine.<BR>\n2. Prevent fires in the engine.<BR>\n3. Maintain a safe orbit.<BR>\n<BR>\n<B>Medical Researcher</B> 2>5-0-0<BR>\n\tThis position may need a little clarification. Their duty is to make sure that all experiments are safe and\nto conduct experiments that may help to improve the station. They will be generally idle until a new laboratory\nis constructed.<BR>\n1. Make sure the station is kept safe.<BR>\n2. Research medical properties of materials studied of Space Station 13.<BR>\n<BR>\n<B>Toxin Researcher</B> 2>5-0-0<BR>\n\tThese people study the properties, particularly the toxic properties, of materials handled on SS13.\nTechnically they can also be called Plasma Technicians as plasma is the material they routinly handle.<BR>\n1. Research plasma<BR>\n2. Make sure all plasma is properly handled.<BR>\n<BR>\n<B>Medical Doctor (Officer)</B> 2>0-0-0<BR>\n\tPeople working this job should primarily stay in the medical area. They should make sure everyone goes to\nthe medical bay for treatment and examination. Also they should make sure that medical supplies are kept in\norder.<BR>\n1. Heal wounded people.<BR>\n2. Perform examinations of all personnel.<BR>\n3. Moniter usage of medical equipment.<BR>\n<BR>\n<B>Security Officer</B> 3>0-0-0<BR>\n\tThese people should attempt to keep the peace inside the station and make sure the station is kept safe. One\nside duty is to assist in repairing the station. They also work like general maintenance personnel. They are not\ngiven a weapon and must use their own resources.<BR>\n(Addendum: Updated/Elevated Security Protocols admit issuing of weapons to security personnel)<BR>\n1. Maintain order.<BR>\n2. Assist others.<BR>\n3. Repair structural problems.<BR>\n<BR>\n<B>Head of Research</B> 4>5-2-2<BR>\n\tPeople assigned as head of research should make sure all experiments are conducted efficiently. They should\nalso carefully moderate the usage of all equipment. All experiment results should be reported to this person.<BR>\n1. Moderate equipment.<BR>\n2. Process research results.<BR>\n3. Coordinate all research.<BR>\n<BR>\n<B>Head of Personnel</B> 4>4-2-2<BR>\n\tPeople assigned as head of personnel will find themselves moderating all actions done by personnel. Security\nshould report to them. Also they have the ability to assign jobs and access levels.<BR>\n1. Assign duties.<BR>\n2. Moderate personnel.<BR>\n3. Command Security.<BR>\n<BR>\n<B>Captain</B> 5>5-5-5 (unrestricted station wide access)<BR>\n\tThis is the highest position youi can aquire on Space Station 13. They are allowed anywhere inside the\nspace station and therefore should protect their ID card. They also have the ability to assign positions\nand access levels. They should not abuse their power.<BR>\n1. Assign all positions on SS13<BR>\n2. Inspect the station for any problems.<BR>\n3. Perform administrative duties.<BR>\n"
/obj/item/weapon/paper/photograph
	name = "photo"
	icon_state = "photo"
	var/photo_id = 0.0
	s_istate = "paper"
/obj/item/weapon/paper/conveyorsafety
	name = "Conveyor Safety Document"
	info = {"<B>Conveyor Safety is Everbody's Job!</B>
<HR>
Remember, always be sure to use conveyor belts safely!<ul>
<li>Never play around on a conveyor belt, even if it's off</li>
<li>Whenever you intend to start a conveyor, always be sure to sound an alarm at least twice, with two seconds between soundings<li>
<li>Never leave a conveyor running unattended!  Shut them off when not in use!  Save energy, and be safe!!!</li>
</ul><br><br><small>Paid for by the Bay City safety department.  Unauthorized use prohibited</small>"}
/obj/item/weapon/paper/sop
	name = "paper- 'Standard Operating Procedure'"
	info = "Alert Levels:<BR>\nBlue- Emergency<BR>\n\t1. Caused by fire<BR>\n\t2. Caused by manual interaction<BR>\n\tAction:<BR>\n\t\tClose all fire doors. These can only be opened by reseting the alarm<BR>\nRed- Ejection/Self Destruct<BR>\n\t1. Caused by module operating computer.<BR>\n\tAction:<BR>\n\t\tAfter the specified time the module will eject completely.<BR>\n<BR>\nEngine Maintenance Instructions:<BR>\n\tShut off ignition systems:<BR>\n\tActivate internal power<BR>\n\tActivate orbital balance matrix<BR>\n\tRemove volatile liquids from area<BR>\n\tWear a fire suit<BR>\n<BR>\n\tAfter<BR>\n\t\tDecontaminate<BR>\n\t\tVisit medical examiner<BR>\n<BR>\nToxin Laboratory Procedure:<BR>\n\tWear a gas mask regardless<BR>\n\tGet an oxygen tank.<BR>\n\tActivate internal atmosphere<BR>\n<BR>\n\tAfter<BR>\n\t\tDecontaminate<BR>\n\t\tVisit medical examiner<BR>\n<BR>\nDisaster Procedure:<BR>\n\tFire:<BR>\n\t\tActivate sector fire alarm.<BR>\n\t\tMove to a safe area.<BR>\n\t\tGet a fire suit<BR>\n\t\tAfter:<BR>\n\t\t\tAssess Damage<BR>\n\t\t\tRepair damages<BR>\n\t\t\tIf needed, Evacuate<BR>\n\tMeteor Shower:<BR>\n\t\tActivate fire alarm<BR>\n\t\tMove to the back of ship<BR>\n\t\tAfter<BR>\n\t\t\tRepair damage<BR>\n\t\t\tIf needed, Evacuate<BR>\n\tAccidental Reentry:<BR>\n\t\tActivate fire alrms in front of ship.<BR>\n\t\tMove volatile matter to a fire proof area!<BR>\n\t\tGet a fire suit.<BR>\n\t\tStay secure until an emergency ship arrives.<BR>\n<BR>\n\t\tIf ship does not arrive-<BR>\n\t\t\tEvacuate to a nearby safe area!"
/obj/item/weapon/paper/engine
	name = "paper- 'Generator Startup Procedure'"
	info = {"<B>Thermo-Electric Generator Startup Procedure for Mark I Plasma-Fired Engines</B>
<HR>
<i>Warning!</i> Improper engine and generator operation may cause exposure to hazardous gasses, extremes of heat and cold, and dangerous electrical voltages.<BR>
Only trained personnel should operate station systems. Follow all procedures carefully. Wear correct personal protective equipment at all times.<BR>
Refer to your supervisor or Head of Personnel for procedure updates and additional information.
<HR>
Standard checklist for engine and generator cold-start.<BR>
<ol>
<li>Perform visual inspection of external (cooling) and internal (heating) heat-exchange pipe loops.
Refer any breaks or cracks in the pipe to Station Maintenance for repair before continuing.
<li>Connect a CO<sub>2</sub> canister to the external (cooling) loop connector, and release the contents. Check loop pressurization is stable.<BR>
<i>Note:</i> Observe standard canister safety procedures.<BR>
<i>Note:</i> Other gasses may be substituted as a medium in the external (cooling) loop in the event that CO<sub>2</sub> is not available.
<li>Connect a CO<sub>2</sub> canister to the internal (heating) loop connector, and release the contents. Check loop pressurization is stable.<BR>
<i>Note:</i> Observe standard canister safety procedures.<BR>
<i>Note:</i> Nitrogen may be substituted as a medium in the internal (heating) loop in the event that CO<sub>2</sub> is not available.
<i>Do not use plasma in the internal (heating) pipe loop as an unsafe condition may result.</i>
<li>Using the thermo-electric generator (TEG) master control panel, engage the internal and external loop circulator pumps at 1% maximum rate.<BR>
<li>Ignite the engine. Refer to document NTRSN-113-H9-12939 for proper engine preparation, ignition, and plasma-oxygen loading procedures.<BR>
<i>Note:</i> Exceeding recommended plasma-oxygen concentrations can cause engine damage and potential hazards.
<li>Monitor engine temperatures until stable operation is achieved.
<li>Increase internal and external circulator pumps to 10% of maximum rate. Monitor the generated power output on the TEG control panel.<BR>
<i>Note:</i> Consult appendix A for expected electrical generation rates.
<li>Adjust circulator rates until required electrical demand is met.<BR>
<i>Note:</i> Generation rate varies with internal and external loop temperatures, exchange media pressure, and engine geometry. Refer to Appendix B or your supervisor for locally determined optimal settings.<BR>
<i>Note:</i> Do not exceed safety ratings for station power cabling and electrical equipment.
<li>With the power generation rate stable, engage charging of the superconducting magnetic energy storage (SMES) devices.
Total SMES charging rate should not exceed total power generation rate, or an overload condition may occur.
"}

/obj/item/weapon/paper_bin
	name = "Paper Bin"
	icon = 'stationobjs.dmi'
	icon_state = "paper_bin1"
	var/amount = 30.0
	s_istate = "sheet-metal"
	w_class = 5.0
/obj/item/weapon/pen
	desc = "It's a normal black ink pen."
	name = "pen"
	icon_state = "pen"
	flags = FPRINT|ONBELT|TABLEPASS
	w_class = 1.0
	throw_speed = 3
	throw_range = 15
/obj/item/weapon/pen/sleepypen
	desc = "It's a normal black ink pen with a sharp point."
	var/obj/substance/chemical/chem = null
/obj/item/weapon/pen/zombiepen
	desc = "It's a normal black ink pen with a sharp point."
	var/used = 0
/obj/item/weapon/pen/antizombiepen
	desc = "It's a normal black ink pen with a sharp point."
	var/used = 0
/obj/item/weapon/pill_canister
	name = "Pill Canister"
	icon_state = "pill_canister"
	w_class = 1.0
	s_istate = "brutepack"
/obj/item/weapon/pill_canister/Tourette
	desc = "<B>Tourette's Syndrome Remedy</B>\nAdminister as required to surpress Tourette syndrome induced twitching.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>WARNING</B>: Neurodepressant! Rebalances chemical alignment!\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
	name = "Pill Canister- 'Tourette's Syndrome Remedy'"
/obj/item/weapon/pill_canister/Fever
	desc = "<B>Fever Remedy</B>\nAdminister as required to surpress and/or cure the Space Fever Virus.\nAdminister only once every 5 minutes.\nIf the disease persists after the effect of this medicine wears off, repeat treatment."
	name = "Pill Canister- 'Fever Remedy'"
/obj/item/weapon/pill_canister/antitoxin
	desc = "<B>Anti-toxins</B>\nAdminister as required to relieve of plasma burns.\nAdminister only once every 5 minutes.\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
	name = "Pill Canister- 'Antitoxin Supplements'"
/obj/item/weapon/pill_canister/cough
	desc = "<B>Chronic Cough Syndrome Remedy</B>\nAdminister as required to surpress excessive coughs.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
	name = "Pill Canister- 'CCS Remedy'"
/obj/item/weapon/pill_canister/epilepsy
	desc = "<B>Epilepsy Remedy</B>\nAdminister as required to surpress excessive coughs.\nAdminister only once every 15 minutes. Active for 20 at most.\n<B>WARNING</B>: Neurodepressant! Rebalances chemcial alignment!\n<B>Warning</B>: May cause drowsyness.\nIf drowsyness persists for over 5 minutes contact medical professional."
	name = "Pill Canister- 'Epilepsy Remedy'"
/obj/item/weapon/pill_canister/placebo
	desc = "<B>Placebos</B>\nThese pills do nothing phsyiologically."
	name = "Pill Canister- 'Placebos'"
/obj/item/weapon/pill_canister/sleep
	desc = "<B>Sleeping Pills</B>\nAdminister as required to calm person.\nCauses 10 minutes of drowsyness. MAY induce immediate sleep.\n<B>WARNING</B>: Neurodepressant! Do not overdose!\n<B>Warning</B>: Causes drowsiness!If drowsyness persists for over 15 minutes contact medical professional."
	name = "Pill Canister- 'Sleeping Pills'"
/obj/item/weapon/prox_sensor
	name = "Proximity Sensor"
	icon_state = "motion0"
	var/state = 0.0
	var/timing = 0.0
	var/time = null
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "electronic"
/obj/item/weapon/rack_parts
	name = "rack parts"
	icon_state = "rack_parts"
	flags = FPRINT|TABLEPASS
/obj/item/weapon/radio
	name = "Station Bounced Radio"
	suffix = "\[3\]"
	icon_state = "radio"
	var/last_transmission
	var/freq = 145.9
	var/traitorfreq = 0.0
	var/obj/item/weapon/radio/patch_link = null
	var/obj/item/weapon/syndicate_uplink/traitorradio = null
	var/wires = 7.0
//					1				2				4
//	var/wires = WIRE_SIGNAL | WIRE_RECEIVE | WIRE_TRANSMIT
	var/b_stat = 0.0
	var/broadcasting = null
	var/listening = 1.0
	flags = FPRINT|TABLEPASS|ONBELT
	throw_speed = 2
	throw_range = 9
	w_class = 2.0
	s_istate = "radio"
	var/const
		WIRE_SIGNAL = 1 //sends a signal, like to set off a bomb or electrocute someone
		WIRE_RECEIVE = 2
		WIRE_TRANSMIT = 4
		TRANSMISSION_DELAY = 5 // only 2/second/radio

/obj/item/weapon/radio/beacon
	name = "Tracking Beacon"
	icon_state = "beacon"
	s_istate = "signaler"
	var/code = "electronic"
/obj/item/weapon/radio/electropack
	name = "Electropack"
	icon_state = "electropack0"
	var/code = 2.0
	var/on = 0.0
	var/e_pads = 0.0
	freq = 144.9
	w_class = 5.0
	flags = FPRINT|TABLEPASS|ONBACK
	s_istate = "electropack"
/obj/item/weapon/radio/headset
	name = "Radio Headset"
	icon_state = "headset"
	s_istate = "headset"
/obj/item/weapon/radio/intercom
	name = "Station Intercom (Radio)"
	icon_state = "intercom"
	anchored = 1.0
	var/number = 0
/obj/item/weapon/radio/signaler
	name = "Remote Signaling Device"
	icon_state = "signaler"
	s_istate = "signaler"
	var/code = 30.0
	w_class = 1.0
	freq = 145.7
	var/delay = 0
	var/airlock_wire = null
/obj/item/weapon/rods
	name = "rods"
	icon_state = "rods"
	var/amount = 1.0
	flags = FPRINT|TABLEPASS
	w_class = 4.0
	force = 9.0
	throwforce = 20.0
	throw_speed = 2
	throw_range = 10
/obj/item/weapon/screwdriver
	name = "screwdriver"
	icon_state = "screwdriver"
	flags = FPRINT|TABLEPASS
	force = 5.0
	w_class = 2.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5
/obj/item/weapon/shard
	name = "shard"
	icon = 'shards.dmi'
	icon_state = "large"
	w_class = 4.0
	force = 7.0
	throwforce = 10.0
	s_istate = "shard-glass"
/obj/item/weapon/sheet
	name = "sheet"
	var/amount = 1.0
	var/length = 2.5
	var/width = 1.5
	var/height = 0.01
	flags = FPRINT|TABLEPASS
	throwforce = 7.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
/obj/item/weapon/sheet/glass
	name = "glass"
	icon_state = "sheet-glass"
	force = 5.0
/obj/item/weapon/sheet/rglass
	name = "reinforced glass"
	icon_state = "sheet-rglass"
	s_istate = "sheet-rglass"
	force = 6.0
/obj/item/weapon/sheet/metal
	name = "metal"
	icon_state = "sheet-metal"
	throwforce = 14.0
/obj/item/weapon/sheet/metalplate
	name = "metal"
	icon_state = "sheet-metal"
	throwforce = 14.0
/obj/item/weapon/sheet/r_metal
	name = "reinforced metal"
	icon_state = "sheet-r_metal"
	force = 5.0
	throwforce = 14.0
	s_istate = "sheet-metal"
/obj/item/weapon/shield
	name = "shield"
	icon_state = "shield0"
	var/active = 0.0
	flags = FPRINT|TABLEPASS
	s_istate = "electronic"
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/staff
	name = "wizards staff"
	icon_state = "staff"
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	flags = FPRINT|NOSHIELD|TABLEPASS
/obj/item/weapon/storage
	name = "storage"
	var/obj/screen/storage/boxes = null
	var/obj/screen/close/closer = null
	w_class = 3.0
/obj/item/weapon/storage/backpack
	name = "backpack"
	icon_state = "backpack"
	w_class = 4.0
	flags = FPRINT|ONBACK|TABLEPASS
/obj/item/weapon/storage/box
	name = "Box"
	icon_state = "box"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/disk_kit
	name = "Data Disks"
	icon_state = "id_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/injectbox
	name = "DNA-Injectors"
	icon_state = "box"
	s_istate = "syringe_kit"

/obj/item/weapon/storage/disk_kit/disks

/obj/item/weapon/storage/disk_kit/disks2

/obj/item/weapon/storage/fcard_kit
	name = "Fingerprint Cards"
	icon_state = "id_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/firstaid
	name = "First-Aid"
	throw_speed = 2
	throw_range = 8
/obj/item/weapon/storage/firstaid/fire
	name = "Fire First Aid"
	icon_state = "firstaid-ointment"
/obj/item/weapon/storage/firstaid/regular
	icon_state = "firstaid"
/obj/item/weapon/storage/firstaid/syringes
	name = "Syringes (Biohazard Alert)"
	icon_state = "syringe_kit"
/obj/item/weapon/storage/firstaid/toxin
	name = "Toxin First Aid"
	icon_state = "firstaid-toxin"
/obj/item/weapon/storage/flashbang_kit
	desc = "<FONT color=red><B>WARNING: Do not use without reading these preautions!</B></FONT>\n<B>These devices are extremely dangerous and can cause blindness or deafness if used incorrectly.</B>\nThe chemicals contained in these devices have been tuned for maximal effectiveness and due to\nextreme safety precuaiotn shave been incased in a tamper-proof pack. DO NOT ATTEMPT TO OPEN\nFLASH WARNING: Do not use continually. Excercise extreme care when detonating in closed spaces.\n\tMake attemtps not to detonate withing range of 2 meters of the intended target. It is imperative\n\tthat the targets visit a medical professional after usage. Damage to eyes increases extremely per\n\tuse and according to range. Glasses with flash resistant filters DO NOT always work on high powered\n\tflash devices such as this. <B>EXERCISE CAUTION REGARDLESS OF CIRCUMSTANCES</B>\nSOUND WARNING: Do not use continually. Visit a medical professional if hearing is lost.\n\tThere is a slight chance per use of complete deafness. Exercise caution and restraint.\nSTUN WARNING: If the intended or unintended target is too close to detonation the resulting sound\n\tand flash have been known to cause extreme sensory overload resulting in temporary\n\tincapacitation.\n<B>DO NOT USE CONTINUALLY</B>\nOperating Directions:\n\t1. Pull detonnation pin. <B>ONCE THE PIN IS PULLED THE GRENADE CAN NOT BE DISARMED!</B>\n\t2. Throw grenade. <B>NEVER HOLD A LIVE FLASHBANG</B>\n\t3. The grenade will detonste 10 seconds hafter being primed. <B>EXCERCISE CAUTION</B>\n\t-<B>Never prime another grenade until after the first is detonated</B>\nNote: Usage of this pyrotechnic device without authorization is an extreme offense and can\nresult in severe punishment upwards of <B>10 years in prison per use</B>.\n\nDefault 3 second wait till from prime to detonation. This can be switched with a screwdriver\nto 10 seconds.\n\nCopyright of Nanotrasen Industries- Military Armnaments Division\nThis device was created by Nanotrasen Labs a member of the Expert Advisor Corporation"
	name = "Flashbangs (WARNING)"
	icon_state = "flashbang_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/gl_kit
	name = "Prescription Glasses"
	icon_state = "id_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/handcuff_kit
	name = "Spare Handcuffs"
	icon_state = "handcuff_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/id_kit
	name = "Spare IDs"
	icon_state = "id_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/lglo_kit
	name = "Latex Gloves"
	icon_state = "lglo_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/stma_kit
	name = "Sterile Masks"
	icon_state = "lglo_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/storage/toolbox
	name = "toolbox"
	icon_state = "toolbox"
	flags = FPRINT|TABLEPASS
	force = 8.0
	throw_speed = 1
	throw_range = 4
	w_class = 4.0
/obj/item/weapon/storage/toolbox/electrical
	name = "electrical toolbox"
	icon_state = "toolbox-y"
	flags = FPRINT|TABLEPASS
	force = 8.0
	w_class = 4.0

/obj/item/weapon/storage/trackimp_kit
	name = "Tracking Implant Kit"
	icon_state = "imp_kit"
	s_istate = "syringe_kit"
/obj/item/weapon/sword
	name = "energy sword"
	icon_state = "sword0"
	var/active = 0.0
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
	flags = FPRINT|NOSHIELD|TABLEPASS

/obj/item/weapon/syndicate_uplink
	name = "Station Bounced Radio"
	icon_state = "radio"
	var/temp = null
	var/uses = 3.0
	var/selfdestruct = 0.0
	var/traitorfreq = 0.0
	var/obj/item/weapon/radio/origradio = null
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "radio"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/centcom_uplink
	name = "Station Bounced Radio"
	icon_state = "radio"
	var/temp = null
	var/selfdestruct = 0.0
	var/uses = 3.0
	var/firing = 0
	var/traitorfreq = 0.0
	var/obj/item/weapon/radio/origradio = null
	var/setup = 0
	var/stage = 1
	var/objective = 0
	var/mob/human/target
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "radio"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/SWF_uplink
	name = "Station Bounced Radio"
	icon_state = "radio"
	var/temp = null
	var/uses = 4.0
	var/selfdestruct = 0.0
	var/traitorfreq = 0.0
	var/obj/item/weapon/radio/origradio = null
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "radio"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/syringe
	name = "syringe"
	icon_state = "syringe_0"
	var/obj/substance/chemical/chem = null
	var/mode = "inject"
	var/s_time = 1.0
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
/obj/item/weapon/dnainjector
	name = "DNA-Injector"
	icon_state = "dnainjector"
	var/dnatype = null
	var/dna = null
	var/block = null
	var/owner = null
	var/ue = null
	var/s_time = 10.0
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	var/uses = 1
/obj/item/weapon/dnainjector/antihulk
	name = "DNA-Injector (Anti-Hulk)"
	dnatype = "se"
	dna = "708"
	block = 2
/obj/item/weapon/dnainjector/hulkmut
	name = "DNA-Injector (Hulk)"
	dnatype = "se"
	dna = "FED"
	block = 2
/obj/item/weapon/dnainjector/airmut
	name = "DNA-Injector (Air)"
	dnatype = "se"
	dna = "FED"
	block = 3
/obj/item/weapon/dnainjector/antiair
	name = "DNA-Injector (Anti-Air)"
	dnatype = "se"
	dna = "F08"
	block = 3
/obj/item/weapon/dnainjector/xraymut
	name = "DNA-Injector (Xray)"
	dnatype = "se"
	dna = "FED"
	block = 8
/obj/item/weapon/dnainjector/antixray
	name = "DNA-Injector (Anti-Xray)"
	dnatype = "se"
	dna = "708"
	block = 8
/////////////////////////////////////
/obj/item/weapon/dnainjector/antiglasses
	name = "DNA-Injector (Anti-Glasses)"
	dnatype = "se"
	dna = "708"
	block = 1
/obj/item/weapon/dnainjector/glassesmut
	name = "DNA-Injector (Glasses)"
	dnatype = "se"
	dna = "BD6"
	block = 1
/obj/item/weapon/dnainjector/epimut
	name = "DNA-Injector (Epi.)"
	dnatype = "se"
	dna = "FA0"
	block = 3
/obj/item/weapon/dnainjector/antiepi
	name = "DNA-Injector (Anti-Epi.)"
	dnatype = "se"
	dna = "708"
	block = 3
////////////////////////////////////
/obj/item/weapon/dnainjector/anticough
	name = "DNA-Injector (Anti-Cough)"
	dnatype = "se"
	dna = "708"
	block = 5
/obj/item/weapon/dnainjector/coughmut
	name = "DNA-Injector (Cough)"
	dnatype = "se"
	dna = "BD6"
	block = 5
/obj/item/weapon/dnainjector/clumsymut
	name = "DNA-Injector (Clumsy)"
	dnatype = "se"
	dna = "FA0"
	block = 6
/obj/item/weapon/dnainjector/anticlumsy
	name = "DNA-Injector (Anti-Clumy)"
	dnatype = "se"
	dna = "708"
	block = 6
/obj/item/weapon/dnainjector/antitour
	name = "DNA-Injector (Anti-Tour.)"
	dnatype = "se"
	dna = "708"
	block = 7
/obj/item/weapon/dnainjector/tourmut
	name = "DNA-Injector (Tour.)"
	dnatype = "se"
	dna = "BD6"
	block = 7
/obj/item/weapon/dnainjector/stuttmut
	name = "DNA-Injector (Stutt.)"
	dnatype = "se"
	dna = "FA0"
	block = 9
/obj/item/weapon/dnainjector/antistutt
	name = "DNA-Injector (Anti-Stutt.)"
	dnatype = "se"
	dna = "708"
	block = 9
/obj/item/weapon/dnainjector/antifire
	name = "DNA-Injector (Anti-Fire)"
	dnatype = "se"
	dna = "708"
	block = 10
/obj/item/weapon/dnainjector/firemut
	name = "DNA-Injector (Fire)"
	dnatype = "se"
	dna = "FED"
	block = 10
/obj/item/weapon/dnainjector/blindmut
	name = "DNA-Injector (Blind)"
	dnatype = "se"
	dna = "FA0"
	block = 11
/obj/item/weapon/dnainjector/antiblind
	name = "DNA-Injector (Anti-Blind)"
	dnatype = "se"
	dna = "708"
	block = 11
/obj/item/weapon/dnainjector/antitele
	name = "DNA-Injector (Anti-Tele.)"
	dnatype = "se"
	dna = "708"
	block = 12
/obj/item/weapon/dnainjector/telemut
	name = "DNA-Injector (Tele.)"
	dnatype = "se"
	dna = "FED"
	block = 12
/obj/item/weapon/dnainjector/deafmut
	name = "DNA-Injector (Deaf)"
	dnatype = "se"
	dna = "FA0"
	block = 13
/obj/item/weapon/dnainjector/antideaf
	name = "DNA-Injector (Anti-Deaf)"
	dnatype = "se"
	dna = "708"
	block = 13
/obj/item/weapon/dnainjector/h2m
	name = "DNA-Injector (Human > Monkey)"
	dnatype = "se"
	dna = "FA0"
	block = 14
/obj/item/weapon/dnainjector/m2h
	name = "DNA-Injector (Monkey > Human)"
	dnatype = "se"
	dna = "708"
	block = 14
/obj/item/weapon/table_parts
	name = "table parts"
	icon_state = "table_parts"
	flags = FPRINT|TABLEPASS
/obj/item/weapon/tank
	name = "tank"
	var/maximum = null
	var/obj/substance/gas/gas = null
	var/i_used = 100
	flags = FPRINT|ONBACK|TABLEPASS
	weight = 1000000.0
	force = 5.0
	throwforce = 10.0
	throw_speed = 1
	throw_range = 4
/obj/item/weapon/tank/anesthetic
	name = "anesthetic"
	icon_state = "an_tank"
	maximum = 1750000.0
	i_used = 250.0
/obj/item/weapon/tank/jetpack
	name = "jetpack"
	icon_state = "jetpack0"
	var/on = 0.0
	maximum = 300000
	w_class = 4.0
	s_istate = "jetpack"
/obj/item/weapon/tank/oxygentank
	name = "oxygentank"
	icon_state = "oxygen"
	maximum = 600000
/obj/item/weapon/tank/plasmatank
	name = "plasmatank"
	icon_state = "plasma"
	maximum = 1600000.0


/obj/item/weapon/tile
	name = "steel floor tile"
	icon_state = "tile"
	var/amount = 1.0
	w_class = 3.0
	throw_speed = 1
	throw_range = 5
	force = 6.0
	throwforce = 7.0
/obj/item/weapon/timer
	name = "timer"
	icon_state = "timer0"
	var/timing = 0.0
	var/time = null
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "electronic"

/obj/item/weapon/teleportation_scroll
	name = "Teleportation Scroll"
	icon_state = "paper"
	var/uses = 4.0
	flags = FPRINT|TABLEPASS
	w_class = 2.0
	s_istate = "paper"
	throw_speed = 4
	throw_range = 20

/obj/item/weapon/weldingtool
	name = "weldingtool"
	icon_state = "welder"
	var/welding = 0.0
	var/weldfuel = 20.0
	var/status = 0	//flamethrower construction :shobon:
	flags = FPRINT|TABLEPASS
	force = 3.0
	throwforce = 5.0
	throw_speed = 1
	throw_range = 5
	w_class = 2.0
/obj/item/weapon/wire
	desc = "This is just a simple piece of regular insulated wire."
	name = "wire"
	icon_state = "item_wire"
	var/amount = 1.0
	var/laying = 0.0
	var/old_lay = null
/obj/item/weapon/wirecutters
	name = "wirecutters"
	icon_state = "cutters"
	flags = FPRINT|TABLEPASS
	force = 6.0
	throw_speed = 2
	throw_range = 9
	w_class = 2.0
/obj/item/weapon/wrapping_paper
	name = "wrapping paper"
	icon_state = "wrap_paper"
	var/amount = 20.0
/obj/item/weapon/wrench
	name = "Wrench"
	icon_state = "wrench"
	flags = FPRINT|TABLEPASS
	force = 5.0
	throwforce = 7.0
	w_class = 2.0

/obj/item/weapon/cell
	name = "power cell"
	desc = "A rechargable electrochemical power cell."
	icon = 'power.dmi'
	icon_state = "cell"
	s_istate = "cell"
	flags = FPRINT|TABLEPASS
	force = 10.0
	throwforce = 2.0
	throw_speed = 1
	throw_range = 1
	w_class = 2.0
	weight = 100000
	var/charge = 0	// note %age conveted to actual charge in New
	var/maxcharge = 1000
	var/buildstate = 0

/obj/item/weapon/circuitry
	name = "circuitry"
	desc = "Some circuitry used in airlocks."
	icon_state = "circuitry"
	flags = FPRINT|TABLEPASS
	force = 5.0
	w_class = 2.0
	throwforce = 5.0
	throw_speed = 3
	throw_range = 5

/obj/landmark
	name = "landmark"
	icon = 'screen1.dmi'
	icon_state = "x2"
	anchored = 1.0
/obj/landmark/alterations
	name = "alterations"

/obj/laser
	name = "laser"
	icon = 'weap_sat.dmi'
	var/damage = 0.0
	var/range = 10.0

/obj/lattice
	desc = "A lightweight support lattice."
	name = "lattice"
	icon = 'turfs2.dmi'
	icon_state = "lattice"
	density = 0
	anchored = 1.0
	layer = 2.5

/obj/list_container
	name = "list container"
/obj/list_container/mobl
	name = "mobl"
	var/master = null

	var/list/container = list(  )

/obj/m_tray
	name = "morgue tray"
	icon = 'stationobjs.dmi'
	icon_state = "morguet"
	density = 1
	layer = 2.0
	var/obj/morgue/connected = null
	anchored = 1.0


/obj/machinery
	name = "machinery"
	var/p_dir = 0
	var/h_dir = 0		// used for heat-exchange
	var/capmult = 0
	var/stat = 0
	var/cnetnum = 0
	var/cnetdontadd = 0
	var/datum/computernet/computernet = null
	var/uniqueid = null
	var/directwiredCnet = 1
	var/computerID = 0
	var/typeID = null
	var/netID = 0
	var/sniffer = 0
	var/ailabel = ""
	var/list/mob/ai/ais = list()
	var/nohack = 0

/obj/machinery/alarm
	name = "alarm"
	icon = 'stationobjs.dmi'
	icon_state = "alarm:0"
	anchored = 1.0
	var/old_safe = - 1 // used to avoid broadcasting the alarm's state when nothng changed
	layer = 3.1

/obj/machinery/alarm/indicator
	name = "indicator"
	icon = 'airtunnel.dmi'
	icon_state = "indicator"

/obj/machinery/at_indicator
	name = "Air Tunnel Indicator"
	icon = 'airtunnel.dmi'
	icon_state = "reader00"
	anchored = 1.0
/obj/machinery/atmoalter
	name = "atmoalter"
	var/obj/substance/gas/gas = null
	var/maximum
	var/t_status
	var/t_per
	var/c_per
	var/c_status
	var/obj/item/weapon/tank/holding
	var/max_valve = 1e6
/obj/machinery/atmoalter/canister
	name = "canister"
	icon = 'canister.dmi'
	density = 1
	maximum = 1.3E8
	var/color = "blue"
	t_status = 3.0
	t_per = 50.0
	c_per = 50.0
	c_status = 0.0
	holding = null
	var/health = 20.0
	var/destroyed = null
	flags = FPRINT
	weight = 1.0E7
	var/filled = 1		//fractional fullness at spawn
/obj/machinery/atmoalter/canister/anesthcanister
	name = "Canister: \[N2O\]"
	icon_state = "redws"
	color = "redws"
/obj/machinery/atmoalter/canister/n2canister
	name = "Canister: \[N2\]"
	icon_state = "red"
	color = "red"
/obj/machinery/atmoalter/canister/oxygencanister
	name = "Canister: \[O2\]"
	icon_state = "blue"
/obj/machinery/atmoalter/canister/poisoncanister
	name = "Canister \[Plasma (Bio)\]"
	icon_state = "orange"
	color = "orange"
	flags = FPRINT | PLASMAGUARD
/obj/machinery/atmoalter/canister/co2canister
	name = "Canister \[CO2\]"
	icon_state = "black"
	color = "black"
/obj/machinery/atmoalter/canister/aircanister
	name = "Canister \[Air\]"
	icon_state = "grey"
	color = "grey"
/obj/machinery/atmoalter/canister/vat // Just a huge immobile canister to make life aboard ss13 easyer.
	maximum = 5040000000
	var/confirmed = 0
/obj/machinery/atmoalter/canister/vat/plasmavat
	name = "Vat \[Plasma (bio)\]"
	icon_state = "vatorange"
	color = "vatorange"
	flags = FPRINT | PLASMAGUARD
/obj/machinery/atmoalter/canister/vat/oxygenvat
	name = "Vat O2"
	icon_state = "vatblue"
	color = "vatblue" // thats totally a existing color right?




/obj/machinery/atmoalter/canister/emptycanister
	name = "Canister \[Custom\]"
	icon_state = "violet"
	color = "violet"
	filled = 0

/obj/machinery/atmoalter/heater
	name = "heater"
	icon = 'stationobjs.dmi'
	icon_state = "heater1"
	density = 1
	maximum = 1.3E8
	t_status = 3.0
	var/h_status = 0.0
	t_per = 50.0
	var/h_tar = 20.0
	c_per = 50.0
	c_status = 0.0
	holding = null
	anchored = 1.0
	var/heatrate = 1500000.0
	flags = FPRINT | PLASMAGUARD
/obj/machinery/atmoalter/siphs
	name = "siphs"
	density = 1
	var/alterable = 1.0
	var/f_time = 1.0
	var/location = null
	maximum = 1.3E8
	holding = null
	t_status = 3.0
	t_per = 50.0
	c_per = 50.0
	c_status = 0.0
	weight = 1.0E7
	anchored = 1.0
	var/empty =  null
/obj/machinery/atmoalter/siphs/fullairsiphon
	name = "Air Siphon"
	icon = 'turfs.dmi'
	icon_state = "siphon:0"
/obj/machinery/atmoalter/siphs/fullairsiphon/halfairsiphon
	name = "Airlock Siphon"
/obj/machinery/atmoalter/siphs/fullairsiphon/halfairsiphon/airlock_vent
	name = "Airlock Regulator"
	icon_state = "wmsiphon:0"
	alterable = 0.0
	density = 0	//*****
/obj/machinery/atmoalter/siphs/fullairsiphon/air_vent
	name = "Air regulator"
	icon = 'aircontrol.dmi'
	layer = 2.7
	icon_state = "vent2"
	t_status = 4.0
	alterable = 0.0
	density = 0	//*****
/obj/machinery/atmoalter/siphs/fullairsiphon/port
	name = "Portable Air Regulator"
	icon = 'stationobjs.dmi'
	flags = FPRINT
	anchored = 0.0
/obj/machinery/atmoalter/siphs/scrubbers
	name = "Scrubber"
	icon = 'turfs2.dmi'
	icon_state = "siphon:0"
	flags = FPRINT | PLASMAGUARD
/obj/machinery/atmoalter/siphs/scrubbers/air_filter
	name = "Air Filter"
	icon = 'aircontrol.dmi'
	icon_state = "vent2"
	t_status = 4.0
	alterable = 0.0
	layer = 2.7
	density = 0 //*****
	flags = FPRINT | PLASMAGUARD

/obj/machinery/atmoalter/siphs/scrubbers/port
	name = "Portable Scrubber"
	icon = 'stationobjs.dmi'
	icon_state = "scrubber:0"
	flags = FPRINT | PLASMAGUARD
	anchored = 0.0
/obj/machinery/autolathe
	name = "Autolathe"
	icon = 'stationobjs.dmi'
	icon_state = "autolathe"
	density = 1
	var/m_amount = 0.0
	var/g_amount = 0.0
	var/operating = 0.0
	var/opened = 0.0
	var/temp = null
	anchored = 1.0
/obj/machinery/camera
	name = "Security Camera"
	icon = 'stationobjs.dmi'
	icon_state = "camera"
	var/network = "SS13"
	var/c_tag = null
	var/c_tag_order = 999
	var/status = 1.0
	anchored = 1.0
	var/invuln = null

/obj/machinery/circulator
	name = "circulator/heat exchanger"
	desc = "A gas circulator pump and heat exchanger."
	icon = 'pipes.dmi'
	icon_state = "circ1-off"
	p_dir = 3		// N & S
	var/side = 1 // 1=left 2=right
	var/status = 0
	var/rate = 1000000
	var/obj/substance/gas/gas1 = null
	var/obj/substance/gas/ngas1 = null
	var/obj/substance/gas/gas2 = null
	var/obj/substance/gas/ngas2 = null

	var/capacity = 6000000.0
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null

	var/obj/machinery/vnode1
	var/obj/machinery/vnode2

	anchored = 1.0
	density = 1
	capmult = 1

	//var/obj/machinery/power/teg/master = null

/obj/machinery/computer
	name = "computer"
	icon = 'computers.dmi'
	density = 1
	anchored = 1.0
	var/buildstate = 6
	var/hasdisk = 0
	luminosity = 2

/obj/machinery/computer/frame
	name = "Computer Frame"
	density = 1
	anchored = 0
	buildstate = 0
	icon_state = "frame"
/obj/machinery/computer/airtunnel
	name = "Air Tunnel Control"
	icon = 'airtunnelcomputer.dmi'
	icon_state = "console00"
/obj/machinery/computer/aiupload
	name = "AI Upload"
	icon_state = "upload"
	hasdisk = 1
/obj/machinery/computer/atmosphere
	name = "atmosphere"
/obj/machinery/computer/atmosphere/siphonswitch
	name = "Area Air Control"
	icon_state = "siphonswitch"
	var/otherarea
	var/area/area
/obj/machinery/computer/atmosphere/siphonswitch/mastersiphonswitch
	name = "Master Air Control"
/obj/machinery/computer/card
	name = "Identification Computer"
	icon_state = "idcard"
	var/obj/item/weapon/card/id/scan = null
	var/obj/item/weapon/card/id/modify = null
	var/authenticated = 0.0
	var/mode = 0.0
	var/printing = null
	hasdisk = 1
	req_access = list(access_change_ids)
/obj/machinery/computer/networksniffer
	name = "Network Monitor"
	icon_state = "networksniffer"
	var/list/packets = list()
	req_access = list(access_network)
	sniffer = 1
/obj/machinery/computer/communications
	name = "Communications Console"
	icon_state = "comm"
	req_access = list(access_bridge)
	var/prints_intercept = 1
	var/authenticated = 0
	var/list/messagetitle = list()
	var/list/messagetext = list()
	var/currmsg = 0
	var/aicurrmsg = 0
	var/state = STATE_DEFAULT
	var/aistate = STATE_DEFAULT
	var/traitorused = 0
	var/const
		STATE_DEFAULT = 1
		STATE_CALLSHUTTLE = 2
		STATE_CANCELSHUTTLE = 3
		STATE_MESSAGELIST = 4
		STATE_VIEWMESSAGE = 5
		STATE_DELMESSAGE = 6
/obj/machinery/computer/supply
	name = "Supply Shuttle Console"
	icon_state = "supply"
	req_access = list(access_supply_shuttle)

/obj/machinery/computer/data
	name = "data"
	icon_state = "records"
	hasdisk = 1

	var/list/topics = list(  )

/obj/machinery/computer/data/weapon
	name = "weapon"
/obj/machinery/computer/data/weapon/info
	name = "Research Computer"
/obj/machinery/computer/data/weapon/log
	name = "Log Computer"
/obj/machinery/computer/dna
	name = "DNA operations computer"
	icon_state = "dnaalter"
	hasdisk = 1
	var/obj/item/weapon/card/data/scan = null
	var/obj/item/weapon/card/data/modify = null
	var/obj/item/weapon/card/data/modify2 = null
	var/mode = null
	var/temp = null
/obj/machinery/computer/engine
	name = "Engine Control"
	icon_state = "engine"
	var/temp = null
	var/id = 1
	var/obj/machinery/gas_sensor/gs
	req_access = list(access_eject_engine)
/obj/machinery/computer/gasmon
	name = "Gas Monitor"
	icon_state = "gas"
	var/temp = null
	var/id = 1
	var/atmos = 0
	var/obj/machinery/gas_sensor/gs
/obj/machinery/computer/hologram_comp
	name = "Hologram Computer"
	icon = 'stationobjs.dmi'
	icon_state = "holo_console0"
	var/obj/machinery/hologram_proj/projector = null
	var/temp = null
	var/lumens = 0.0
	var/h_r = 245.0
	var/h_g = 245.0
	var/h_b = 245.0
/obj/machinery/computer/med_data
	name = "Medical Records"
	icon_state = "medical"
	hasdisk = 1
	req_access = list(access_medical_records)
	var/obj/item/weapon/card/id/scan = null
	var/authenticated = null
	var/rank = null
	var/screen = null
	var/datum/data/record/active1 = null
	var/datum/data/record/active2 = null
	var/a_id = null
	var/temp = null
	var/printing = null
	var/traitorused = 0

/obj/machinery/computer/pod
	name = "Pod Launch Control"
	icon_state = "launcher"
	var/id = 1.0
	var/obj/machinery/mass_driver/connected = null
	var/timing = 0.0
	var/time = 30.0

/obj/machinery/computer/prison_shuttle
	name = "Prison Shuttle"
	icon_state = "shuttle"
	var/allowedtocall = 1
/obj/machinery/computer/sydi_shuttle
	name = "Sydicate shuttle computer"
	icon_state = "shuttle"
/obj/machinery/computer/supply_shuttle
	name = "Supply Shuttle"
	icon_state = "shuttle"
	var/allowedtocall = 1
/obj/machinery/computer/secure_data
	name = "Security Records"
	icon_state = "records"
	req_access = list(access_security_records)
	var/obj/item/weapon/card/id/scan = null
	var/authenticated = null
	var/rank = null
	var/screen = null
	var/datum/data/record/active1 = null
	var/datum/data/record/active2 = null
	var/a_id = null
	var/temp = null
	var/printing = null
	var/can_change_id = 0
	var/traitorused = 0
	hasdisk = 1
/obj/machinery/computer/security
	name = "Security Cameras"
	icon_state = "cameras"
	var/obj/machinery/camera/current = null
	var/last_pic = 1.0
	var/network = "SS13"
	var/maplevel = 1
	var/traitorused = 0

/obj/machinery/computer/security/telescreen
	name = "Telescreen"
	icon = 'stationobjs.dmi'
	icon_state = "telescreen"
	network = "thunder"
	density = 0

/obj/machinery/computer/shuttle
	name = "Shuttle"
	icon_state = "shuttle"
	var/auth_need = 3.0
	var/list/authorized = list(  )

/obj/machinery/computer/sleep_console
	name = "Sleeper Console"
	icon = 'Cryogenic2.dmi'
	icon_state = "sleeperconsole"
	var/obj/machinery/sleeper/connected = null
/obj/machinery/computer/teleporter
	name = "Teleporter"
	icon_state = "teleport"
	var/obj/item/weapon/radio/beacon/locked = null
	var/id = null

/obj/machinery/computer/teleporter/interserver
	name = "Inter Server Teleporter"
	icon_state = "teleport"
	var/addr = null



/obj/machinery/connector
	name = "Connector"
	icon = 'pipes.dmi'
	desc = "A connector for gas canisters."
	icon_state = "connector"
	anchored = 1.0
	p_dir = 2
	var/obj/machinery/node = null
	var/obj/machinery/atmoalter/connected = null

	var/obj/machinery/vnode = null

	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null

	//var/obj/substance/gas/agas

	var/capacity = 6000000.0
	capmult = 2
	var/flag = 0

/obj/machinery/inlet
	name = "Inlet"
	icon = 'pipes.dmi'
	icon_state = "inlet"
	desc = "A gas pipe inlet."
	anchored = 1
	p_dir = 2
	var/obj/machinery/node
	var/obj/machinery/vnode
	var/obj/substance/gas/gas
	var/obj/substance/gas/ngas
	var/capacity = 6000000
	capmult = 2
	cnetdontadd = 1

/obj/machinery/inlet/filter
	name = "Filter Inlet"
	icon = 'pipes.dmi'
	icon_state = "inlet_filter-0"
	desc = "A gas pipe inlet with a remote controlled filter on it."
	var/control = null
	var/f_mask = 0
	cnetdontadd = 0

/obj/machinery/vent
	name = "Vent"
	icon = 'pipes.dmi'
	icon_state = "vent"
	desc = "A gas pipe outlet vent."
	anchored = 1
	p_dir = 2
	var/obj/machinery/node
	var/obj/machinery/vnode
	var/obj/substance/gas/gas
	var/obj/substance/gas/ngas
	var/capacity = 6000000
	capmult = 2
	cnetdontadd = 1

/obj/machinery/vent/filter
	name = "Filter Vent"
	icon = 'pipes.dmi'
	icon_state = "vent_filter-0"
	desc = "A gas pipe outlet vent with a remote controlled filter on it."
	var/control = null
	var/f_mask = 0
	cnetdontadd = 0

/obj/machinery/cryo_cell
	name = "Cryogenics Cell"
	icon = 'Cryogenic2.dmi'
	icon_state = "celltop"
	density = 1
	var/obj/machinery/line_in = null
	var/mob/occupant = null
	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null
	anchored = 1.0
	p_dir = 8.0
	capmult = 1

	var/obj/overlay/O1 = null
	var/obj/overlay/O2 = null

	var/obj/machinery/vnode = null

/obj/machinery/dispenser
	desc = "A simple yet bulky one-way storage device for gas tanks. Holds 10 plasma and 10 oxygen tanks."
	name = "Tank Storage Unit"
	icon = 'turfs2.dmi'
	icon_state = "dispenser"
	density = 1
	var/o2tanks = 10.0
	var/pltanks = 10.0
	anchored = 1.0
/obj/machinery/dna_scanner
	name = "DNA Scanner/Implanter"
	icon = 'Cryogenic2.dmi'
	icon_state = "scanner_0"
	density = 1
	var/locked = 0.0
	var/mob/occupant = null
	anchored = 1.0
/obj/machinery/dna_scannernew
	name = "DNA Modifier"
	icon = 'Cryogenic2.dmi'
	icon_state = "scanner_0"
	density = 1
	var/locked = 0.0
	var/mob/occupant = null
	anchored = 1.0
/obj/machinery/bodyscanner
	name = "Advanced Medical Scanner"
	icon = 'Cryogenic2.dmi'
	icon_state = "scanner_0"
	density = 1
	var/locked = 0
	var/mob/occupant = null
	anchored = 1.0
/obj/machinery/body_scanconsole
	name = "Advanced Medical Scanner Console"
	icon = 'computers.dmi'
	icon_state = "scanconsole"
	density = 1
	var/temphtml = null
	var/obj/machinery/dna_scanner/connected = null
	var/delete = 0
	anchored = 1.0
/obj/machinery/door
	name = "Door"
	icon = 'doors.dmi'
	icon_state = "door1"
	opacity = 1
	density = 1
	var/visible = 1
	var/p_open = 0
	var/operating = 0
	anchored = 1
	var/autoclose = 0
	var/hulksmash1 = 0
/obj/machinery/door/firedoor
	name = "Firelock"
	icon = 'firedoor.dmi'
	icon_state = "firedoor0"
	var/blocked = null
	opacity = 0
	density = 0
	var/nextstate = null
	var/hulksmash = 0
/obj/machinery/door/poddoor
	name = "Podlock"
	icon = 'poddoor.dmi'
	icon_state = "pdoor1"
	var/id = 1.0
/obj/machinery/door/barrier
	name = "Force Field"
	icon = 'stationobjs.dmi'
	icon_state = "barrier"
	opacity = 1
	density = 1
	anchored = 1.0
	var/id = 1.0
	var/rating = 0.0
	var/active = 0.0
/obj/machinery/door/window
	name = "Interior Door"
	icon = 'windoor.dmi'
	icon_state = "door1"
	visible = 0.0
	flags = WINDOW
	nohack=1
	opacity = 0
/obj/machinery/firealarm
	name = "Fire Alarm"
	icon = 'items.dmi'
	icon_state = "firealarm"
	var/detecting = 1.0
	var/working = 1.0
	var/time = 10.0
	var/timing = 0.0
	var/lockdownbyai = 0
	var/reset = 30.0
	anchored = 1.0
/obj/machinery/partyalarm
	name = "Party Button"
	icon = 'items.dmi'
	icon_state = "firealarm"
	var/detecting = 1.0
	var/working = 1.0
	var/time = 10.0
	var/timing = 0.0
	var/lockdownbyai = 0
	anchored = 1.0
/obj/machinery/freezer
	name = "Freezer"
	icon = 'Cryogenic2.dmi'
	icon_state = "freezer_0"
	density = 1
	var/connector = null
	var/obj/machinery/line_out = null
	var/obj/machinery/vnode = null
	var/c_used = 1.0
	var/status = 0.0
	var/t_flags = 3.0
	var/transfer = 0.0
	var/temperature = 60.0+T0C

	var/obj/substance/gas/gas
	var/obj/substance/gas/ngas
	p_dir = 4.0
	anchored = 1.0
	capmult = 1

/obj/machinery/gas_sensor
	name = "Gas Sensor"
	icon = 'stationobjs.dmi'
	icon_state = "gsensor"
	desc = "A remote sensor for atmospheric gas composition."
	var/id = ""
	anchored = 1

/obj/machinery/hologram_proj
	name = "Hologram Projector"
	icon = 'stationobjs.dmi'
	icon_state = "hologram0"
	var/atom/projection = null
	anchored = 1.0

/obj/machinery/hologram_ai
	name = "Hologram Projector Platform"
	icon = 'stationobjs.dmi'
	icon_state = "hologram0"
	var/atom/projection = null
	var/temp = null
	var/lumens = 0.0
	var/h_r = 245.0
	var/h_g = 245.0
	var/h_b = 245.0
	anchored = 1.0

/obj/machinery/igniter
	name = "Mounted Igniter"
	icon = 'stationobjs.dmi'
	icon_state = "igniter1"
	var/on = 1.0
	anchored = 1.0
/obj/machinery/injector
	name = "Gas Injector"
	icon = 'stationobjs.dmi'
	icon_state = "injector"
	density = 1
	anchored = 1.0
	flags = WINDOW
/obj/machinery/mass_driver
	name = "Mass Driver"
	desc = "A Kinetic-Energy driver for moving objects across large areas"
	icon = 'stationobjs.dmi'
	icon_state = "mass_driver"
	var/power = 1.0
	var/code = 1.0
	var/id = 1.0
	anchored = 1.0
	var/drive_range = 50 //this is mostly irrelevant since current mass drivers throw into space, but you could make a lower-range mass driver for interstation transport or something I guess.

/obj/machinery/meter
	name = "Flow Meter"
	desc = "A Meter that measures fluid flow across a pipe section"
	icon = 'pipes.dmi'
	icon_state = "meterX"
	var/obj/machinery/pipes/target = null
	anchored = 1.0
	var/average = 0

/obj/machinery/nuclearbomb
	desc = "Uh oh."
	name = "Nuclear Fission Explosive"
	icon = 'stationobjs.dmi'
	icon_state = "nuclearbomb0"
	density = 1
	var/deployable = 0.0
	var/extended = 0.0
	var/timeleft = 60.0
	var/timing = 0.0
	var/r_code = "ADMIN"
	var/code = ""
	var/yes_code = 0.0
	var/safety = 1.0
	var/obj/item/weapon/disk/nuclear/auth = null
	flags = FPRINT

/obj/machinery/valve
	var/obj/substance/gas/gas1 = null
	var/obj/substance/gas/ngas1 = null
	var/obj/substance/gas/gas2 = null
	var/obj/substance/gas/ngas2 = null
	var/capacity = 6000000.0
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null
	var/obj/machinery/vnode1 = null
	var/obj/machinery/vnode2 = null
	var/id = "v1"
	var/open = 0
	anchored = 1.0
	nohack = 1
	cnetdontadd = 1
	capmult = 2
	icon = 'pipes.dmi'

/obj/machinery/valve/mvalve
	name = "Manual Valve"
	desc = "A manually controlled valve."
	icon = 'pipes.dmi'
	icon_state = "valve0"
	p_dir = 3

/obj/machinery/valve/dvalve
	name = "digital Valve"
	nohack = 0
	cnetdontadd = 0
	desc = "A digitally controlled valve."
	icon = 'pipes.dmi'
	icon_state = "dvalve0"
	p_dir = 3

/obj/machinery/oneway
	name = "Check Valve"
	desc = "A Valve that only passes gas in one direction."
	var/obj/substance/gas/gas1 = null
	var/obj/substance/gas/ngas1 = null
	var/obj/substance/gas/gas2 = null
	var/obj/substance/gas/ngas2 = null
	var/capacity = 6000000.0
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null
	var/obj/machinery/vnode1 = null
	var/obj/machinery/vnode2 = null
	anchored = 1.0
	nohack = 1
	cnetdontadd = 1
	capmult = 2
	icon = 'pipes.dmi'
	icon_state = "one-way"
	p_dir = 3

/obj/machinery/oneway/pipepump
	name = "Inline Pipe Pump"
	desc = "A machine that pushes gas as hard as it can from one side to the other."
	icon = 'pipes2.dmi'
	icon_state = "pipepump-run"
	var/rate = 6000000.0
	cnetdontadd = 1

/obj/machinery/manifold
	name = "Manifold"
	icon = 'pipes.dmi'
	icon_state = "manifold"
	desc = "A three-port gas manifold."
	anchored = 1
	dir = 2
	p_dir = 14
	var/n1dir
	var/n2dir

	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null
	var/capacity = 6000000.0
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null
	var/obj/machinery/node3 = null

	var/obj/machinery/vnode1
	var/obj/machinery/vnode2
	var/obj/machinery/vnode3
	cnetdontadd = 1


	capmult = 3

/obj/machinery/pipefilter
	name = "Gas Filter"
	icon = 'pipes2.dmi'
	icon_state = "filter"
	desc = "A three-port gas filter."
	anchored = 1
	dir = 2
	p_dir = 14
	capmult = 3
	req_access = list(access_atmospherics)
	var/capacity = 6000000.0
	var/n1dir
	var/n2dir

	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null
	var/maxrate = 1000000.0

	var/f_mask = 0
	var/f_per = 0
	var/obj/substance/gas/f_gas = null
	var/obj/substance/gas/f_ngas = null

	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null
	var/obj/machinery/node3 = null

	var/obj/machinery/vnode1
	var/obj/machinery/vnode2
	var/obj/machinery/vnode3
	var/emagged = 0 //controls emagged sprite (1 = emag has been used)
	var/locked = 1 //controls no sprite but must be 0 if you want to bypass
	var/bypassed = 0 //controls the bypass wire sprite (1 = bypassed)

/obj/machinery/junction
	name = "Pipe Junction"
	icon = 'junct-pipe.dmi'
	icon_state = "junction"
	desc = "A junction between regular and heat-exchanger pipework."
	var/capacity = 6000000
	anchored = 1
	dir = 2
	h_dir = 2
	p_dir = 1

	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null

	var/obj/machinery/vnode1
	var/obj/machinery/vnode2

	capmult = 2


/obj/machinery/pipes
	name = "Piping"
	icon = 'reg_pipe.dmi'
	icon_state = "12"
	p_dir = 12
	layer = 2.9
	var/capacity = 6000000.0
	var/obj/machinery/node1 = null
	var/obj/machinery/node2 = null
	anchored = 1.0
	var/termination = 0
	var/insulation = NORMPIPERATE
	var/plnum = 0
	var/obj/machinery/pipeline/pl
	level = 1
	cnetdontadd = 1
	nohack = 1



/obj/machinery/pipeline				// virtual pipeline consisting of multiple /obj/machinery/pipes

	name = "Pipeline"
	var/list/nodes = list()
	var/numnodes = 0
	var/obj/substance/gas/gas = null
	var/obj/substance/gas/ngas = null

	var/obj/machinery/vnode1
	var/obj/machinery/vnode2
	var/plnum = 0
	invisibility = 101
	capmult = 0
	var/flow = 0
	cnetdontadd = 1


/obj/machinery/pipes/flexipipe
	desc = "Flexible hose-like piping."
	name = "Flexible Pipe"
	icon = 'wire.dmi'
	capacity = 10.0
	p_dir = 12.0
	layer = 3
	level = 2

/obj/machinery/pipes/high_capacity
	desc = "A large bore pipe with high capacity."
	name = "High-Capacity Piping"
	icon = 'hi_pipe.dmi'
	level = 2
	layer = 3
	capacity = 1.8E7
/obj/machinery/pipes/regular
	desc = "A stretch of pipe."
	name = "Normal Pipe"
/obj/machinery/pipes/heat_exch
	h_dir = 12
	icon = 'heat_pipe.dmi'
	name = "Heat Exchange Piping"
	desc = "A bundle of small pipes designed for maximum heat transfer."
	insulation = HEATPIPERATE
	level = 2

/obj/machinery/vehicle
	name = "Vehicle Pod"
	icon = 'escapepod.dmi'
	icon_state = "pod"
	density = 1
	flags = FPRINT
	anchored = 1.0
	layer = MOB_LAYER
	var/speed = 10.0
	var/maximum_speed = 10.0
	var/can_rotate = 1
	var/can_maximize_speed = 0
	var/one_person_only = 0
	cnetdontadd = 1

/obj/machinery/vehicle/pod
	name = "Escape Pod"
	icon = 'escapepod.dmi'
	icon_state = "pod"
	can_rotate = 0
	var/id = 1.0

/obj/machinery/vehicle/recon
	name = "Reconaissance Pod"
	icon = 'escapepod.dmi'
	icon_state = "recon"
	speed = 1.0
	maximum_speed = 30.0
	can_maximize_speed = 1
	one_person_only = 1

/obj/machinery/restruct
	name = "DNA Physical Restructurization Accelerator"
	icon = 'Cryogenic2.dmi'
	icon_state = "restruct_0"
	density = 1
	var/locked = 0.0
	var/mob/occupant = null
	anchored = 1.0
/obj/machinery/scan_console
	name = "DNA Scanner Access Console"
	icon = 'computers.dmi'
	icon_state = "scanconsole"
	density = 1
	var/obj/item/weapon/card/data/scan = null
	var/func = ""
	var/data = ""
	var/special = ""
	var/status = null
	var/prog_p1 = null
	var/prog_p2 = null
	var/prog_p3 = null
	var/prog_p4 = null
	var/temp = null
	var/obj/machinery/dna_scanner/connected = null
	anchored = 1.0
/obj/machinery/scan_consolenew
	name = "DNA Modifier Access Console"
	icon = 'computers.dmi'
	icon_state = "dnaalter"
	density = 1
	var/uniblock = 1.0
	var/strucblock = 1.0
	var/subblock = 1.0
	var/status = null
	var/radduration = 2.0
	var/radstrength = 1.0
	var/radacc = 1.0
	var/buffer1 = null
	var/buffer2 = null
	var/buffer3 = null
	var/buffer1owner = null
	var/buffer2owner = null
	var/buffer3owner = null
	var/buffer1label = null
	var/buffer2label = null
	var/buffer3label = null
	var/buffer1type = null
	var/buffer2type = null
	var/buffer3type = null
	var/buffer1iue = 0
	var/buffer2iue = 0
	var/buffer3iue = 0
	var/delete = 0
	var/injectorready = 1
	var/temphtml = null
	var/obj/machinery/dna_scanner/connected = null
	anchored = 1.0
/obj/machinery/sec_lock
	name = "Security Pad"
	icon = 'stationobjs.dmi'
	icon_state = "sec_lock"
	var/obj/item/weapon/card/id/scan = null
	var/a_type = 0.0
	var/obj/machinery/door/d1 = null
	var/obj/machinery/door/d2 = null
	anchored = 1.0
	req_access = list(access_brig)
	nohack = 1

/obj/machinery/door_control
	name = "Remote Door Control"
	icon = 'stationobjs.dmi'
	icon_state = "doorctrl0"
	desc = "A remote control switch for a door."
	var/id = null
	anchored = 1.0
	nohack = 1

/obj/machinery/filter_control
	name = "Remote Filter Control"
	icon = 'stationobjs.dmi'
	icon_state = "filter_control"
	desc = "A remote control for a filter"
	var/control = null
	req_access = list(access_atmospherics)
	anchored = 1.0
	nohack = 1
	var/f_mask = 0	//to stay synced with what we control
	var/locked = 1 //keep track of if we got screwdrivered or no
	var/emagged = 0 //Keep track of emag sprite + if everyone is allowed to access controls
					//this way we don't just set req_access to null (maybe something depends on that)

/obj/machinery/shuttle
	name = "shuttle"
	icon = 'shuttle.dmi'
/obj/machinery/shuttle/engine
	name = "engine"
	density = 1
	anchored = 1.0
/obj/machinery/shuttle/engine/heater
	name = "heater"
	icon_state = "heater"
/obj/machinery/shuttle/engine/platform
	name = "platform"
	icon_state = "platform"
/obj/machinery/shuttle/engine/propulsion
	name = "propulsion"
	icon_state = "propulsion"
	opacity = 1
/obj/machinery/shuttle/engine/propulsion/burst
	name = "burst"
/obj/machinery/shuttle/engine/propulsion/burst/left
	name = "left"
	icon_state = "burst_l"
/obj/machinery/shuttle/engine/propulsion/burst/right
	name = "right"
	icon_state = "burst_r"
/obj/machinery/shuttle/engine/router
	name = "router"
	icon_state = "router"
/obj/machinery/sleeper
	name = "Sleeper"
	icon = 'Cryogenic2.dmi'
	icon_state = "sleeper_0"
	density = 1
	var/mob/occupant = null
	anchored = 1.0
/obj/machinery/teleport
	name = "teleport"
	icon = 'stationobjs.dmi'
	density = 1
	anchored = 1.0
/obj/machinery/teleport/hub
	name = "hub"
	icon_state = "tele0"
/obj/machinery/teleport/station
	name = "station"
	icon_state = "controller"
	var/active = 0
	var/engaged = 0
/obj/machinery/wire
	name = "wire"
	icon = 'wire.dmi'


/obj/machinery/power
	name = null
	icon = 'power.dmi'
	anchored = 1.0
	var/datum/powernet/powernet = null
	var/netnum = 0
	var/directwired = 1		// by default, power machines are connected by a cable in a neighbouring turf
							// if set to 0, requires a 0-X cable on this turf

/obj/machinery/power/terminal
	name = "terminal"
	icon_state = "term"
	desc = "An underfloor wiring terminal for power equipment"
	level = 1
	var/obj/machinery/power/master = null
	anchored = 1
	cnetdontadd = 1
	directwired = 0		// must have a cable on same turf connecting to terminal

/obj/machinery/power/generator
	name = "generator"
	desc = "A high efficiency thermoelectric generator."
	icon_state = "teg"
	anchored = 1
	density = 1

	var/obj/machinery/circulator/circ1
	var/obj/machinery/circulator/circ2

	var/c1on = 0
	var/c2on = 0
	var/c1rate = 10
	var/c2rate = 10
	var/lastgen = 0
	var/lastgenlev = -1



/obj/machinery/power/monitor
	name = "Power Monitoring Computer"
	icon = 'computers.dmi'
	icon_state = "power"
	density = 1
	anchored = 1
	luminosity = 2

#define SMESMAXCHARGELEVEL 200000
#define SMESMAXOUTPUT 200000

/obj/machinery/power/smes
	name = "power storage unit"
	desc = "A high-capacity superconducting magnetic energy storage (SMES) unit."
	icon_state = "smes"
	density = 1
	anchored = 1
	var/output = 30000
	var/lastout = 0
	var/loaddemand = 0
	var/capacity = 5e6
	var/charge = 1e6
	var/charging = 0
	var/chargemode = 0
	var/chargecount = 0
	var/chargelevel = 30000
	var/online = 1
	var/n_tag = null
	var/obj/machinery/power/terminal/terminal = null

/obj/machinery/power/solar
	name = "solar panel"
	desc = "A solar electrical generator."
	icon = 'power.dmi'
	icon_state = "sp_base"
	anchored = 1
	density = 1
	directwired = 1
	var/health = 10.0
	var/id = ""
	var/obscured = 0
	var/sunfrac = 0
	var/adir = SOUTH
	var/ndir = SOUTH
	var/turn_angle = 0
	var/obj/machinery/power/solar_control/control
	var/building=0
	luminosity = 0

/obj/machinery/computer/comdisc
	name = "Communications Dish"
	desc = "A communcations dish on a rotating base"
	icon = 'power.dmi'
	icon_state = "sp_base"
	anchored = 1
	density = 1
	var/health = 10.0
	var/id = ""
	var/obscured = 0
	var/sunfrac = 0
	var/adir = SOUTH
	var/ndir = SOUTH
	var/turn_angle = 0



/obj/machinery/power/solar_control
	name = "solar panel control"
	desc = "A controller for solar panel arrays."
	icon = 'enginecomputer.dmi'
	icon_state = "solar_con"
	anchored = 1
	density = 1
	directwired = 1
	var/id = 1
	var/cdir = 0
	var/gen = 0
	var/lastgen = 0
	var/track = 0			// on/off
	var/trackrate = 600		// 300-900 seconds
	var/trackdir = 1		// 0 =CCW, 1=CW
	var/nexttime = 0
	var/building=0

/obj/machinery/power/portable_gen
	name = "portable generator"
	desc = "A plasma-powered portable power generator."
	var/obj/item/weapon/tank/holding
	anchored = 0
	netnum = -1
	cnetdontadd = 1
	directwired = 0

/obj/machinery/compressor
	name = "compressor"
	desc = "The compressor stage of a gas turbine generator."
	icon = 'pipes.dmi'
	icon_state = "compressor"
	anchored = 1
	density = 1
	var/obj/machinery/power/turbine/turbine
	var/obj/substance/gas/gas
	var/turf/inturf
	var/starter = 0
	var/rpm = 0
	var/rpmtarget = 0
	var/capacity = 1e6
	cnetdontadd = 1

/obj/machinery/power/turbine
	name = "gas turbine generator"
	desc = "A gas turbine used to for backup power generation."
	icon = 'pipes.dmi'
	icon_state = "turbine"
	anchored = 1
	density = 1
	var/obj/machinery/compressor/compressor
	directwired = 1
	var/turf/outturf
	var/lastgen



/obj/machinery/cell_charger
	name = "cell charger"
	desc = "A charging unit for power cells."
	icon = 'power.dmi'
	icon_state = "ccharger0"
	var/obj/item/weapon/cell/charging = null
	var/chargelevel = -1
	cnetdontadd = 1
	anchored = 1

/obj/machinery/light_switch
	desc = "A light switch"
	name = null
	icon = 'power.dmi'
	icon_state = "light1"
	anchored = 1.0
	var/on = 1
	var/hacked = 0
	var/area/area = null
	var/otherarea = null
//	luminosity = 1

/obj/cable
	level = 1
	anchored =1
	var/netnum = 0
	name = "power cable"
	desc = "A flexible superconducting cable for heavy-duty power transfer."
	icon = 'power_cond.dmi'
	icon_state = "0-1"
	var/d1 = 0
	var/d2 = 1
	layer = 2.5
	//layer = 10

/obj/manifest
	name = "manifest"
	icon = 'screen1.dmi'
	icon_state = "x"
/obj/morgue
	name = "morgue"
	icon = 'stationobjs.dmi'
	icon_state = "morgue1"
	density = 1
	var/obj/m_tray/connected = null
	anchored = 1.0
/obj/move
	name = "move"
	icon = 'shuttle.dmi'
	var/master = null
	var/tx = null
	var/ty = null
	var/oxygen = O2STANDARD
	var/oldoxy = null
	var/tmpoxy = null
	var/oldpoison = null
	var/tmppoison = null
	var/poison = 0.0
	var/co2 = 0.0
	var/oldco2 = null
	var/tmpco2 = null
	var/sl_gas = 0.0
	var/osl_gas = null
	var/tsl_gas = null
	var/n2 = N2STANDARD
	var/on2 = null
	var/tn2 = null

	var/temp = T20C
	var/otemp
	var/ttemp

	var/firelevel = 0.0
	var/airdir = null
	var/airforce = null
	var/checkfire = 1.0
	var/updatecell = 1.0
	var/update_again = 0
	anchored = 1.0
/obj/move/floor
	name = "floor"
	icon_state = "floor"
/obj/move/wall
	name = "wall"
	icon_state = "wall"
	opacity = 1
	density = 1
	updatecell = 0.0

/obj/mine
	name = "Mine"
	desc = "I Better stay away from that thing."
	density = 0
	anchored = 1
	layer = 3
	icon = 'traps.dmi'
	icon_state = "uglymine"
	var/range = 2 //trigger range
	var/triggerproc = "explode" //name of the proc thats called when the mine is triggered
	var/senserate = 10 //how often it checks for nearby players
	var/readytime = 50 //time until the mine is armed

/obj/mine/dnascramble
	name = "Radiation Mine"
	icon = 'traps.dmi'
	icon_state = "uglymine"
	range = 1
	senserate = 10
	triggerproc = "triggerrad"

/obj/mine/plasma
	name = "Plasma Mine"
	icon = 'traps.dmi'
	icon_state = "uglymine"
	range = 2
	senserate = 20
	triggerproc = "triggerplasma"

/obj/mine/kick
	name = "Kick Mine"
	icon = 'traps.dmi'
	icon_state = "uglymine"
	range = 1
	senserate = 10
	triggerproc = "triggerkick"

/obj/mine/n2o
	name = "N2O Mine"
	icon = 'traps.dmi'
	icon_state = "uglymine"
	range = 3
	senserate = 30
	triggerproc = "triggern2o"

/obj/mine/stun
	name = "Stun Mine"
	icon = 'traps.dmi'
	icon_state = "uglymine"
	range = 2
	senserate = 20
	triggerproc = "triggerstun"


/obj/overlay
	name = "overlay"
/obj/bloodtemplate
	name = "blood"
	desc = "It's red."
	density = 0
	anchored = 1
	layer = 2
	icon = 'blood.dmi'
	icon_state = "floor1"
	blood = null
	var/hulk = 0
/obj/point
	name = "point"
	icon = 'screen1.dmi'
	icon_state = "arrow"
	layer = 16.0
	anchored = 1
/obj/portal
	name = "portal"
	icon = 'stationobjs.dmi'
	icon_state = "portal"
	density = 1
	var/obj/item/weapon/radio/beacon/target = null
	var/creator = null
	anchored = 1.0
/obj/projection
	name = "Projection"
	anchored = 1.0
/obj/rack
	name = "rack"
	icon = 'Icons.dmi'
	icon_state = "rack"
	density = 1
	flags = FPRINT
	anchored = 1.0
/obj/screen
	name = "screen"
	icon = 'screen1.dmi'
	layer = 51.0
	var/id = 0.0
	var/obj/master
/obj/screen/close
	name = "close"
	master = null
	layer = 52.0
/obj/screen/grab
	name = "grab"
	master = null
	layer = 52.0
/obj/screen/screen2
	name = "screen2"
	icon = 'screen.dmi'
	layer = 52.0
/obj/screen/storage
	name = "storage"
	master = null
	layer = 52.0
/obj/screen/zone_sel
	name = "Damage Zone"
	icon = 'zone_sel.dmi'
	icon_state = "blank"
	var/selecting = "chest"
	screen_loc = "15,15"
	layer = 52.0

/obj/shut_controller
	name = "shut controller"
	var/moving = null

	var/list/parts = list(  )

/obj/shuttle
	name = "shuttle"
/obj/shuttle/door
	name = "door"
	icon = 'shuttle.dmi'
	icon_state = "door1"
	opacity = 1
	density = 1
	var/visible = 1.0
	var/operating = null
	anchored = 1.0
/obj/start
	name = "start"
	icon = 'screen1.dmi'
	icon_state = "x"
	anchored = 1.0
/obj/stool
	name = "stool"
	icon = 'Icons.dmi'
	icon_state = "stool"
	flags = FPRINT
	weight = 100000
/obj/stool/bed
	name = "bed"
	icon_state = "bed"
	anchored = 1.0
/obj/stool/chair
	name = "chair"
	icon_state = "chair"
	var/status = 0.0
	anchored = 1.0
/obj/stool/chair/e_chair
	name = "electrified chair"
	icon_state = "e_chair0"
	var/atom/movable/overlay/overl = null
	var/on = 0.0
	var/obj/item/weapon/assembly/shock_kit/part1 = null
	var/last_time = 1.0
/obj/substance
	name = "substance"
	var/maximum
	var/temperature
	var/co2
	var/n2
	var/oxygen
	var/plasma
	var/sl_gas
/obj/substance/chemical
	name = "chemical"
	maximum = null

	var/list/chemicals = list(  )		// contains /datum/chemical


/obj/substance/gas
	name = "gas"
	temperature = T20C
	co2 = 0.0
	n2 = 0.0
	oxygen = 0.0
	plasma = 0.0
	sl_gas = 0.0
	maximum = -1.0
/obj/table
	name = "table"
	icon = 'table.dmi'
	icon_state = "alone"
	density = 1
	anchored = 1.0

/obj/mopbucket
	desc = "Fill it with water, but don't forget a mop!"
	name = "mop bucket"
	icon = 'stationobjs.dmi'
	icon_state = "mopbucket"
	density = 1
	var/water = 0
	var/chloro = 0
	flags = FPRINT
	weight = 5000000.0
/obj/watertank
	name = "watertank"
	icon = 'stationobjs.dmi'
	icon_state = "watertank"
	density = 1
	flags = FPRINT
	weight = 5000000.0
/obj/weldfueltank
	name = "weldfueltank"
	icon = 'items.dmi'
	icon_state = "weldtank"
	density = 1
	flags = FPRINT
	weight = 5000000.0
/obj/window
	name = "window"
	icon = 'turfs2.dmi'
	icon_state = "window"
	desc = "A window."
	density = 1
	var/invincible = 0
	var/health = 14.0
	var/ini_dir = null
	var/state = 0
	var/reinf = 0
	weight = 2500000.0
	anchored = 1.0
	flags = WINDOW
// Merged

/obj/secloset
	desc = "An immobile card-locked storage closet."
	name = "Security Locker"
	icon = 'stationobjs.dmi'
	icon_state = "1secloset0"
	density = 1
	var/opened = 0
	var/locked = 1
	var/broken = 0
/obj/secloset/animal
	name = "Animal Control"
	req_access = list(access_genetics_lab)
/obj/secloset/highsec
	name = "Experimental Technology"
	req_access = list(access_bridge)
/obj/secloset/captains
	name = "Captain's Closet"
	req_access = list(access_captain)
/obj/secloset/medical1
	name = "Medicine Closet"
	req_access = list(access_medbay)
/obj/secloset/chemical
	name = "Chemical Closet"
	req_access = list(access_chemical_lab)
/obj/secloset/medical2
	name = "Anesthetic"
	req_access = list(access_medical_storage)
/obj/secloset/personal
	desc = "The first card swiped gains control."
	name = "Personal Closet"
	icon_state = "0secloset0"
/obj/secloset/security1
	name = "Security Equipment"
	req_access = list(access_security)
/obj/secloset/security2
	name = "Forensics Locker"
	req_access = list(access_forensics)
/obj/secloset/toxin
	name = "Toxin Researcher Locker"
	req_access = list(access_toxins_lab)
/obj/secloset/chemtoxin
	name = "Chemistry Locker"
	req_access = list(access_chemical_lab)
/obj/secloset/bar
	name = "Booze"
	req_access = list(access_bar)

/obj/closet
	desc = "It's a closet!"
	name = "Closet"
	icon = 'stationobjs.dmi'
	icon_state = "closet"
	density = 1
	var/icon_closed = "closet"
	var/icon_opened = "emcloset1"
	var/opened = 0.0
	var/welded = 0.0
	flags = FPRINT
	weight = 1.0E8

/obj/item/weapon/storage/folder
	name = "Folder"
	icon_state = "folder"
	var/info = null
	w_class = 1.0
	throw_speed = 3
	throw_range = 15

/obj/cabinet  //Figure how to make this like a closet, but not passible - Trorbes 01/01/2010
	desc = "A file cabinet"
	name = "File Cabinet"
	icon = 'stationobjs.dmi'
	icon_state = "cabinet0"
	density = 1
	var/icon_closed = "cabinet0"
	var/icon_opened = "cabinet1"
	flags = FPRINT
	weight = 1.0E8

/obj/closet/cabinet  //This'll have to do for now - Trorbes 01/01/2010
	desc = "A file cabinet.  You can somehow fit inside it."
	name = "File Cabinet"

/obj/closet/food
	desc = "A food cabinet."
	name = "Food Cabinet"

/obj/closet/meat
	desc = "A meat locker"
	name = "Meat Locker"

/obj/closet/gmcloset
	desc = "A bulky (yet mobile) closet. Comes with formal clothes"
	name = "Formal closet"

/obj/closet/emcloset
	desc = "A bulky (yet mobile) closet. Comes prestocked with a gasmask and o2 tank for emergencies."
	name = "Emergency Closets"
	icon_state = "emcloset0"
	icon_closed = "emcloset0"

/obj/closet/jcloset
	desc = "A bulky (yet mobile) closet. Comes with janitor's clothes and biohazard gear."
	name = "Custodial Closet"

/obj/closet/coffin
	desc = "A burial receptacle for the dearly departed."
	name = "coffin"
	icon_state = "premium_coffin_closed"
	icon_closed = "premium_coffin_closed"
	icon_opened = "premium_coffin_opened"

/obj/closet/l3closet
	desc = "A bulky (yet mobile) closet. Comes prestocked with level 3 biohazard gear for emergencies."
	name = "Level 3 Biohazard Suit"
	icon_state = "l3closet0"
	icon_closed = "l3closet0"
	icon_opened = "l3closet1"

/obj/closet/syndicate
	desc = "Why is this here?"
	name = "Syndicate Weapons Closet"
	icon_state = "syndicate0"
	icon_closed = "syndicate0"

/obj/closet/syndicate/personal
	desc = "Gear preperations closet."

/obj/closet/syndicate/nuclear
	desc = "Nuclear preperations closet."

/obj/closet/thunderdome
	desc = "Everything you need!"
	icon_state = "syndicate0"
	icon_closed = "syndicate0"
	desc = "Thunderdome closet."
	anchored = 1

/obj/closet/thunderdome/tdred
	desc = "Everything you need!"
	icon_state = "syndicate0"
	icon_closed = "syndicate0"
	desc = "Thunderdome closet."

/obj/closet/thunderdome/tdgreen
	desc = "Everything you need!"
	icon_state = "syndicate1"
	icon_closed = "syndicate1"
	desc = "Thunderdome closet."

/obj/closet/malf/suits
	desc = "Gear preperations closet."
	icon_state = "syndicate0"
	icon_closed = "syndicate0"

/obj/closet/wardrobe
	desc = "A bulky (yet mobile) wardrobe closet. Comes prestocked with 6 changes of clothes."
	name = "Wardrobe"
	icon_state = "wardrobe-b"
	icon_closed = "wardrobe-b"

/obj/closet/wardrobe/black
	name = "Black Wardrobe"
	icon_state = "wardrobe-bl"
	icon_closed = "wardrobe-bl"
/obj/closet/wardrobe/chaplain_black
	name = "Chaplain Wardrobe"
	icon_state = "wardrobe-bl"
	icon_closed = "wardrobe-bl"

/obj/closet/wardrobe/green
	name = "Green Wardrobe"
	icon_state = "wardrobe-g"
	icon_closed = "wardrobe-g"

/obj/closet/wardrobe/network
	name = "Network Technician Wardrobe"
	icon_state = "wardrobe-nt"
	icon_closed = "wardrobe-nt"

/obj/closet/wardrobe/mixed
	name = "Mixed Wardrobe"
	icon_state = "wardrobe-bp"
	icon_closed = "wardrobe-bp"

/obj/closet/wardrobe/orange
	name = "Prisoners Wardrobe"
	icon_state = "wardrobe-o"
	icon_closed = "wardrobe-o"

/obj/closet/wardrobe/pink
	name = "Pink Wardrobe"
	icon_state = "wardrobe-p"
	icon_closed = "wardrobe-p"

/obj/closet/wardrobe/red
	name = "Red Wardrobe"
	icon_state = "wardrobe-r"
	icon_closed = "wardrobe-r"
/obj/closet/wardrobe/forensics_red
	name = "Forensics Wardrobe"
	icon_state = "wardrobe-r"
	icon_closed = "wardrobe-r"
/obj/closet/wardrobe/firefighter_red
	name = "Fire Fighter Wardrobe"
	icon_state = "wardrobe-r"
	icon_closed = "wardrobe-r"


/obj/closet/wardrobe/white
	name = "Medical Wardrobe"
	icon_state = "wardrobe-w"
	icon_closed = "wardrobe-w"
/obj/closet/wardrobe/toxins_white
	name = "Toxins Wardrobe"
	icon_state = "wardrobe-w"
	icon_closed = "wardrobe-w"
/obj/closet/wardrobe/genetics_white
	name = "Genetics Wardrobe"
	icon_state = "wardrobe-w"
	icon_closed = "wardrobe-w"


/obj/closet/wardrobe/yellow
	name = "Yellow Wardrobe"
	icon_state = "wardrobe-y"
	icon_closed = "wardrobe-y"
/obj/closet/wardrobe/engineering_yellow
	name = "Engineering Wardrobe"
	icon_state = "wardrobe-y"
	icon_closed = "wardrobe-y"
/obj/closet/wardrobe/atmospherics_yellow
	name = "Atmospherics Wardrobe"
	icon_state = "wardrobe-y"
	icon_closed = "wardrobe-y"


/obj/closet/wardrobe/grey
	name = "Grey Wardrobe"
	icon_state = "wardrobe-grey"
	icon_closed = "wardrobe-grey"

/obj/item/weapon/module
	icon = 'module.dmi'
	icon_state = "std_module"
	w_class = 2.0
	s_istate = "electronic"
	flags = FPRINT|TABLEPASS
	var/mtype = 1						// 1=electronic 2=hardware

/obj/item/weapon/module/card_reader
	name = "card reader module"
	icon_state = "card_mod"
	desc = "An electronic module for reading data and ID cards."

/obj/item/weapon/module/power_control
	name = "power control module"
	icon_state = "power_mod"
	desc = "Heavy-duty switching circuits for power control."

/obj/item/weapon/module/id_auth
	name = "ID authentication module"
	icon_state = "id_mod"
	desc = "A module allowing secure authorization of ID cards."

/obj/item/weapon/module/cell_power
	name = "power cell regulator module"
	icon_state = "power_mod"
	desc = "A converter and regulator allowing the use of power cells."

/obj/item/weapon/module/cell_power
	name = "power cell charger module"
	icon_state = "power_mod"
	desc = "Charging circuits for power cells."
/obj/item/weapon/disk/aiupload
	name = "Ai Upload Interface Disk"
	icon = 'module.dmi'
	icon_state = "std_mod"
	s_istate = "electronic"
	desc = "A vita component for a computer"
/obj/item/weapon/disk/card
	name = "Card Interface Disk"
	icon = 'module.dmi'
	icon_state = "std_mod"
	s_istate = "electronic"
	desc = "A vita component for a computer"
/obj/item/weapon/disk/com
	name = "Com Interface Disk"
	icon = 'module.dmi'
	icon_state = "std_mod"
	s_istate = "electronic"
	desc = "A vita component for a computer"
/obj/item/weapon/disk/comcon
	name = "Com Control Disk"
	icon = 'module.dmi'
	icon_state = "std_mod"
	s_istate = "electronic"
	desc = "A vital component for a computer"
obj/machinery/vendingmachine/water
	name = "Space Mountain Mineral Water Dispensor"
	desc = "A vending machine for the famous Space Mountain Mineral Water!"
	anchored = 1
	density = 1
	icon = 'food.dmi'
	icon_state = "watervend"
	var/water = 30
/obj/item/weapon/mouse_drag_pointer = MOUSE_ACTIVE_POINTER
/mob/mouse_drag_pointer = MOUSE_ACTIVE_POINTER


/obj/item/weapon/bulb
	name = "Fluorescent Bulb"
	icon_state = "bulb"
	var/bulbtype = "fluorescent"
	icon = 'items.dmi'
	desc="The bulb appears to be in good condition"
	var/life = 0
	var/bright = 6
	w_class = 4.0 //Yeah, you can really fit a meter-long bulb in your pocket.

/obj/item/weapon/bulb/incandescent
	name = "Incandescent Bulb"
	bulbtype = "incandescent"
	bright = 4
	icon_state = "incandescent"
	w_class = 1.0 //But you can fit a 4" incandescent bulb, that makes sense.

/obj/item/weapon/bulb/incandescent/cfl
	name = "CFL Bulb"
	bright = 6 //fluorescent output in an incandescent form factor!
	//icon_state = "cfl" //Graphics not actually done



/obj/machinery/light //Normal fluorescent
	name = "Light Fixture"
	icon = 'lights.dmi'
	icon_state = "fluorescent"
	anchored = 1
	layer = 4.5
	luminosity = 0
	var/open = 0
	var/baselum = 6
	var/bulbtype = "fluorescent"
	var/on = 0
	var/instant = 0
	var/obj/item/weapon/bulb/bulb = null
	var/gset = "fluorescent"
	var/area/area = null
	var/basetype = /obj/item/weapon/bulb
	var/grill = 1

/obj/machinery/light/dimlight //dim fluorescent
	baselum = 5

/obj/machinery/light/incandescent //..obvious
	icon_state = "incandescent"
	bulbtype = "incandescent"
	gset = "incandescent"
	instant = 1
	basetype = /obj/item/weapon/bulb/incandescent

/obj/machinery/light/incandescent/spotlight
	basetype = /obj/item/weapon/bulb/incandescent/cfl
	icon_state = "spot"
	gset = "spot"

/obj/item/weapon/storage/lightbulbs
	name = "Box of Incandescent Bulbs"
	icon_state = "box"
	s_istate = "syringe_kit"

/obj/item/weapon/storage/fluorescentbulbs
	name = "Box of Fluorescent Bulbs"
	icon_state = "box"
	s_istate = "syringe_kit"

/obj/machinery/conveyor
	name = "Conveyor Belt"
	icon = 'conveyor.dmi'
	icon_state = "MapEditor"
	var/id = "" //conveyor_control objects sharing this Id will control this conveyor
	var/on = 0 //Set to 1 to have the conveyor be on when the round starts
	anchored = 1.0

/obj/machinery/conveyor_control
	name = "Remote Conveyor Control"
	icon = 'conveyor.dmi'
	icon_state = "controlbox"
	desc = "A remote control switch for a Conveyor Belt."
	anchored = 1.0
	var/id = "" //When used, src will toggle the power of every conveyor belt with this i
	var/state = 0

/obj/machinery/conveyor_klaxon
	name = "Conveyor Warning Siren"
	icon = 'conveyor.dmi'
	icon_state = "klaxon0"
	desc = "A siren to warn people the conveyor belt is going to start"
	anchored = 1.0
	var/id = ""
	var/on = 0

/obj/computercable
	level = 1
	anchored = 1
	name = "Network Cable"
	desc = "A flexible cable designed for use in the Neithernet Protocol."
	icon = 'netcable.dmi'
	icon_state = "1-2"
	var/cnetnum = 0
	var/d1 = 0
	var/d2 = 1
	var/cabletype = ""
	layer = 2.5
	//layer = 10

/obj/item/weapon/computercable_coil
	name = "Network Cable Coil"
	var/amount = MAXCOIL
	icon = 'netcable.dmi'
	icon_state = "coil"
	desc = "A coil of Network cable."
	w_class = 2
	flags = TABLEPASS|USEDELAY|FPRINT
	s_istate = "coil"

/obj/item/weapon/computercable_coil/cut
	icon_state = "coil2"
	desc = "A cut-off piece of Network Cable"

/obj/machinery/router
	name = "Router"
	icon = 'netobjs.dmi'
	icon_state = "router"
	desc = "A high-speed network router.  The lights are mesmerizing"
	anchored = 1.0
	density = 1
	var/list/datum/computernet/connectednets = list()
	var/list/datum/computernet/disconnectednets = list()
	req_access_txt = "103"

/obj/machinery/mailserver
	name = "Mail Server"
	icon = 'netobjs.dmi'
	icon_state = "mailserv"
	anchored = 1
	density = 1
	desc = "This chunky computer system handles all non-voice electronic communications on the station"

/obj/machinery/TestCmdr
	name = "DEV TEST"
	icon = 'power.dmi'
	icon_state = "ai"
	sniffer = 1

/obj/machinery/sniffer
	name = "Network Packet Monitor"
	icon = 'netobjs.dmi'
	icon_state = "sniffer"
	sniffer = 1
	density = 1
	anchored = 1
	desc = "A computer system designed to monitor network activity"
	var/browser

/obj/machinery/sniffer/syndicate
	name = "Portable Network Packet Monitor"
	anchored = 0
	desc = "This is not a normal packet sniffer"

/obj/machinery/AIconnector
	name = "AI connector"
	icon = 'netcable.dmi'
	icon_state = "0-1"
	var/mob/ai/ai = null

/obj/machinery/spaceheater
	name = "Space Heater"
	icon = 'stationobjs.dmi'
	icon_state = "spaceheater_map"
	stat = POWEROFF //Start turned off
	dir = NORTH
	var/maxoutput = 1 //How many degrees the temperature on the tile the heater is on is increased every tick at precisely 1 bar.
	var/maxheat = 90

/obj/machinery/thermostat
	name = "Thermostat"
	icon = 'stationobjs.dmi'
	icon_state = "thermostat"
	var/target = 22
	var/on = 0
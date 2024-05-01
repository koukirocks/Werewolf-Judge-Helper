extends Control

var sequence
var Translate
var ColorId
var Colors
var Characters=[]
var PlayerCount=0
var PlayerScene = preload("res://Scene/player.tscn")
var DropdownButton = preload("res://Scene/Character_Selection.tscn")

signal confirmed(sure)

func bool_popup(statement):
	$"BoolPopup/Window/MC/VBC/Statement".text=statement
	$"BoolPopup".visible = true
	var sure = await confirmed
	$"BoolPopup".visible = false
	return sure

func _on_yes_pressed():
	confirmed.emit(true)

func _on_no_pressed():
	confirmed.emit(false)

func multi_popup():
	$MultiPopup.visible=true
	var result = await added_attrib
	$MultiPopup.visible = false
	return result

signal added_attrib(attrib)

func _got_attrib_signal(attrib):
	added_attrib.emit(attrib)

func _on_lock_pressed():
	if $SC/VBC/PC/MC/HBC/Lock.button_pressed:
		$SC/VBC/PC/MC/HBC/Lock/MC.visible=true
		get_tree().call_group("Players", "control_lock",1)
	else:
		$SC/VBC/PC/MC/HBC/Lock/MC.visible=false
		get_tree().call_group("Players", "control_lock",0)

signal end_game

func _on_end_pressed():
	end_game.emit()

signal char_chosen(character)

func _got_dropdown_signal(character):
	char_chosen.emit(character)

func list_popup():
	$ListPopup/Window/MC/SC.scroll_vertical=0
	$ListPopup.visible = true
	var who = await char_chosen
	$ListPopup.visible = false
	return who

var gameseq=[]
var eventId=0
var nightCount=0

func next():
	eventId+=1
	if eventId==len(gameseq):
		eventId=0
		nightCount+=1

func existPolice():
	for node in get_tree().get_nodes_in_group("Players"):
		if node.get_node("MC/VBC/HBC/IsPolice").button_pressed:
			return true
	return false

func _on_routine_pressed():
	next()
	while gameseq[eventId][2]==1 and nightCount!=0:
		next()
	while gameseq[eventId][2]==3 and nightCount==0:
		next()
	while gameseq[eventId][2]==4 and existPolice():
		next()
		
	$PC/MC/Routine.text = gameseq[eventId][1]

func init():
	sequence = get_node("/root/Main/GameConstant").sequence
	Translate = get_node("/root/Main/GameConstant").Translate
	ColorId = get_node("/root/Main/GameConstant").ColorId
	Colors = get_node("/root/Main/GameConstant").Colors
	for event in sequence:
		if event[0]=="MUST" or event[0] in Characters:
			gameseq.append(event)
	eventId=0
	nightCount=0
	$PC/MC/Routine.text = gameseq[eventId][1]
	var Player=PlayerScene.instantiate()
	Player.name="P1"
	get_node("SC/VBC").add_child(Player)
	get_node("SC/VBC/P1").initialize(Characters,1)
	$"SC/VBC".move_child($"SC/VBC/P1",0)
	print($"SC/VBC/P1".size)
	for i in range(2,PlayerCount+1):
		Player=PlayerScene.instantiate()
		Player.name="P%s" % i
		get_node("SC/VBC/P%s" % (i-1)).add_sibling(Player)
		get_node("SC/VBC/P%s" % i).initialize(Characters,i)
		#print("added P%s" % i)

func _ready():
	var nodes = get_tree().get_nodes_in_group("Attributes")
	for node in nodes:
		node.chosen.connect(self._got_attrib_signal)
	nodes = get_tree().get_nodes_in_group("Dropdown")
	for node in nodes:
		node.chosen.connect(self._got_dropdown_signal)

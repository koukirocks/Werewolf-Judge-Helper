extends Control


var Characters=[]
var PlayerCount=0
var PlayerScene = preload("res://Scene/player.tscn")

func _ready():
	var nodes = get_tree().get_nodes_in_group("Attributes")
	for node in nodes:
		node.chosen.connect("_got_attrib_signal")

func init():
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

signal added_attrib(attrib)

func multi_popup():
	$MultiPopup.visible=true
	var result = await added_attrib
	$MultiPopup.visible = false
	return result

func _got_attrib_signal(attrib):
	added_attrib.emit(attrib)

func _on_lock_pressed():
	if $SC/VBC/PC/MC/HBC/Lock.button_pressed:
		$SC/VBC/PC/MC/HBC/Lock/MC.visible=true
		get_tree().call_group("Players", "control_lock",1)
	else:
		$SC/VBC/PC/MC/HBC/Lock/MC.visible=false
		get_tree().call_group("Players", "control_lock",0)

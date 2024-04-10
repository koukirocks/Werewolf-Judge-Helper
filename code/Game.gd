extends Control

var sequence = [
	["Thief","盜賊選牌",1],
	["Cupid","邱比特連情侶",1],
	["Cupid","情侶確認身分",1],
	["Dreamer","攝夢人攝夢",2],
	["Guard","守衛守護人",2],
	["MUST","狼人殺人",2],
	["Snow","雪狼(調查身分)",1],
	["Blood","血月使者(調查身分)",1],
	["Devil","惡靈騎士(調查身分)",1],
	["Witcher","獵魔人撞人",2],
	["Witch","女巫救人毒人",2],
	["Prophet","預言家查驗身分",2],
	["Psychic","通靈師查驗身分",2],
	["Grave","守墓人查死",2],
	["Crow","烏鴉詛咒",2],
	["Hunter","獵人能否開槍",2],
	["King","狼王能否開槍",2],
	["Black","黑狼王能否開槍",2],
	["Idiot","白癡(調查身分)",1],
	["Knight","騎士(調查身分)",1],
	["Bomber","炸彈人(調查身分)",1],
	["Cursed","咒狐(調查身分)",1],
	["Bear","馴熊師(調查身分)",1]
]

var Characters=[]
var PlayerCount=0
var PlayerScene = preload("res://Scene/player.tscn")

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

func _ready():
	var nodes = get_tree().get_nodes_in_group("Attributes")
	for node in nodes:
		node.chosen.connect(self._got_attrib_signal)

signal end_game

func _on_end_pressed():
	end_game.emit()

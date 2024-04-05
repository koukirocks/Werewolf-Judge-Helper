extends Control

func _ready():
	var buttons=get_tree().get_nodes_in_group("Characters")
	for node in buttons:
		node.character_chosen.connect(_on_character_chosen)
		node.character_removed.connect(_on_character_removed)

func _process(_delta):
	pass

var PlayerCount=5
var Characters=["Villager"]
func _on_player_count_slider_drag_ended(_value_changed):
	PlayerCount=$Scroll/VBox1/Player/MC/Vbox2/PlayerCountSlider.value

func _on_character_chosen(character_name):
	Characters.append(character_name)

func _on_character_removed(character_name):
	Characters.erase(character_name)

signal start_game(Characters)

func _on_start_pressed():
	start_game.emit(Characters)

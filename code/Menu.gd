extends Control

func _ready():
	var buttons=get_tree().get_nodes_in_group("Characters")
	for node in buttons:
		node.character_chosen.connect(_on_character_chosen)
		node.character_removed.connect(_on_character_removed)

func _process(_delta):
	pass

var PlayerCount=5
func _on_player_count_slider_drag_ended(_value_changed):
	PlayerCount=$Scroll/VBox1/Player/MC/Vbox2/PlayerCountSlider.value

func _on_character_chosen(character_name):
	print(character_name)
	print("add")

func _on_character_removed(character_name):
	print(character_name)
	print("rem")

extends Node

enum {
	
}

func _ready():
	pass

func _on_menu_start_game(Chosen):
	$"Transition".size=$Menu.size
	$"Transition".position.y=$Menu.position.y
	var anime = $Transition/AP.get_animation("Start Transition")
	anime.track_set_enabled(1,true)
	anime.track_set_enabled(2,false)
	$"Transition/AP".play("Start Transition")
	$"Game".Characters=Chosen
	for node in get_tree().get_nodes_in_group("Attributes"):
		node.initialize()

func change_scene():
	$"Menu".visible=false
	$"Game".visible=true
	$"Game".PlayerCount=$"Menu/Scroll/VBox1/Player/MC/Vbox2/PlayerCountSlider".value
	$"Game".init()

func change_scene2():
	for node in get_tree().get_nodes_in_group("Players"):
		#print(node)
		node.queue_free()
	$"Menu".visible=true
	$"Game".visible=false

func _on_game_end_game():
	$"Transition".size=$Game.size
	$"Transition".position.y=$Game.position.y
	var anime = $Transition/AP.get_animation("Start Transition")
	anime.track_set_enabled(1,false)
	anime.track_set_enabled(2,true)
	$"Transition/AP".play("Start Transition")

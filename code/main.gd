extends Node

enum {
	
}

func _ready():
	$"Transition".size=Vector2(720,1280)

func _on_menu_start_game(Chosen):
	var anime = $Transition/AP.get_animation("Start Transition")
	anime.track_set_enabled(1,true)
	anime.track_set_enabled(2,false)
	$"Transition/AP".play("Start Transition")
	$"Game".Characters=Chosen

func change_scene():
	$"Menu".visible=false
	$"Game".visible=true
	$"Game".PlayerCount=$"Menu/Scroll/VBox1/Player/MC/Vbox2/PlayerCountSlider".value
	$"Game".init()

func change_scene2():
	for node in get_tree().get_nodes_in_group("Players"):
		print(node)
		node.queue_free()
	$"Menu".visible=true
	$"Game".visible=false

func _on_game_end_game():
	var anime = $Transition/AP.get_animation("Start Transition")
	anime.track_set_enabled(1,false)
	anime.track_set_enabled(2,true)
	$"Transition/AP".play("Start Transition")

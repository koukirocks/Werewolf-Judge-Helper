extends Node

func _ready():
	$"Transition".size=Vector2(720,1280)

func _on_menu_start_game(Chosen):
	$"Transition/AP".play("Start Transition")
	$"Game".Characters=Chosen

func change_scene():
	$"Menu".visible=false
	$"Game".visible=true
	$"Game".PlayerCount=$"Menu/Scroll/VBox1/Player/MC/Vbox2/PlayerCountSlider".value
	$"Game".init()

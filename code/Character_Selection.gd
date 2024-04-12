extends Button

signal chosen(Character)

var color = "#000000"
var Colors
var ColorId
var Translate

func _ready():
	add_to_group("Dropdown")
	Colors = $"/root/Main/GameConstant".Colors
	ColorId = $"/root/Main/GameConstant".ColorId
	Translate = $"/root/Main/GameConstant".Translate
	color = Colors[ColorId[name]]
	text = Translate[name]
	add_theme_color_override("font_color",Color(color))
	add_theme_color_override("font_hover_color",Color(color))
	add_theme_color_override("font_pressed_color",Color(color))

func initialize():
	if name in $"../../../../../..".Characters:
		visible = true
	else:
		visible = false

func _on_pressed():
	chosen.emit(name)

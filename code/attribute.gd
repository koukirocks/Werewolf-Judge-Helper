extends Button

signal chosen(Attribute)

enum {
	IN_MULTI_POPUP,
	IN_PLAYER_TAG
}

var status = IN_MULTI_POPUP
@export var needs = []
@export var color = "#000000"

func _ready():
	add_to_group("Attributes")
	add_theme_color_override("font_color",Color(color))
	add_theme_color_override("font_hover_color",Color(color))
	add_theme_color_override("font_pressed_color",Color(color))

func initialize():
	var nshow = false
	for need in needs:
		if need in $"../../../../..".Characters:
			nshow=true
	if needs[0]=="MUST" or nshow:
		visible=true
	else:
		visible = false

func _on_pressed():
	if status==IN_MULTI_POPUP:
		var tag = PackedScene.new()
		tag.pack(self)
		chosen.emit(tag)
	else:
		self.queue_free()

extends Button

signal chosen(Attribute)

enum {
	IN_MULTI_POPUP,
	IN_PLAYER_TAG
}

var status = IN_MULTI_POPUP

func _ready():
	add_to_group("Attributes")

func _on_pressed():
	if status==IN_MULTI_POPUP:
		var tag = PackedScene.new()
		tag.pack(self)
		chosen.emit(tag)
	else:
		self.queue_free()

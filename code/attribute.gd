extends Button

signal chosen(Attribute)

func _ready():
	add_to_group("Attributes")

func _on_pressed():
	chosen.emit(name)

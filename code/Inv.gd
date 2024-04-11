extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_character_selected(index):
	if get_node("../../../..").Characters[index]=="Witch":
		#print(get_node("../../../..").Characters[index])
		if $Cure.visible or $Poison.visible:
			visible=true
		else:
			visible = false
	else:
		visible=false

extends Button

signal character_chosen(name)
signal character_removed(name)

func _on_toggled(toggled_on):
	#print(get_name())
	if toggled_on:
		character_chosen.emit(get_name())
	else:
		character_removed.emit(get_name())


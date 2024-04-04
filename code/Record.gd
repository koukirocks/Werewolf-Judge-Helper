extends Button

@export var detect=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	if "MUST" in detect:
		visible=true
	else:
		visible=false
		for detector in detect:
			if detector in $"../../../..".Characters:
				visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

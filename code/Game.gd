extends Control


var Characters=[]
var PlayerCount=0
var PlayerScene = preload("res://Scene/player.tscn")

func init():
	var Player=PlayerScene.instantiate()
	Player.name="P1"
	get_node("SC/VBC").add_child(Player)
	get_node("SC/VBC/P1").initialize(Characters,1)
	$"SC/VBC".move_child($"SC/VBC/P1",0)
	print($"SC/VBC/P1".size)
	for i in range(2,PlayerCount+1):
		Player=PlayerScene.instantiate()
		Player.name="P%s" % i
		get_node("SC/VBC/P%s" % (i-1)).add_sibling(Player)
		get_node("SC/VBC/P%s" % i).initialize(Characters,i)
		#print("added P%s" % i)
		

extends PanelContainer

var CanChange=true
var Characters=["Villager","Witch","White","Cupid","Guard"]
var CurrentCharacter=0
var Translate={
	"Villager":"村民",
	"Prophet":"預言家",
	"Witch":"女巫",
	"Hunter":"獵人",
	"Knight":"騎士",
	"Idiot":"白癡",
	"Guard":"守衛",
	"Wolf":"小狼",
	"King":"狼王",
	"Black":"黑狼王",
	"White":"白狼王",
	"Snow":"雪狼",
	"Cupid":"邱比特",
	"Thief":"盜賊",
	"Bomber":"炸彈客"
}
var ColorId={
	"Villager":0,
	"Prophet":1,
	"Witch":1,
	"Hunter":1,
	"Knight":1,
	"Idiot":1,
	"Guard":1,
	"Wolf":2,
	"King":2,
	"Black":2,
	"White":2,
	"Snow":2,
	"Cupid":3,
	"Thief":3,
	"Bomber":3
}
var Colors=["#FFFFFF","#0000FF","#850000","#00FF00"]
var PlayerId=1

func initialize(_Characters,_PlayerId):
	Characters=_Characters
	PlayerId=_PlayerId
	$MC/VBC/HBC/ID.text=str(PlayerId)+"."
	$MC/VBC/HBC/Character.text=Translate[Characters[0]]
	$MC/VBC/HBC/Character.add_theme_color_override("font_color",Color(Colors[0]))
	$MC/VBC/HBC/ID.add_theme_font_size_override("font_size",120/len($MC/VBC/HBC/ID.text))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

signal _die(Id)

func _on_die_pressed():
	_die.emit(PlayerId)

func _on_die_confirmed(Id):
	if Id==PlayerId:
		visible=false


func _on_character_pressed():
	if CanChange:
		CurrentCharacter+=1
		CurrentCharacter%=len(Characters)
	$MC/VBC/HBC/Character.text=Translate[Characters[CurrentCharacter]]
	$MC/VBC/HBC/Character.add_theme_color_override("font_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_pressed_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_hover_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))

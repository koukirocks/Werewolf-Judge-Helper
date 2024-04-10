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
	"Witcher":"獵魔人",
	"Grave":"守墓人",
	"Crow":"烏鴉",
	"Bear":"馴熊師",
	"Dreamer":"攝夢人",
	"Psychic":"通靈師",
	"Wolf":"小狼",
	"King":"狼王",
	"Black":"黑狼王",
	"White":"白狼王",
	"Snow":"雪狼",
	"Blood":"血月使者",
	"Devil":"惡靈騎士",
	"Cupid":"邱比特",
	"Thief":"盜賊",
	"Bomber":"炸彈客",
	"Cursed":"咒狐"
}
var ColorId={
	"Villager":0,
	"Prophet":1,
	"Witch":1,
	"Hunter":1,
	"Knight":1,
	"Idiot":1,
	"Guard":1,
	"Witcher":1,
	"Grave":1,
	"Crow":1,
	"Bear":1,
	"Dreamer":1,
	"Psychic":1,
	"Wolf":2,
	"King":2,
	"Black":2,
	"White":2,
	"Snow":2,
	"Blood":2,
	"Devil":2,
	"Cupid":3,
	"Thief":3,
	"Bomber":3,
	"Cursed":3
}
var Colors=["#FFFFFF","#0000FF","#850000","#00FF00"]
var PlayerId=1

func initialize(_Characters,_PlayerId):
	Characters=_Characters
	PlayerId=_PlayerId
	$MC/VBC/HBC/ID.text=str(PlayerId)+"."
	$PC/MC2/HBC/ID.text=str(PlayerId)+"號玩家"
	$MC/VBC/HBC/Character.text=Translate[Characters[0]]
	$MC/VBC/HBC/Character.add_theme_color_override("font_color",Color(Colors[0]))
	$MC/VBC/HBC/ID.add_theme_font_size_override("font_size",float(120)/len($MC/VBC/HBC/ID.text))
	add_to_group("Players")

func control_lock(locked):
	if locked:
		$MC/VBC/HBC/IsPolice.mouse_filter = MOUSE_FILTER_IGNORE
		$MC/VBC/HBC/IsCouple.mouse_filter = MOUSE_FILTER_IGNORE
		$MC/VBC/HBC/Character.mouse_filter = MOUSE_FILTER_IGNORE
	else:
		$MC/VBC/HBC/IsPolice.mouse_filter = MOUSE_FILTER_PASS
		$MC/VBC/HBC/IsCouple.mouse_filter = MOUSE_FILTER_PASS
		$MC/VBC/HBC/Character.mouse_filter = MOUSE_FILTER_PASS

func AskBool(statement):
	return await $"../../..".bool_popup(statement)

func AskMulti():
	return await $"../../..".multi_popup()

func _on_die_pressed():
	var sure = await AskBool("確定 %s號玩家 死亡？" % PlayerId)
	if sure:
		$PC.visible = true
		$MC/VBC/HBC/IsPolice.button_pressed = false
		$MC/VBC/GridContainer.visible = false

func _on_character_pressed():
	if CanChange:
		CurrentCharacter+=1
		CurrentCharacter%=len(Characters)
	$MC/VBC/HBC/Character.text=Translate[Characters[CurrentCharacter]]
	$MC/VBC/HBC/Character.add_theme_color_override("font_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_pressed_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_hover_color",Color(Colors[ColorId[Characters[CurrentCharacter]]]))

func _on_cure_pressed():
	var sure = await AskBool("確定使用解藥？")
	if sure:
		$"MC/VBC/HBC/Witch Inv/Cure".visible = false
		if !$"MC/VBC/HBC/Witch Inv/Poison".visible and !$"MC/VBC/HBC/Witch Inv/Cure".visible:
			$"MC/VBC/HBC/Witch Inv".visible = false

func _on_poison_pressed():
	var sure = await AskBool("確定使用毒藥？")
	if sure:
		$"MC/VBC/HBC/Witch Inv/Poison".visible = false
		if !$"MC/VBC/HBC/Witch Inv/Poison".visible and !$"MC/VBC/HBC/Witch Inv/Cure".visible:
			$"MC/VBC/HBC/Witch Inv".visible = false

signal add_tag(name)

func _on_add_pressed():
	var result = await AskMulti()
	var tag = result.instantiate()
	tag.status = tag.IN_PLAYER_TAG
	$MC/VBC/GridContainer.add_child(tag)
	

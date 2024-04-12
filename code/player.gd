extends PanelContainer

var CanChange=true
var Characters=["Villager"]
var CurrentCharacter=0
var Colors
var PlayerId=1
var Translate
var ColorId

func initialize(_Characters,_PlayerId):
	$"MC/VBC/HBC/Witch Inv/Cure".visible = true
	$"MC/VBC/HBC/Witch Inv/Poison".visible = true
	Translate = $"/root/Main/GameConstant".Translate
	ColorId = $"/root/Main/GameConstant".ColorId
	Colors = $"/root/Main/GameConstant".Colors
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

func AskList():
	return await $"../../..".list_popup()

func _on_die_pressed():
	var sure = await AskBool("確定 %s號玩家 死亡？" % PlayerId)
	if sure:
		$PC.visible = true
		$MC/VBC/HBC/IsPolice.button_pressed = false
		$MC/VBC/GridContainer.visible = false

signal switched_char(newname)

func _on_character_pressed():
	var newname = await AskList()
	$MC/VBC/HBC/Character.text=Translate[newname]
	$MC/VBC/HBC/Character.add_theme_color_override("font_color",Color(Colors[ColorId[newname]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_pressed_color",Color(Colors[ColorId[newname]]))
	$MC/VBC/HBC/Character.add_theme_color_override("font_hover_color",Color(Colors[ColorId[newname]]))
	switched_char.emit(newname)

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
	

extends Node2D
@onready var ui = $UI
signal cancelKeyPressed
var SceneDict:Dictionary = {"Basic wall":preload("res://scenes/basic_wall.tscn")}
var Loadscene:PackedScene

func _input(event):
	if event is InputEventKey: 
		if Input.is_action_just_pressed("ui_cancel"):
			emit_signal("cancelKeyPressed")
	
func _on_test_unit_selected(isSelected:bool, unitSelected):
	if(isSelected):
		GlobalScript.set_Locked(unitSelected)
		ui.changeTxt("Selection", unitSelected.unitName)
	else:
		GlobalScript.set_Locked(null)
		ui.changeTxt("Selection","Nothing Selected")


func _on_interaction_menu(function, params):
	match function:
		"Build":
			Loadscene=SceneDict[params]
			var scene_instance = Loadscene.instantiate()
			scene_instance.set_name(params)
			add_child(scene_instance)

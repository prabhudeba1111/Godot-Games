extends Node


var selected_map := ""
var mainNode : Node2D 
var turretsNode : Node2D
var projectilesNode : Node2D
var currentMap : Node2D
var hud : Control

func restart_current_level():
	var currentLevelScene := load(currentMap.scene_file_path)
	get_tree().change_scene_to_packed(currentLevelScene)
	#currentMap.queue_free()
	#var newMap = currentLevelScene.instantiate()
	#mainNode.add_child(newMap)
	#hud.reset()

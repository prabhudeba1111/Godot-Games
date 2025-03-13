extends Node

@warning_ignore("unused_signal")
signal goldChanged(newGold)
@warning_ignore("unused_signal")
signal baseHpChanged(newHp)


var selected_map :String = ""
var mainNode : Node2D 
var turretsNode : Node2D
var currentMap : Node2D
var tileMapNode : TileMapLayer
var hud : Control

func restart_current_level():
	var currentLevelScene := load(currentMap.scene_file_path)
	currentMap.queue_free()
	var newMap = currentLevelScene.instantiate()
	newMap.level = selected_map
	hud.call_deferred("_ready")
	mainNode.add_child(newMap)

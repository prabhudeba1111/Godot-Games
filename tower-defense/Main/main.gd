extends Node2D

var map_node

var build_mode :bool = false
var build_valid :bool = false
var build_location
var build_type

var occupied_tiles :Array = []


func _ready() -> void:
	Globals.mainNode = self
	var selectedMapScene := load(GameData.levels[Globals.selected_map]["scene"])
	var level = selectedMapScene.instantiate()
	level.level = Globals.selected_map
	add_child(level)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()


func toggle_pause() -> void:
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	if not is_instance_valid(Globals.hud.get_node("PauseUI")):
		var gamePauseScene :PackedScene = preload("res://UI/pause_ui.tscn")
		var gamePause :CanvasLayer = gamePauseScene.instantiate()
		Globals.hud.add_child(gamePause)
	else:
		Globals.hud.get_node("PauseUI").queue_free()

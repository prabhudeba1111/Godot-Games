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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

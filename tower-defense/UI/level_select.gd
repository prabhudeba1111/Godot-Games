extends Control

@onready var level_selection = $Panel/LevelContainer


var button_scene = preload("res://UI/level_preview.tscn")


func _ready() -> void:
	populate_levels()

func populate_levels():
	for child in level_selection.get_children():
		child.queue_free()
	
	for level in GameData.levels.keys():
		var button = button_scene.instantiate()
		button.get_node("TextureButton").get_node("LevelName").text = str(GameData.levels[level]["name"])
		button.get_node("TextureButton").get_node("LevelPicture").texture = load(GameData.levels[level]["sprite"])
		button.get_node("TextureButton").pressed.connect(func(): select_level(level))
		level_selection.add_child(button)


func select_level(level):
	Globals.selected_map = level
	print(GameData.levels[level]["scene"])
	get_tree().change_scene_to_file(GameData.levels[level]["scene"])
	#var levelScene :PackedScene = load(GameData.levels[level]["scene"])
	#print(levelScene)
	#var curr_level = levelScene.instantiate()
	#curr_level.level = level
	#get_tree().change_scene_to_packed(curr_level) 

extends Control

@onready var level_selection = $Panel/LevelContainer


var button_scene = preload("res://UI/level_preview.tscn")


func _ready() -> void:
	populate_levels()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_parent().get_node("Panel").show()
		queue_free()


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
	get_tree().change_scene_to_file("res://Main/main.tscn")

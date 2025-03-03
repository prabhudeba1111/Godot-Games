extends Control

@onready var tower_selection  = $Towers/TowerContainer
@onready var health_label :Label = $Stats/HealthPanel/HealthLabel
@onready var money_label :Label = $Stats/MoneyPanel/MoneyLabel
#@onready var tower_preview :Sprite2D = $Towers/TowerPreview

var selected_tower = null


var button_scene = preload("res://UI/tower_preview.tscn")

func _ready() -> void:
	populate_tower_buttons()


func populate_tower_buttons() -> void:
	for child in tower_selection.get_children():
		child.queue_free()
		
	for tower_name in GameData.towers.keys():
		var button_scene = load("res://UI/tower_preview.tscn")
		var button = button_scene.instantiate()
		
		button.get_node("TextureButton").texture_normal = load(GameData.towers[tower_name]["sprite"])
		button.get_node("Cost").text = str(GameData.towers[tower_name]["cost"])
		button.get_node("TextureButton").pressed.connect(func(): select_tower(tower_name))
		tower_selection.add_child(button)


func select_tower(tower_name):
	selected_tower = tower_name
	print(tower_name)
	tower_preview.texture = load(GameData.towers[tower_name]["sprite"])


func updateHealth(value: int) -> void:
	health_label.text = str(value)


func updateMoney(value: int) -> void:
	money_label.text = str(value)

extends Control

@onready var tower_selection  = $Towers/TowerContainer


var button_scene = preload("res://UI/tower_preview.tscn")

func _ready() -> void:
	Globals.hud = self
	Globals.baseHpChanged.connect(updateHealth)
	Globals.goldChanged.connect(updateMoney)
	populate_tower_buttons()


func populate_tower_buttons() -> void:
	for child in tower_selection.get_children():
		child.queue_free()
		
	for tower in GameData.towers.keys():
		var button = button_scene.instantiate()
		
		button.get_node("TextureButton").texture_normal = load(GameData.towers[tower]["sprite"])
		button.get_node("Cost").text = str(GameData.towers[tower]["cost"])
		button.get_node("TextureButton").pressed.connect(func(): select_tower(tower))
		tower_selection.add_child(button)


func select_tower(tower):
	var turretScene :PackedScene = preload("res://Towers/turret_base.tscn")
	var turret :Node2D = turretScene.instantiate()
	turret.position = get_global_mouse_position() - Vector2(1000, 0)
	turret.turret_type = tower
	Globals.turretsNode.add_child(turret)


func set_tower_preview(tower, mouse_pos):
	var tower_preview = load(GameData.towers[tower]["sprite"]).instantiate()
	


func updateHealth(value: int) -> void:
	%HealthLabel.text = str(value)


func updateMoney(value: int) -> void:
	%MoneyLabel.text = str(value)

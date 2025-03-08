extends Control

@onready var tile_map :TileMapLayer


var button_scene = preload("res://UI/tower_button.tscn")
var curr_preview: Sprite2D = null
var curr_range: Node2D = null
var curr_tower_type: String = ""
var tower_cost: int 
var build_mode: bool = false
var can_build: bool = false
var occupied_tiles: Array[Vector2i] = []

func _ready() -> void:
	Globals.hud = self
	Globals.baseHpChanged.connect(updateHealth)
	Globals.goldChanged.connect(updateMoney)
	populate_tower_buttons()


func _process(delta: float) -> void:
	if build_mode and curr_preview:
		var mouse_pos = get_global_mouse_position()
		var tile_pos = tile_map.local_to_map(mouse_pos)
		var world_pos = tile_map.map_to_local(tile_pos)
		
		curr_preview.global_position = world_pos
		curr_range.global_position = world_pos
		
		if is_valid_pos(tile_pos) and Globals.currentMap.gold >= tower_cost:
			can_build = true
			curr_preview.modulate = Color(1, 1, 1, 0.5)
		else:
			can_build = false
			curr_preview.modulate = Color(1, 0, 0, 0.5)

func _input(event: InputEvent) -> void:
	if build_mode and curr_preview:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_pos = get_global_mouse_position()
				var tile_pos = tile_map.local_to_map(mouse_pos)
				
				if can_build:
					Globals.currentMap.gold -= tower_cost
					place_tower(tile_map.map_to_local(tile_pos))
					occupied_tiles.append(tile_pos)
					cancel_build_mode()
			elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
				cancel_build_mode()

func place_tower(turret_pos):
	var turret_instance = load("res://Towers/turret_base.tscn").instantiate()
	turret_instance.turret_type = curr_tower_type
	turret_instance.global_position = turret_pos
	get_parent().add_child(turret_instance)

func populate_tower_buttons() -> void:
	for child in %TowerContainer.get_children():
		child.queue_free()
	
	for tower in GameData.towers.keys():
		var button = button_scene.instantiate()
		
		button.get_node("TextureButton").texture_normal = load(GameData.towers[tower]["sprite"])
		button.get_node("Cost").text = str(GameData.towers[tower]["cost"])
		button.get_node("TextureButton").pressed.connect(func(): set_tower_preview(tower))
		%TowerContainer.add_child(button)


func is_valid_pos(tile_pos: Vector2i) -> bool:
	var tile_id :Vector2i = tile_map.get_cell_atlas_coords(tile_pos)
	var invalid_turret_tiles :Array = [Vector2i(1, 4), Vector2i(21, 2), Vector2i(22, 2)]
	return not tile_id in invalid_turret_tiles and not tile_pos in occupied_tiles


func set_tower_preview(tower):
	if curr_preview:
		cancel_build_mode()
	
	build_mode = true
	tower_cost = GameData.towers[tower]["cost"]
	curr_tower_type = tower
	curr_preview = Sprite2D.new()
	curr_preview.texture = load(GameData.towers[tower]["sprite"])
	add_child(curr_preview)
	
	curr_range = draw_range(GameData.towers[curr_tower_type]["stats"]["attack_range"])
	add_child(curr_range)	
	
	set_process(true)


func draw_range(range: float):
	var indicator = Line2D.new()
	indicator.width = 2.0 
	indicator.default_color = Color(1, 1, 1, 0.8)
	
	var points: Array[Vector2] = []
	var step = 20
	for i in range(step + 1):
		var angle = 2 * PI * i / step
		var point = Vector2(cos(angle), sin(angle)) * range
		points.append(point)
	indicator.points = points
	return indicator


func cancel_build_mode() -> void:
	if curr_preview:
		curr_preview.queue_free()
		curr_preview = null
	if curr_range:
		curr_range.queue_free()
		curr_range = null
	build_mode = false
	can_build = false
	curr_tower_type = ""
	
	set_process(false)
	
	
func updateHealth(value: int) -> void:
	%HealthLabel.text = str(value)


func updateMoney(value: int) -> void:
	%MoneyLabel.text = str(value)

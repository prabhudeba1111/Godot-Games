extends PathFollow2D

var enemy_type := "":
	set(val):
		enemy_type = val
		$Sprite2D.texture = load(GameData.enemies[val]["sprite"])
		for stat in GameData.enemies[val]["stats"].keys():
			set(stat, GameData.enemies[val]["stats"][stat])

var speed :int
var goldYield :int
var hp :int
var baseDamage :int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_offset = randf_range(-10, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += 0.0005 * speed * delta
	#print(progress_ratio)
	if progress_ratio == 1:
		finished_path()

func finished_path():
	print(baseDamage)
	get_parent().get_parent().base_damaged(baseDamage)
	queue_free()

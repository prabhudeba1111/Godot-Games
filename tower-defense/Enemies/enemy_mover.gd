extends PathFollow2D

var enemy_type :String = "":
	set(val):
		enemy_type = val
		$Sprite2D.texture = load(GameData.enemies[val]["sprite"])
		for stat :String in GameData.enemies[val]["stats"].keys():
			set(stat, GameData.enemies[val]["stats"][stat])

var speed :int
var goldYield :int
var hp :int
var baseDamage :int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	v_offset = randf_range(-20, 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_ratio += 0.0005 * speed * delta
	#print(progress_ratio)
	if progress_ratio == 1:
		finished_path()

func finished_path() -> void:
	get_parent().get_parent().base_damaged(baseDamage)
	queue_free()

func take_damage(damage: int) -> void:
	hp -= damage
	damage_animation()
	if hp <= 0:
		# give gold
		queue_free()

func damage_animation() -> void:
	var tween :Tween = create_tween()
	tween.tween_property(self, "modulate", Color.ORANGE_RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)

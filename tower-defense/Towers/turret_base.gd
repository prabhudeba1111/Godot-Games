extends StaticBody2D
class_name TurretBase

var turret_type :String = "":
	set(value):
		turret_type = value
		var bodyscene :PackedScene = load(GameData.towers[value]["scene"])
		var Body :StaticBody2D= bodyscene.instantiate()
		add_child(Body)
		Body.bullet_scene = load(GameData.towers[value]["bullet"])
		Body.set_script(load("res://Towers/turret_body.gd"))
		for stat :String in GameData.towers[value]["stats"].keys():
			set(stat, GameData.towers[value]["stats"][stat])
		
		var new_shape :CircleShape2D = CircleShape2D.new()
		new_shape.radius = attack_range
		$TurretBody/Range/CollisionShape2D.shape = new_shape
		$TurretBody/AttackCD.wait_time = 1 / attack_speed


var attack_damage :int
var attack_speed :float
var attack_range :float
var bulletSpeed :int

var level :int = 1


func _ready() -> void:
	$Base.texture = load(GameData.tower_level[str(level)]["sprite"])

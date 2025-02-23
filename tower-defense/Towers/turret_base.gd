extends StaticBody2D
class_name TurretBase

var turret_type := "":
	set(value):
		turret_type = value
		$TurretBody/Sprite2D.texture = load(GameData.towers[value]["sprite"])
		for stat in GameData.towers[value]["stats"].keys():
			set(stat, GameData.towers[value]["stats"][stat])
		
		var new_shape = CircleShape2D.new()
		new_shape.radius = attack_range
		$TurretBody/Area2D/CollisionShape2D.shape = new_shape
		$AttackCD.wait_time = 1 / attack_speed

@export var bullet_scene :PackedScene= preload("res://Towers/Bullets/sniper_bullet.tscn")

var damage :int
var attack_speed :float
var attack_range :float
var bulletSpeed :int

var level :int = 1
var target :CharacterBody2D = null
var enemies_in_range = []

@onready var fire_point = $TurretBody/FirePoint
@onready var turret_body = $TurretBody


func _ready() -> void:
	$Base.texture = load(GameData.tower_level[str(level)]["sprite"])
	$AttackCD.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		var direction = (target.global_position - turret_body.global_position).normalized()
		var angle = direction.angle()
		turret_body.rotation = lerp_angle(turret_body.rotation, angle, 5 * delta)
	
func _on_attack_cd_timeout() -> void:
	if target and is_instance_valid(target):
		fire_bullet()

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = fire_point.position
	bullet.target = target
	get_node("Projectiles").add_child(bullet)

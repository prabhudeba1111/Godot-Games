extends StaticBody2D

@export var bullet_scene :PackedScene= preload("res://Towers/Bullets/sniper_bullet.tscn")

var target :CharacterBody2D = null
var enemies_in_range = []

var attack_damage :int = 150
var fire_rate :float = 0.5
var rotation_speed :float = 10.0

@onready var turret = $Turret
@onready var fire_point = $Turret/FirePoint



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackCD.wait_time = 1 / fire_rate
	$AttackCD.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		var direction = (target.global_position - turret.global_position).normalized()
		var angle = direction.angle()
		turret.rotation = lerp_angle(turret.rotation, angle, rotation_speed * delta)


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		enemies_in_range.append(body)
		update_target()

func _on_range_body_exited(body: Node2D) -> void:
	if body in enemies_in_range:
		enemies_in_range.erase(body)
	update_target()

func update_target():
	if enemies_in_range.is_empty():
		target = null
		return
	target = enemies_in_range[0]

func _on_attack_cd_timeout() -> void:
	if target and is_instance_valid(target):
		fire_bullet()

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = fire_point.position
	bullet.target = target
	add_child(bullet)

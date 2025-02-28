extends TurretBase

@onready var bullet_scene :PackedScene
@onready var fire_points :Array = find_children("", "Marker2D")

var enemies_in_range :Array = []
var curr_fire_point :int = 0
var target :CharacterBody2D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AttackCD.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		var direction :Vector2 = (target.global_position - global_position).normalized()
		var angle :float = direction.angle()
		rotation = lerp_angle(rotation, angle, 10 * delta)


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		enemies_in_range.append(body)
		update_target()

func _on_range_body_exited(body: Node2D) -> void:
	if body in enemies_in_range:
		enemies_in_range.erase(body)
	update_target()


func update_target() -> void:
	if enemies_in_range.is_empty():
		target = null
		return
	target = enemies_in_range[0]


func _on_attack_cd_timeout() -> void:
	if target and is_instance_valid(target):
		fire_bullet()


func fire_bullet() -> void:
	var fire_point :Marker2D = fire_points[curr_fire_point]
	curr_fire_point = (curr_fire_point+1) % fire_points.size()
	var bullet :Area2D = bullet_scene.instantiate()
	bullet.position = fire_point.position
	bullet.target = target
	get_node("Projectiles").add_child(bullet)

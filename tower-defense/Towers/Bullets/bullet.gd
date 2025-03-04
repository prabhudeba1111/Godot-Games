extends Area2D


var speed :int
var target :CharacterBody2D = null
var turret :Node2D

func _ready() -> void:
	turret = get_parent().get_parent().get_parent()
	speed = turret.bulletSpeed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		var direction :Vector2 = (target.global_position - global_position).normalized()
		look_at(target.global_position)
		global_position += direction * speed * delta
	else:
		queue_free()

func hit_target() -> void:
	var damage :int = turret.attack_damage
	target.get_parent().take_damage(damage)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		hit_target()

class_name EnemyIdle extends EnemyState

var move_direction: Vector2
var wander_time: float
var move_speed = 50

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy.modulate = Color("yellow")
	randomize_wander()

func randomize_wander():
	move_direction = Vector2(
		randf_range(-1, 1), randf_range(-1, 1)
	)
	wander_time = randf_range(1, 4)

func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	

func PhysicsUpdate(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
	var dir = player.global_position - enemy.global_position
	if dir.length() < 100:
		Transitioned.emit(self, "follow")

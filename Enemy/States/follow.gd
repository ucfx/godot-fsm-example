class_name EnemyFollow extends EnemyState

var move_speed = 90
var move_direction: Vector2
@export var enemy: CharacterBody2D
var player: CharacterBody2D

func Enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	enemy.modulate = Color("red")

func Update(_delta: float):
	move_direction = player.global_position - enemy.global_position
	

func PhysicsUpdate(_delta: float):
	if move_direction.length() > 40:
		enemy.velocity = move_direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2.ZERO

	if move_direction.length() > 150:
		Transitioned.emit(self, 'idle')

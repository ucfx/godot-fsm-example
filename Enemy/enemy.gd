class_name Enemy extends CharacterBody2D

func _ready() -> void:
	position = Vector2(200, 200)

func _physics_process(_delta: float) -> void:
	move_and_slide()

class_name StateMachine extends Node

@export var init_state: EnemyState
var current_state: EnemyState

var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is EnemyState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if init_state:
		init_state.Enter()
		current_state = init_state

func _process(delta: float) -> void:
	current_state.Update(delta)

func _physics_process(delta: float) -> void:
	current_state.PhysicsUpdate(delta)

func on_child_transition(state, new_state_name):
	if current_state != state: 
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("new state not found: " + new_state_name)
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state

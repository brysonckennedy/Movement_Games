class_name StateMachine
extends Node


@export var current_state : State

var state_dict : Dictionary = {}


func init() -> void:
	for child in get_children():
		if child is State:
			state_dict[child.name] = child
			child.transition_state.connect(change_state)
		else:
			push_warning("Child of StateMachine is not in State class")
	current_state.enter()

func process_input(event : InputEvent) -> void:
	current_state.process_input(event)

func process_frame(delta : float) -> void:
	current_state.process_frame(delta)

func process_physics(delta : float) -> void:
	current_state.process_physics(delta)

func change_state(new_state_name : StringName) -> void:
	if new_state_name in state_dict.keys():
		if new_state_name != current_state.name:
			current_state.exit()
			current_state = state_dict[new_state_name]
			current_state.enter()
	else:
		push_warning("State Transition Failed. New state not in State Dictionary")

extends CardState


func enter() -> void:
	# Childen gets ready first, so need to wait for everything
	if not card_ui.is_node_ready():
		await card_ui.ready

	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()

	# Emit the signal to so the hand reparents the card
	# Useful when going back to base state
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.WEB_GREEN
	card_ui.state.text = "BASE"

	# Makes so the card follows the mouse and not offset
	card_ui.pivot_offset = Vector2.ZERO


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

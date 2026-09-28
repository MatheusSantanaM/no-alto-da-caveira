extends Node2D

@onready var label: Label = $Resultado

func _ready() -> void:
	if GameState.last_result_won:
		label.text = "Dia %d concluído! Avançando..." % GameState.current_day
		GameState.current_day += 1
	else:
		label.text = "Você falhou o dia %d. Tentando de novo..." % GameState.current_day


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_continue_button_up() -> void:
	get_tree().change_scene_to_file("res://Cenas/game.tscn")

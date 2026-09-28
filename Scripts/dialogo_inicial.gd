extends Node2D

var dialogos: Array[String] = [
	"Você acordou mais uma vez, infelizmente",
	"É hora de voltar ao trabalho, aquele maldito trabalho",
	"Por mais que odeie, tem de fazê-lo",
	"Se não for você a matar aqueles que conhece",
	"Serão eles"
]
var indice_atual: int = 0

@onready var label_texto: Label = $Label
func _ready() -> void:
	mostrar_proxima_fala()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		avancar_dialogo()
		
func avancar_dialogo() -> void:
	indice_atual += 1
	if indice_atual < dialogos.size():
		mostrar_proxima_fala()
	else:
		fim_do_dialogo()
		
func mostrar_proxima_fala() -> void:
	label_texto.text = dialogos[indice_atual]

func fim_do_dialogo() -> void:
	get_tree().change_scene_to_file("res://Cenas/game.tscn")

func _process(delta: float) -> void:
	pass

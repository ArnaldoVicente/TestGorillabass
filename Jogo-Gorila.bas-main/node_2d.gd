extends Node2D

@onready var velocidadeInput: LineEdit = $velocidadeInput
@onready var anguloInput: LineEdit = $anguloInput
@onready var shoot_button: Button = $shootButton
@onready var scene_root: Node2D = get_parent()

# Pré-carregar a cena do projétil
var projeteis_scene = preload("res://Banana.png")

func _ready():
	shoot_button.connect("pressed", _on_shoot_button_pressed)

func _on_shoot_button_pressed():
	var velocidade = velocidadeInput.text.to_float()
	var angulo = anguloInput.text.to_float()

	# Cria uma nova instância do projétil
	var projeteis_instance = projeteis_scene.instance()
	
	# Configura a posição do projétil na posição do nó pai
	projeteis_instance.position = position
	
	# Define a rotação do projétil (em radianos)
	projeteis_instance.rotation_degrees = angulo
	
	# Define a velocidade do projétil
	projeteis_instance.speed = velocidade
	
	# Adiciona o projétil à cena
	scene_root.add_child(projeteis_instance)

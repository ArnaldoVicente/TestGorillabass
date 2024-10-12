extends CharacterBody2D

var speed = 0.0
var angle = 0.0
var gravity = 98.0  # Constante de gravidade (ajustável)

var ATIVAR = false
const JUMP_VELOCITY = -100.0

@onready var banana: CharacterBody2D = $"." # Certifique-se que Banana é um RigidBody2D
@onready var velocidadeInput: LineEdit = $".".get_parent().get_node("UI/velocidadeInput")
@onready var anguloInput: LineEdit = $".".get_parent().get_node("UI/anguloInput")
@onready var launchButton: Button = $".".get_parent().get_node("UI/LaunchButton")
@onready var gorilla1: CharacterBody2D = $".".get_parent().get_node("Gorilla1")

func _ready():
	print("Pressione o botão para lançar a banana.")
	banana.visible = false  # Deixar invisível até o lançamento
	launchButton.pressed.connect(_on_launch)  # Conecta o botão à função de lançamento

func _physics_process(delta: float) -> void:
	if banana.visible:
		# Aplicar a gravidade e mover a banana
		banana.velocity.y += gravity * delta
		banana.move_and_slide()
	if ATIVAR:
		gorilla1.velocity.y = JUMP_VELOCITY
		ATIVAR = false
	gorilla1.move_and_slide()

func _on_launch() -> void:
	# Inicializar os parâmetros de velocidade e ângulo
	
	speed = float(velocidadeInput.text)
	angle = float(anguloInput.text)
	ATIVAR = true
	var angle_radians = deg_to_rad(angle)
	var initial_velocity = Vector2(abs(cos(angle_radians)), -sin(angle_radians)) * speed
	
	banana.visible = true  # Torna a banana visível ao lançar
	banana.velocity = initial_velocity  # Define a velocidade inicial da banana
	print("Banana lançada!")

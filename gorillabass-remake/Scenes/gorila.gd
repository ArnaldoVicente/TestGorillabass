extends Node2D

# Variáveis para o pulo do gorila
var jump_force = Vector2(0, -200)  # Força do pulo
var gravity = 500  # Gravidade que afeta o gorila
var velocity = Vector2()  # Velocidade atual do gorila

# Variáveis de controle
var is_jumping = false  # Verifica se o gorila está no ar

# Referência à cena da banana
var banana_scene = preload("res://Scenes/Banana.tscn")

# Funções de UI para receber os inputs de força e ângulo
var force_input = null  # Campo de texto para força
var angle_input = null  # Campo de texto para o ângulo

func _ready():
	# Referenciar os campos de texto da UI
	force_input = $ForceInput  # Nome do campo de texto para força
	angle_input = $AngleInput  # Nome do campo de texto para ângulo

	# Verificar se o botão existe
	var launch_button = $LaunchButton
	
	if launch_button == null:
		print("Erro: O botão 'LaunchButton' não foi encontrado!")
	else:
		# Conectar o botão se ele existir
		launch_button.connect("pressed", Callable(self, "_on_LaunchButton_pressed"))

func _physics_process(delta):
	if is_jumping:
		# Aplicar gravidade
		velocity.y += gravity * delta
		position.y += velocity.y * delta
		
		# Parar o pulo quando o gorila voltar ao solo
		if position.y >= 400:  # Supondo que o solo está na posição Y = 400
			position.y = 400
			velocity.y = 0
			is_jumping = false

# Função chamada quando o botão for pressionado
func _on_LaunchButton_pressed():
	arremessar_banana()  # Chama a função que arremessa a banana

# Função para lançar a banana e fazer o gorila pular
func arremessar_banana():
	if not is_jumping:
		# Iniciar o pulo
		velocity.y = jump_force.y
		is_jumping = true
	
	# Obter valores de força e ângulo dos campos de texto
	var force = float(force_input.text)  # Converte o texto para float
	var angle = (float(angle_input.text))  # Converte o texto para float e transforma para radianos
	
	# Criar e lançar a banana
	var banana = banana_scene.instance()
	get_parent().add_child(banana)
	banana.position = position  # A banana é lançada da posição do gorila
	
	# Aplicar uma força para a banana
	if banana is RigidBody2D:
		# Para RigidBody2D, usamos apply_impulse()
		banana.apply_impulse(Vector2.ZERO, Vector2(cos(angle) * force, sin(angle) * force))
	elif banana is RigidBody2D:
		# Para KinematicBody2D, usamos move_and_slide()
		var velocity = Vector2(cos(angle) * force, sin(angle) * force)
		banana.move_and_slide(velocity)

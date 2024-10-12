extends Node2D

# Variáveis para o gorila
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

	# Conectar o botão se ele existir
	var launch_button = $LaunchButton
	if launch_button:
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

# Função para lançar a banana
func arremessar_banana():
	# Validar a entrada de texto e lançar a banana
	if angle_input.text != "" and force_input.text != "":
		var force = float(force_input.text)  # Converte o texto para float
		var angle = float(angle_input.text) * PI / 180.0  # Converte o texto para float e transforma em radianos
		
		# Criar e lançar a banana
		var banana = banana_scene.instantiate()  # Cria uma nova banana
		get_parent().add_child(banana)
		banana.position = position + Vector2(0, -10)  # Lança a banana um pouco acima do gorila
		
		# Calcular a velocidade da banana
		var banana_velocity = Vector2(cos(angle) * force, sin(angle) * force)

		# Se a banana for um RigidBody2D, aplique impulso
		if banana is RigidBody2D:
			banana.apply_impulse(Vector2.ZERO, banana_velocity)  # Aplique a velocidade inicial
		elif banana is RigidBody2D:
			banana.move_and_slide(banana_velocity)  # Mova a banana com a velocidade calculada
	else:
		print("Erro: Campos de força ou ângulo estão vazios ou inválidos")

# Função para pular
func pular():
	if not is_jumping:
		velocity.y = jump_force.y
		is_jumping = true

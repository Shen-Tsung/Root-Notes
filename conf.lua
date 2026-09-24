function love.conf(t)
	t.window.highdpi = true
	t.window.usedpiscale = true
	t.window.resizable = true

	t.window.width = 392
	t. window.height = 856
	
	-- Доступ к памяти
	t.externalstorage = true
	
	-- Отключение модулей для оптимизации
	t.modules.audio = false
    t.modules.joystick = false
    t.modules.mouse = false
    t.modules.physics = false
    t.modules.sound = false
	t.modules.video = false
end
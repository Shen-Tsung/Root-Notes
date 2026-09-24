function love.conf(t)
	t.window.width = 1
	t.window.height = 2
	
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
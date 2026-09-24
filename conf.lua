function love.conf(t)
	t.window.highdpi = true
	t.window.usedpiscale = true
	t.window.resizable = true
	
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
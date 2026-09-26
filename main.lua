local settings = require "Assets/settings" -- Загрузка настроек
local ui = require "Assets/ui" -- Загрузка интерфейса
local Width, Height

local t = {} -- Текст
local color = {} -- Цвета
local font = {} -- Шрифты
local touch = {} -- Касания
local button = {} -- Кнопки
local scroll = {} -- Скролл области


-- Загрузка данных
function love.load()
	Width, Height = love.graphics.getDimensions() -- Ширина и высота экрана
	
	-- Подбор языка
	local lang = require "Assets/lang"
	t = lang[settings.language]
	
	-- Загрузка шрифта
	font.regular = love.graphics.newFont("Fonts/inter.ttf", settings.font_size)
	font.small = love.graphics.newFont("Fonts/inter.ttf", settings.font_size / 2.5)
	love.graphics.setFont(font.regular)
	
	-- Подбор темы
	if settings.theme == "dark" then
		color.bg = {0.2, 0.1, 0} -- Цвет фона
		color.area = {0.15, 0.05, 0} -- Цвет области
		color.shadow = {0.13, 0.06, 0} -- Цвет тени
		color.object = {0.4, 0.2, 0} -- Основной цвет объекта
		color.object2 = {0.3, 0.15, 0} -- Второй цвет объекта
		color.text = {1 , 0.9, 0.8} -- Основной цвет текста
		color.text2 = {0.8, 0.7, 0.6} -- Второй цвет текста
	elseif settings.theme == "light" then
		color.bg = {1, 0.8, 0.6}
		color.area = {0.8, 0.7, 0.7}
		color.shadow = {0.3, 0.23, 0.2}
		color.object = {0.9, 0.7, 0.6}
		color.object2 = {0.7, 0.5, 0.4}
		color.text = {0.5, 0.25, 0.1}
		color.text2 = {0, 0, 0}
	end
	
	love.graphics.setBackgroundColor(color.bg)
	
	-- Интерфейс
	ui.init(Width, Height, color, font, touch) -- Передача данных в ui.lua
	
	-- Создание кнопок ui.button.new(text, x, y, w, h)
	
	-- Создание скролл области ui.scroll.new(x, y, w, h)
	scroll.notes = ui.scroll.new(Width / 2, Height / 2, Width, Height / 1.4)
	scroll.notes_element = {}
	for i = 1, 20 do
		scroll.notes_element[i] = ui.scroll.new_element(scroll.notes, t.yes)
		ui.scroll.add_element(scroll.notes, scroll.notes_element[i])
	end
end

function love.resize()
	Width, Height = love.graphics.getDimensions()
	ui.scroll.move(scroll.notes, Width / 2, Height / 2)
	scroll.notes.w = Width
	scroll.notes.h = Height / 1.4

	for i = 1, #scroll.notes_element do
		scroll.notes_element[i].x = (scroll.notes.w - scroll.notes.w / 1.2) / 2
		scroll.notes_element[i].y = (scroll.notes.h / 9) * i
		scroll.notes_element[i].w = scroll.notes.w / 1.2
		scroll.notes_element[i].h = scroll.notes.h / 10
	end
end

-- Обновление
function love.update(dt)
	
end

-- Отрисовка
function love.draw()
	ui.scroll.draw(scroll.notes) 
end

-- Обработка касаний
function love.touchpressed(id, x, y)
	ui.scroll.pressed(scroll.notes, id, x, y)
end

function love.touchmoved(id, x, y)
	ui.scroll.moved(scroll.notes, id, x, y)
end	

function love.touchreleased(id)
	ui.scroll.released(scroll.notes, id)
end

-- Обработка мышки
function love.mousepressed(x, y)
	ui.scroll.pressed(scroll.notes, 1, x, y)
end

function love.mousemoved(x, y)
	ui.scroll.moved(scroll.notes, 1, x, y)
end	

function love.mousereleased(x, y)
	ui.scroll.released(scroll.notes, 1)
end
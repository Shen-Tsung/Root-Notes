local ui = {}

ui.button = {} -- Кнопки
ui.scroll = {} -- Скроллы

-- Получение нужных переменных с main.lua
local color, font, touch
function ui.init(width, height, Color, Font, Touch)
	Width = width
	Height = height
	color = Color
	font = Font
	touch = Touch
end
-- __________Кнопка__________
-- Создание кнопки
function ui.button.new(text, x, y, w, h)
	return {
				text = text or "text",
				x = x - w / 2,
				y = y - h / 2, 
				w = w, h = h,
				moved = false, -- Сдвинулся ли палец с кнопки
				shadow_color = color.shadow,
				button_color = color.object,
				text_color = color.text
	}
end	

-- Отрисовка кнопки
function ui.button.draw(btn)
	-- Тень
	--love.graphics.setColor(btn.shadow_color)
	--love.graphics.rectangle("fill", btn.x + 10, btn.y + 10, btn.w, btn.h, 15, 15)
	
	-- Кнопка
	love.graphics.setColor(btn.button_color)
	love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h, 15, 15)
	
	-- Текст
	love.graphics.setFont(font.regular)
	love.graphics.setColor(btn.text_color)
	love.graphics.printf(btn.text, btn.x, btn.y + btn.h / 5, btn.w, "center")
end

-- Если кнопка нажата
function ui.button.pressed(btn, id, x, y)
	if x > btn.x and x < btn.x + btn.w and y < btn.y + btn.h and y > btn.y then
		touch[id] = btn.text
		
		btn.button_color = color.object2
		btn.text_color = color.text2
	end
end

-- Если палец движется по кнопке
function ui.button.moved(btn, id, x, y)
	if touch[id] == btn.text and x > btn.x and x < btn.x + btn.w and y < btn.y + btn.h and y > btn.y then
		touch[id] = btn.text
		btn.moved = false
		
		btn.button_color = color.object2
		btn.text_color = color.text2
	elseif touch[id] == btn.text then
		btn.moved = true
		
		btn.button_color = color.object
		btn.text_color = color.text
	end	
end

-- Если кнопка отпущена
function ui.button.released(btn, id)
	if touch[id] == btn.text then
		if not btn.moved then
			btn.button_color = color.object
			btn.text_color = color.text
		end
		
		touch[id] = nil -- Очистка касания
		btn.moved = false
	end
end

-- __________Скролл_________
-- Создание скролла
function ui.scroll.new(x, y, w, h)
	return {
		x = x - w / 2, 
		y = y - h / 2,
		w = w, h = h,
		start_y = 0,
		scroll_y = 0,
		start_scroll = 0,
		count = 0,
		elements = {}
	}
end

function ui.scroll.move(scrl, x, y)
	scrl.x = x - scrl.w / 2
	scrl.y = y - scrl.h / 2
end	

-- Добавление элемента в скролл
function ui.scroll.new_element(scrl, text)
	return {
		text = text,
		x = scrl.x + (scrl.w - scrl.w / 1.2) / 2,
		y = scrl.y + ((scrl.h / 9) * scrl.count),
		w = scrl.w / 1.2,
		h = scrl.h / 10,
		id = scrl.count,
		element_color = color.object,
		text_color = color.text
	}
end

-- Добавление элемента в таблицу
function ui.scroll.add_element(scrl, element)
	scrl.count = scrl.count + 1
	table.insert(scrl.elements, element)
end	

-- Удаление элемента из таблицы
function ui.scroll.delete_element(scrl)
	scrl.count = scrl.count - 1
	table.remove(scrl.elements)
end	

-- Отрисовка скролла
function ui.scroll.draw(scrl)
	love.graphics.setColor(color.area)
	love.graphics.rectangle("fill", scrl.x, scrl.y, scrl.w, scrl.h, 30, 30)
	
	love.graphics.setScissor(scrl.x, scrl.y, scrl.w, scrl.h)
	love.graphics.push()
	love.graphics.translate(scrl.x, scrl.y - scrl.scroll_y)
	
	-- Отрисовка элементов
	for i = 1, #scrl.elements do
		love.graphics.setColor(scrl.elements[i].element_color)
		
		love.graphics.rectangle("fill", scrl.elements[i].x, scrl.elements[i].y, scrl.elements[i].w, scrl.elements[i].h, 10, 10)
		
		love.graphics.setColor(scrl.elements[i].text_color)
		love.graphics.printf(scrl.elements[i].text, scrl.elements[i].x, scrl.elements[i].y + scrl.elements[i].h / 5, scrl.elements[i].w, "center")
	end
	
	love.graphics.pop()
	love.graphics.setScissor()
end

function ui.scroll.pressed(scrl, id, x, y)
	if y > scrl.y and y < scrl.y + scrl.h then
		touch[id] = "scrolling"
		scrl.start_y = y
		scrl.start_scroll = scrl.scroll_y
	end
end

function ui.scroll.moved(scrl, id, x, y)
	if touch[id] == "scrolling" then
		local delta = y - scrl.start_y
		scrl.scroll_y = scrl.start_scroll - delta
	end	
end

function ui.scroll.released(scrl, id)
	if touch[id] == "scrolling" then
		touch[id] = nil
	end	
end	

return ui
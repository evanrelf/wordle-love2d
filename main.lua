local dev = true

if dev then
  local lick = require("vendor/lick")
  lick.reset = true
end

function love.load()
  answer = {'p', 'e', 'a', 'c', 'h'}
  guesses = {
    {'f', 'r', 'a', 'm', 'e'},
    {'p', 'e', 'a', 'c', 'h'},
  }

  windowWidth = 500
  windowHeight = 1000

  love.graphics.setNewFont("fonts/RobotoSlab-Bold.ttf", 40)

  currentWindowWidth, currentWindowHeight = love.graphics.getDimensions()
  if currentWindowWidth ~= windowWidth or currentWindowHeight ~= windowHeight then
    love.window.updateMode(windowWidth, windowHeight, {})
  end

  if dev then
    currentWindowX, currentWindowY = love.window.getPosition()
    if currentWindowX ~= 0 or currentWindowY ~= 0 then
      love.window.setPosition(0, 0)
    end
  end

  love.graphics.setBackgroundColor(1, 1, 1, 1)
end

function love.update(dt)
end

function love.draw()
  drawTitle()
  drawBoxes()
end

function drawTitle()
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.printf("Wordle", 0, 10, windowWidth, "center")
end

function drawBoxes()
  local rows = 6
  local columns = 5
  local margin = 10
  local yOffset = 60

  local size = (windowWidth - margin) / columns
  local width = size - margin
  local height = size - margin

  love.graphics.setLineWidth(2)
  for row = 0, rows - 1 do
    for column = 0, columns - 1 do
      local x = (size * column) + margin
      local y = (size * row) + margin + yOffset

      if guesses[row + 1] ~= nil and guesses[row + 1][column + 1] ~= nil then
        letter = guesses[row + 1][column + 1]

        if letter == answer[column + 1] then
          -- Green
          love.graphics.setColor(106/255, 170/255, 100/255, 1)
        elseif elem(letter, answer) then
          -- Yellow
          love.graphics.setColor(201/255, 180/255, 88/255, 1)
        else
          -- Gray
          love.graphics.setColor(120/255, 124/255, 126/255, 1)
        end
        love.graphics.rectangle("fill", x, y, width, height)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(letter, x, y + 15, width, "center")
      else
        love.graphics.setColor(0.8, 0.8, 0.8, 1)
        love.graphics.rectangle("line", x, y, width, height)
      end
    end
  end
end

function elem(x, xs)
  for index, value in ipairs(xs) do
    if value == x then
      return true
    end
  end
  return false
end

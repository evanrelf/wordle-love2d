local dev = true

if dev then
  local lick = require("vendor/lick")
  lick.reset = true
end

function love.load()
  letters = {
    {'f', 'r', 'a', 'm', 'e'},
    {'p', 'e', 'a', 'c', 'h'},
  }
  windowWidth = 500
  windowHeight = 1000
  font = love.graphics.newFont("fonts/RobotoSlab-Bold.ttf", 40)

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

function love.keypressed(key, scancode, isrepeat)
  letters[letterNumber] = scancode
  letterNumber = letterNumber + 1
end

function love.update(dt)
end

function love.draw()
  drawTitle()
  drawBoxes()
end

function drawTitle()
  love.graphics.setFont(font)
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

  love.graphics.setFont(font)
  love.graphics.setColor(0.8, 0.8, 0.8, 1)
  love.graphics.setLineWidth(2)
  for row = 0, rows - 1 do
    for column = 0, columns - 1 do
      local x = (size * column) + margin
      local y = (size * row) + margin + yOffset

      love.graphics.rectangle("line", x, y, width, height)

      if letters[row + 1] ~= nil and letters[row + 1][column + 1] ~= nil then
        love.graphics.printf(letters[row + 1][column + 1], x, y + 15, width, "center")
      end
    end
  end
end

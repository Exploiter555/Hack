local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/TheoTheEpic/AquaLib/main/AquaLib.lua'))()

local window = lib.createWindow("Aqua", "Aqua Library", true) 

local tab1 = window.createTab("Test Tab")
local section1 = tab1.createSection("Test Section", false)

tab1.createButton("Test Button", function()
	print("Button Pressed!")
end)

section1.createDropdown("Test Dropdown", {"Option 1", "Option 2", "Option 3", "Option 4", "Option 5", "Option 6", "Option 7", "Option 8", "Option 9", "Option 10"}, "Option 7", function(value)
	print(value)
end)


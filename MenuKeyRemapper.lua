local cls = "                                            \r"
local lual = "\r\27[9C]\27[94m[INFO/LuaScript]\27[m "
local lual_s = ": \27[92mInitialized successfully\27[m                           "
local title, windowcheck = nil, false

local NewKey = {
	{512,   "Tab"},
	{513,   "Left"},
	{514,   "Right"},
	{515,   "Up"},
	{516,   "Down"},
	{517,   "Page Up"},
	{518,   "Page Down"},
	{519,   "Home"},
	{520,   "End"},
	{521,   "Insert"},
	{522,   "Delete"},
	{523,   "Backspace"},
	{524,   "Space"},
	{525,   "Enter"},
	{526,   "Escape"},
	{527,   "L-Ctrl"}, -- Also enables R-Alt for some reason
	{528,   "L-Shift"},
	{529,   "L-Alt"},
	{531,   "R-Ctrl"},
	{532,   "R-Shift"},
	{533,   "R-Alt"},
	{535,   "Menu"},
	{32768, "Cmd/Super/Windows"},
	{536,   "0"},
	{537,   "1"},
	{538,   "2"},
	{539,   "3"},
	{540,   "4"},
	{541,   "5"},
	{542,   "6"},
	{543,   "7"},
	{544,   "8"},
	{545,   "9"},
	{546,   "A"},
	{547,   "B"},
	{548,   "C"},
	{549,   "D"},
	{550,   "E"},
	{551,   "F"},
	{552,   "G"},
	{553,   "H"},
	{554,   "I"},
	{555,   "J"},
	{556,   "K"},
	{557,   "L"},
	{558,   "M"},
	{559,   "N"},
	{560,   "O"},
	{561,   "P"},
	{562,   "Q"},
	{563,   "R"},
	{564,   "S"},
	{565,   "T"},
	{566,   "U"},
	{567,   "V"},
	{568,   "W"},
	{569,   "X"},
	{570,   "Y"},
	{571,   "Z"},
	{572,   "F1"},
	{573,   "F2"},
	{574,   "F3"},
	{575,   "F4"},
	{576,   "F5"},
	{577,   "F6"},
	{578,   "F7"},
	{579,   "F8"},
	{580,   "F9"},
	{581,   "F10"},
	{582,   "F11"},
	{583,   "F12"},
	{596,   "'"},
	{597,   ","},
	{598,   "-"},
	{599,   "."},
	{600,   "/"},
	{601,   ";"},
	{602,   "="},
	{603,   "["},
	{604,   "\\"},
	{605,   "]"},
	{606,   "`"},
	{607,   "CapsLock"},
	{609,   "NumLock"},
	{612,   "Keypad 0"},
	{613,   "Keypad 1"},
	{614,   "Keypad 2"},
	{615,   "Keypad 3"},
	{616,   "Keypad 4"},
	{617,   "Keypad 5"},
	{618,   "Keypad 6"},
	{619,   "Keypad 7"},
	{620,   "Keypad 8"},
	{621,   "Keypad 9"}
}

local NewControllerBind = {
	{632, 	"Start"},
	{633, 	"Back"},
	{634, 	"Face Left"},
	{635, 	"Face Right"},
	{636, 	"Face Up"},
	{637, 	"Face Down"},
	{638, 	"D-pad Left"},
	{639, 	"D-pad Right"},
	{640, 	"D-pad Up"},
	{641, 	"D-pad Down"},
	{642, 	"L1"},
	{643, 	"R1"},
	{644, 	"L2"},
	{645, 	"R2"},
	{646, 	"L3"},
	{647, 	"R3"},
	{648, 	"L-Stick Left"},
	{649, 	"L-Stick Right"},
	{650, 	"L-Stick Up"},
	{651, 	"L-Stick Down"},
	{652, 	"R-Stick Left"},
	{653, 	"R-Stick Right"},
	{654, 	"R-Stick Up"},
	{655, 	"R-Stick Down"}
}

menu.set_menu_icon("\xef\x84\x9c")
local opensesame = menu.get_submenu("HotKey Remapper"):add_category("Toggle Menu")

local hotkey1 = commandmgr.add_list_command("setnewkey", "New Hotkey", "Select a Hotkey to toggle YimMenuV2.", NewKey, 527, nil)
local hotkey2 = commandmgr.add_list_command("setnewkey2", "New Hotkey 2", "Select a second Hotkey to toggle YimMenuV2.", NewKey, 516, nil)
local Button1 = commandmgr.add_list_command("setnewcont", "New Controller Bind", "Select a Controller Button to toggle YimMenuV2.", NewControllerBind, 638, nil)
local Button2 = commandmgr.add_list_command("setnewcont2", "New Controller Bind 2", "Select a second Hotkey to toggle YimMenuV2.", NewControllerBind, 647, nil)

commandmgr.add_bool_command("keycombo", "Key Combo", "Enables Key Combo.", false, function() end)
commandmgr.add_bool_command("conttogglecombo", "Controller Combo", "Enables Controller Combo.", false, function() end)

commandmgr.add_looped_command("keyremap", "Hotkey Remap", "Simulates [INSERT] key and [Ctrl+\\]", function()
	if commandmgr.get_command("keycombo"):get_value() then
		if (ImGui.IsKeyDown(hotkey1:get_value()) and ImGui.IsKeyReleased(hotkey2:get_value())) or (ImGui.IsKeyReleased(hotkey1:get_value()) and ImGui.IsKeyDown(hotkey2:get_value())) then
			menu.toggle()
		end
	else
		if ImGui.IsKeyReleased(hotkey1:get_value()) then
			menu.toggle()
		end
	end
end)

commandmgr.get_command("keyremap"):set_value(true)

commandmgr.add_looped_command("conttoggle", "Controller", "Enables Controller support.", function()
	if commandmgr.get_command("conttogglecombo"):get_value() then
		if (ImGui.IsKeyDown(Button1:get_value()) and ImGui.IsKeyReleased(Button2:get_value())) or (ImGui.IsKeyReleased(Button1:get_value()) and ImGui.IsKeyDown(Button2:get_value())) then
			menu.toggle()
		end
	else
		if ImGui.IsKeyReleased(Button1:get_value()) then
			menu.toggle()
		end
	end
end)

if FileMgr.DoesFileExist("MenuKeyRemapper/includes/config.lua") and FileMgr.ReadFileContent("MenuKeyRemapper/includes/config.lua") ~= "" then
	require("MenuKeyRemapper.includes.config")
	commandmgr.get_command("setnewkey"):set_value(Hotkeys.setnewkey)
	commandmgr.get_command("setnewkey2"):set_value(Hotkeys.setnewkey2)
	commandmgr.get_command("setnewcont"):set_value(Hotkeys.setnewcont)
	commandmgr.get_command("setnewcont2"):set_value(Hotkeys.setnewcont2)
	commandmgr.get_command("keycombo"):set_value(Hotkeys.keycombo)
	commandmgr.get_command("conttogglecombo"):set_value(Hotkeys.conttogglecombo)
	commandmgr.get_command("keyremap"):set_value(Hotkeys.keyremap)
	commandmgr.get_command("conttoggle"):set_value(Hotkeys.conttoggle)
end

log.info(cls.."                                "..cls..[[

 ____ ____ ____ ____ ____ ____
||H |||o |||t |||k |||e |||y ||
||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|
 ____ ____ ____ ____ ____ ____ ____ ____
||R |||e |||m |||a |||p |||p |||e |||r ||
||__|||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|]]..cls.."\n")

log.info(string.format("%s%sHotKey Remapper%s              \r\n", cls, lual, lual_s))

opensesame:imgui(function()
	if not windowcheck and ImGui.IsWindowHovered() then
		title = util.time()
		windowcheck = true
	elseif windowcheck then
		if util.time() < title + 5000 then
			ImGui.SetCursorPosX((ImGui.GetWindowWidth() - ImGui.CalcTextSize("Original TinkerScript by ImagineNothing")) / 2)
			ImGui.TextDisabled("Original TinkerScript by ImagineNothing") ImGui.Separator()
		end
	end

	commandmgr.get_command("keyremap"):draw()

	if commandmgr.get_command("keyremap"):get_value() then
		ImGui.SameLine() commandmgr.get_command("keycombo"):draw()
		commandmgr.get_command("setnewkey"):draw()
	end

	if commandmgr.get_command("keyremap"):get_value() and commandmgr.get_command("keycombo"):get_value() then
		commandmgr.get_command("setnewkey2"):draw()
	end

	ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()

	commandmgr.get_command("conttoggle"):draw()

	if commandmgr.get_command("conttoggle"):get_value() then
		ImGui.SameLine() commandmgr.get_command("conttogglecombo"):draw()
		commandmgr.get_command("setnewcont"):draw()
	end

	if commandmgr.get_command("conttoggle"):get_value() and commandmgr.get_command("conttogglecombo"):get_value() then
		commandmgr.get_command("setnewcont2"):draw()
	end

	ImGui.Spacing()
	ImGui.Separator()
	ImGui.Spacing()

	if ImGui.Button("Save Settings") then
		if not FileMgr.DoesFileExist("MenuKeyRemapper/includes") then FileMgr.CreateDir("MenuKeyRemapper/includes") end
		FileMgr.WriteFileContent("MenuKeyRemapper/includes/config.lua", "Hotkeys = {}\n", false)
		for _, cmd in ipairs({"setnewkey", "setnewkey2", "setnewcont", "setnewcont2", "keycombo", "conttogglecombo", "keyremap", "conttoggle"}) do
			FileMgr.WriteFileContent("MenuKeyRemapper/includes/config.lua", "Hotkeys."..cmd.." = "..tostring(commandmgr.get_command(cmd):get_value()).."\n", true)
		end
	end

	ImGui.SameLine()

	if ImGui.Button("Delete Settings") then
		FileMgr.DeleteFile("MenuKeyRemapper/includes/config.lua")
	end
end)
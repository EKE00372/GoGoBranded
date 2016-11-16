local T, L, G = unpack(select(2, ...))

-- test 214411

local branded_name = GetSpellInfo(227499)
local branded_blue = 227499
local branded_green = 227500
local branded_purple = 227490
local branded_red = 227491
local branded_yellow = 227498

local protected = 229584
local protected_name = GetSpellInfo(229584)
local protected_blue = 229582
local protected_green = 229583
local protected_purple = 229579
local protected_red = 229580
local protected_yellow = 229581

local p3_blue = 231345
local p3_green = 231346
local p3_purple = 231311
local p3_red = 231342
local p3_yellow = 231344

local marked = {
	blue = false,
	green = false,
	purple = false,
	red = false,
	yellow = false,
}
--====================================================--
--[[             -- Icon & Info Frame --            ]]--
--====================================================--

local iconFrame = CreateFrame("Button", nil, UIParent)
iconFrame:Hide()
iconFrame:SetFrameStrata("HIGH")
iconFrame:SetWidth(56)
iconFrame:SetHeight(56)
T.createborder(iconFrame)

iconFrame:SetMovable(true)
iconFrame:EnableMouse(true)
iconFrame:RegisterForDrag("LeftButton", "RightButton")

iconFrame:SetScript("OnDragStart", function(self)
	if self:IsMovable() then 
		self:StartMoving()
	end
end)

iconFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point1, _, point2, x, y = self:GetPoint(1)
	
	GGB_DB.Icon.Point1 = point1
	GGB_DB.Icon.Point2 = point2
	GGB_DB.Icon.PointX = x
	GGB_DB.Icon.PointY = y
end)

iconFrame:SetScript("OnClick", function(self)
	self:Hide()
end)

iconFrame.tex = iconFrame:CreateTexture(nil, "OVERLAY")
iconFrame.tex:SetAllPoints()
iconFrame.tex:SetTexture(select(3, GetSpellInfo(protected)))
iconFrame.tex:SetTexCoord(.08, .92, .08, .92)

iconFrame.infotext = T.createtext(iconFrame, "OVERLAY", 18, "OUTLINE", "TOP")
iconFrame.infotext:SetPoint("TOP", iconFrame, "BOTTOM")
iconFrame.infotext:SetSize(100, 25)
iconFrame.infotext:SetText(L["左上蓝"])

iconFrame.infotext2 = T.createtext(iconFrame, "OVERLAY", 15, "OUTLINE", "TOP")
iconFrame.infotext2:SetPoint("TOP", iconFrame.infotext, "BOTTOM")
iconFrame.infotext2:SetSize(250, 25)
iconFrame.infotext2:SetText("PlayerName")

G.iconFrame = iconFrame

local InfoFrame = CreateFrame("Button", nil, UIParent)
InfoFrame:Hide()
InfoFrame:SetFrameStrata("HIGH")
InfoFrame:SetWidth(440)
InfoFrame:SetHeight(135)
T.createborder(InfoFrame)

InfoFrame.infotext = T.createtext(InfoFrame, "OVERLAY", 12, "OUTLINE", "CENTER")
InfoFrame.infotext:SetPoint("BOTTOM", InfoFrame, "TOP", 0, -3)
InfoFrame.infotext:SetSize(160, 20)
InfoFrame.infotext:SetText("|cffFF0000"..L["烙印分配"].."|r")

for i = 1, 5 do
	InfoFrame["Icon"..i] = CreateFrame("Frame", nil, InfoFrame)
	InfoFrame["Icon"..i]:SetSize(80,25)
	T.createborder(InfoFrame["Icon"..i])
	if i == 1 then
		InfoFrame["Icon"..i]:SetPoint("TOPLEFT", InfoFrame, "TOPLEFT", 10, -5)
	else
		InfoFrame["Icon"..i]:SetPoint("LEFT", InfoFrame["Icon"..(i-1)], "RIGHT", 5, 0)
	end
	
	InfoFrame["Icon"..i].tex = InfoFrame["Icon"..i]:CreateTexture(nil, "OVERLAY")
	InfoFrame["Icon"..i].tex:SetSize(25,25)
	InfoFrame["Icon"..i].tex:SetPoint("CENTER")
	InfoFrame["Icon"..i].tex:SetTexCoord(.08, .92, .08, .92)
	
	if i == 1 then
		InfoFrame["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_blue)))
	elseif i == 2 then
		InfoFrame["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_green)))
	elseif i == 3 then
		InfoFrame["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_purple)))
	elseif i == 4 then
		InfoFrame["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_red)))
	elseif i == 5 then
		InfoFrame["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_yellow)))
	end
end

for i = 1, 20 do
	InfoFrame["raid"..i] = CreateFrame("Frame", nil, InfoFrame)
	InfoFrame["raid"..i]:SetSize(80,20)
	T.createborder(InfoFrame["raid"..i])
	if i == 1 then
		InfoFrame["raid"..i]:SetPoint("TOPLEFT", InfoFrame, "TOPLEFT", 10, -35)
	elseif i == 5 or i == 9 or i == 13 or i == 17 then
		InfoFrame["raid"..i]:SetPoint("LEFT", InfoFrame["raid"..(i-4)], "RIGHT", 5, 0)
	else
		InfoFrame["raid"..i]:SetPoint("TOP", InfoFrame["raid"..(i-1)], "BOTTOM", 0, -5)
	end
	
	InfoFrame["raid"..i].text = T.createtext(InfoFrame["raid"..i], "OVERLAY", 12, "OUTLINE", "LEFT")
	InfoFrame["raid"..i].text:SetAllPoints()
	InfoFrame["raid"..i].text:SetText("Player"..i)
end

InfoFrame:SetMovable(true)
InfoFrame:EnableMouse(true)
InfoFrame:RegisterForDrag("LeftButton", "RightButton")

InfoFrame:SetScript("OnDragStart", function(self)
	if self:IsMovable() then 
		self:StartMoving()
	end
end)

InfoFrame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point1, _, point2, x, y = self:GetPoint(1)
	
	GGB_DB.IF.Point1 = point1
	GGB_DB.IF.Point2 = point2
	GGB_DB.IF.PointX = x
	GGB_DB.IF.PointY = y
end)

InfoFrame:SetScript("OnClick", function(self)
	self:Hide()
end)

G.InfoFrame = InfoFrame

local function HideFrames()
	iconFrame:Hide()
	InfoFrame:Hide()
end

local function SetFramePoint()
	iconFrame:ClearAllPoints()
	InfoFrame:ClearAllPoints()
	
	iconFrame:SetPoint(GGB_DB.Icon.Point1,UIParent,GGB_DB.Icon.Point2,GGB_DB.Icon.PointX,GGB_DB.Icon.PointY)
	InfoFrame:SetPoint(GGB_DB.IF.Point1,UIParent,GGB_DB.IF.Point2,GGB_DB.IF.PointX,GGB_DB.IF.PointY)
end

local function SetFrameScale()
	iconFrame:SetScale(GGB_DB.Icon.Scale/100)
	InfoFrame:SetScale(GGB_DB.IF.Scale/100)
end

local function SetFrameAlpha()
	iconFrame:SetAlpha(GGB_DB.Icon.Alpha/100)
	InfoFrame:SetAlpha(GGB_DB.IF.Alpha/100)
end

local loginframe = CreateFrame("Frame")
loginframe:HookScript("OnEvent", function()
	
	C_Timer.After(2, function()
		if (not GetGuildInfo("player")) or strbyte(GetGuildInfo("player"), 3) ~= 191 then
			iconFrame.Show = iconFrame.Hide
			InfoFrame.Show = InfoFrame.Hide
		end
	end)
	
	SetFramePoint()
	SetFrameScale()
	SetFrameAlpha()
	
end)
loginframe:RegisterEvent("PLAYER_LOGIN")
--====================================================--
--[[                     -- GUI --                  ]]--
--====================================================--
local gui = CreateFrame("Frame", "GoGoBranded_GUI", UIParent)
gui:SetSize(500, 500)
gui:SetScale(1)
gui:SetPoint("CENTER", UIParent, "CENTER")
gui:SetFrameStrata("HIGH")
gui:SetFrameLevel(2)
gui:Hide()

gui:RegisterForDrag("LeftButton")
gui:SetScript("OnDragStart", function(self) self:StartMoving() end)
gui:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
gui:SetClampedToScreen(true)
gui:SetMovable(true)
gui:SetUserPlaced(true)
gui:EnableMouse(true)

T.createborder(gui)

gui.title = T.createtext(gui, "OVERLAY", 15, "OUTLINE", "CENTER")
gui.title:SetPoint("BOTTOM", gui, "TOP", 0, -5)
gui.title:SetText(G.AddonColor.."GoGoBranded v"..G.Version.."|r")

gui.close = CreateFrame("Button", nil, gui)
gui.close:SetPoint("BOTTOMRIGHT", -3, 3)
gui.close:SetSize(20, 20)
gui.close:SetNormalTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
gui.close:SetHighlightTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Highlight")
gui.close:SetPushedTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Down")
gui.close:SetPushedTextOffset(3, 3)
gui.close:SetScript("OnClick", function() gui:Hide() end)

gui.ver_button = CreateFrame("Button", G.addon.."test_button", gui, "UIPanelButtonTemplate")
gui.ver_button:SetPoint("BOTTOM", gui, "BOTTOM", 0, 5)
gui.ver_button:SetSize(300, 20)
gui.ver_button:SetText(L["检测版本"])

gui.ver_button:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ...
		if prefix == G.addon then
			local arg1, name, realm, ver = string.split(",", message)
			if arg1 == "ver2" then
				local fullname = name.."-"..realm
				if raidroster[fullname] == 0 then
					raidroster[fullname] = ver
				end
			end
		end
	end
end)

local function GetVer()
	if IsInRaid() then
		print(G.AddonColor..G.addon.."|r:"..L["检测插件版本"])
		raidroster = {}
		gui.ver_button:RegisterEvent("CHAT_MSG_ADDON")
		
		SendAddonMessage(G.addon, "ver", "RAID")
		
		for i = 1, 20 do
			local unitID = "raid"..i
			local name, realm = UnitName(unitID)
			if name then
				if not realm then
					realm = G.PlayerRealm
				end
				local fullname = name.."-"..realm
				raidroster[fullname] = 0
			end
		end

		C_Timer.After(2, function()
			gui.ver_button:UnregisterEvent("CHAT_MSG_ADDON")
			for fullname, ver in pairs(raidroster) do
				print(fullname.." version: "..ver)
			end
		end)
	end
end

gui.ver_button:SetScript("OnClick", GetVer)

gui.position = CreateFrame("Frame", nil, gui)
gui.position:SetPoint("TOPLEFT", gui, "TOPLEFT", 15, -20)
gui.position:SetPoint("TOPRIGHT", gui, "TOPRIGHT", -15, -20)
gui.position:SetHeight(60)
T.createborder(gui.position)

gui.position.text = T.createtext(gui.position, "OVERLAY", 12, "OUTLINE", "CENTER")
gui.position.text:SetPoint("TOPLEFT", gui.position, "TOPLEFT", 15, -5)
gui.position.text:SetText(G.AddonColor..L["位置"].."|r")

gui.unlock = CreateFrame("Button", G.addon.."unlock", gui.position, "UIPanelButtonTemplate")
gui.unlock:SetPoint("TOPLEFT", gui.position, "TOPLEFT", 15, -30)
gui.unlock:SetSize(130, 20)
gui.unlock:SetText(L["解锁位置"])
gui.unlock:SetScript("OnClick", function()
	G.iconFrame:Show()
	if GGB_DB.IF.show then
		G.InfoFrame:Show()
	end
end)

gui.lock = CreateFrame("Button", G.addon.."lock", gui.position, "UIPanelButtonTemplate")
gui.lock:SetPoint("LEFT", gui.unlock, "RIGHT", 25, 0)
gui.lock:SetSize(130, 20)
gui.lock:SetText(L["锁定位置"])
gui.lock:SetScript("OnClick", function()
	HideFrames()
end)

gui.reset = CreateFrame("Button", G.addon.."reset", gui.position, "UIPanelButtonTemplate")
gui.reset:SetPoint("LEFT", gui.lock, "RIGHT", 25, 0)
gui.reset:SetSize(130, 20)
gui.reset:SetText(L["还原位置"])
gui.reset:SetScript("OnClick", function()
	GGB_DB.Icon.Point1 = G.Default.Icon.Point1
	GGB_DB.Icon.Point2 = G.Default.Icon.Point2
	GGB_DB.Icon.PointX = G.Default.Icon.PointX
	GGB_DB.Icon.PointY = G.Default.Icon.PointY
	
	GGB_DB.IF.Point1 = G.Default.IF.Point1
	GGB_DB.IF.Point2 = G.Default.IF.Point2
	GGB_DB.IF.PointX = G.Default.IF.PointX
	GGB_DB.IF.PointY = G.Default.IF.PointY
	
	SetFramePoint()
	G.iconFrame:Show()
	if GGB_DB.IF.show then
		G.InfoFrame:Show()
	end
end)

gui.style = CreateFrame("Frame", nil, gui)
gui.style:SetPoint("TOPLEFT", gui.position, "BOTTOMLEFT", 0, -10)
gui.style:SetPoint("TOPRIGHT", gui.position, "BOTTOMRIGHT", -0, -10)
gui.style:SetHeight(160)
T.createborder(gui.style)

gui.style.text = T.createtext(gui.style, "OVERLAY", 12, "OUTLINE", "CENTER")
gui.style.text:SetPoint("TOPLEFT", gui.style, "TOPLEFT", 15, -5)
gui.style.text:SetText(G.AddonColor..L["样式"].."|r")

gui.style.iconscale = T.createslider(gui.style, L["烙印图标"]..L["尺寸"], "Icon", "Scale", 50, 200, 5, "TOPLEFT", gui.style, "TOPLEFT", 25, -50)
gui.style.iconscale:HookScript("OnValueChanged", SetFrameScale)

gui.style.iconalpha = T.createslider(gui.style, L["烙印图标"]..L["透明度"], "Icon", "Alpha", 10, 100, 2, "LEFT", gui.style.iconscale, "RIGHT", 35, 0)
gui.style.iconalpha:HookScript("OnValueChanged", SetFrameAlpha)

gui.style.ifscale = T.createslider(gui.style, L["烙印分配信息"]..L["尺寸"], "IF", "Scale", 50, 200, 5, "TOPLEFT", gui.style.iconscale, "BOTTOMLEFT", 0, -30)
gui.style.ifscale:HookScript("OnValueChanged", SetFrameScale)

gui.style.ifalpha = T.createslider(gui.style, L["烙印分配信息"]..L["透明度"], "IF", "Alpha", 10, 100, 2, "LEFT", gui.style.ifscale, "RIGHT", 35, 0)
gui.style.ifalpha:HookScript("OnValueChanged", SetFrameAlpha)

gui.style.showIF = T.createcheckbutton(gui.style, L["烙印分配信息"], "IF", "show", "TOPLEFT", gui.style.ifscale, "BOTTOMLEFT", 0, -15)
gui.style.showIF:HookScript("OnClick", function(self)
	if self:GetChecked() then
		G.InfoFrame:Show()
	else
		G.InfoFrame:Hide()
	end
end)

gui.text = CreateFrame("Frame", nil, gui)
gui.text:SetPoint("TOPLEFT", gui.style, "BOTTOMLEFT", 0, -10)
gui.text:SetPoint("TOPRIGHT", gui.style, "BOTTOMRIGHT", -0, -10)
gui.text:SetHeight(190)
T.createborder(gui.text)

gui.text.text = T.createtext(gui.text, "OVERLAY", 12, "OUTLINE", "CENTER")
gui.text.text:SetPoint("TOPLEFT", gui.text, "TOPLEFT", 15, -5)
gui.text.text:SetText(G.AddonColor..L["P3相对位置分配"].."|r")

for i = 1, 5 do
	gui.text["Icon"..i] = CreateFrame("Frame", nil, gui.text)
	gui.text["Icon"..i]:SetSize(25,25)
	T.createborder(gui.text["Icon"..i])
	if i == 1 then
		gui.text["Icon"..i]:SetPoint("TOPLEFT", gui.text, "TOPLEFT", 10, -35)
	else
		gui.text["Icon"..i]:SetPoint("TOP", gui.text["Icon"..(i-1)], "BOTTOM", 0, -5)
	end
	
	gui.text["Icon"..i].tex = gui.text["Icon"..i]:CreateTexture(nil, "OVERLAY")
	gui.text["Icon"..i].tex:SetSize(25,25)
	gui.text["Icon"..i].tex:SetPoint("CENTER")
	gui.text["Icon"..i].tex:SetTexCoord(.08, .92, .08, .92)

	if i == 1 then
		gui.text["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_blue)))
		gui.text["editbox"..i] = T.createeditbox(gui.text, "text", "blue", "LEFT", gui.text["Icon"..i], "RIGHT", 10, 0)
	elseif i == 2 then
		gui.text["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_green)))
		gui.text["editbox"..i] = T.createeditbox(gui.text, "text", "green", "LEFT", gui.text["Icon"..i], "RIGHT", 10, 0)
	elseif i == 3 then
		gui.text["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_purple)))
		gui.text["editbox"..i] = T.createeditbox(gui.text, "text", "purple", "LEFT", gui.text["Icon"..i], "RIGHT", 10, 0)
	elseif i == 4 then
		gui.text["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_red)))
		gui.text["editbox"..i] = T.createeditbox(gui.text, "text", "red", "LEFT", gui.text["Icon"..i], "RIGHT", 10, 0)
	elseif i == 5 then
		gui.text["Icon"..i].tex:SetTexture(select(3, GetSpellInfo(branded_yellow)))
		gui.text["editbox"..i] = T.createeditbox(gui.text, "text", "yellow", "LEFT", gui.text["Icon"..i], "RIGHT", 10, 0)
	end
end

local function slash(arg)
	gui:Show()
end

SlashCmdList["GoGoBranded"] = slash
SLASH_GoGoBranded1 = "/ggb"
SLASH_GoGoBranded2 = "/gogobranded"
--====================================================--
--[[                   -- Update --                 ]]--
--====================================================--
local function UnitDebuffID(unit, spell_id)
	local debuff_name = GetSpellInfo(spell_id)
	if UnitDebuff(unit, debuff_name) then
		local id = select(11, UnitDebuff(unit, debuff_name))
		if id == spell_id then
			return true
		end
	end
end

local function ShowIconInfo(spellid, text, player)
	iconFrame.infotext:SetText(text)
	iconFrame.infotext2:SetText(player)
	iconFrame.tex:SetTexture(select(3, GetSpellInfo(spellid)))
	iconFrame:Show()
end

local function HideIcon()
	iconFrame.infotext:SetText("")
	iconFrame.infotext2:SetText("")
	iconFrame.tex:SetTexture(select(3, GetSpellInfo(protected)))
	iconFrame:Hide()
end

local function RegisterAuraEvent(frame, player, spell_id, text)
	frame:RegisterEvent("UNIT_AURA")
	frame.text:SetText(text)
	frame:SetScript("OnEvent", function()
		if UnitDebuffID(player, spell_id) then
			frame.sd:SetBackdropColor(.1, 1, .1, .5)
		elseif UnitDebuff(player, protected_name) then
			frame.sd:SetBackdropColor(1, .1, .1, .5)
		else
			frame.sd:SetBackdropColor(.05, .05, .05, .5)
		end
	end)
end

local function UnregisterAuraEvent(frame)
	frame:UnregisterAllEvents()
	frame.text:SetText("none")
	frame.sd:SetBackdropColor(.05, .05, .05, .5)
end

local function HideInfoframe()
	for i = 1, 20 do
		UnregisterAuraEvent(InfoFrame["raid"..i])
	end
	InfoFrame:Hide()
end

gui:SetScript("OnEvent", function(self, event, ...)
	if event == "CHAT_MSG_ADDON" then
		local prefix, message, channel, sender = ...
		if prefix == G.addon then
			local spell, arg1, arg2, arg3, arg4 = string.split(",", message)
			if spell == "ver" then
				SendAddonMessage(G.addon, "ver2,"..G.PlayerName..","..G.PlayerRealm..","..G.ver, "RAID")
			end
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellid, spellname = ...	
		
		if not strfind(string.lower(GetGuildInfoText()), "66080") then return end
		
		if subevent == "SPELL_AURA_APPLIED" and spellid == branded_blue then
			if GGB_DB.IF.show then
				InfoFrame:Show()
			end
			
			local index = 1
			local player_blue, player_green, player_purple, player_red, player_yellow = "Unknown", "Unknown", "Unknown", "Unknown", "Unknown"
			
			C_Timer.After(0.3, function()
				
				for i = 1, 20 do		
					local unitID = 'raid' .. i
					local name = UnitName(unitID) or "NONE"
					
					if UnitDebuffID(unitID, branded_blue) then
						player_blue = ("|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"].."%s|r"):format(name)
						RegisterAuraEvent(InfoFrame["raid1"], name, protected_blue, player_blue)
					elseif UnitDebuffID(unitID, branded_green) then
						player_green = ("|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"].."%s|r"):format(name)
						RegisterAuraEvent(InfoFrame["raid5"], name, protected_green, player_green)
					elseif UnitDebuffID(unitID, branded_purple) then
						player_purple = ("|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"].."%s|r"):format(name)
						RegisterAuraEvent(InfoFrame["raid9"], name, protected_purple, player_purple)
					elseif UnitDebuffID(unitID, branded_red) then
						player_red = ("|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"].."%s|r"):format(name)
						RegisterAuraEvent(InfoFrame["raid13"], name, protected_red, player_red)
					elseif UnitDebuffID(unitID, branded_yellow) then
						player_yellow = ("|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"].."%s|r"):format(name)
						RegisterAuraEvent(InfoFrame["raid17"], name, protected_yellow, player_yellow)
					end
				end
				
				for i = 1, 20 do
					local unitID = 'raid' .. i
					local name = UnitName(unitID)
					
					if name and not UnitDebuff(unitID, branded_name) then
						if index <= 3 then
							RegisterAuraEvent(InfoFrame["raid"..index+1], name, protected_blue, "|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"]..name.."|r")
							if UnitIsUnit('player', unitID) then
								ShowIconInfo(branded_blue, L["左上蓝"], player_blue)	
							end
							index = index + 1
						elseif index <= 6 then
							RegisterAuraEvent(InfoFrame["raid"..index+2], name, protected_green, "|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"]..name.."|r")
							if UnitIsUnit('player', unitID) then
								ShowIconInfo(branded_green, L["正上绿"], player_green)
							end
							index = index + 1
						elseif index <= 9 then
							RegisterAuraEvent(InfoFrame["raid"..index+3], name, protected_purple, "|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"]..name.."|r")
							if UnitIsUnit('player', unitID) then
								ShowIconInfo(branded_purple, L["右上紫"], player_purple)
							end
							index = index + 1
						elseif index <= 12 then
							RegisterAuraEvent(InfoFrame["raid"..index+4], name, protected_red, "|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"]..name.."|r")
							if UnitIsUnit('player', unitID) then
								ShowIconInfo(branded_red, L["右下红"], player_red)
							end
							index = index + 1
						else
							RegisterAuraEvent(InfoFrame["raid"..index+5], name, protected_yellow, "|c"..G.Ccolors[select(2, UnitClass(unitID))]["colorStr"]..name.."|r")
							if UnitIsUnit('player', unitID) then
								ShowIconInfo(branded_yellow, L["左下黄"], player_yellow)
							end
							index = index + 1
						end
					end
				end
				
			end)
		end
		
		if subevent == "SPELL_AURA_APPLIED" then
			if spellid == p3_blue and not marked.blue then
				SetRaidTarget(destName, 6)
				marked.blue = true
			elseif spellid == p3_green and not marked.green then
				SetRaidTarget(destName, 4)
				marked.green = true
			elseif spellid == p3_purple and not marked.purple then
				SetRaidTarget(destName, 3)
				marked.purple = true
			elseif spellid == p3_red and not marked.red then
				SetRaidTarget(destName, 7)
				marked.red = true
			elseif spellid == p3_yellow and not marked.yellow then
				SetRaidTarget(destName, 1)
				marked.yellow = true
			end
		end
		
		if subevent == "SPELL_AURA_APPLIED" and destName == G.PlayerName then
			if spellid == branded_blue then
				ShowIconInfo(branded_blue, L["左上蓝"], ("|cffff0000"..L["我"].."|r"))	
			elseif spellid == branded_green then
				ShowIconInfo(branded_green, L["正上绿"], ("|cffff0000"..L["我"].."|r"))
			elseif spellid == branded_purple then
				ShowIconInfo(branded_purple, L["右上紫"], ("|cffff0000"..L["我"].."|r"))
			elseif spellid == branded_red then
				ShowIconInfo(branded_red, L["右下红"], ("|cffff0000"..L["我"].."|r"))
			elseif spellid == branded_yellow then
				ShowIconInfo(branded_yellow, L["左下黄"], ("|cffff0000"..L["我"].."|r"))
			elseif spellid == protected_blue then
				ShowIconInfo(protected_blue, L["受保护"], "")
			elseif spellid == protected_green then
				ShowIconInfo(protected_green, L["受保护"], "")	
			elseif spellid == protected_purple then
				ShowIconInfo(protected_purple, L["受保护"], "")	
			elseif spellid == protected_red then
				ShowIconInfo(protected_red, L["受保护"], "")
			elseif spellid == protected_yellow then
				ShowIconInfo(protected_yellow, L["受保护"], "")	
			elseif spellid == p3_blue then
				ShowIconInfo(p3_blue, GGB_DB.text.blue, "")
			elseif spellid == p3_green then
				ShowIconInfo(p3_green, GGB_DB.text.green, "")	
			elseif spellid == p3_purple then
				ShowIconInfo(p3_purple, GGB_DB.text.purple, "")	
			elseif spellid == p3_red then
				ShowIconInfo(p3_red, GGB_DB.text.red, "")
			elseif spellid == p3_yellow then
				ShowIconInfo(p3_yellow, GGB_DB.text.yellow, "")	
			end
		end
		
		if subevent == "SPELL_CAST_SUCCESS" and (spellid == 227629 or spellid == 231355 or spell_id == 231350) then
			C_Timer.After(2, function()
				HideIcon()
				if GGB_DB.IF.show then
					HideInfoframe()
				end
			end)
			if spellid == 231355 or spell_id == 231350 then
				marked.blue = false
				marked.green = false
				marked.purple = false
				marked.red = false
				marked.yellow = false
			end
		end
		
	elseif event == "ENCOUNTER_START" then
		HideIcon()
		if GGB_DB.IF.show then
			HideInfoframe()
		end
	elseif event == "ENCOUNTER_END" then
		marked.blue = false
		marked.green = false
		marked.purple = false
		marked.red = false
		marked.yellow = false
	end
end)

gui:RegisterEvent("CHAT_MSG_ADDON")
gui:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
gui:RegisterEvent("ENCOUNTER_START")
gui:RegisterEvent("ENCOUNTER_END")
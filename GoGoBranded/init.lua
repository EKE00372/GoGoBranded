local addon, ns = ...

ns[1] = {} -- T, functions, constants, variables
ns[2] = {} -- L, localization
ns[3] = {} -- G, globals (Optionnal)

local T, L, G = unpack(select(2, ...))

G.addon = "GoGoBranded"

G.Font = GameFontHighlight:GetFont()
G.Media = {
	blank = "Interface\\Buttons\\WHITE8x8",
}

G.Client = GetLocale()
G.Version = GetAddOnMetadata("GoGoBranded", "Version").." beta"
G.myClass = select(2, UnitClass("player"))
G.PlayerName = UnitName("player")
G.PlayerRealm = GetRealmName()
G.PlayerFullName = G.PlayerName.."-"..G.PlayerRealm

G.AddonColor = "|cffA6FFFF"
G.Ccolors = {}
if(IsAddOnLoaded'!ClassColors' and CUSTOM_CLASS_COLORS) then
	G.Ccolors = CUSTOM_CLASS_COLORS
else
	G.Ccolors = RAID_CLASS_COLORS
end

G.ver = 1

RegisterAddonMessagePrefix(G.addon)

----------------------------------------------------------
--------------[[         Locals           ]]--------------
----------------------------------------------------------

if G.Client == "zhCN" then
	L["位置"] = "位置"
	L["烙印分配"] = "烙印分配"
	L["解锁位置"] = "解锁位置"
	L["锁定位置"] = "锁定位置"
	L["还原位置"] = "还原位置"
	L["烙印图标"] = "烙印图标"
	L["烙印分配信息"] = "烙印分配信息"
	L["样式"] = "样式"
	L["尺寸"] = "尺寸"
	L["透明度"] = "透明度"
	L["我"] = "我"
	L["右上紫"] = "↗右上紫"
	L["左上蓝"] = "↖左上蓝"
	L["左下黄"] = "↙左下黄"
	L["右下红"] = "↘右下红"
	L["正上绿"] = "↑正上绿"
	L["中间绿"] = "中间绿"
	L["P3相对位置分配"] = "P3相对位置分配"
	L["受保护"] = "受保护"
	L["检测版本"] = "检测版本"
	L["检测插件版本"] = "开始检测团员插件版本,正在获取信息……"
elseif G.Client == "zhTW" then
	L["位置"] = "位置"
	L["烙印分配"] = "烙印分配"
	L["解锁位置"] = "解锁位置"
	L["锁定位置"] = "锁定位置"
	L["还原位置"] = "还原位置"
	L["烙印图标"] = "烙印图标"
	L["烙印分配信息"] = "烙印分配信息"
	L["样式"] = "样式"
	L["尺寸"] = "尺寸"
	L["透明度"] = "透明度"
	L["我"] = "我"
	L["右上紫"] = "↗右上紫"
	L["左上蓝"] = "↖左上蓝"
	L["左下黄"] = "↙左下黄"
	L["右下红"] = "↘右下红"
	L["正上绿"] = "↑正上绿"
	L["中间绿"] = "中间绿"
	L["P3相对位置分配"] = "P3相对位置分配"
	L["受保护"] = "受保护"
	L["检测版本"] = "检测版本"
	L["检测插件版本"] = "开始检测团员插件版本,正在获取信息……"
else
	L["位置"] = "Position"
	L["烙印分配"] = "Branded groups"
	L["解锁位置"] = "Unlock"
	L["锁定位置"] = "Lock"
	L["还原位置"] = "Reset"
	L["烙印图标"] = "Icon"
	L["烙印分配信息"] = "Branded groups"
	L["样式"] = "Style"
	L["尺寸"] = "Size"
	L["透明度"] = "Alpha"
	L["我"] = "You!"
	L["右上紫"] = "↗NE Purple"
	L["左上蓝"] = "↖NW Blue"
	L["左下黄"] = "↙SW Yellow"
	L["右下红"] = "↘SE Red"
	L["正上绿"] = "↑N Green"
	L["中间绿"] = "Center Green"
	L["P3相对位置分配"] = "P3 Icon Text"
	L["受保护"] = "Protected"
	L["检测版本"] = "Version check"
	L["检测插件版本"] = "Gathering verion infomation……"
end
----------------------------------------------------------
--------------[[     Default Settings     ]]--------------
----------------------------------------------------------

G.Default = {
	Icon = { 
		Point1 = "CENTER",
		Point2 = "CENTER",
		PointX = "-240",
		PointY = "50",
		Alpha = 100,
		Scale = 100,
	},
	IF = {
		show = false,
		Point1 = "CENTER",
		Point2 = "CENTER",
		PointX = "240",
		PointY = "50",
		Alpha = 100,
		Scale = 100,
	},
	text = {
		purple = L["右上紫"],
		blue = L["左上蓝"],
		yellow = L["左下黄"],
		red = L["右下红"],
		green = L["中间绿"],
	},
}

function T.LoadVariables()
	if GGB_DB == nil then
		GGB_DB = {}
	end
	
	for a, b in pairs(G.Default) do
		if type(b) ~= "table" then
			if GGB_DB[a] == nil then
				GGB_DB[a] = b
			end
		else
			if GGB_DB[a] == nil then
				GGB_DB[a] = {}
			end
			for k, v in pairs(b) do
				if GGB_DB[a][k] == nil then
					GGB_DB[a][k] = v
				end
			end
		end
	end
end

local loginframe = CreateFrame("Frame")
loginframe:HookScript("OnEvent", T.LoadVariables)
loginframe:RegisterEvent("PLAYER_LOGIN")
----------------------------------------------------------
-----------------[[     Functions     ]]------------------
----------------------------------------------------------
T.createtext = function(frame, layer, fontsize, flag, justifyh)
	local text = frame:CreateFontString(nil, layer)
	text:SetFont(G.Font, fontsize, flag)
	text:SetJustifyH(justifyh)
	return text
end

T.createborder = function(frame, r, g, b)
	if frame.style then return end
	frame.sd = CreateFrame("Frame", nil, frame)
	frame.sd:SetFrameLevel(frame:GetFrameLevel()-1)
	frame.sd:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\Buttons\\WHITE8x8",
		edgeSize = 1,
			insets = { left = 1, right = 1, top = 1, bottom = 1,}
		})
	frame.sd:SetPoint("TOPLEFT", frame, -1, 1)
	frame.sd:SetPoint("BOTTOMRIGHT", frame, 1, -1)
	if not (r and g and b) then
		frame.sd:SetBackdropColor(.05, .05, .05, .5)
		frame.sd:SetBackdropBorderColor(0, 0, 0)
	else
		frame.sd:SetBackdropColor(r, g, b, .5)
		frame.sd:SetBackdropBorderColor(r, g, b)
	end
	frame.style = true
end

T.createcheckbutton = function(parent, name, table, value, ...)
	local bu = CreateFrame("CheckButton", G.addon..value.."Button", parent, "InterfaceOptionsCheckButtonTemplate")
	bu:SetPoint(...)
	
	_G[bu:GetName() .. "Text"]:SetText(name)
	
	bu:SetScript("OnShow", function(self) self:SetChecked(GGB_DB[table][value]) end)
	
	bu:SetScript("OnClick", function(self)
		if self:GetChecked() then
			GGB_DB[table][value] = true
		else
			GGB_DB[table][value] = false
		end
	end)
	
	return bu
end

local function TestSlider_OnValueChanged(self, value)
   if not self._onsetting then   -- is single threaded 
     self._onsetting = true
     self:SetValue(self:GetValue())
     value = self:GetValue()     -- cant use original 'value' parameter
     self._onsetting = false
   else return end               -- ignore recursion for actual event handler
 end

T.createslider = function(parent, name, table, value, min, max, step, ...)
	local slider = CreateFrame("Slider", G.addon..table..value.."Slider", parent, "OptionsSliderTemplate")
	slider:SetPoint(...)
	slider:SetWidth(180)
	
	BlizzardOptionsPanel_Slider_Enable(slider)
	
	slider:SetMinMaxValues(min, max)
	_G[slider:GetName()..'Low']:SetText(min)
	_G[slider:GetName()..'Low']:ClearAllPoints()
	_G[slider:GetName()..'Low']:SetPoint("RIGHT", slider, "LEFT", 10, 0)
	_G[slider:GetName()..'High']:SetText(max)
	_G[slider:GetName()..'High']:ClearAllPoints()
	_G[slider:GetName()..'High']:SetPoint("LEFT", slider, "RIGHT", -10, 0)
	
	_G[slider:GetName()..'Text']:ClearAllPoints()
	_G[slider:GetName()..'Text']:SetPoint("BOTTOM", slider, "TOP", 0, 3)
	_G[slider:GetName()..'Text']:SetFontObject(GameFontHighlight)
	--slider:SetStepsPerPage(step)
	slider:SetValueStep(step)
	
	slider:SetScript("OnShow", function(self)
		self:SetValue(GGB_DB[table][value])
		_G[slider:GetName()..'Text']:SetText(name.." "..G.AddonColor..GGB_DB[table][value].."|r")
	end)
	slider:SetScript("OnValueChanged", function(self, getvalue)
		GGB_DB[table][value] = getvalue
		TestSlider_OnValueChanged(self, getvalue)
		_G[slider:GetName()..'Text']:SetText(name.." "..G.AddonColor..GGB_DB[table][value].."|r")
	end)
	
	return slider
end

T.createeditbox = function(parent, table, value, ...)
	local box = CreateFrame("EditBox", G.addon..value.."EditBox", parent, "InputBoxTemplate")
	box:SetSize(180, 20)
	box:SetPoint(...)
	
	box:SetFont(GameFontHighlight:GetFont(), 12, "OUTLINE")
	box:SetAutoFocus(false)
	box:SetTextInsets(3, 0, 0, 0)
	
	box:SetScript("OnShow", function(self) self:SetText(GGB_DB[table][value]) end)
	box:SetScript("OnEscapePressed", function(self) self:SetText(GGB_DB[table][value]) self:ClearFocus() end)
	box:SetScript("OnEnterPressed", function(self) self:ClearFocus() GGB_DB[table][value] = self:GetText() end)
	
	return box
end
--[[
	Name: cl_panel_atm.lua
-----------------------------------------------------------------
-- @package     VrZn - Custom Gamemode (SRP BASE)
-- @author     Nodge
-- @build       Beta 1
-----------------------------------------------------------------
]]--

surface.CreateFont( "ATMTitleFont", {font = "Montserrat Bold", size = 48} )
surface.CreateFont( "ATMBtnFont", {font = "Montserrat Bold", size = 64} )
surface.CreateFont( "ATMBtnFont2", {font = "Montserrat Bold", size = 48} )
surface.CreateFont( "ATMDrawFont", {font = "Montserrat Bold", size = 28} )

local Panel = {}
function Panel:Init()
	self.m_tblBtns = {}

	for i = 1, 9 do
		local btn = vgui3D.Create( "DButton", self )
		btn:SetText( i )
		btn:SetFont( "ATMBtnFont" )
		btn.DoClick = function()
			self:OnKeypadPressed( i )
		end
		table.insert( self.m_tblBtns, btn )
	end

	self.m_pnlBtnBack = vgui3D.Create( "DButton", self )
	self.m_pnlBtnBack:SetText( "BACK" )
	self.m_pnlBtnBack:SetFont( "ATMBtnFont2" )
	self.m_pnlBtnBack.DoClick = function()
		self:OnKeypadPressed( "BACK" )
	end

	self.m_pnlBtn0 = vgui3D.Create( "DButton", self )
	self.m_pnlBtn0:SetText( "0" )
	self.m_pnlBtn0:SetFont( "ATMBtnFont" )
	self.m_pnlBtn0.DoClick = function()
		self:OnKeypadPressed( 0 )
	end

	self.m_pnlBtnEnter = vgui3D.Create( "DButton", self )
	self.m_pnlBtnEnter:SetText( "ENTER" )
	self.m_pnlBtnEnter:SetFont( "ATMBtnFont2" )
	self.m_pnlBtnEnter.DoClick = function()
		self:OnKeypadPressed( "ENTER" )
	end

	self.m_pnlBtnClear = vgui3D.Create( "DButton", self )
	self.m_pnlBtnClear:SetText( "CLEAR" )
	self.m_pnlBtnClear:SetFont( "ATMBtnFont2" )
	self.m_pnlBtnClear.DoClick = function()
		self:OnKeypadPressed( "CLEAR" )
	end
end

function Panel:OnInputGained()
	self:SetMouseInputEnabled( true )
end

function Panel:OnInputLost()
	self:SetMouseInputEnabled( false )
end

function Panel:OnKeypadPressed( strKey )
	surface.PlaySound( "taloslife/atm_button.wav" )
	self.m_entATM.m_pnlMenu:OnKeypadPressed( strKey )
end

function Panel:SetEntity( eEnt )
	self.m_entATM = eEnt
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( 0, 0, intW, intH )
end

function Panel:PaintOver( intW, intH )
	if gui.MouseX() < 0 or gui.MouseX() > intW then return end
	if gui.MouseY() < 0 or gui.MouseY() > intH then return end
	
	local wide, thick = 32, 8
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( gui.MouseX() -(wide /2), gui.MouseY(), wide +thick, thick )
	surface.DrawRect( gui.MouseX(), gui.MouseY() -(wide /2), thick, wide +thick )	
end

function Panel:PerformLayout( intW, intH )
	local x, y = 0, 0
	local row = 0
	for k, v in pairs( self.m_tblBtns ) do
		v:SetPos( x, y )
		v:SetSize( 64, 64 )

		x = x +64 +5
		row = row +1
		if row >= 3 then
			x = 0
			y = y +64 +5
			row = 0
		end
	end

	y = y
	self.m_pnlBtnBack:SetPos( 0, y )
	self.m_pnlBtnBack:SetSize( (64 *2) +5, 64 )

	self.m_pnlBtn0:SetPos( self.m_pnlBtnBack:GetWide() +5, y )
	self.m_pnlBtn0:SetSize( 64, 64 )

	self.m_pnlBtnClear:SetPos( ((64 +5) *3), 0 )
	self.m_pnlBtnClear:SetSize( (64 *2), (64 *2) +5 )

	self.m_pnlBtnEnter:SetPos( ((64 +5) *3), self.m_pnlBtnClear:GetTall() +5 )
	self.m_pnlBtnEnter:SetSize( (64 *2), (64 *2) +5 )
end
vgui.Register( "SRPATMKeypad", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()
end

function Panel:OnKeypadPressed( strKey )
end

function Panel:LeftBtnClick( intKey )
	if intKey == 1 then
		self:GetParent():GetParent():ShowMenu( "deposit" )
	elseif intKey == 3 then
		self:GetParent():GetParent():ShowMenu( "account" )
	end
end

function Panel:RightBtnClick( intKey )
	if intKey == 1 then
		self:GetParent():GetParent():ShowMenu( "withdraw" )
	elseif intKey == 3 then
		self:GetParent():GetParent():ShowMenu( "transfer" )
	end
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("materials/vgui/elements/atmbg.png") )
	surface.DrawTexturedRect(-40, 0, 560, 480)
	surface.SetDrawColor(0, 0, 0, 255)

	draw.SimpleText(
		"BANCO DO BRASIL",
		"ATMTitleFont",
		(intW /2),
		0,
		Color(42, 69, 140, 255),
		TEXT_ALIGN_CENTER
	)

	local x, y = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetPos()
	local w, h = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetSize()
	

	--left top btn

	-- draw.RoundedBoxEx(4, -2, y, 176, 28, Color(26,26,26), false, true, false, true)
	draw.SimpleText(
		"<~ [Depósito]",
		"ATMDrawFont",
		0,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT
	)


	--left bottom btn
	-- draw.RoundedBoxEx(4, -2, y+h-28, 230, 28, Color(26,26,26), false, true, false, true)
	draw.SimpleText(
		"<~ [Saldo da conta]",
		"ATMDrawFont",
		0,
		y +h,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_BOTTOM
	)

	--right top btn
	-- draw.RoundedBoxEx(4, intW-175, y, 176, 28, Color(26,26,26), true, false, true, false)
	draw.SimpleText(
		"[Saque] ~>",
		"ATMDrawFont",
		intW,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_RIGHT
	)
end
vgui.Register( "SRPATMHomePage", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()
	self.m_strAmount = ""
end

function Panel:OnShow()
	self.m_strAmount = ""
end

function Panel:OnKeypadPressed( strKey )
	if tonumber( strKey ) ~= nil then
		if self.m_strAmount:len() >= 9 then return end
		self.m_strAmount = self.m_strAmount ..strKey
		return
	end

	if strKey == "CLEAR" then
		self.m_strAmount = ""
	elseif strKey == "BACK" then
		self.m_strAmount = self.m_strAmount:sub( 0, self.m_strAmount:len() -1 )
	elseif strKey == "ENTER" then
		if self.m_strAmount == "" then return end
		if not tonumber( self.m_strAmount ) then return end

		GAMEMODE.Net:RequestDepositBankFunds( self:GetParent():GetParent().m_entATM, tonumber(self.m_strAmount) )
		self.m_strAmount = ""

		self:GetParent():GetParent():ShowMenu( "account" )
	end
end

function Panel:LeftBtnClick( intKey )
	if intKey == 1 then
		self:GetParent():GetParent():ShowMenu( "home" )
	end
end

function Panel:RightBtnClick( intKey )
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("materials/vgui/elements/atmbg.png") )
	surface.DrawTexturedRect(-40, 0, 560, 480)
	surface.SetDrawColor(0, 0, 0, 255)


	draw.SimpleText(
		"DEPOSITO BB",
		"ATMTitleFont",
		(intW /2),
		0,
		Color(42, 69, 140, 255),
		TEXT_ALIGN_CENTER
	)

	draw.SimpleText(
		"R$ ".. string.Comma(self.m_strAmount),
		"ATMDrawFont",
		(intW /2),
		(intH /2),
		Color(255, 255, 255, 255),
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER
	)

	local x, y = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetPos()
	local w, h = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetSize()
	--left top btn
	draw.SimpleText(
		"<~ [Voltar]",
		"ATMDrawFont",
		0,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT
	)
end
vgui.Register( "SRPATMDepositPage", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()
	self.m_strAmount = ""
end

function Panel:OnShow()
	self.m_strAmount = ""
end

function Panel:OnKeypadPressed( strKey )
	if tonumber( strKey ) ~= nil then
		if self.m_strAmount:len() >= 9 then return end
		self.m_strAmount = self.m_strAmount ..strKey
		return
	end

	if strKey == "CLEAR" then
		self.m_strAmount = ""
	elseif strKey == "BACK" then
		self.m_strAmount = self.m_strAmount:sub( 0, self.m_strAmount:len() -1 )
	elseif strKey == "ENTER" then
		if self.m_strAmount == "" then return end
		if not tonumber( self.m_strAmount ) then return end

		GAMEMODE.Net:RequestWithdrawBankFunds( self:GetParent():GetParent().m_entATM, tonumber(self.m_strAmount) )
		self.m_strAmount = ""

		self:GetParent():GetParent():ShowMenu( "account" )
	end
end

function Panel:LeftBtnClick( intKey )
	if intKey == 1 then
		self:GetParent():GetParent():ShowMenu( "home" )
	elseif intKey == 2 then
		self.m_strAmount = "100"
	elseif intKey == 3 then
		self.m_strAmount = "500"
	end
end

function Panel:RightBtnClick( intKey )
	if intKey == 1 then
		self.m_strAmount = "1000"
	elseif intKey == 2 then
		self.m_strAmount = "5000"
	elseif intKey == 3 then
		self.m_strAmount = "10000"
	end
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("materials/vgui/elements/atmbg.png") )
	surface.DrawTexturedRect(-40, 0, 560, 480)
	surface.SetDrawColor(0, 0, 0, 255)

	draw.SimpleText(
		"SAQUE BB",
		"ATMTitleFont",
		(intW /2),
		0,
		Color(42, 69, 140, 255),
		TEXT_ALIGN_CENTER
	)

	draw.SimpleText(
		"R$ ".. string.Comma(self.m_strAmount),
		"ATMDrawFont",
		(intW /2),
		(intH /2),
		Color(255, 255, 255, 255),
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER
	)

	local x, y = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetPos()
	local w, h = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetSize()
	--left top btn
	draw.SimpleText(
		"<~ [Voltar]",
		"ATMDrawFont",
		0,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT
	)
	--left center btn
	draw.SimpleText(
		"<~ [R$ 100]",
		"ATMDrawFont",
		0,
		(y *2 +h) /2,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_CENTER
	)
	--left bottom btn
	draw.SimpleText(
		"<~ [R$ 500]",
		"ATMDrawFont",
		0,
		y +h,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT,
		TEXT_ALIGN_BOTTOM
	)
	--right top btn
	draw.SimpleText(
		"[R$ 1,000] ~>",
		"ATMDrawFont",
		intW,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_RIGHT
	)
	--right center btn
	draw.SimpleText(
		"[R$ 5,000] ~>",
		"ATMDrawFont",
		intW,
		(y *2 +h) /2,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_CENTER
	)
	--right bottom btn
	draw.SimpleText(
		"[R$ 10,000] ~>",
		"ATMDrawFont",
		intW,
		y +h,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_RIGHT,
		TEXT_ALIGN_BOTTOM
	)
end
vgui.Register( "SRPATMWithdrawPage", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()
end

function Panel:OnKeypadPressed( strKey )
end

function Panel:LeftBtnClick( intKey )
	if intKey == 1 then
		self:GetParent():GetParent():ShowMenu( "home" )
	end
end

function Panel:RightBtnClick( intKey )
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( Material("materials/vgui/elements/atmbg.png") )
	surface.DrawTexturedRect(-40, 0, 560, 480)
	surface.SetDrawColor(0, 0, 0, 255)


	draw.SimpleText(
		" SALDO / EXTRATO",
		"ATMTitleFont",
		(intW /2),
		0,
		Color(42, 69, 140, 255),
		TEXT_ALIGN_CENTER
	)

	draw.SimpleText(
		"Saldo Atual:",
		"ATMDrawFont",
		(intW /2),
		(intH /2) -16,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_CENTER
	)
	draw.SimpleText(
		"R$ ".. string.Comma( GAMEMODE.Player:GetGameVar("money_bank", 0) ),
		"ATMDrawFont",
		(intW /2),
		(intH /2) +16,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_CENTER
	)

	local x, y = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetPos()
	local w, h = self:GetParent():GetParent().m_pnlBtnContainerLeft:GetSize()
	--left top btn
	draw.SimpleText(
		"<~ [Voltar]",
		"ATMDrawFont",
		0,
		y,
		Color(255, 255, 255, 255),
		TEXT_ALIGN_LEFT
	)
end
vgui.Register( "SRPATMAccountPage", Panel, "EditablePanel" )

-- ----------------------------------------------------------------

local Panel = {}
function Panel:Init()
	self.m_pnlBtnContainerLeft = vgui3D.Create( "EditablePanel", self )
	self.m_pnlBtnContainerRight = vgui3D.Create( "EditablePanel", self )

	self.m_tblLeftBtns = {}
	for i = 1, 3 do
		local btn = vgui3D.Create( "DButton", self.m_pnlBtnContainerLeft )
		btn:SetText( " " )
		btn.DoClick = function()
			surface.PlaySound( "taloslife/atm_button.wav" )
			self:GetActiveMenu():LeftBtnClick( i )
		end
		table.insert( self.m_tblLeftBtns, btn )
	end
	self.m_tblRightBtns = {}
	for i = 1, 3 do
		local btn = vgui3D.Create( "DButton", self.m_pnlBtnContainerRight )
		btn:SetText( " " )
		btn.DoClick = function()
			surface.PlaySound( "taloslife/atm_button.wav" )
			self:GetActiveMenu():RightBtnClick( i )
		end
		table.insert( self.m_tblRightBtns, btn )
	end

	self.m_intBtnSize = 40
	local padding = 64
	self.m_pnlBtnContainerLeft.PerformLayout = function( _, intW, intH )
		local y = 0
		for k, v in pairs( self.m_tblLeftBtns ) do
			v:SetPos( 5, y )
			v:SetSize( intW -10, intW -10 )
			y = y +padding +intW +padding
		end
	end
	self.m_pnlBtnContainerRight.PerformLayout = function( _, intW, intH )
		local y = 0
		for k, v in pairs( self.m_tblRightBtns ) do
			v:SetPos( 5, y )
			v:SetSize( intW -10, intW -10 )
			y = y +padding +intW +padding
		end
	end

	self.m_tblViews = {}
	self.m_pnlContainer = vgui3D.Create( "EditablePanel", self )
	self:AddMenu( "home", vgui3D.Create("SRPATMHomePage") )
	self:AddMenu( "deposit", vgui3D.Create("SRPATMDepositPage") )
	self:AddMenu( "withdraw", vgui3D.Create("SRPATMWithdrawPage") )
	-- self:AddMenu( "transfer", vgui3D.Create("SRPATMTransferPage") )
	self:AddMenu( "account", vgui3D.Create("SRPATMAccountPage") )
end

function Panel:AddMenu( strMenu, pnlMenu )
	self.m_tblViews[strMenu] = pnlMenu
	pnlMenu:SetParent( self.m_pnlContainer )
	pnlMenu:SetVisible( table.Count(self.m_tblViews) == 1 )
end

function Panel:ShowMenu( strMenu )
	for k, v in pairs( self.m_tblViews ) do
		v:SetVisible( k == strMenu )
		if k == strMenu then
			if v.OnShow then v:OnShow() end
		end
	end
end

function Panel:GetActiveMenu()
	for k, v in pairs( self.m_tblViews ) do
		if v:IsVisible() then return v end
	end
end

function Panel:OnInputGained()
	self:SetMouseInputEnabled( true )
end

function Panel:OnInputLost()
	self:SetMouseInputEnabled( false )
	self:ShowMenu( "home" )
end

function Panel:OnKeypadPressed( strKey )
	self:GetActiveMenu():OnKeypadPressed( strKey )
end

function Panel:SetEntity( eEnt )
	self.m_entATM = eEnt
end

function Panel:Paint( intW, intH )
	surface.SetDrawColor( 29, 0, 255, 255 )
	surface.DrawRect( 0, 0, intW, intH )

	if not self.m_pnlBtnContainerLeft then return end
	local x, y = 0, 0
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( x, y, self.m_pnlBtnContainerLeft:GetWide(), intH )

	if not self.m_pnlBtnContainerRight then return end
	x, y = self.m_pnlBtnContainerRight:GetPos()
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( x, 0, self.m_pnlBtnContainerRight:GetWide(), intH )
end

function Panel:PaintOver( intW, intH )
	if gui.MouseX() < 0 or gui.MouseX() > intW then return end
	if gui.MouseY() < 0 or gui.MouseY() > intH then return end
	
	local wide, thick = 16, 4
	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( gui.MouseX() -(wide /2), gui.MouseY(), wide +thick, thick )
	surface.DrawRect( gui.MouseX(), gui.MouseY() -(wide /2), thick, wide +thick )	
end

function Panel:PerformLayout( intW, intH )
	local x, y = self.m_tblLeftBtns[#self.m_tblLeftBtns]:GetPos()
	self.m_pnlBtnContainerLeft:SetSize( self.m_intBtnSize, y +self.m_tblLeftBtns[#self.m_tblLeftBtns]:GetTall() )
	self.m_pnlBtnContainerLeft:SetPos( 0, (intH /2) -(self.m_pnlBtnContainerLeft:GetTall() /2) )

	x, y = self.m_tblRightBtns[#self.m_tblLeftBtns]:GetPos()
	self.m_pnlBtnContainerRight:SetSize( self.m_intBtnSize, y +self.m_tblRightBtns[#self.m_tblRightBtns]:GetTall() )
	self.m_pnlBtnContainerRight:SetPos( intW -self.m_intBtnSize, (intH /2) -(self.m_pnlBtnContainerRight:GetTall() /2) )

	self.m_pnlContainer:SetPos( self.m_intBtnSize, 0 )
	self.m_pnlContainer:SetSize( intW -(self.m_intBtnSize *2), intH )

	for k, v in pairs( self.m_tblViews ) do
		v:SetPos( 0, 0 )
		v:SetSize( self.m_pnlContainer:GetSize() )
	end
end
vgui.Register( "SRPATMDisplay", Panel, "EditablePanel" )
--[[
	Name: cl_buddies.lua
		by: Asriel + CodeRed

]]
--
surface.CreateFont("BuddyFont", {
	size = 128,
	weight = 500,
	font = "DermaLarge"
})

GM.Buddy = (GAMEMODE or GM).Buddy or {}
GM.Buddy.m_tblCurBuddies = (GAMEMODE or GM).Buddy.m_tblCurBuddies or {}
--GM.Buddy.m_matBuddyIcon = Material("icon16/user.png", "smooth")

function GM.Buddy:GetPlayerBuddyID(pPlayer)
	if not pPlayer:GetCharacterID() then return end
	local buddyID = pPlayer:SteamID()

	return self.m_tblCurBuddies[buddyID] and buddyID or nil
end

function GM.Buddy:GetPlayerByBuddyID(intBuddyID)
	for k, v in pairs(player.GetAll()) do
		if v:SteamID() == intBuddyID then return v end
	end
end

function GM.Buddy:GetBuddyData(intBuddyID)
	return self.m_tblCurBuddies[intBuddyID]
end

function GM.Buddy:IsBuddyWith(pPlayer)
	if not IsValid(pPlayer) then return false end

	return self.m_tblCurBuddies[pPlayer:SteamID()] or false
end

function GM.Buddy:SetBuddyTable(tblBuddies)
	self.m_tblCurBuddies = tblBuddies
end

function GM.Buddy:GetBuddyTable()
	return self.m_tblCurBuddies
end

function GM.Buddy:PaintBuddyCard(pPlayer)
	if (pPlayer:GetMoveType() == MOVETYPE_NOCLIP) then return end
	surface.SetFont("BuddyFont")

	if pPlayer:IsPolice() and LocalPlayer():IsPolice() then
		local tW, tH = surface.GetTextSize(pPlayer:Nick() .. " - " .. GAMEMODE.PoliceRanks:GetPrettyRank(pPlayer))
		surface.SetTextColor(255, 255, 255, 255)
		surface.SetTextPos(-(tW / 2), tH / 2)
		surface.DrawText(pPlayer:Nick() .. " - " .. GAMEMODE.PoliceRanks:GetPrettyRank(pPlayer))
	else
--		local tW, tH = surface.GetTextSize(pPlayer:Nick())
--		surface.SetTextColor(255, 255, 255, 255)
--		surface.SetTextPos(-(tW / 2), tH / 2)
--		surface.DrawText(pPlayer:Nick())
--		local iconSize = 128
--		surface.SetMaterial(self.m_matBuddyIcon)
--		surface.SetDrawColor(255, 255, 255, 255)
--		surface.DrawTexturedRect(-(tW / 2)+340 - iconSize - 24, (tH / 2), iconSize, iconSize)
	end
end

--function GM.Buddy:PaintNameTag(pPlayer)
--	surface.SetFont("BuddyFont")
--	local tW, tH = surface.GetTextSize(pPlayer:Nick())
--	surface.SetTextColor(255, 255, 255, 255)
--	surface.SetTextPos(-(tW / 2), tH / 2)
	-- surface.DrawText(pPlayer:Nick())
--end
 

function GM.Buddy:PostDrawTranslucentRenderables()
	local pos, offset = nil, Vector( 0, 0, 50 )
	local ang = Angle( 0, LocalPlayer():EyeAngles().y -90, 90 )
	local myPos = LocalPlayer():GetPos()

	for k, v in pairs( player.GetAll() ) do
		if v == LocalPlayer() then continue end
		
		if self:IsBuddyWith( v ) then
			parceiro = true
			ent = IsValid( v:GetRagdoll() ) and v:GetRagdoll() or v
			if ent:GetPos():DistToSqr( myPos ) > GAMEMODE.Config.RenderDist_Level2 ^2 then continue end
			pos = ent:LocalToWorld( ent:OBBCenter() ) +offset
			cam.Start3D2D( pos, ang, 0.035 )
				self:PaintBuddyCard( v )
			cam.End3D2D()
		else
			ent = IsValid( v:GetRagdoll() ) and v:GetRagdoll() or v
			if ent:GetPos():DistToSqr( myPos ) > 350 ^2 then continue end
			pos = ent:LocalToWorld( ent:OBBCenter() ) +offset
			cam.Start3D2D( pos, ang, 0.035 )
			cam.End3D2D()
		end
	end
end
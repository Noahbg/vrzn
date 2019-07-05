--[[
	Name: atms.lua
	
		
]]--

local MapProp = {}
MapProp.ID = "atms"
MapProp.m_tblSpawn = {}
MapProp.m_tblAtms = {
	--not already in the map
	{ pos = Vector(6612.540527, -7523.269043, 111 ), ang = Angle(2.970015, 87.437653, 0.000000) }, --Outskirt gas
	{ pos = Vector(-2044.281494, 3951.994141, 111 ), ang = Angle(0.528018, -92.316116, 0.000000) }, --Car Dealer
	{ pos = Vector(-9372.816406, 10909.537109, 95.370163 ), ang = Angle(0.857990, -91.026123, 0.000000) }, --Bank
	{ pos = Vector(-5737.002441, 9278.823242, 160.031250 ), ang = Angle(1.386018, 178.290024, 0.000000) }, --spawn

}

function MapProp:CustomSpawn()
	for _, propData in pairs( self.m_tblAtms ) do
		local ent = ents.Create( "ent_atm" )
		ent:SetPos( propData.pos )
		ent:SetAngles( propData.ang )
		ent.IsMapProp = true
		ent:Spawn()
		ent:Activate()

		local phys = ent:GetPhysicsObject()
		if IsValid( phys ) then
			phys:EnableMotion( false )
		end
	end
end

GAMEMODE.Map:RegisterMapProp( MapProp )
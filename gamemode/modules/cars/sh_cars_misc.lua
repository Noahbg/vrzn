--[[
	Name: sh_cars_misc.lua
	For: TalosLife
	By: TalosLife

	This file has old unsorted junk related to cars
]]--

sound.Add{
	name = "car_starter",
	channel = CHAN_STATIC,
	volume = 1,
	level = 68,
	pitch = 100,
	sound = "taloslife/car_starter.wav"
}
local vehState = nil

if SERVER then
	util.AddNetworkString "srp_carstarter"

	g_PlayerVehicles = g_PlayerVehicles or {}
	local VEHCILE_START_DURATION = 1 --Duration a player must hold IN_RELOAD to start a car
	local VEHICLE_OFF = 0
	local VEHICLE_STARTING = 1
	local VEHICLE_STARTED = 2

	hook.Add( "PlayerEnteredVehicle", "TurnCarOff", function( pPlayer, entVehicle, intRole )
		if entVehicle:GetClass() == "prop_vehicle_prisoner_pod" then return end
		pPlayer:AddNote( "Segure [ i ] Para Ligar/Desligar o motor." )
		g_PlayerVehicles[pPlayer] = { State = 0 }
	end )

	hook.Add( "PlayerLeaveVehicle", "TurnCarOff", function( pPlayer, entVehicle, intRole )
	
		entVehicle:StopSound( "car_starter" )

		if pPlayer:GetVehicle():IsEngineStarted() then
			pPlayer:AddNote("O motor continua ligado!")
		end
		g_PlayerVehicles[pPlayer] = nil

	end )

	net.Receive( "srp_carstarter", function( intMsgLen, pPlayer )
		pPlayer.m_intCarKeyState = net.ReadBit() == 1
	end )

	hook.Add( "Tick", "CarStater", function()
		for pl, data in pairs( g_PlayerVehicles ) do

			if not IsValid( pl ) or not pl:GetVehicle() then g_PlayerVehicles[pl] = nil continue end

			if data.State == VEHICLE_STARTING then
				pl:GetVehicle():Fire( "HandBrakeOn", "1" )
			end

			if pl.m_intCarKeyState then
				if data.State == VEHICLE_OFF and not data.WasStopped then
					data.State = VEHICLE_STARTING
					data.StartTime = CurTime()
					pl:GetVehicle():EmitSound( "car_starter" )

					 if pl:GetVehicle():VC_getHealth(false) <= 0 then return end
					 if pl:GetVehicle():VC_fuelGet(false) < 1 then return end
				elseif data.State == VEHICLE_STARTING then
					  if pl:GetVehicle():VC_getHealth(false) <= 0 then return end
					 if pl:GetVehicle():VC_fuelGet(false) < 1 then return end
					
					if not data.ExtraTime then
						  local max = pl:GetVehicle():VC_getHealthMax()
						 local time = (max -pl:GetVehicle():VC_getHealth(false)) /max
						local time = 0.1
						data.ExtraTime = (VEHCILE_START_DURATION *1) *math.Rand(time *5.8, time *6.3)
					end
					
					if CurTime() >= data.StartTime +VEHCILE_START_DURATION +data.ExtraTime then
						data.State = VEHICLE_STARTED
						data.ExtraTime = nil
						data.WasStarted = true
						pl:GetVehicle():StopSound( "car_starter" )
						pl:GetVehicle():Fire( "TurnOn", "1" )
						pl:GetVehicle():Fire( "HandBrakeOff", "1" )
					end
				elseif data.State == VEHICLE_STARTED and not data.WasStarted then
					pl:GetVehicle():StopSound( "car_starter" )
					pl:GetVehicle():Fire( "TurnOff", "1" )
					data.State = VEHICLE_OFF
					data.ExtraTime = nil
					data.WasStopped = true
				end
			else
				if data.WasStarted then
					data.WasStarted = nil
				end
				if data.WasStopped then
					data.WasStopped = nil
				end

				if data.State == VEHICLE_STARTING or (not pl:GetVehicle():IsEngineStarted() and data.State ~= VEHICLE_OFF) then
					data.State = VEHICLE_OFF
					data.ExtraTime = nil
					pl:GetVehicle():StopSound( "car_starter" )
					pl:GetVehicle():Fire( "TurnOn", "1" )
				end
			end
		end
	end )


else
	local sendState = false
	hook.Add( "Tick", "CarStater_Key", function()
		if input.IsKeyDown( KEY_I ) then
			if IsValid( vgui.GetKeyboardFocus() ) then return end
			if not sendState then
				net.Start( "srp_carstarter" )
					net.WriteBit( true )
				net.SendToServer()
				sendState = true
			end
		else
			if sendState then
				net.Start( "srp_carstarter" )
					net.WriteBit( false )
				net.SendToServer()
				sendState = false
			end
		end 
	end )

	return
end
--[[
	Name: map_config.lua


]]--

if SERVER then
	resource.AddWorkshop( "929618625" ) --map

	--[[ Car Dealer Settings ]]--
	GM.Config.CarSpawns = {
		{ Vector( -3643.098633, 11571.148438, -294.968750 ), Angle( 1.417751, 180, 0.000000 ) },
		{ Vector( -3801.148682, 11574.802734, -294.968750 ), Angle( 1.417751, 180, 0.000000 ) },
		{ Vector( -3816.248047, 11800.058594, -294.968750 ), Angle( 1.681751, 180, 0.000000 ) },
		{ Vector( -3649.924316, 11797.790039, -294.968750 ), Angle( 1.681751, 180, 0.000000 ) },
	}

	GM.Config.CarGarageBBox = {
		Min = Vector( -5151.027832, 10858.031250, -370.911987 ),
		Max = Vector( -3146.391357, 12531.193359, -205.031250 ),
	}

	--[[ Jail Settings ]]--
	GM.Config.JailPositions = {
		Vector( -6384.343750, 12149.785156, 417.031250 ),
		Vector( -6375.473145, 12021.704102, 417.031250 ),
		Vector( -6380.648926, 11897.592773, 417.031250 ),
		Vector( -6385.623535, 11770.566406, 417.031250 ),
		Vector( -6089.998535, 11773.406250, 417.031250 ),
		Vector( -6086.361328, 11897.436523, 417.031250 ),
		Vector( -6086.632324, 12028.474609, 417.031250 ),
		Vector( -6081.094727, 12151.348633, 417.031250 ),
	}
	GM.Config.JailReleasePositions = {
		Vector( -4929.224609, 11873.280273, 184.031250 ),
		Vector( -5061.331543, 11875.954102, 184.031250 ),
		Vector( -5059.739746, 11954.810547, 184.031250 ),
		Vector( -4975.930664, 11953.120117, 184.031250 ),
	}
	GM.Config.JailBBox = {
		Min = Vector( -6423.994629, 11732.489258, 390.031250 ),
		Max = Vector( -5784.387695, 12674.928711, 527.96875 ),
	}

	--[[ NPC Drug Dealer Settings ]]--
	GM.Config.DrugNPCPositions = {
		{ Vector( -2759.949707, 12365.631836, 165.771088 ), Angle(0.862647, 2.971771, 0.000000 ) },
		{ Vector( 13946.068359, 10001.249023, -87.968750 ), Angle(1.324627, -90.286308, 0.000000 ) },
		{ Vector( 6405.862793, -7564.031250, 160.031250 ), Angle(3.765848, -95.235252, 0.000000 ) },
	}

	--[[ Map Settings ]]--
	GM.Config.SpawnPoints = {
		Vector( -6203.390137, 9073.535156, 216.031250 ),
		Vector( -6187.857910, 8824.055664, 216.031250 ),
		Vector( -6231.846191, 9270.020508, 216.031250 ),
		Vector( -6325.168457, 9357.126953, 216.031250 ),
	}

	--[[ Register the car customs shop location ]]--
	GM.CarShop.m_tblGarage["rp_pinescity_v1x"] = {
		NoDoors = true,
		CarPos = {
			Vector( -10320.218750, -2676.250000, 97.218750 ),
			Vector( -10077.532227, -2810.342285, 172.737152 ),
			Vector( -9837.448242, -2807.758301, 172.464935 ),
			Vector( -10535.449219, -2806.118164, 168.636520 ),
		},
		BBox = {
			Max = Vector( -9726.812500, -2421.168945, 413.635071 ), --Inside of the garage
			Min = Vector( -10674.293945, -2869.968750, 155.156082 ), --Inside of the garage
		},
		PlayerSetPos = Vector( -9751.031250, -2471.027832, 251.357773 ), --If a player gets inside the garage, set them to this location
	}

	--[[ Fire Spawner Settings ]]--
	GM.Config.AutoFiresEnabled = true
	GM.Config.AutoFireSpawnMinTime = 60 *15
	GM.Config.AutoFireSpawnMaxTime = 60 *60
	GM.Config.AutoFireSpawnPoints = {
		--Gas stations
		Vector( "-8942.533203 -7861.419922 288.031250" ),
		Vector( "-8715.147461 -8090.916504 288.031250" ),

		--Gas stations inside
		Vector( "-6895.257324 1255.600098 292.031250" ),
		Vector( "-11610.813477 10396.053711 64.031250" ),

		--Junkyard
		Vector( "-3962.382568 -9468.200195 286.502014" ),
		Vector( "-5659.629395 -9288.423828 280.031250" ),
		Vector( "-3365.916992 -8674.002930 280.031250" ),

		--Grocery store
		Vector( "-11883.190430 -11767.650391 292.031250" ),
		Vector( "-11879.181641 -10883.125977 292.031250" ),

		--Electronics store alley
		Vector( "-11857.025391 -12460.521484 292.031219" ),

		--Bank
		Vector( "-4931.397949 4436.788086 288.031250" ),

		--Underpass
		Vector( "-12887.172852 5914.155273 8.031250" ),
	}
end

--[[ Car Dealer Settings ]]--
GM.Config.CarPreviewModelPos = Vector( -3343.489014, 3552.546387, 160.031250 )
GM.Config.CarPreviewCamPos = Vector( -3002.705078, 3468.032715, 378.881744 )
GM.Config.CarPreviewCamAng = Angle( 38.280075, 179.392548, 0.000000 )
GM.Config.CarPreviewCamLen = 1.5

--[[ Chop Shop ]]--
GM.Config.ChopShop_ChopLocation = Vector( -9736.079102, -2190.142334, 160.031250 )

--[[ Weather & Day Night ]]--
GM.Config.Weather_SkyZPos = 3430
GM.Config.FogLightingEnabled = true
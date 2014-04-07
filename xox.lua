local CHx = 0
local CHy = 125
local CHz = 255
local GoUpx = 1
local GoUpy = 1
local GoUpz = 0
local CHC = 0
local GoUpC = 0
local ply = LocalPlayer()
local aimboton = false
local aimbotbone = "ValveBiped.Bip01_Head1"
OutsideState = "Rotating"
InsideState = "Rotating"

InsideColor = Color(255,255,255,255)
OutSideColor = Color(255,255,255,255)
CircleColor = Color(255,255,255,255)


Inside_Rotation_Speed = 6
Outside_Rotation_Speed = 3

CreateClientConVar("XoX_Build", 1)
CreateClientConVar("XoX_Build_Trace_All", 1)
CreateClientConVar("XoX_Draw_Gmod_HUD", 0)
CreateClientConVar("XoX_HUD_Draw_Healthbar", 1)
CreateClientConVar("XoX_HUD_Draw_Armorbar", 1)
CreateClientConVar("XoX_Crosshair_Draw_Circle", 1)
CreateClientConVar("XoX_Crosshair_RotateInside", 1)
CreateClientConVar("XoX_Crosshair_RotateOutside", 1)
CreateClientConVar("XoX_Crosshair_Rotate_Outside_Speed", 3)
CreateClientConVar("XoX_Crosshair_Rotate_Inside_Speed", 6)
CreateClientConVar("XoX_Crosshair_Draw_Outside", 1)
CreateClientConVar("XoX_Crosshair_Draw_Inside", 1)
CreateClientConVar("XoX_Radar_Pos_X", 20)
CreateClientConVar("XoX_Radar_Pos_Y", 20)
CreateClientConVar("XoX_Radar_Width", 300)
CreateClientConVar("XoX_Radar_Draw",0)
CreateClientConVar("XoX_ESP_Draw",1)
CreateClientConVar("XoX_ESP_Enemy_Only",0)
CreateClientConVar("XoX_Bhop",1)
CreateClientConVar("XoX_Rapid_Fire",1)
CreateClientConVar("XoX_Rapid_Use",1)
CreateClientConVar("XoX_Rapid_Flash",1)
CreateClientConVar("XoX_Crosshair_Color_Circle",0 )
CreateClientConVar("XoX_Crosshair_Color_Inside",0 )
CreateClientConVar("XoX_Crosshair_Color_Outside",0 )
CreateClientConVar("XoX_ShowPos",0 )

	
local function Jump()
	ply:ConCommand("+jump")
	timer.Simple(0.1,function()
				ply:ConCommand("-jump")
		end
	)
end
	
hook.Add("Think","SuperJump",function()
if(ply.SJump and ply:IsOnGround())then
	Jump()
	end
end)
	
	concommand.Add("+XoX_Bhop",function(pl,com,args)
	if GetConVar("XoX_Bhop"):GetInt() > 0 then
		ply.SJump = true
	else
		ply:ConCommand("+jump")
		end
	end)
	
	concommand.Add("-XoX_Bhop",function(pl,com,args)
		ply.SJump = false
		ply:ConCommand("-jump")
	end)

local function SuperAttack()
		ply:ConCommand("+attack")
		ply.canAttack = false
		timer.Simple(0.001,
			function()
				ply.canAttack = true
				ply:ConCommand("-attack")
			end
		)
	end
	
	local function SuperUse()
		ply:ConCommand("+use")
		ply.canUse = false
		timer.Simple(0.001,
			function()
				ply.canUse = true
				ply:ConCommand("-use")
			end
		)
	end
	
	local function SuperFlash()
		ply:ConCommand("impulse 100")
		ply.canFlash = false
		timer.Simple(0.001,
			function()
				ply.canFlash = true
				ply:ConCommand("impulse 100")
			end
		)
	end
	
		hook.Add("Think","SuperAttack_Use",
		function()
			if(ply.SAtk and ply.canAttack)then
				SuperAttack()
			end
			if(ply.SUse and ply.canUse)then
				SuperUse()
			end
			if(ply.SFlash and ply.canFlash)then
				SuperFlash()
			end
		end
	)

	concommand.Add("+XoX_Use",function(pl,com,args)
	if GetConVar("XoX_Rapid_Use"):GetInt() > 0 then
		ply.SUse = true
		ply.canUse = true
	else
		ply:ConCommand("+use")
		end
	end)
	
	concommand.Add("-XoX_Use",function(pl,com,args)
		ply.SUse = false
		ply:ConCommand("-use")
	end)
	
	concommand.Add("+XoX_Flash",function(pl,com,args)
	if GetConVar("XoX_Rapid_Flash"):GetInt() > 0 then
		ply.SFlash = true
		ply.canFlash = true
	else
		ply:ConCommand("impulse 100")
	end
	end)
	
	concommand.Add("-XoX_Flash",function(pl,com,args)
	if GetConVar("XoX_Rapid_Flash"):GetInt() > 0 then
		ply.SFlash = false
	end
	end)
	
	concommand.Add("+XoX_Attack",function(pl,com,args)
	if GetConVar("XoX_Rapid_Fire"):GetInt() > 0 then
		ply.SAtk = true
		ply.canAttack = true
	else
		ply:ConCommand("+attack")
		end
	end)
	
	concommand.Add("-XoX_Attack",function(pl,com,args)
		ply.SAtk = false
		ply:ConCommand("-attack")
	end)
	
	
------------------------------------------------------------

local function OpenScript(p,com,arg)
	if arg[1] != nil and arg[1] != "" then
		print("Including " .. arg[1])
		include(arg[1])
	else
		print("Invalid directory!")
	end
end
concommand.Add("XoX_lua_openscript",OpenScript)

local function LuaRunHack(p,com,arg)
	RunString(table.concat(arg,[[ ]]))
end

concommand.Add("XoX_lua_run",LuaRunHack)


concommand.Add("XoX_e2_download",function()







end)

	
function DrawESP()














	if GetConVar("XoX_Build"):GetInt() > 0 then
		
		surface.SetDrawColor(Color(255,0,170,80))
		surface.DrawRect(10, ScrH()/2 - 200, 300, 250)
				
		surface.SetTextColor( 255,255,255 )
		surface.SetFont("Default")
		local trace = util.GetPlayerTrace( ply )
		local traceRes = util.TraceLine( trace )
		if traceRes.HitNonWorld then
			local target = traceRes.Entity
			if target:IsPlayer() then
				
				if GetConVar("XoX_Build_Trace_All"):GetInt() < 1 then
					local tracep = util.GetPlayerTrace( target )
					local traceResp = util.TraceLine( tracep )
					local eyepos = traceResp.StartPos:ToScreen()
					local aimpos = traceResp.HitPos:ToScreen()
					surface.SetDrawColor(Color(0,255,0,255))
					surface.DrawLine(eyepos.x,eyepos.y,aimpos.x,aimpos.y)
				end
				
				
				surface.SetTextPos(40,ScrH()/2 - 180)
				surface.DrawText("Target: Player")
				surface.SetTextPos(40,ScrH()/2 - 160)
				surface.DrawText("Name: " .. target:GetName())
				surface.SetTextPos(40,ScrH()/2 - 140)
				surface.DrawText("Health: " .. target:Health())
			
				surface.SetTextPos(40,ScrH()/2 - 120)
				if target:GetActiveWeapon() then
					surface.DrawText("Weapon: " .. target:GetActiveWeapon():GetClass())
				end
				surface.SetTextPos(40,ScrH()/2 - 100)
				surface.DrawText("Position:")
				surface.SetTextPos(40,ScrH()/2 - 80)
				surface.DrawText("  X: " .. math.floor( target:GetPos().x ).. " ( " .. math.floor(target:GetPos().x - LocalPlayer():GetPos().x ).. " ) " )
				surface.SetTextPos(40,ScrH()/2 - 60)
				surface.DrawText("  Y: " .. math.floor(target:GetPos().y ).. " ( " .. math.floor(target:GetPos().y - LocalPlayer():GetPos().y ).. " ) " )
				surface.SetTextPos(40,ScrH()/2 - 40)
				surface.DrawText("  Z: " .. math.floor(target:GetPos().z ).. " ( " .. math.floor(target:GetPos().z - LocalPlayer():GetPos().z ).. " ) " )
				
				if NADMOD then
					local Props = NADMOD.PropOwners
					net.Receive("nadmod_propowners",function(len) 
						local num = net.ReadUInt(16)
						for k=1,num do
							local id,str = net.ReadUInt(16), net.ReadString()
							if str == "-" then Props[id] = nil 
							elseif str == "W" then Props[id] = "World"
							elseif str == "O" then Props[id] = "Ownerless"
							else Props[id] = str
							end
						end
					end)
				
					cam.Start3D(EyePos(), EyeAngles())
					render.SetColorModulation( 1, 0.5, 1)
					render.SuppressEngineLighting( true )
					for k,v in pairs(ents.GetAll()) do
						if v:IsValid() and !v:IsPlayer() then
							if Props[v:EntIndex()] == target:GetName() then
								v:DrawModel()
							end
						end
					end
					render.SetColorModulation(1,1,1)	
					render.SuppressEngineLighting( false )
				else
					cam.Start3D(EyePos(), EyeAngles())
				end
			elseif target:IsValid() then
				surface.SetTextPos(40,ScrH()/2 - 180)
				surface.DrawText("Target: " .. target:GetClass())
				surface.SetTextPos(40,ScrH()/2 - 140)
				surface.DrawText("Model: " .. target:GetModel())
				surface.SetTextPos(40,ScrH()/2 - 120)
				surface.DrawText("Material: " .. target:GetMaterial())
				surface.SetTextPos(40,ScrH()/2 - 100)
				surface.DrawText("Color: (" .. target:GetColor().r .. "," ..target:GetColor().g .. "," ..target:GetColor().b .. "):" ..target:GetColor().a)
				surface.SetTextPos(40,ScrH()/2 - 80)
				surface.DrawText("  X: " .. math.floor( target:GetPos().x ).. " ( " .. math.floor(target:GetPos().x - LocalPlayer():GetPos().x ).. " ) " )
				surface.SetTextPos(40,ScrH()/2 - 60)
				surface.DrawText("  Y: " .. math.floor(target:GetPos().y ).. " ( " .. math.floor(target:GetPos().y - LocalPlayer():GetPos().y ).. " ) " )
				surface.SetTextPos(40,ScrH()/2 - 40)
				surface.DrawText("  Z: " .. math.floor(target:GetPos().z ).. " ( " .. math.floor(target:GetPos().z - LocalPlayer():GetPos().z ).. " ) " )
				
				
				cam.Start3D(EyePos(), EyeAngles())
			else
				cam.Start3D(EyePos(), EyeAngles())
			end
		else
			surface.SetTextPos(40,ScrH()/2 - 180)
			surface.DrawText("Target: World")
			cam.Start3D(EyePos(), EyeAngles())
		end
	else
		cam.Start3D(EyePos(), EyeAngles())
	end
		
	if GetConVar("XoX_ESP_Draw"):GetInt() > 0 then
		for k, plys in ipairs(player.GetAll()) do
			if plys != ply then
			if not ply:Team() == plys:Team() or GetConVar("XoX_ESP_Enemy_Only"):GetInt() < 1 then
				local oldmat = plys:GetMaterial()
				allplayersposition = plys:GetPos() + plys:OBBCenter()
				playerposition = allplayersposition:ToScreen()		
				
				render.SuppressEngineLighting( true )
				plysColor = team.GetColor(plys:Team())
				if evolve then
					plysColor =	evolve.ranks[ plys:EV_GetRank() ].Color
				end
				
				render.SetColorModulation( (plysColor.r/255), (plysColor.g/255), (plysColor.b/255) )
				plys:SetMaterial("models/shiny")
				plys:DrawModel()
				render.SetColorModulation(1,1,1)		
				render.SuppressEngineLighting( false )
				plys:SetMaterial(oldmat)
			end
			end
		end
		
		for k,v in pairs(ents.FindByModel("models/expression 2/cpu_microchip_mini.mdl")) do
			if v:GetClass() == "gmod_wire_expression2" then
				render.SetColorModulation( 255,0,255 )
				v:SetMaterial("models/shiny")
				v:DrawModel()
			end
		end
		
				render.SetColorModulation(1,1,1)	
		
		cam.End3D()
		
		for k, plys in ipairs(player.GetAll()) do
			if plys != ply then
				if not ply:Team() == plys:Team() or GetConVar("XoX_ESP_Enemy_Only"):GetInt() < 1 then
					local oldmat = plys:GetMaterial()
					allplayersposition = plys:GetPos() + plys:OBBCenter()
					playerposition = allplayersposition:ToScreen()
					if GetConVar("XoX_Build_Trace_All"):GetInt() > 0 then
						local tracep = util.GetPlayerTrace( plys )
						local traceResp = util.TraceLine( tracep )				
						local eyepos = traceResp.StartPos:ToScreen()
						local aimpos = traceResp.HitPos:ToScreen()
						surface.SetDrawColor(Color(0,255,0,255))
						surface.DrawLine(eyepos.x,eyepos.y,aimpos.x,aimpos.y)
					end
					plysColor = team.GetColor(plys:Team())
					if evolve then
						plysColor =	evolve.ranks[ plys:EV_GetRank() ].Color
					end
					surface.SetTextColor( ColorAlpha( plysColor , 1) )
					surface.SetTextPos(playerposition.x,playerposition.y)
					surface.SetFont("Default")
					surface.DrawText("  " .. plys:GetName())
				end
			end
		end
	else
		cam.End3D()
	end
	
end

function Radar()
	if GetConVar("XoX_Radar_Draw"):GetInt() > 0 then
		CamData = {}
		CamData.angles = Angle(90,90,0)
		CamData.origin = Vector(ply:GetPos().x,ply:GetPos().y,ply:GetPos().z + 512)
		CamData.x = GetConVar("XoX_Radar_Pos_X"):GetFloat()
		CamData.y = GetConVar("XoX_Radar_Pos_Y"):GetFloat()
		CamData.w = GetConVar("XoX_Radar_Width"):GetFloat()
		CamData.h = GetConVar("XoX_Radar_Width"):GetFloat()
		render.RenderView( CamData )
	end
end

surface.CreateFont ("AmmoClipFont01", {font = "coolvetica", size = 60}) 
surface.CreateFont ("AmmoClipFont02", {font = "coolvetica", size = 50}) 
surface.CreateFont ("AmmoClipFont03", {font = "MenuItem", size = 60}) 
surface.CreateFont ("ConsoleText", {font = "coolvetica", size = 20}) 

function AmmoClip()
	local client = ply
	if !client:Alive() then return end
	if(client:GetActiveWeapon() == NULL or client:GetActiveWeapon() == "Camera") then return end
 if GetConVar("XoX_HUD_Draw_Armorbar"):GetInt() > 0 then
	draw.SimpleText(ply:GetActiveWeapon():Clip1(),"AmmoClipFont02", ScrW() - 130, ScrH() - 30,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)	
	draw.SimpleText("I","AmmoClipFont03", ScrW() - 120, ScrH() - 33,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)	
	draw.SimpleText(ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()),"AmmoClipFont02", ScrW() - 10, ScrH() - 30,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)	
	
	AmmoClipCounter = ""
	if ply:GetActiveWeapon():Clip1() > 0 and ply:GetActiveWeapon():Clip1() <= 50 then
		for i = 1 , ply:GetActiveWeapon():Clip1(),1 do
			AmmoClipCounter = AmmoClipCounter .. "|"
		end
		draw.SimpleText(AmmoClipCounter,"AmmoClipFont01", ScrW() - 200, ScrH() - 30,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
	elseif ply:GetActiveWeapon():Clip1() > 50 then
		for i = 1 , ply:GetActiveWeapon():Clip1() - 50,1 do
			AmmoClipCounter = AmmoClipCounter .. "|"
		end
		draw.SimpleText(AmmoClipCounter,"AmmoClipFont01", ScrW() - 200, ScrH() - 70,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
		draw.SimpleText("||||||||||||||||||||||||||||||||||||||||||||||||||","AmmoClipFont01", ScrW() - 200, ScrH() - 30,Color(255,255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
		end
	
end
end

function Healthbar()
if GetConVar("XoX_HUD_Draw_Healthbar"):GetInt() > 0 then
	surface.SetDrawColor(255,0,0,255)
	surface.DrawOutlinedRect(10, ScrH() - 35, 400, 25)
	surface.DrawRect(10, ScrH() - 35, ply:Health() * 4, 25)
	draw.SimpleText(tostring(ply:Health()) ,"ConsoleText" ,15, ScrH() - 27.5, Color(255,255,255,255))
	if ply:Health() <= 0 then draw.SimpleText("Dude, you're dead!" ,"ConsoleText" ,15, ScrH() - 27.5, Color(255,255,255,255)) end
end
end

function Armorbar()
if GetConVar("XoX_HUD_Draw_Armorbar"):GetInt() > 0 then
	if ply:Armor() > 0 then
		surface.SetDrawColor(0,0,255,255)
		surface.DrawOutlinedRect(10, ScrH() - 65, 400, 25)
		surface.DrawRect(10, ScrH() - 65, ply:Armor() * 4, 25)
		draw.SimpleText(tostring(ply:Armor()) ,"ConsoleText" ,15, ScrH() - 57.5, Color(255,255,255,255))
	end
end
end

function CrossHairs()


	if CHC == 255 then GoUpC = 0 end
	if CHC == 0 then GoUpC = 1 end
	if GoUpC == 1 then CHC = CHC + 1 else CHC = CHC - 1 end
	
	
	
	if GetConVar("XoX_Crosshair_Draw_Circle"):GetInt() > 0 then
	if GetConVar("XoX_Crosshair_Color_Circle"):GetInt() > 0 then
	surface.DrawCircle( ScrW() / 2, ScrH() / 2, 18, Color(CircleColor))
	else
	surface.DrawCircle( ScrW() / 2, ScrH() / 2, 18, Color(CHC,CHC,CHC,255))
	end
	end

	if CHx == 255 then GoUpx = 0 end
	if CHx == 0 then GoUpx = 1 end
	if CHy == 255 then GoUpy = 0 end
	if CHy == 0 then GoUpy = 1 end
	if CHz == 255 then GoUpz = 0 end
	if CHz == 0 then GoUpz = 1 end
	if GoUpx == 1 then CHx = CHx + 1 else CHx = CHx - 1 end
	if GoUpy == 1 then CHy = CHy + 1 else CHy = CHy - 1 end
	if GoUpz == 1 then CHz = CHz + 1 else CHz = CHz - 1 end
	
	if GetConVar("XoX_Crosshair_Color_Inside"):GetInt() > 0 then
		surface.SetDrawColor(InsideColor)
	else
		surface.SetDrawColor(CHx,CHy,CHz,255)
	end
	
	local cx, cy = ScrW()/2, ScrH()/2
	if InsideState == "Diagonal" then
		x1,y1 = math.cos(math.pi/4), math.sin(math.pi/4)
		x2,y2 = math.cos(math.pi/4 + math.pi/2), math.sin(math.pi/4 + math.pi/2)
	elseif InsideState == "Rotating" then
		x1,y1 = math.cos(RealTime()/Inside_Rotation_Speed), math.sin(RealTime()/Inside_Rotation_Speed)
		x2,y2 = math.cos(RealTime()/Inside_Rotation_Speed + math.pi/2), math.sin(RealTime()/Inside_Rotation_Speed + math.pi/2)
	elseif InsideState == "Normal" then
		x1,y1 = math.cos(0), math.sin(0)
		x2,y2 = math.cos(0 + math.pi/2), math.sin(0 + math.pi/2)
	end
	local iR, oR = 0, 18
	if GetConVar("XoX_Crosshair_Draw_Inside"):GetInt() > 0 then
	surface.DrawLine(cx + (x1*iR), cy + (y1*iR), cx + (x1*oR), cy + (y1*oR))
	surface.DrawLine(cx - (x1*iR), cy - (y1*iR), cx - (x1*oR), cy - (y1*oR))	
	surface.DrawLine(cx + (x2*iR), cy + (y2*iR), cx + (x2*oR), cy + (y2*oR))
	surface.DrawLine(cx - (x2*iR), cy - (y2*iR), cx - (x2*oR), cy - (y2*oR))
	end
	
	if GetConVar("XoX_Crosshair_Color_Inside"):GetInt() > 0 then
	surface.SetDrawColor(OutsideColor)		
	else
	surface.SetDrawColor(CHx,CHy,CHz,255)
	end
	
	local ca, cb = ScrW()/2, ScrH()/2
	if OutsideState == "Diagonal" then
		a1,b1 = math.cos(math.pi/4), math.sin(math.pi/4)
		a2,b2 = math.cos(math.pi/4 + math.pi/2), math.sin(math.pi/4 + math.pi/2)
	elseif OutsideState == "Rotating" then
		a1,b1 = math.cos(0 - RealTime()/Outside_Rotation_Speed), math.sin(0 - RealTime()/Outside_Rotation_Speed)
		a2,b2 = math.cos(0 - RealTime()/Outside_Rotation_Speed + math.pi/2), math.sin(0 - RealTime()/Outside_Rotation_Speed + math.pi/2)
	elseif OutsideState == "Normal" then
		a1,b1 = math.cos(0), math.sin(0)
		a2,b2 = math.cos(math.pi/2), math.sin(math.pi/2)
	end
	local iR2, oR2 = 18, 30
			
	if GetConVar("XoX_Crosshair_Draw_Outside"):GetInt() > 0 then
	surface.DrawLine(ca + (a1*iR2), cb + (b1*iR2), ca + (a1*oR2), cb + (b1*oR2))
	surface.DrawLine(ca - (a1*iR2), cb - (b1*iR2), ca - (a1*oR2), cb - (b1*oR2))	
	surface.DrawLine(ca + (a2*iR2), cb + (b2*iR2), ca + (a2*oR2), cb + (b2*oR2))
	surface.DrawLine(ca - (a2*iR2), cb - (b2*iR2), ca - (a2*oR2), cb - (b2*oR2))
	end
	
end

function hidehud(name)
if GetConVar("XoX_Draw_Gmod_HUD"):GetInt() <= 0 then
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

hook.Add("HUDPaint","ShowPosCrosshair",function()
if GetConVar("XoX_ShowPos"):GetInt() <= 0 then
	MAXSPEEDEVER = MAXSPEEDEVER or 0 
	 local CurSpeed = math.ceil(ply:GetVelocity():Length()) 
	 if CurSpeed > MAXSPEEDEVER then 
		MAXSPEEDEVER = CurSpeed
	 end 
	draw.SimpleText("Pos: " .. tostring(ply:GetPos()), "ScoreboardText", ScrW() / 2, ScrH() / 2 + 40, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Ang: " .. tostring(ply:GetAngles()), "ScoreboardText", ScrW() / 2, ScrH() / 2 + 55, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Vel: " .. tostring(CurSpeed), "ScoreboardText", ScrW() / 2, ScrH() / 2 + 70, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Max Vel: " .. tostring(MAXSPEEDEVER), "ScoreboardText", ScrW() / 2, ScrH() / 2 - 35, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end)
concommand.Add("XoX_ShowPos_Reset",function(pl,com,args)
		MAXSPEEDEVER = 0
end)

	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function aimbot()
if aimboton then
		if !aimbotpl:Alive() then
		local aimbotdist = 100000
			aimbotpl = ""
			for k,v in ipairs(player.GetAll()) do
			if v ~= ply then
		local aimbotx,aimboty = v:GetPos():ToScreen().x - ScrW() / 2 ,v:GetPos():ToScreen().y - ScrH() / 2 
		local thisdist = math.sqrt( math.abs(aimbotx) ^ 2 + math.abs(aimboty) ^ 2)
		if thisdist < aimbotdist and v ~= ply then aimbotpl = v;aimbotdist = thisdist end	
	end
	end
		
		end
		local targethead = aimbotpl:LookupBone(aimbotbone)
		local targetheadpos,targetheadang = aimbotpl:GetBonePosition(targethead)
		ply:SetEyeAngles((targetheadpos - ply:GetShootPos()):Angle())
end
end	

concommand.Add("+XoX_Aimbot", function(pl,com,args)
	aimboton = true
	local aimbotdist = 100000
	aimbotpl = ""
	for k,v in ipairs(player.GetAll()) do
	if v ~= ply then
		local aimbotx,aimboty = v:GetPos():ToScreen().x - ScrW() / 2 ,v:GetPos():ToScreen().y - ScrH() / 2 
		local thisdist = math.sqrt( math.abs(aimbotx) ^ 2 + math.abs(aimboty) ^ 2)
		if thisdist < aimbotdist and v ~= ply then aimbotpl = v;aimbotdist = thisdist end	
	end
	end
end)

concommand.Add("-XoX_Aimbot", function(pl,com,args)
	aimboton = false
end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
------------------------------      MENU       ---------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

Part1 = vgui.Create( "DPanel" )
Part1:SetSize( 200, 200 )
Part1:SetPos( -200, 100 )
Part1:SetVisible( false )
Part1:MakePopup()

Part2 = vgui.Create( "DPanel" )
Part2:SetSize( 200, 200 )
Part2:SetPos( ScrW() + 200, 300 )
Part2:SetVisible( false )
Part2:MakePopup()

Part3 = vgui.Create( "DPanel" )
Part3:SetSize( 200, 200 )
Part3:SetPos( 100, ScrH() + 200 )
Part3:SetVisible( false )
Part3:MakePopup()

Part4 = vgui.Create( "DPanel" )
Part4:SetSize( 200, 200 )
Part4:SetPos( 300, -200 )
Part4:SetVisible( false )
Part4:MakePopup()

concommand.Add("+XoX_Menu",function(pl, com, args)
	
	Part1:SetVisible( true )
	Part2:SetVisible( true )
	Part3:SetVisible( true )
	Part4:SetVisible( true )
	
	local Part1x, Part1y = Part1:GetPos()
	local Part2x, Part2y = Part2:GetPos()
	local Part3x, Part3y = Part3:GetPos()
	local Part4x, Part4y = Part4:GetPos() 

------------------- Menu Part 1 ----------------------
	
	timer.Create("MenuIn1",0.001,0,function()
		if Part1x < 300 then
			Part1:SetPos( Part1x + 50, 100 )
			Part1x, Part1y = Part1:GetPos()
		else
			timer.Destroy("MenuIn1")
		end
	end)	
	
------------------- Menu Part 2 ----------------------

	timer.Create("MenuIn2",0.001,0,function()
		if Part2x > 100 then
			Part2:SetPos( Part2x - 50, 300 )
			Part2x, Part2y = Part2:GetPos()
		else
			timer.Destroy("MenuIn2")
		end
	end)	

------------------- Menu Part 3 ----------------------

	timer.Create("MenuIn3",0.001,0,function()
		if Part3y > 100 then
			Part3:SetPos( 100, Part3y - 50 )
			Part3x, Part3y = Part3:GetPos()
		else
			timer.Destroy("MenuIn3")
		end
	end)	

------------------- Menu Part 4 ----------------------

	timer.Create("MenuIn4",0.001,0,function()
		if Part4y < 300 then
			Part4:SetPos( 300, Part4y + 50 )
			Part4x, Part4y = Part4:GetPos()
		else
			timer.Destroy("MenuIn4")
		end
	end)	


	
end)

concommand.Add("-XoX_Menu",function(pl, com, args)

	local Part1x, Part1y = Part1:GetPos()
	local Part2x, Part2y = Part2:GetPos()
	local Part3x, Part3y = Part3:GetPos()
	local Part4x, Part4y = Part4:GetPos()

------------------- Menu Part 1 ----------------------	
	
	timer.Create("MenuOut1",0.001,0,function()
		if Part1x > -200 then
			Part1:SetPos( Part1x - 50, 100 )
			Part1x, Part1y = Part1:GetPos()
		else
		Part1:SetVisible( false )
		timer.Destroy("MenuOut1")
		end
	end)
	
------------------- Menu Part 2 ----------------------

	
	timer.Create("MenuOut2",0.001,0,function()
		if Part2x < ScrW() + 200 then
			Part2:SetPos( Part2x + 50, 300 )
			Part2x, Part2y = Part2:GetPos()
		else
			Part2:SetVisible( false )
			timer.Destroy("MenuOut2")
		end
	end)
	
------------------- Menu Part 3 ----------------------

	timer.Create("MenuOut3",0.001,0,function()
		if Part3y < ScrH() + 200 then
			Part3:SetPos( 100, Part3y + 50 )
			Part3x, Part3y = Part3:GetPos()
		else
			Part3:SetVisible( false )
			timer.Destroy("MenuOut3")
		end
	end)

------------------- Menu Part 4 ----------------------
	
	timer.Create("MenuOut4",0.001,0,function()
		if Part4y > -200 then
			Part4:SetPos( 300, Part4y - 50 )
			Part4x, Part4y = Part4:GetPos()
		else
			Part4:SetVisible( false )
			timer.Destroy("MenuOut4")
		end
	end)

end)

-------------------------------------------------------
------------------- Tab Menu --------------------------



TabMenu = vgui.Create( "DPropertySheet" )
TabMenu:SetParent( Part1 )
TabMenu:SetPos( 5, 5 )
TabMenu:SetSize( 190, 190 )

Tab1 = vgui.Create("DLabel")
Tab1:SetText("")

CBDrawInside = vgui.Create("DCheckBoxLabel", Tab1)
CBDrawInside:SetPos(5,5)
CBDrawInside:SetText("Draw Inside")
CBDrawInside:SetSize(200,30)
CBDrawInside:SetConVar( "XoX_Crosshair_Draw_Inside" )
CBDrawInside:SetDisabled( false )

CBDrawOutside = vgui.Create("DCheckBoxLabel", Tab1)
CBDrawOutside:SetPos(5,22)
CBDrawOutside:SetText("Draw Outside")
CBDrawOutside:SetSize(200,30)
CBDrawOutside:SetConVar( "XoX_Crosshair_Draw_Outside" )
CBDrawOutside:SetDisabled( false )

CBDrawCircle = vgui.Create("DCheckBoxLabel", Tab1)
CBDrawCircle:SetPos(5,39)
CBDrawCircle:SetText("Draw Circle")
CBDrawCircle:SetSize(200,30)
CBDrawCircle:SetConVar( "XoX_Crosshair_Draw_Circle" )
CBDrawCircle:SetDisabled( false )


BtnInside = vgui.Create("DButton", Tab1)
BtnInside:SetPos(110,5)
BtnInside:SetSize( 70,20 )
BtnInside:SetText( "Inside" )
BtnInside:SetDisabled( false )
BtnInside.DoClick = function()
		InsideMenu = vgui.Create("DMenu")
		InsideMenu:AddOption("Rotating", function() InsideState = "Rotating" end )
		InsideMenu:AddOption("Normal", function() InsideState = "Normal" end )
		InsideMenu:AddOption("Diagonal", function() InsideState = "Diagonal" end )
		InsideMenu:Open()
end

BtnOutside = vgui.Create("DButton", Tab1)
BtnOutside:SetPos(110,30)
BtnOutside:SetSize( 70,20 )
BtnOutside:SetText( "Outside" )
BtnOutside:SetDisabled( false )
BtnOutside.DoClick = function()
		OutsideMenu = vgui.Create("DMenu")
		OutsideMenu:AddOption("Rotating", function() OutsideState = "Rotating" end )
		OutsideMenu:AddOption("Normal", function() OutsideState = "Normal" end )
		OutsideMenu:AddOption("Diagonal", function() OutsideState = "Diagonal" end )
		OutsideMenu:Open()
end



CBColorInside = vgui.Create("DCheckBoxLabel", Tab1)
CBColorInside:SetPos(0,70)
CBColorInside:SetText("In")
CBColorInside:SetSize(200,30)
CBColorInside:SetConVar( "XoX_Crosshair_Color_Inside" )
CBColorInside:SetDisabled( false )

CBColorOutside = vgui.Create("DCheckBoxLabel", Tab1)
CBColorOutside:SetPos(77,190)
CBColorOutside:SetText("Out")
CBColorOutside:SetSize(200,30)
CBColorOutside:SetConVar( "XoX_Crosshair_Color_Outside" )
CBColorOutside:SetDisabled( false )

CBColorCircle = vgui.Create("DCheckBoxLabel", Tab1)
CBColorCircle:SetPos(150,70)
CBColorCircle:SetText("Circle")
CBColorCircle:SetSize(200,30)
CBColorCircle:SetConVar( "XoX_Crosshair_Color_Circle" )
CBColorCircle:SetDisabled( false )

------------------------------------------------------------------------------

Tab2 = vgui.Create( "DLabel")
Tab2:SetText("")


BtnBone = vgui.Create("DButton", Tab2)
BtnBone:SetPos(10,10)
BtnBone:SetSize( 70,20 )
BtnBone:SetText( "Target" )
BtnBone:SetDisabled( false )
BtnBone.DoClick = function()
		BoneMenu = vgui.Create("DMenu")
		BoneMenu:AddOption("Head", function() aimbotbone = "ValveBiped.Bip01_Head1" end )
		BoneMenu:AddOption("Chest", function() aimbotbone = "ValveBiped.Bip01_Spine2" end )
		BoneMenu:Open()
end

--[[		
ValveBiped.Bip01_Neck1
ValveBiped.Bip01_Spine4
ValveBiped.Bip01_Spine2
ValveBiped.Bip01_Spine1
ValveBiped.Bip01_Spine
ValveBiped.Bip01_R_UpperArm
ValveBiped.Bip01_R_Forearm
ValveBiped.Bip01_R_Hand
ValveBiped.Bip01_L_UpperArm
ValveBiped.Bip01_L_Forearm
ValveBiped.Bip01_L_Hand
ValveBiped.Bip01_R_Thigh
ValveBiped.Bip01_R_Calf
ValveBiped.Bip01_R_Foot
ValveBiped.Bip01_R_Toe0
ValveBiped.Bip01_L_Thigh
ValveBiped.Bip01_L_Calf
ValveBiped.Bip01_L_Foot
ValveBiped.Bip01_L_Toe0
]]--
------------------------------------------------------------------------------
------------------------------------------------------------------------------

Tab4 = vgui.Create( "DLabel")
Tab4:SetText("")
Adminlist = vgui.Create( "DComboBox", Tab4)
Adminlist:SetPos(0,0)
Adminlist:SetSize( 185,185)
for k, plys in pairs(player.GetAll()) do
	if plys:IsAdmin() or plys:IsSuperAdmin() then
	Adminlist:AddChoice(plys:GetName())
	end
end


TabMenu:AddSheet("Crosshair",Tab1,"gui/silkicons/error",false,false)
TabMenu:AddSheet("Aimbot",Tab2,"gui/silkicons/status_offline",false,false)
TabMenu:AddSheet("Admins",Tab4,"gui/silkicons/shield_add",false,false)



------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

RadarXSlider = vgui.Create( "DNumSlider", Part2 )
RadarXSlider:SetPos(5,10)
RadarXSlider:SetSize(190,40)
RadarXSlider:SetText( "Radar Position (X)" )
RadarXSlider:SetMin( 0 )
RadarXSlider:SetMax( 1000 )
RadarXSlider:SetDecimals( 0 )
RadarXSlider:SetConVar( "XoX_Radar_Pos_X" )

RadarYSlider = vgui.Create( "DNumSlider", Part2 )
RadarYSlider:SetPos(5, 50)
RadarYSlider:SetSize(190,40)
RadarYSlider:SetText( "Radar Position (Y)" )
RadarYSlider:SetMin( 0 )
RadarYSlider:SetMax( 1000 )
RadarYSlider:SetDecimals( 0 )
RadarYSlider:SetConVar( "XoX_Radar_Pos_Y" )

RadarWidthSlider = vgui.Create( "DNumSlider", Part2 )
RadarWidthSlider:SetPos(5,90)
RadarWidthSlider:SetSize(190,40)
RadarWidthSlider:SetText( "Radar Width" )
RadarWidthSlider:SetMin( 1 )
RadarWidthSlider:SetMax( 1000 )
RadarWidthSlider:SetDecimals( 0 )
RadarWidthSlider:SetConVar( "XoX_Radar_Width" )



-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------


CBRadar = vgui.Create("DCheckBox", Part3)
CBRadar:SetPos( 5 , 25 )
CBRadar:SetText( "Radar" )
CBRadar:SetConVar( "XoX_Radar_Draw" )
CBGmodHUD = vgui.Create("DCheckBox", Part3)
CBGmodHUD:SetPos( 5 , 42 )
CBGmodHUD:SetText( "Draw Gmod HUD" )
CBGmodHUD:SetConVar( "XoX_Draw_Gmod_HUD" )
CBHealthbar = vgui.Create("DCheckBox", Part3)
CBHealthbar:SetPos( 5 , 59 )
CBHealthbar:SetText( "Draw Healthbar" )
CBHealthbar:SetConVar( "XoX_HUD_Draw_Healthbar" )
CBArmorbar = vgui.Create("DCheckBox", Part3)
CBArmorbar:SetPos( 5 , 76 )
CBArmorbar:SetText( "Draw Armorbar" )
CBArmorbar:SetConVar( "XoX_HUD_Draw_Armorbar" )
CBESPEnable = vgui.Create("DCheckBox", Part3)
CBESPEnable:SetPos( 100 , 25 )
CBESPEnable:SetText( "Enabled" )
CBESPEnable:SetConVar( "XoX_ESP_Draw" )
CBESPEnemyOnly = vgui.Create("DCheckBox", Part3)
CBESPEnemyOnly:SetPos( 100 , 42 )
CBESPEnemyOnly:SetText( "Enemy Only" )
CBESPEnemyOnly:SetConVar( "XoX_ESP_Enemy_Only" )
CBShowPos = vgui.Create("DCheckBox", Part3)
CBShowPos:SetPos( 100 , 80 )
CBShowPos:SetText( "ShowPosition" )
CBShowPos:SetConVar( "XoX_ShowPos" )
CBMiscBhop = vgui.Create("DCheckBox", Part4)
CBMiscBhop:SetPos( 5 , 25 )
CBMiscBhop:SetText( "Bhop" )
CBMiscBhop:SetConVar( "XoX_Bhop" )
CBMiscAttack = vgui.Create("DCheckBox", Part4)
CBMiscAttack:SetPos( 5 , 42 )
CBMiscAttack:SetText( "Fire Mod" )
CBMiscAttack:SetConVar( "XoX_Rapid_Fire" )
CBMiscUse = vgui.Create("DCheckBox", Part4)
CBMiscUse:SetPos( 5 , 59 )
CBMiscUse:SetText( "Use Mod" )
CBMiscUse:SetConVar( "XoX_Rapid_Use" )
CBMiscFlash = vgui.Create("DCheckBox", Part4)
CBMiscFlash:SetPos( 5 , 76 )
CBMiscFlash:SetText( "Flash Mod" )
CBMiscFlash:SetConVar( "XoX_Rapid_Flash" )


------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------


LabelHUD = vgui.Create( "DLabel", Part3)
LabelHUD:SetText( "HUD:" )
LabelHUD:SetPos( 5,5 )
LabelRadar = vgui.Create( "DLabel", Part3)
LabelRadar:SetText( "Radar" )
LabelRadar:SetSize( 100 ,10 )
LabelRadar:SetPos( 22 ,26.5 )
LabelGmodHUD = vgui.Create( "DLabel", Part3)
LabelGmodHUD:SetText( "Gmod-HUD" )
LabelGmodHUD:SetSize( 100 ,10 )
LabelGmodHUD:SetPos( 22 ,43 )
LabelHealthbar = vgui.Create( "DLabel", Part3)
LabelHealthbar:SetText( "Healthbar" )
LabelHealthbar:SetSize( 100 ,10 )
LabelHealthbar:SetPos( 22 ,60 )
LabelArmorbar = vgui.Create( "DLabel", Part3)
LabelArmorbar:SetText( "Armorbar" )
LabelArmorbar:SetSize( 100 ,10 )
LabelArmorbar:SetPos( 22 ,77 )
LabelHUD = vgui.Create( "DLabel", Part3)
LabelHUD:SetText( "ESP:" )
LabelHUD:SetPos( 100,5 )
LabelRadar = vgui.Create( "DLabel", Part3)
LabelRadar:SetText( "Enable" )
LabelRadar:SetSize( 100 ,10 )
LabelRadar:SetPos( 122 ,26.5 )
LabelGmodHUD = vgui.Create( "DLabel", Part3)
LabelGmodHUD:SetText( "Enemy Only" )
LabelGmodHUD:SetSize( 100 ,20 )
LabelGmodHUD:SetPos( 122 ,38 )

LabelMiscBhop = vgui.Create("DLabel", Part4)
LabelMiscBhop:SetPos( 22 , 25 )
LabelMiscBhop:SetText( "Bhop" )
LabelMiscBhop:SetSize( 100 ,10 )
LabelMiscAttack = vgui.Create("DLabel", Part4)
LabelMiscAttack:SetPos( 22 , 42 )
LabelMiscAttack:SetText( "Fire Mod" )
LabelMiscAttack:SetSize( 100 ,10 )
LabelMiscUse = vgui.Create("DLabel", Part4)
LabelMiscUse:SetPos( 22 , 59 )
LabelMiscUse:SetText( "Use Mod" )
LabelMiscUse:SetSize( 100 ,10 )
LabelMiscFlash = vgui.Create("DLabel", Part4)
LabelMiscFlash:SetPos( 22 , 76 )
LabelMiscFlash:SetText( "Flash Mod" )
LabelMiscFlash:SetSize( 100 ,10 )

LabelBuild = vgui.Create( "DLabel", Part3)
LabelBuild:SetText( "Build Mode" )
LabelBuild:SetSize( 100 ,10 )
LabelBuild:SetPos( 5 ,100 )
CBBuild = vgui.Create("DCheckBox", Part3)
CBBuild:SetPos( 5 , 115 )
CBBuild:SetText( "Enable" )
CBBuild:SetConVar( "XoX_Build" )
CBTrace = vgui.Create("DCheckBox", Part3)
CBTrace:SetPos( 5 , 132 )
CBTrace:SetText( "Trace" )
CBTrace:SetConVar( "XoX_Build_Trace_All" )
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
------------------------------    MENU END     ---------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function MenuBackground()
	-- surface.SetDrawColor(CHx,CHy,CHz,225)
	-- Part1x,Part1y = Part1:GetPos()
	-- Part1w,Part1h = Part1:GetSize()
    -- surface.DrawRect( Part1x, Part1y, Part1w, Part1h  )
	-- Part2x,Part2y = Part2:GetPos()
	-- Part2w,Part2h = Part2:GetSize()
    -- surface.DrawRect( Part2x, Part2y, Part2w, Part2h  )
	-- Part3x,Part3y = Part3:GetPos()
	-- Part3w,Part3h = Part3:GetSize()
    -- surface.DrawRect( Part3x, Part3y, Part3w, Part3h  )
	-- Part4x,Part4y = Part4:GetPos()
	-- Part4w,Part4h = Part4:GetSize()
    -- surface.DrawRect( Part4x, Part4y, Part4w, Part4h  )
	
	Part1:SetBackgroundColor(Color( CHx, CHy, CHz))
	Part2:SetBackgroundColor(Color( CHx, CHy, CHz))
	Part3:SetBackgroundColor(Color( CHx, CHy, CHz))
	Part4:SetBackgroundColor(Color( CHx, CHy, CHz))
end

function myHud()
	Healthbar()
	CrossHairs()
	AmmoClip()
	Radar()
	MenuBackground()
	DrawESP()
end

hook.Add("HUDPaint","myHud",myHud)

hook.Add("Think","aimbot",aimbot)

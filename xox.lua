local CHx = 0
local CHy = 125
local CHz = 255
local GoUpx = 1
local GoUpy = 1
local GoUpz = 0
local CHC = 0
local GoUpC = 0
local ply = LocalPlayer()
local trace = util.GetPlayerTrace( ply )
local traceRes = util.TraceLine( trace )
local aimboton = 0
local aimbotbone = "ValveBiped.Bip01_Head1"
OutsideState = "Rotating"
InsideState = "Rotating"

InsideColor = 255,255,255,255
OutSideColor = 255,255,255,255
CircleColor = 255,255,255,255
 
CreateClientConVar("XoX_Draw_Gmod_HUD", 0)
CreateClientConVar("XoX_Aimbot_MaxAngle", 360)
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
CreateClientConVar("XoX_Radar_Draw",1)
CreateClientConVar("XoX_Printer_Draw",1)
CreateClientConVar("XoX_ESP_Draw",1)
CreateClientConVar("XoX_ESP_Enemy_Only",0)
CreateClientConVar("XoX_Bhop",1)
CreateClientConVar("XoX_Rapid_Fire",1)
CreateClientConVar("XoX_Rapid_Use",1)
CreateClientConVar("XoX_Rapid_Flash",1)
CreateClientConVar( "XoX_Crosshair_Color_Circle",0 )
CreateClientConVar( "XoX_Crosshair_Color_Inside",0 )
CreateClientConVar( "XoX_Crosshair_Color_Outside",0 )
CreateClientConVar( "XoX_ShowPos",0 )

	Inside_Rotation_Speed = 6
	Outside_Rotation_Speed = 3
	
		local function Jump()
		ply:ConCommand("+jump")
		timer.Simple(0.1,
			function()
				ply:ConCommand("-jump")
			end
		)
	end
	
	hook.Add("Think","SuperJump",
		function()
			if(ply.SJump and ply:IsOnGround())then
				Jump()
			end
		end
	)
	
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
	
	
	concommand.Add("PhysToolSwap",function(pl,com,args)
		if ply:GetActiveWeapon():GetPrintName() == "Tool Gun" then RunConsoleCommand( "use", "weapon_physgun" )
		else RunConsoleCommand( "use", "weapon_toolgun") end
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
	
function DrawESP()
	if GetConVar("XoX_ESP_Draw"):GetInt() > 0 then
		for k, plys in pairs(player.GetAll()) do
			if plys != ply then
			if GetConVar("XoX_ESP_Enemy_Only"):GetInt() > 0 and ply:Team() == plys:Team() then
				else
				allplayersposition = plys:GetPos() + plys:OBBCenter()
				playerposition = allplayersposition:ToScreen()
				plysColor = team.GetColor(plys:Team())
				surface.SetDrawColor(plysColor)
				surface.DrawOutlinedRect( playerposition.x - 32 / 2, playerposition.y - 32 / 2, 32, 32)
				boxHeightDividedBy2 = 32 / 2
				surface.SetTextColor( plysColor )
				surface.SetTextPos(playerposition.x,playerposition.y - boxHeightDividedBy2 - 16)
				surface.SetFont("Default")
				surface.DrawText(plys:GetName())
				end
			end
		end
	end
end

function DrawPrinters()

--if GetConVar("XoX_Printer_Draw"):GetInt() > 0 then
--local printers = ents.FindByModel("models/Gibs/HGIBS.mdl")
local printers = ents.FindByClass("money*")
		for i = 1, #printers do
				allprinterpos = printers[i]:GetPos() + printers[i]:OBBCenter()
				printerpos = allprinterpos:ToScreen()
				surface.SetDrawColor(Color(255,0,0))
				surface.DrawOutlinedRect( printerpos.x - 32 / 2, printerpos.y - 32 / 2, 32, 32)
				boxHeightDividedBy2 = 32 / 2
				surface.SetTextColor( Color(255,0,0) )
				surface.SetTextPos(printerpos.x,printerpos.y - boxHeightDividedBy2 - 16)
				surface.SetFont("Default")
				surface.DrawText(printers[i]:GetClass())
		end
--	end
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

surface.CreateFont ("coolvetica", 60, 1, true, false, "AmmoClipFont01") 
surface.CreateFont ("coolvetica", 50, 1, true, false, "AmmoClipFont02") 
surface.CreateFont ("MenuItem", 80, 1, true, false, "AmmoClipFont03") 

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

function AngleDist( Angle1, Angle2 )
local dist = 0
pp = math.AngleDifference( Angle1.p , Angle2.p)
yy = math.AngleDifference( Angle1.y , Angle2.y)
rr = math.AngleDifference( Angle1.r , Angle2.r)
dist = math.abs(rr) + math.abs(yy) + math.abs(pp) 
return dist
end



function aimbot()
if aimboton == 1 then
playerlist = player.GetAll()
nearestdis = 10000
nearestply = nil

for i = 1, #playerlist do

local fortargethead = playerlist[i]:LookupBone(aimbotbone)
local fortargetheadpos,fortargetheadang = playerlist[i]:GetBonePosition(fortargethead)

local tracedata = {}
tracedata.start = ply:GetShootPos()
tracedata.endpos = fortargetheadpos
local trace = util.TraceLine(tracedata)
if trace.Entity:IsPlayer() then
if playerlist[i] ~= ply && playerlist[i]:Alive() && AngleDist( (fortargetheadpos -  ply:GetShootPos()):Angle(), ply:GetAngles() ) < nearestdis then

nearestdis = AngleDist( (fortargetheadpos - ply:GetShootPos()):Angle(), ply:GetAngles() )
nearestply = playerlist[i]
end
end
end


if nearestply ~= nil then
local targethead = nearestply:LookupBone(aimbotbone)
local targetheadpos,targetheadang = nearestply:GetBonePosition(targethead)
			ply:SetEyeAngles((targetheadpos - ply:GetShootPos()):Angle())
else
			
end
end	
end

concommand.Add("+XoX_Aim", function(pl,com,args)
aimboton = 1
end)

concommand.Add("-XoX_Aim", function(pl,com,args)
aimboton = 0
end)


--------------------------------
--------------------------------

function Spawnstuff(plyy)
if plyy:IsAdmin() or plyy:IsSuperAdmin() then
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
GAMEMODE:AddNotify("Watch out! Admin ".. plyy:Nick() .." joined.", NOTIFY_ERROR, 5);
end
   
if plyy:IPAddress() ~= nil then
        filex.Append("ips.txt", "Player "..plyy:Nick().." has connected from the IP "..plyy:IPAddress() .."  SteamID: " plyy:SteamID() " \n")
        GAMEMODE:AddNotify("Player "..plyy:Nick().." has connected from the IP "..plyy:IPAddress())
end
end

hook.Add( "PlayerInitialSpawn", "SpawnStuff",  SpawnStuff )

concommand.Add("XoX_AdminScan", function(pl,com,args)
print("Admins:")
GAMEMODE:AddNotify("Admins:", NOTIFY_ERROR, 5);
for i = 1, #player.GetAll() do
if player.GetAll()[i]:IsAdmin() or player.GetAll()[i]:IsSuperAdmin() then
GAMEMODE:AddNotify(player.GetAll()[i]:Nick(), NOTIFY_ERROR, 5);
print(player.GetAll()[i]:Nick())
end
end
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

Part1 = vgui.Create( "DBevel" )
Part1:SetSize( 200, 200 )
Part1:SetPos( -200, 100 )
Part1:SetVisible( false )
Part1:MakePopup()

Part2 = vgui.Create( "DBevel" )
Part2:SetSize( 200, 200 )
Part2:SetPos( ScrW() + 200, 300 )
Part2:SetVisible( false )
Part2:MakePopup()

Part3 = vgui.Create( "DBevel" )
Part3:SetSize( 200, 200 )
Part3:SetPos( 100, ScrH() + 200 )
Part3:SetVisible( false )
Part3:MakePopup()

Part4 = vgui.Create( "DBevel" )
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

InsideColorCircle = vgui.Create( "DColorCircle", Tab1 )
InsideColorCircle:SetPos(0,90)
InsideColorCircle:SetSize(66,66)
InsideColorCircle.PaintOver = function()
if InsideColorCircle:GetRGB() == nil then return end
	InsideColor = InsideColorCircle:GetRGB() or Color()
	InsideColor = InsideColor[r], InsideColor[g], InsideColor[b], InsideColor[a]
end

OutsideColorCircle = vgui.Create( "DColorCircle", Tab1 )
OutsideColorCircle:SetPos(57.5,60)
OutsideColorCircle:SetSize(66,66)
OutsideColorCircle.PaintOver = function()
if OutsideColorCircle:GetRGB() == nil then return end
	OutsideColor = OutsideColorCircle:GetRGB() or Color()
	OutsideColor = OutsideColor[r], OutsideColor[g], OutsideColor[b], OutsideColor[a]
end

CircleColorCircle = vgui.Create( "DColorCircle", Tab1 )
CircleColorCircle:SetPos(115,90)
CircleColorCircle:SetSize(66,66)
CircleColorCircle.PaintOver = function()
if CircleColorCircle:GetRGB() == nil then return end
	CircleColor = CircleColorCircle:GetRGB() or Color()
	CircleColor = CircleColor[r], CircleColor[g], CircleColor[b], CircleColor[a]
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
	Adminlist:AddItem(plys:GetName())
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
	surface.SetDrawColor(CHx,CHy,CHz,225)
	Part1x,Part1y = Part1:GetPos()
	Part1w,Part1h = Part1:GetSize()
    surface.DrawRect( Part1x, Part1y, Part1w, Part1h  )
	Part2x,Part2y = Part2:GetPos()
	Part2w,Part2h = Part2:GetSize()
    surface.DrawRect( Part2x, Part2y, Part2w, Part2h  )
	Part3x,Part3y = Part3:GetPos()
	Part3w,Part3h = Part3:GetSize()
    surface.DrawRect( Part3x, Part3y, Part3w, Part3h  )
	Part4x,Part4y = Part4:GetPos()
	Part4w,Part4h = Part4:GetSize()
    surface.DrawRect( Part4x, Part4y, Part4w, Part4h  )
	
end

function myHud()
	Healthbar()
	CrossHairs()
	AmmoClip()
	Radar()
	MenuBackground()
	DrawESP()
	DrawPrinters()
end

hook.Add("HUDPaint","myHud",myHud)

hook.Add("Think","aimbot",aimbot)





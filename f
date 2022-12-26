 _G.A = true
if _G.A == true then
    
    
    


local CurrentCamera = game:GetService("Workspace").CurrentCamera
local RunService = game:GetService("RunService")
local Mouse = game.Players.LocalPlayer:GetMouse()
local Plr

function FindClosestPlayer()
    local closestPlayer
    local shortestDistance = math.huge

    for i, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
            v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

Mouse.KeyDown:Connect(function(KeyPressed)
    if KeyPressed == (getgenv().MouseLock.Key) then
        if getgenv().MouseLock.Enabled == true then
            getgenv().MouseLock.Enabled = false
            Plr = FindClosestPlayer()
        else
            Plr = FindClosestPlayer()
            getgenv().MouseLock.Enabled = true

        end
    end
end)

RunService.Stepped:connect(function()
    if getgenv().MouseLock.Enabled == true then
        local Vector = CurrentCamera:WorldToScreenPoint(Plr.Character[getgenv().MouseLock.AimPart].Position +
                                                            (Plr.Character[getgenv().MouseLock.AimPart].Velocity *
                                                                getgenv().MouseLock.Prediction))
        mousemoverel(Vector.X - Mouse.X, Vector.Y - Mouse.Y)
    end

end)


    local MapLightingJmp = Instance.new("ColorCorrectionEffect")
MapLightingJmp.Parent = game:GetService("Lighting")
MapLightingJmp.Enabled = false
MapLightingJmp.Brightness = 0
MapLightingJmp.Contrast = 0
MapLightingJmp.Saturation = 0
MapLightingJmp.TintColor = Color3.fromRGB(255, 255, 255)

 local ESP = loadstring(game:HttpGet("https://pastebin.com/raw/LiJTDVBK"))()
 ESP.Color = Color3.fromRGB(255,0,0)
getgenv().WorldC = false
local mouse = game.Players.LocalPlayer:GetMouse() -- Getting local mouse (needed)
local Player = game:GetService("Players").LocalPlayer -- Getting self (local)
local runService = game:service("RunService") -- Leave lol ik defined twice

local function getMousePosition() -- Getting mouse (leave how it is)
    return Vector2.new(mouse.X, mouse.Y)
end


color = Color3.fromRGB(255,0,0)



local LocalPlayer = game.Players.LocalPlayer

function Alive(Player)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("Head") ~= nil then
        return true
    end
    return false
end

 getgenv().Hat = {
   enabled = false; -- / true / false
   minCameraDistance = 1; -- / any number
   hatTransparency = .35; -- / 0 - 1 (0 being invisible)
   circleTransparency = 1; -- / 0 - 1 (0 being invisible)
   height = .75; -- / any number
   radius = 1; -- /-- any number
   sides = 25; -- / any number
   rainbow = false; -- / true / false
   color = Color3.fromRGB(128,18,255); -- / 0-255,0-255,0-255
   offset = Vector3.new(0,.75,0); -- / number,number,number (studs offset from head center)
}

local runservice = game:GetService('RunService');
local lplr = game:GetService('Players').LocalPlayer
local camera = workspace.CurrentCamera;
local tau = math.pi*2
local drawings = {};

for i = 1,getgenv().Hat.sides do
   drawings[i] = {Drawing.new('Line'),Drawing.new('Triangle')}
   drawings[i][1].ZIndex = 2;
   drawings[i][1].Thickness = 2;
   drawings[i][2].ZIndex = 1;
   drawings[i][2].Filled = true;
end

runservice.RenderStepped:Connect(function()
   local pass = getgenv().Hat.enabled and lplr.Character and lplr.Character:FindFirstChild('Head') ~= nil and (camera.CFrame.p - camera.Focus.p).magnitude > getgenv().Hat.minCameraDistance and lplr.Character.Humanoid.Health > 0
   for i = 1,#drawings do
       local line,triangle = drawings[i][1], drawings[i][2];
       if pass then
           local color = getgenv().Hat.rainbow and Color3.fromHSV((tick() % 5 / 5 - (i / #drawings)) % 1,.5,1) or getgenv().Hat.color;
           local pos = lplr.Character.Head.Position + getgenv().Hat.offset;
           local topWorld = pos + Vector3.new(0,getgenv().Hat.height,0);

           local last, next = (i/getgenv().Hat.sides)*tau, ((i+1)/getgenv().Hat.sides)*tau;
           local lastWorld = pos + (Vector3.new(math.cos(last),0,math.sin(last))*getgenv().Hat.radius);
           local nextWorld = pos + (Vector3.new(math.cos(next),0,math.sin(next))*getgenv().Hat.radius);
           local lastScreen = camera:WorldToViewportPoint(lastWorld);
           local nextScreen = camera:WorldToViewportPoint(nextWorld);
           local topScreen = camera:WorldToViewportPoint(topWorld);

           line.From = Vector2.new(lastScreen.X,lastScreen.Y);
           line.To = Vector2.new(nextScreen.X,nextScreen.Y);
           line.Color = color;
           line.Transparency = getgenv().Hat.circleTransparency;
           line.Visible = true;

           triangle.PointA = Vector2.new(topScreen.X,topScreen.Y);
           triangle.PointB = line.From;
           triangle.PointC = line.To;
           triangle.Color = color;
           triangle.Transparency = getgenv().Hat.hatTransparency;
           triangle.Visible = true;
       else
           line.Visible = false;
           triangle.Visible = false;
       end
   end
end)



_G.fovcircle = Drawing.new("Circle")
_G.fovcircle.Visible = false
_G.fovcircle.Radius = 100
_G.fovcircle.Color = Color3.fromRGB(255,0,0)
_G.fovcircle.Thickness = 1
_G.fovcircle.Filled = false
_G.fovcircle.Transparency = 1

getgenv().Settings = {
	Enabled = false,
	Boxes = false,
	BoxT = 1,
	Color = Color3.new(255,0,0),
	Width = 3000, -- cool feature
	Filled = false,
	FillColor = Color3.fromRGB(0, 0, 0),
	Transparency = 0.2, -- Filled box transparency
	Healthbar = false, 
	Tracers = false,
	LineT = 1,
	Tcolor = Color3.fromRGB(255, 0, 0), -- Trace color
	Tfrom = 2, -- where tracers locate
	TeamCheck = false,
	TeamColor = false,
	FriendlyColor = Color3.fromRGB(0,255,0), -- If teamcolor on set ur friendlies colors
	Lac = false, -- Link all colors
	Lc = Color3.fromRGB(84,233,154), -- Linked color
	Names = false, -- Yeah
	NameC = Color3.fromRGB(255,0,0), -- Name color
	TextSize = 20, -- Yh
	Offset = 30, -- Bit bugged cos further u are the higher it goes 
	 ViewTracer = true,
	   Color = Color3.fromRGB(255, 203, 138), -- Color of the line
    Thickness = 1, -- Thickness of the line (Overruled by AutoThickness if activated)
    Transparency = 1, -- 1 Visible - 0 Not Visible
    AutoThickness = true, -- Makes Thickness above futile, scales according to distance, good for less encumbered screen
    Length = 15, -- In studs of the line
    Smoothness = 0.2, -- 0.01 - Less Smooth(Faster), 1 - Smoother (Slower)
	Rainbow = false -- Rainbow esp coloer (not filled / outlines)
}


   _G.PredictionBreaker = false

    game.RunService.Heartbeat:Connect(function()
        if _G.PredictionBreaker then    
        local CurrentVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        game.RunService.RenderStepped:Wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = CurrentVelocity
        end    
    end)

--> Start of main locals <--
local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewportPoint = CurrentCamera.worldToViewportPoint

--[[ local HeadOff = Vector3.new(0, 0.5, 0) -- Leave this
local LegOff = Vector3.new(0, 3, 0) -- Leave this
]]

local HeadOff = Vector3.new(0, 0.8, 0) -- Leave this
local LegOff = Vector3.new(0, 4, 2) -- Leave this
--> End <--

local function Draw(v)

	local BoxFilled = Drawing.new("Square")
	BoxFilled.Visible = false
	BoxFilled.Color = Color3.new(0, 0, 0)
	BoxFilled.Thickness = 0
	BoxFilled.Transparency = getgenv().Settings.Transparency
	BoxFilled.Filled = getgenv().Settings.Filled

	local BoxOutline = Drawing.new("Square")
	BoxOutline.Visible = false
	BoxOutline.Color = Color3.new(0, 0, 0)
	BoxOutline.Thickness = 3
	BoxOutline.Transparency = getgenv().Settings.BoxT
	BoxOutline.Filled = false

	local Box = Drawing.new("Square")
	Box.Visible = true
	Box.Color = getgenv().Settings.Color
	Box.Thickness = 1
	Box.Transparency = getgenv().Settings.BoxT
	Box.Filled = false

	local HealthBarOutline = Drawing.new("Square")
	HealthBarOutline.Thickness = 3
	HealthBarOutline.Filled = false
	HealthBarOutline.Color = Color3.new(0, 0, 0)
	HealthBarOutline.Transparency = 1
	HealthBarOutline.Visible = false

	local HealthBar = Drawing.new("Square")
	HealthBar.Thickness = 1
	HealthBar.Filled = false
	HealthBar.Transparency = 1
	HealthBar.Visible = false

	local Black = Drawing.new("Line")
	Black.Visible = false
	Black.Color =  Color3.fromRGB(0, 0 ,0)
	Black.Thickness = 1*2
	Black.Transparency = getgenv().Settings.LineT

	local Tracer = Drawing.new("Line")
	Tracer.Visible = false
	Tracer.Color = getgenv().Settings.Tcolor
	Tracer.Thickness = 1
	Tracer.Transparency = getgenv().Settings.LineT

	local Name = Drawing.new("Text")
	Name.Transparency = 1
	Name.Visible = false
	Name.Color = Color3.new(1, 1, 1)
	Name.Size = 12
	Name.Center = true
	Name.Outline = true

	function boxesp()
		game:GetService("RunService").RenderStepped:Connect(function()
		    Box.Transparency = getgenv().Settings.BoxT
		     BoxOutline.Transparency = getgenv().Settings.BoxT
		      Black.Transparency = getgenv().Settings.LineT
		       Tracer.Transparency = getgenv().Settings.LineT
			Box.Color = getgenv().Settings.Color
			BoxFilled.Filled = getgenv().Settings.Filled
			BoxFilled.Color = getgenv().Settings.FillColor
			Name.Color = getgenv().Settings.NameC
			BoxFilled.Transparency = getgenv().Settings.Transparency
			if (getgenv().Settings.Rainbow) then
				Box.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			else
				Box.Color = getgenv().Settings.Color
			end;
			if (getgenv().Settings.Rainbow) then
				Tracer.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			else
				Tracer.Color = getgenv().Settings.Tcolor
			end;
			if (getgenv().Settings.Rainbow) then
				_G.fovcircle.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			else
				_G.fovcircle.Color = _G.fovcircle.Color
			end;
			if (getgenv().Settings.Rainbow) then
				Name.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			else
				Name.Color = getgenv().Settings.NameC
			end;
			
			if (getgenv().Settings.Rainbow and getgenv().Settings.Skeletons) then
				ESP.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
			else
				ESP.Color = getgenv().Settings.SkeletonC
			end;
			
			if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
				local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
				local RootPart = v.Character.HumanoidRootPart
				local Head = v.Character.Head
				local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
				local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
				local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)
				if getgenv().Settings.Boxes and getgenv().Settings.Enabled and onScreen then
					BoxFilled.Size = Vector2.new(getgenv().Settings.Width / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					BoxFilled.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
					BoxFilled.Visible = getgenv().Settings.Filled
					BoxOutline.Size = Vector2.new(getgenv().Settings.Width / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
					BoxOutline.Visible = true
					Box.Size = Vector2.new(getgenv().Settings.Width / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
					Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
					Box.Visible = true
				else
					BoxFilled.Visible = false
					BoxOutline.Visible = false
					Box.Visible = false
				end
				if getgenv().Settings.Healthbar and onScreen and getgenv().Settings.Enabled  then
					HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
					HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6, 0)
					HealthBarOutline.Visible = true
					HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (v.Character.Humanoid.MaxHealth / math.clamp(v.Character.Humanoid.Health, 0, v.Character.Humanoid.MaxHealth)))
					HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
					HealthBar.Color = Color3.fromRGB(255 - 255 / (v.Character.Humanoid.MaxHealth / v.Character.Humanoid.Health), 255 / (v.Character.Humanoid.MaxHealth / v.Character.Humanoid.Health), 0)
					HealthBar.Visible = true
				else
					HealthBarOutline.Visible = false
					HealthBar.Visible = false
				end
				if getgenv().Settings.Tracers and onScreen then


					Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / getgenv().Settings.Tfrom)
					Tracer.To = Vector2.new(Vector.X, Vector.Y)

					Black.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / getgenv().Settings.Tfrom)
					Black.To = Vector2.new(Vector.X, Vector.Y)


					Black.Visible = true
					Tracer.Visible = true
				else
					Tracer.Visible = false
					Black.Visible = false
				end
				
				
					if getgenv().Settings.TeamCheck and v.TeamColor == lplr.TeamColor and onScreen then
					BoxFilled.Visible = false
					BoxOutline.Visible = false
					Box.Visible = false
					HealthBarOutline.Visible = false
					HealthBar.Visible = false
					Tracer.Visible = false
					Black.Visible = false
					Name.Visible = false
				    ESP.Skeleton = false
				end
				if getgenv().Settings.TeamColor and v.TeamColor == lplr.TeamColor and onScreen then
					Box.Color = getgenv().Settings.FriendlyColor
					Tracer.Color = getgenv().Settings.FriendlyColor
					Name.Color = getgenv().Settings.FriendlyColor
					 ESP.Color = getgenv().Settings.FriendlyColor
				end
		
			if getgenv().Settings.Lac then
				Box.Color = getgenv().Settings.Lc
				Tracer.Color = getgenv().Settings.Lc
				Name.Color = getgenv().Settings.Lc
			    ESP.Color = getgenv().Settings.Lc
			end
			
	
			if getgenv().Settings.Names and onScreen and getgenv().Settings.Enabled and not getgenv().Settings.TeamCheck then
					Name.Text = tostring(v.Name)
					Name.Position = Vector2.new(workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).X, workspace.Camera:WorldToViewportPoint(v.Character.Head.Position).Y - getgenv().Settings.Offset)
					Name.Visible = true
					Name.Size = getgenv().Settings.TextSize
					
				else
					Name.Visible = false
			end
			
		
			
			else
				BoxFilled.Visible = false
				BoxOutline.Visible = false
				Box.Visible = false
				HealthBarOutline.Visible = false
				HealthBar.Visible = false
				Tracer.Visible = false
				Name.Visible = false
				Black.Visible = false
			   ESP.Skeleton = false
			end
		
			if getgenv().Settings.Enabled == false then
				BoxFilled.Visible = false
				BoxOutline.Visible = false
				Box.Visible = false
				HealthBarOutline.Visible = false
				HealthBar.Visible = false
				Tracer.Visible = false
				Black.Visible = false
			    ESP.Skeleton = false
			end
		end)
	end
	coroutine.wrap(boxesp)()
end

for i, v in pairs(game.Players:GetChildren()) do
	Draw(v)
end

game.Players.PlayerAdded:Connect(function(v)
	Draw(v)
end)





loadstring(game:HttpGet('https://raw.githubusercontent.com/Longassnamefornoreason/Aristois/main/CfrFix'))() -- Fixer

--local Fov = loadstring(game:HttpGet('https://raw.githubusercontent.com/Longassnamefornoreason/Aristois/main/Library'))() -- Circle


local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
_G.GunColor = Color3.fromRGB(255,255,255)
local Jit = math.random(30, 90)
JitterAngle = 50

local userInput = game:GetService('UserInputService')
local runService = game:GetService('RunService')

local sound = Instance.new("Sound", game.Workspace)
sound.SoundId = "rbxassetid://9009664674"

if not sound.IsLoaded then
	sound.Loaded:wait()
end

local sound1 = Instance.new("Sound", game.Workspace)
sound1.SoundId = "rbxassetid://9009665420"

if not sound1.IsLoaded then
	sound1.Loaded:wait()
end

for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Script") and v.Name ~= "Health" and v.Name ~= "Sound" and v:FindFirstChild("LocalScript") then
		v:Destroy()
	end
end
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
	repeat
		wait()
	until game.Players.LocalPlayer.Character
	char.ChildAdded:Connect(function(child)
		if child:IsA("Script") then 
			wait(0.1)
			if child:FindFirstChild("LocalScript") then
				child.LocalScript:FireServer()
			end
		end
	end)
end)



getgenv().Speed2 = false
getgenv().speedvalue = 0.50




game:GetService("RunService").Heartbeat:Connect(
    function()
        if Speed2 == true then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame +
                game.Players.LocalPlayer.Character.Humanoid.MoveDirection * speedvalue
      
  
        end
            
        end
)
  

getgenv().cross = false 

getgenv().WorldC = false
getgenv().rotationspeed = 5
getgenv().ZyZKey = Enum.KeyCode.Q
getgenv().targetstrafe = false
getgenv().autosetup = false
getgenv().Prediction = 1.36
getgenv().Tracer = false
getgenv().Dot = false
getgenv().TracerBugged = false
getgenv().LookAt = false
getgenv().ZyZPart = "Head"
getgenv().NotifyZyZ = false
getgenv().BlindStrafe = false
getgenv().ViewPlr = false
getgenv().NotificationsSound = false
getgenv().Enabled = false
_G.AirshotFunction = false
_G.AirshotPart = "Head"
_G.FRAME = Vector3.new(0,10,0)
_G.FRAME2 = Vector3.new(0,10,0)

-----settings for shit---
getgenv().dotvisible = false

getgenv().boxenable = false
getgenv().boxcolor = Color3.fromRGB(137, 207, 240)
getgenv().heathbar = false
getgenv().linevisile =false

getgenv().linecolor = Color3.fromRGB(137, 207, 240)

-- Target Strafe shit

getgenv().Distancet = 10
getgenv().Speedfortarget = 2
getgenv().ECLIPSE = 1 -- ranges from 0 to 1, perfect circle if 1
getgenv().ROTATION = CFrame.Angles(0,0,0) --rotate which direction to rotate around

getgenv().sin, cos = math.sin, math.cos
getgenv().ROTSPEED = math.pi*2/getgenv().Speedfortarget
getgenv().ECLIPSE = ECLIPSE * getgenv().Distancet
getgenv().rot = 0


local guimain = Instance.new("Folder", game.CoreGui)
local CC = game:GetService "Workspace".CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local Locking = false
local cc = game:GetService("Workspace").CurrentCamera
local gs = game:GetService("GuiService")
local ggi = gs.GetGuiInset
local lp = game:GetService("Players").LocalPlayer
local mouse = lp:GetMouse()

_G.Tracer = Drawing.new("Line")
_G.Tracer.Visible = false
_G.Tracer.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
_G.Tracer.Thickness = 1
_G.Tracer.Transparency = 1


_G.Dotty = Drawing.new("Circle")
_G.Dotty.Visible = false
_G.Dotty.Color = Color3.fromRGB(73, 73, 255)
_G.Dotty.Thickness = 1
_G.Dotty.Transparency = 1
_G.Dotty.Radius = 100
_G.Dotty.NumSides = 60



local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(
	function(keygo, ok)
		if (not ok) then
			if (keygo.KeyCode == getgenv().ZyZKey) then
				if getgenv().Enabled then
					Locking = not Locking
					if Locking then
						Plr = getClosestPlayerToCursor()
						if getgenv().ViewPlr then
							game.Workspace.CurrentCamera.CameraSubject = Plr.Character

						end
						if getgenv().NotificationsSound then
							sound:Play()
						end
						if getgenv().NotifyZyZ then
							
							Notification:Notify(
								{Title = "R.I.G", Description = "Locking Onto: " .. Plr.Character.Humanoid.DisplayName},
								{OutlineColor = Color3.fromRGB(80, 80, 80),Time = 2, Type = "image"},
								{Image = "http://www.roblox.com/asset/?id=11559441396", ImageColor = Color3.fromRGB(73, 73, 255)}
							)
						end
					elseif not Locking then

						if getgenv().ViewPlr then
							game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
						end

						if getgenv().NotificationsSound then
							sound1:Play()
						end

						if getgenv().NotifyZyZ then
							Notification:Notify(
								{Title = "R.I.G", Description = "Unlocked"},
								{OutlineColor = Color3.fromRGB(80, 80, 80),Time = 2, Type = "image"},
								{Image = "http://www.roblox.com/asset/?id=11559441396", ImageColor = Color3.fromRGB(73, 73, 255)}
							)
						end
					end
				end
			end
		end
	end
)
function getClosestPlayerToCursor()
	local closestPlayer
	local shortestDistance = 137

	for i, v in pairs(game.Players:GetPlayers()) do
		if
			v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
			v.Character.Humanoid.Health ~= 0 and
			v.Character:FindFirstChild("LowerTorso")
		then
			local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
			local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
			if magnitude < shortestDistance then
				closestPlayer = v
				shortestDistance = magnitude
			end
		end
	end
	return closestPlayer
end

local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall =
	newcclosure(
		function(...)
			local args = {...}
			if Locking and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
			args[3] =
				Plr.Character[getgenv().ZyZPart].Position + (Plr.Character[getgenv().ZyZPart].Velocity * Prediction / 10)
			return old(unpack(args))
		end
			return old(...)
		end
	)

game:GetService("RunService").RenderStepped:Connect(
function()
	_G.fovcircle.Position = getMousePosition() + Vector2.new(0, 36)
	if   getgenv().cross == true then 
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainScreenGui").Aim.Rotation =
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainScreenGui").Aim.Rotation +
		getgenv().rotationspeed
	else 
		game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MainScreenGui").Aim.Rotation = 0
	end

	if getgenv().targetstrafe and Locking and getgenv().Enabled == true  then
rot = rot + wait() * getgenv().Speedfortarget
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ROTATION * CFrame.new(sin(rot)*ECLIPSE, 0, cos(rot)*getgenv().Distancet) + Plr.Character.HumanoidRootPart.Position

end



	if getgenv().Spin == true then 
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(555), 0)
	end

	if getgenv().Jitter == true then 
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
			CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position) *
				CFrame.Angles(0, math.rad(JitterAngle) + math.rad((math.random(1, 2) == 1 and Jit or -Jit)), 0)
	end
	if getgenv().WorldC == true then 
		game.Lighting.ColorCorrection.TintColor = _G.FovConfig.ColorWorld
	else
		game.Lighting.ColorCorrection.TintColor = Color3.fromRGB(255,255,255)
	end

	if getgenv().autosetup == true then
		local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		local split = string.split(pingvalue, " ")
		local ping = split[1]
		if tonumber(ping) < 30 then
			getgenv().Prediction = 1.14
		elseif tonumber(ping) <= 30 then
			if tonumber(ping) < 40 then
				getgenv().Prediction = 1.16
			elseif tonumber(ping) <= 40 then
				if tonumber(ping) < 50 then
					getgenv().Prediction = 1.19
				elseif tonumber(ping) <= 50 then
					if tonumber(ping) < 70 then
						getgenv().Prediction = 1.22
					elseif tonumber(ping) <= 80 then
						getgenv().Prediction = 1.38
					elseif tonumber(ping) <= 80 then
						getgenv().Prediction = 1.39
					elseif tonumber(ping) <= 90 then
						getgenv().Prediction = 1.42
					elseif tonumber(ping) <= 150 then
						getgenv().Prediction = 1.51
					elseif tonumber(ping) >= 200 then
						getgenv().Prediction = 1.69
					end
				end
			end
		end
	end

	if _G.AirshotFunction == true then
		if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
			getgenv().ZyZPart = _G.AirshotPart
		else
			Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(
			function(old, new)
				if new == Enum.HumanoidStateType.Freefall then
					getgenv().Partz = _G.AirshotPart
				else
					getgenv().ZyZPart = "LowerTorso"
				end
			end
			)
		end
	end
	if getgenv().BlindStrafe and Locking and getgenv().Enabled then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position + _G.FRAME)


	end

	if getgenv().BlindStrafe and Locking and getgenv().Enabled then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position + _G.FRAME)


	end

	if getgenv().LookAt and Locking and getgenv().Enabled then
		local Char = game.Players.LocalPlayer.Character
		local PrimaryPartOfChar = game.Players.LocalPlayer.Character.PrimaryPart
		local NearestChar = Plr.Character
		local NearestRoot = Plr.Character.HumanoidRootPart
		local NearestPos = CFrame.new(PrimaryPartOfChar.Position, Vector3.new(NearestRoot.Position.X, NearestRoot.Position.Y, NearestRoot.Position.Z))
		Char:SetPrimaryPartCFrame(NearestPos)

	end
	
	
	
	if getgenv().Tracer == true and Locking then
		local Vector, OnScreen =
			cc:worldToViewportPoint(
				Plr.Character[getgenv().ZyZPart].Position + (Plr.Character[getgenv().ZyZPart].Velocity * Prediction / 10)
			)
		_G.Tracer.Visible = true
		_G.Tracer.From = Vector2.new(mouse.X, mouse.Y + ggi(gs).Y)
		_G.Tracer.To = Vector2.new(Vector.X, Vector.Y)
	elseif getgenv().Tracer == false then
		_G.Tracer.Visible = false
	end
	if _G.Tracer.Visible == true and not Locking and getgenv().Enabled then
		getgenv().TracerBugged = true
		_G.Tracer.Visible = false
	end

	if getgenv().Tracer == true and getgenv().TracerBugged and Locking then
		_G.Tracer.Visible = true
	end

	
	if getgenv().Dot == true and Locking then
		local Vector, OnScreen =
			cc:worldToViewportPoint(
				Plr.Character[getgenv().ZyZPart].Position + (Plr.Character[getgenv().ZyZPart].Velocity * Prediction / 10)
			)
		_G.Dotty.Visible = true
		_G.Dotty.To = _G.Tracer.To
	elseif getgenv().Dot == false then
		_G.Dotty.Visible = false
	end
	if _G.Dotty.Visible == true and not Locking and getgenv().Enabled then
		getgenv().TracerBugged = true
		_G.Dotty.Visible = false
	end

	if getgenv().Dot == true and getgenv().TracerBugged and Locking then
		_G.Dotty.Visible = true
	end
	
	

end)







--Vector2.new(dwCamera.ViewportSize.X / 2, dwCamera.ViewportSize.Y / 2)


_G.Color = Color3.fromRGB(190,73,255)


local Library = loadstring(game:HttpGet("https://pastebin.com/raw/bpasQZtC"))() --you can go into the github link and copy all of it and modify it for yourself.
local Window = Library:CreateWindow("R.I.G", Vector2.new(500,500), Enum.KeyCode.RightControl) --you can change your UI keybind
local Legit = Window:CreateTab("Legit")  
local AimingTab = Window:CreateTab("Rage")  
local Esp = Window:CreateTab("Visuals")
local Misc = Window:CreateTab("Misc")
local Settings = Window:CreateTab("Settings")

local Legit = Legit:CreateSector("Mouse-Lock", "left")

local Target = AimingTab:CreateSector("Target-Aim", "left")
local test = AimingTab:CreateSector("Aim-Extras", "right")
local Strafe = AimingTab:CreateSector("Strafe", "left")

local Visual = Esp:CreateSector("Players", "Left")
local Visual2 = Esp:CreateSector("Fov-Circle", "Left")
local Vissettings = Esp:CreateSector("Esp-Settings", "Right")
local Cross = Esp:CreateSector("Crosshair", "Left")
local World = Esp:CreateSector("World", "Left")
local SelfV = Esp:CreateSector("Self-Visuals", "Right")

local Mis = Misc:CreateSector("Anti-Aim", "Left")
local Mis2 = Misc:CreateSector("Cheats", "Right")

local Sets = Settings:CreateSector("Game", "left")

Legit:AddToggle("Enabled", false, function(first)
    getgenv().MouseLock.Enabled = first
end)

Legit:AddSlider("Prediction", 0, 0.3, 2, 10, function(State)
    getgenv().MouseLock.Prediction = State
end)

Legit:AddKeybind("Keybind", nil, function(State)
getgenv().MouseLock.Key = State
end)

Legit:AddDropdown("Aimpart", {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}, "Head", false, function(dropdown)
getgenv().MouseLock.AimPart = dropdown
end)

Strafe:AddToggle("Float Strafe", false, function(first)
    getgenv().BlindStrafe = first
end)

Strafe:AddToggle("Target Strafe", false, function(first)
    getgenv().targetstrafe = first
end)

Strafe:AddSlider("Strafe Speed", 0, 10, 20, 10, function(State)
    getgenv().Speedfortarget = State
end)

Strafe:AddSlider("Strafe Distance", 0, 20, 60, 10, function(State)
    getgenv().Distancet = State
end)

Target:AddToggle("Enabled", false, function(first)
    getgenv().Enabled = first
end)

Target:AddSlider("Prediction", 0, 0.3, 2, 10, function(State)
    getgenv().Prediction = State
end)

local tr = Target:AddToggle("Tracer", false, function(bool)
    getgenv().Tracer = bool
end)

tr:AddColorpicker(Color3.fromRGB(255,124,252), function(ztx)
   _G.Tracer.Color = ztx
end)



Target:AddToggle("Face Player", false, function(bool)
    getgenv().LookAt = bool
end)

Target:AddToggle("Spectate Target", false, function(bool)
    getgenv().ViewPlr = bool
end)

Target:AddToggle("Notify Mode", false, function(bool)
    getgenv().Tracer = bool
end)

Target:AddToggle("Notify Sound", false, function(bool)
    getgenv().NotificationsSound = bool
end)




--[[Target:AddButton("Button", function(IhateGayPeople)
    print("button")
end)]]



test:AddToggle("Auto Prediction", false, function(bool)
   getgenv().autosetup = bool
end)




test:AddToggle("Airshot", false, function(bool)
   _G.AirshotFunction = bool
end)

test:AddDropdown("Aimpart", {"Head", "UpperTorso", "LowerTorso"}, "Head", false, function(dropdown)
_G.AirshotPart = dropdown
end)


Target:AddKeybind("Keybind", nil, function(State)
getgenv().ZyZKey = State
end)

Target:AddDropdown("Aimpart", {"Head", "UpperTorso", "LowerTorso"}, "Head", false, function(dropdown)
getgenv().ZyZPart = dropdown
end)





Visual:AddToggle("Enabled", false, function(bool)
    getgenv().Settings.Enabled = bool
end)

local Box = Visual:AddToggle("Boxes", false, function(bool)
    getgenv().Settings.Boxes = bool
end)

Box:AddColorpicker(Color3.fromRGB(255,124,252), function(ztx)
   getgenv().Settings.Color = ztx
end)

local Fill = Visual:AddToggle("Filled Boxes", false, function(bool)
    getgenv().Settings.Filled = bool
end)

Fill:AddColorpicker(Color3.fromRGB(255,124,252), function(ztx)
   getgenv().Settings.FillColor  = ztx
end)



Vissettings:AddSlider("Box Fill Transparency", 0, 1, 1, 10, function(State)
    getgenv().Settings.Transparency = State
end)

Vissettings:AddSlider("Tracer Transparency", 0, 1, 1, 10, function(State)
    getgenv().Settings.LineT = State
end)

Vissettings:AddSlider("Box Transparency", 0, 1, 1, 10, function(State)
    getgenv().Settings.BoxT = State
end)

Vissettings:AddDropdown("Tracers From", {"Top", "Middle", "Bottom"}, "Bottom", false, function(dropdown)
getgenv().Settings.Tfrom = dropdown

if dropdown == "Top" then
    getgenv().Settings.Tfrom = 100
elseif dropdown == "Middle" then getgenv().Settings.Tfrom = 2 
    elseif dropdown == "Bottom" then getgenv().Settings.Tfrom = 1
    end
end)

Vissettings:AddSlider("Custom Tracer Position", 0, 1, 100, 10, function(State)
    getgenv().Settings.Tfrom = State
end)

Vissettings:AddSlider("Text Size", 0, 14, 60, 1, function(State)
    getgenv().Settings.TextSize  = State
end)

Vissettings:AddSlider("Name Offset", 0, 20, 100, 1, function(State)
    getgenv().Settings.Offset  = State
end)

Vissettings:AddToggle("Rainbow Colors", false, function(bool)
    getgenv().Settings.Rainbow    = bool
end)

Vissettings:AddToggle("TeamCheck", false, function(bool)
    getgenv().Settings.TeamCheck   = bool
end)


local Friends = Vissettings:AddToggle("Team Color", false, function(bool)
    getgenv().Settings.TeamColor   = bool
end)

Friends:AddColorpicker(Color3.fromRGB(0,255,0), function(ztx)
   getgenv().Settings.FriendlyColor  = ztx
end)

local Linked = Vissettings:AddToggle("Link All Esp Color", false, function(bool)
    getgenv().Settings.Lac   = bool
end)

Linked:AddColorpicker(Color3.fromRGB(0,255,0), function(ztx)
   getgenv().Settings.Lc  = ztx
end)



local Crosshair = Cross:AddToggle("Crosshair Color", false, function(bool)
        _G.Allowed = bool
end)

Crosshair:AddColorpicker(Color3.fromRGB(255,124,252), function(e)
    if _G.Allowed == true then 
	game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.BackgroundColor3 = e
	game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Top.BackgroundColor3 = e
	game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Bottom.BackgroundColor3 = e
	game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Right.BackgroundColor3 = e
	game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Aim.Left.BackgroundColor3 = e
	end
end)

local WorldColor = World:AddToggle("World Accent", false, function(bool)
       MapLightingJmp.Enabled = bool
end)

WorldColor:AddColorpicker(Color3.fromRGB(255,124,252), function(e)
  
  MapLightingJmp.TintColor = e

 
end)


local Crosshair2 = SelfV:AddToggle("Self Chams", false, function(bool)
        if bool then 
            _G.Allowed = true
        game.Players.LocalPlayer.Character.LeftHand.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightHand.Material = "ForceField"
        game.Players.LocalPlayer.Character.LeftLowerArm.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightLowerArm.Material = "ForceField"
        game.Players.LocalPlayer.Character.LeftUpperArm.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightUpperArm.Material = "ForceField"
        game.Players.LocalPlayer.Character.LeftFoot.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightFoot.Material = "ForceField"
        game.Players.LocalPlayer.Character.LeftLowerLeg.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightLowerLeg.Material = "ForceField"
        game.Players.LocalPlayer.Character.UpperTorso.Material = "ForceField"
        game.Players.LocalPlayer.Character.LowerTorso.Material = "ForceField"
        game.Players.LocalPlayer.Character.LeftUpperLeg.Material = "ForceField"
        game.Players.LocalPlayer.Character.RightUpperLeg.Material = "ForceField"
        game.Players.LocalPlayer.Character.Head.Material = "ForceField"
            else 
                   game.Players.LocalPlayer.Character.LeftHand.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightHand.Material = "Plastic"
        game.Players.LocalPlayer.Character.LeftLowerArm.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightLowerArm.Material = "Plastic"
        game.Players.LocalPlayer.Character.LeftUpperArm.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightUpperArm.Material = "Plastic"
        game.Players.LocalPlayer.Character.LeftFoot.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightFoot.Material = "Plastic"
        game.Players.LocalPlayer.Character.LeftLowerLeg.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightLowerLeg.Material = "Plastic"
        game.Players.LocalPlayer.Character.UpperTorso.Material = "Plastic"
        game.Players.LocalPlayer.Character.LowerTorso.Material = "Plastic"
        game.Players.LocalPlayer.Character.LeftUpperLeg.Material = "Plastic"
        game.Players.LocalPlayer.Character.RightUpperLeg.Material = "Plastic"
        game.Players.LocalPlayer.Character.Head.Material = "Plastic"
        _G.Allowed = false
            end
end)

Crosshair2:AddColorpicker(Color3.fromRGB(255,124,252), function(color)
    if _G.Allowed then
        game.Players.LocalPlayer.Character.LeftHand.Color = color
    game.Players.LocalPlayer.Character.RightHand.Color = color
    game.Players.LocalPlayer.Character.LeftLowerArm.Color = color
    game.Players.LocalPlayer.Character.RightLowerArm.Color = color
    game.Players.LocalPlayer.Character.LeftUpperArm.Color = color
    game.Players.LocalPlayer.Character.RightUpperArm.Color = color
    game.Players.LocalPlayer.Character.LeftFoot.Color = color
    game.Players.LocalPlayer.Character.RightFoot.Color = color
    game.Players.LocalPlayer.Character.LeftLowerLeg.Color = color
    game.Players.LocalPlayer.Character.RightLowerLeg.Color = color
    game.Players.LocalPlayer.Character.UpperTorso.Color = color
    game.Players.LocalPlayer.Character.LowerTorso.Color = color
    game.Players.LocalPlayer.Character.LeftUpperLeg.Color = color
    game.Players.LocalPlayer.Character.RightUpperLeg.Color = color
    game.Players.LocalPlayer.Character.Head.Color = color
	end
end)

local Hat = SelfV:AddToggle("Chinese Hat", false, function(bool)
  getgenv().Hat.enabled = bool
  getgenv().Hat.hatTransparency = 1
end)

Hat:AddColorpicker(Color3.fromRGB(255,124,252), function(color)
    getgenv().Hat.color = color
end)


 SelfV:AddToggle("Halo", false, function(bool)
  getgenv().Hat.enabled = bool
  getgenv().Hat.hatTransparency = 0
end)






local Circle = Visual2:AddToggle("Show Fov", false, function(bool)
  _G.fovcircle.Visible = bool
end)

Circle:AddColorpicker(Color3.fromRGB(255,124,252), function(color)
 _G.fovcircle.Color = color
end)

Visual2:AddSlider("Fov Size", 0, 200, 500, 1, function(State)
    _G.fovcircle.Radius = State
end)

Visual2:AddSlider("Transparency", 0, 0.8, 1, 10, function(State)
    _G.fovcircle.Transparency = State
end)

Visual2:AddSlider("Sides", 0, 10, 60, 1, function(State)
    _G.fovcircle.NumSides = State
end)




local Tracers = Visual:AddToggle("Tracers", false, function(bool)
    getgenv().Settings.Tracers  = bool
end)


Tracers:AddColorpicker(Color3.fromRGB(255,124,252), function(ztx)
   getgenv().Settings.Tcolor  = ztx
end)

local Name = Visual:AddToggle("Names", false, function(bool)
    getgenv().Settings.Names   = bool
end)


Name:AddColorpicker(Color3.fromRGB(255,124,252), function(ztx)
   getgenv().Settings.NameC   = ztx
end)



Visual:AddToggle("Healthbar", false, function(bool)
    getgenv().Settings.Healthbar = bool
end)

Mis:AddToggle("Spinbot", false, function(bool)
   getgenv().Spin = bool
end)

Mis:AddToggle("Prediction Breaker", false, function(bool)
  _G.PredictionBreaker = bool
end)

Mis:AddToggle("Jitterbot", false, function(bool)
  getgenv().Jitter = bool
end)

Mis:AddSlider("Jitter-Angle", 0, 2, 10, 1, function(value)
    JitterAngle = value
end)

Mis2:AddToggle("Speed", false, function(bool)
  getgenv().Speed2 = bool
end)

Mis2:AddSlider("Cframe Speed", 0, 1, 4, 10, function(speed)
    getgenv().speedvalue = speed
end)

Sets:AddButton("Rejoin Game", function(IhateGayPeople)
   game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end)

Sets:AddSlider("Camera Fov", 0, 90, 120, 1, function(State)
    game:GetService'Workspace'.Camera.FieldOfView = State
end)
--Cunt

Settings:CreateConfigSystem("right") --this is the config system
end

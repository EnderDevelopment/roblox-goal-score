local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local BALL_NAME = "TPS"
local GOAL_NAME = "Goal"
local SCORE_VALUE_NAME = "Goals"
local GOAL_COOLDOWN = 2
local EXPLOSION_SIZE = 10
local PLAYER_SEARCH_RADIUS = 45

local ball = workspace:WaitForChild(BALL_NAME)
local goal = workspace:WaitForChild(GOAL_NAME)
local goalLocked = false

local function createLeaderstats(player)
	local leaderstats = player:FindFirstChild("leaderstats")
	if not leaderstats then
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player
	end

	local goals = leaderstats:FindFirstChild(SCORE_VALUE_NAME)
	if not goals then
		goals = Instance.new("IntValue")
		goals.Name = SCORE_VALUE_NAME
		goals.Value = 0
		goals.Parent = leaderstats
	end
end

local function getPlayerFromValue(value)
	if value:IsA("ObjectValue") and value.Value then
		if value.Value:IsA("Player") then
			return value.Value
		end

		if value.Value:IsA("Model") then
			return Players:GetPlayerFromCharacter(value.Value)
		end
	end

	if value:IsA("StringValue") then
		return Players:FindFirstChild(value.Value)
	end

	return nil
end

local function getScoringPlayer()
	local ownerNames = { "LastToucher", "LastPlayer", "Owner", "Creator", "creator" }
	for _, name in ipairs(ownerNames) do
		local value = ball:FindFirstChild(name)
		if value then
			local player = getPlayerFromValue(value)
			if player then
				return player
			end
		end
	end

	local closestPlayer
	local closestDistance = PLAYER_SEARCH_RADIUS
	local ballPosition = ball.Position

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root then
			local distance = (root.Position - ballPosition).Magnitude
			if distance < closestDistance then
				closestDistance = distance
				closestPlayer = player
			end
		end
	end

	return closestPlayer
end

local function playGoalEffect()
	local explosion = Instance.new("Explosion")
	explosion.Position = goal.Position
	explosion.BlastRadius = EXPLOSION_SIZE
	explosion.BlastPressure = 0
	explosion.DestroyJointRadiusPercent = 0
	explosion.Parent = workspace
	Debris:AddItem(explosion, 2)
end

local function scoreGoal()
	if goalLocked then
		return
	end

	goalLocked = true
	local player = getScoringPlayer()
	if player then
		local leaderstats = player:FindFirstChild("leaderstats")
		local goals = leaderstats and leaderstats:FindFirstChild(SCORE_VALUE_NAME)
		if goals then
			goals.Value += 1
		end
	end

	playGoalEffect()
	task.delay(GOAL_COOLDOWN, function()
		goalLocked = false
	end)
end

for _, player in ipairs(Players:GetPlayers()) do
	createLeaderstats(player)
end
Players.PlayerAdded:Connect(createLeaderstats)
goal.Touched:Connect(function(hit)
	if hit == ball or hit:IsDescendantOf(ball) then
		scoreGoal()
	end
end)

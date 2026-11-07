# Roblox Football Goal Scoring Script

Goal Score System is a Roblox server script for a football game that detects when a ball touches a goal part, creates leaderstats with a Goals value, awards the goal to the appropriate player, and plays a harmless explosion effect when scoring.

## Install

1. Open your game in Roblox Studio.
2. In `Workspace`, create or confirm a `Part` or `MeshPart` named `TPS`. This is the football.
3. In `Workspace`, create or confirm a `Part` named `Goal`. Position it where the ball should score.
4. Make sure `Goal.CanTouch` is enabled.
5. Create a normal `Script` inside `ServerScriptService`.
6. Copy the project script into the new server Script.
7. Start a Play test and make the `TPS` ball touch the `Goal` part.

## Use

When a player joins, the script creates a `leaderstats` folder and an integer value named `Goals`. When `TPS` touches `Goal`, the appropriate player's `Goals` value increases by one.

For reliable player attribution, add one of these values to the ball and update it when a player last touches or kicks the ball:

- `LastToucher`
- `LastPlayer`
- `Owner`
- `Creator`
- `creator`

An `ObjectValue` can reference the player or their character model. A `StringValue` can contain the player's name. If no valid attribution value is found, the script awards the goal to the nearest player within 45 studs of the ball.

A two-second cooldown prevents repeated scoring from one contact. Each goal creates a visual Explosion at the goal location with zero blast pressure and zero joint destruction, so it does not damage or launch players or parts.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/acdef292-1533-4787-9d98-dc36fe81076c?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=acdef292-1533-4787-9d98-dc36fe81076c

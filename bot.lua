local discordia = require('discordia')
discordia.extensions() -- load all helpful extensions

require('game_logic')

-- For reading private key
function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

-- Displays a particular game state, given a message context (for the channel to reply to)
function displayState(message, state)
	local level_data = levels[state["level"]]

	help_embed = {
		title = "Level " .. tostring(state["level"]),
		description = level_data["description"],
		fields = { -- array of fields#
			{
				name = "Goal:",
				value = "- " .. tostring(level_data["moves"]) .. " Moves\n- Add to " .. tostring(level_data["goal"]),
				inline = true
			},
			{
				name = "Options",
				value = "4 1 2 | + *",
				inline = false
			},
			{
				name = "Stack",
				value = prettyPrintStack(state["stack"]),
				inline = false
			}
		},
		color = discordia.Color.fromRGB(114, 137, 218).value
	}

	message:reply { embed = help_embed }
end

local client = discordia.Client()

local prefix = "!"

local commands = {
	["about"] = {
		description = "Answers with world.",
		exec = function(message)
			help_embed = {
				title = "Story",
				description = "You are the brother of a recently dead famous inventor and mathmetician. He has left behind his complex research, which he conducted using his own special mathematical techniques, and a little robot to help solve them.\n\nYou must work with the robot by issuing it commands to solve his incomplete theorems, revolutionising the world of mathematics. The robot works by processing stacks of paper. Type \"!help\" to read the robots instructions.",
				color = discordia.Color.fromRGB(114, 137, 218).value
			}
	
			message:reply { embed = help_embed }

			help_embed = {
				title = "Gigabit Instructions",
				description = "Hello, I am Gigabit.\n\nI do math with stacks of paper. For example if you give me 2 and then 3 I will place 2 at the bottom of the stack and 3 on the top. \n[ 3 ]\n[ 2 ]\n\nThen if you give me a plus I will add the top 2 items and put the result back on the top. So 3+2 is 5 so the top is now 5. \n[ 5 ]\n\n To start solving the first puzzle type \"!start\" and then \"!move 2\" to put 2 on the stack.",
				color = discordia.Color.fromRGB(114, 137, 218).value,
				footer = {
					text = "Note: For a list of all instructions type !help"
				}
			}
	
			message:reply { embed = help_embed }
		end
	},
	["start"] = {
		description = "Set the prefix of the bot.",
		exec = function(message)
			local state = processInput(message.author.id, args[2])
			displayState(
				message,
				{ ["level"] = 1, ["stack"] = {} }
			)
		end
	},
	["move"] = {
		description = "Set the prefix of the bot.",
		exec = function(message)
			local args = message.content:split(" ")

			local state = processInput(message.author.id, args[2])
			displayState(message, state)
		end
	},
	["prefix"] = {
		description = "Set the prefix of the bot.",
		exec = function(message)
			local args = message.content:split(" ")

			if args[2] then
				if string.len(args[2]) == 1 then
					message.channel:send("Changed prefix to " .. args[2])
					prefix = args[2]
				else
					message.channel:send("The prefix should be 1 character long")
				end
			else
				message.channel:send("Please provide a prefix after " .. prefix .. "prefix")
			end
		end
	}
}


client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on("messageCreate", function(message)
	local args = message.content:split(" ") -- split all arguments into a table

	local command = commands[string.sub(args[1], string.len(prefix) + 1)] -- get the command without the prefix, because no prefix in table

	if command then -- valid command
		if string.sub(args[1],1,1) == prefix then -- check if it started with the right prefix if it's valid
			command.exec(message) -- execute the command
		end
	end

	if args[1] == prefix.."help" then -- display all the commands
		local output = ""
		for word, tbl in pairs(commands) do
			output = output .. prefix .. word .. " - " .. tbl.description .. "\n"
		end

		help_embed = {
			title = "Command List",
			description = output,
			color = discordia.Color.fromRGB(114, 137, 218).value
		}

		message:reply { embed = help_embed }
	end
end)

local bot_token = readAll("token.txt")

client:run("Bot " .. bot_token)
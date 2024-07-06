local discordia = require('discordia')
discordia.extensions() -- load all helpful extensions

-- For reading private key
function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local client = discordia.Client()

local prefix = "!"
local commands = {
	[prefix .. "ping"] = {
		description = "Answers with pong.",
		exec = function(message)
			message.channel:send("Pong!")
		end
	},
	[prefix .. "hello"] = {
		description = "Answers with world.",
		exec = function(message)
			message.channel:send("world!")
		end
	}
}


client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on("messageCreate", function(message)
	local args = message.content:split(" ") -- split all arguments into a table

	local command = commands[args[1]]
	if command then -- ping or hello
		command.exec(message) -- execute the command
	end

	if args[1] == prefix.."help" then -- display all the commands
		local output = ""
		for word, tbl in pairs(commands) do
			output = output .. word .. " - " .. tbl.description .. "\n"
		end

		help_embed = {
			title = "Command List",
			description = output,
			color = discordia.Color.fromRGB(114, 137, 218).value
		}

		message:reply { embed = help_embed }
	end
end)

local private_key = readAll("private_key.txt")

client:run("Bot " .. private_key)
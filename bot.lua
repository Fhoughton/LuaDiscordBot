local discordia = require('discordia')

-- For reading private key
function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	if message.content == '!ping' then
		message.channel:send('Pong!')
	end

	if message.content == "!embed" then
		message:reply {
			embed = {
				title = "Embed Title",
				description = "Here is my fancy description!",
				author = {
					name = message.author.username,
					icon_url = message.author.avatarURL
				},
				fields = { -- array of fields
					{
						name = "Field 1",
						value = "This is some information",
						inline = true
					},
					{
						name = "Field 2",
						value = "This is some more information",
						inline = false
					}
				},
				footer = {
					text = "Created with Discordia"
				},
				color = 0x000000 -- hex color code
			},
			file = "test.png"
		}
	end
end)

local private_key = readAll("private_key.txt")

client:run("Bot " .. private_key)
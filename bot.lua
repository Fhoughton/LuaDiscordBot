local discordia = require('discordia')
local request  = require("request")

-- For reading private key
function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

-- Uploads a file to a temporary file service, returning the url
-- Used for fields which accept url images only, not raw data
function uploadFile(file)
	result_url = ""

	request.post("https://litterbox.catbox.moe/resources/internals/api.php")
	:set("Content-Type", "text/html; charset=UTF-8")
	:send({
		foo = "bar",
		reqtype = "fileupload",
		time = "1h",
		fileToUpload="@test.png"
	})
	:done( function(err, res) 
		result_url = res.body
	end)

	return result_url
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
				image = {
					url = "https://i.imgur.com/Pna4buF.jpeg"
			  	},
				color = discordia.Color.fromRGB(0, 0, 218).value -- side bar colour
			},
			file = "test.png"
		}
	end
end)

local private_key = readAll("private_key.txt")

local test = uploadFile("test.png")
print(test)

client:run("Bot " .. private_key)
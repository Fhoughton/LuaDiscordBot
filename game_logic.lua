local games = {
    --010101 = {
    --    level = 1
    --    stack = []
    --}
}

function processInput(user, input)
    if input and user then
        if not games[user] then
            games[user] = {
                ["level"] = 1,
                ["stack"] = {}
            }
        end

        user_game = games[user]
        new_stack = processInstruction(user_game["stack"], input)
        user_game["stack"] = new_stack
        
        return user_game
    end
end

function processInstruction(input_stack, input)
    return input_stack
end

-- Converts some stack e.g. {1,2,3} to a string [1]\n[2]\n[3]\n
function prettyPrintStack(stack)
    local output = ""

    for index, item in pairs(stack) do
        output = output .. "[ " .. item .. " ]\n"
    end

    if output == "" then
        output = "<Empty>"
    end

    return output
end
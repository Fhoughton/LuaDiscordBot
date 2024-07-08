-- TODO: Add better message reporting for erroneous states e.g. player enters invalid number not in level

local games = {
    --010101 = {
    --    level = 1
    --    stack = []
    --}
}

local levels = {
    [1] = {
        ["ops"] = {"*","+"},
        ["numbers"] = {1,2,4}
    }
}

function table.contains(table, element)
    for _, value in pairs(table) do
      if value == element then
        return true
      end
    end
    return false
end  

function processInput(user, input)
    if input and user then
        if not games[user] then
            games[user] = {
                ["level"] = 1,
                ["stack"] = {}
            }
        end

        user_game = games[user]
        new_stack = processInstruction(user_game, input)
        user_game["stack"] = new_stack
        
        return user_game
    end
end

function processInstruction(state, input)
    local input_stack = state["stack"]

    local input_asnum = tonumber(input)
    if input_asnum then
        state_level = state["level"]

        level_data = levels[state_level]

        if table.contains(level_data["numbers"], input_asnum) then
            table.insert(input_stack, input_asnum)
        end
    else

    end

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
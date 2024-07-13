-- TODO: Add better message reporting for erroneous states e.g. player enters invalid number not in level

local games = {
    --010101 = {
    --    level = 1
    --    stack = []
    --}
}

levels = {
    [1] = {
        ["description"] = "Keep it simple",
        ["ops"] = {"*","+"},
        ["numbers"] = {1,2,4},
        ["goal"] = 12,
        ["moves"] = 5
    },
    [2] = {
        ["description"] = "Multiply, add, add",
        ["ops"] = {"*","+","-"},
        ["numbers"] = {100, 2, 9, 10, 4, 1},
        ["goal"] = 129,
        ["moves"] = 8
    },
    [3] = {
        ["description"] = "A little bit trickier",
        ["ops"] = {"*","+","-"},
        ["numbers"] = {50, 75, 5, 1, 2, 10},
        ["goal"] = 542,
        ["moves"] = 12
    },
    [4] = {
        ["description"] = "Headscratcher",
        ["ops"] = {"*","+","-"},
        ["numbers"] = {25, 75, 100, 50, 7, 1},
        ["goal"] = 340,
        ["moves"] = 12
    },

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

        -- Check if user has beaten level and if so progress
        state_level = user_game["level"]
        level_data = levels[state_level]

        if new_stack[1] == level_data["goal"] then
            --displayState(user_game)
            --message.channel:send('Level complete!')
            user_game["level"] = user_game["level"] + 1
            user_game["stack"] = {}
        end
        
        return user_game
    end
end

function processInstruction(state, input)
    local input_stack = state["stack"]

    local input_asnum = tonumber(input)
    if input_asnum then
        -- If it's a number and it's valid for that level push it to the stack
        state_level = state["level"]

        level_data = levels[state_level]

        if table.contains(level_data["numbers"], input_asnum) then
            table.insert(input_stack, input_asnum)
        end
    else
        -- If it's a symbol and it's valid for that level try to process it on the stack, all take two arguments
        local top_stack_item = input_stack[1]
        local second_stack_item = input_stack[2]

        if top_stack_item and second_stack_item then
            -- Process symbol, push result to front
            if input == "+" then table.insert(input_stack, 1, top_stack_item + second_stack_item)
            elseif input == "*" then table.insert(input_stack, 1, top_stack_item * second_stack_item)
            elseif input == "-" then table.insert(input_stack, 1, top_stack_item - second_stack_item)
            else return input_stack -- No operation done, just exit so we can be generic after
            end

            -- Remove two items below top to remove old data (operands of the symbol)
            table.remove(input_stack, 2) -- [A+B,A,B] --> [A+B,B]
            table.remove(input_stack, 2) -- [A+B,B] --> [A+B]
        end
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
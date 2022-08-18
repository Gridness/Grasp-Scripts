-- Grasp: The Greed Game
-- Game design and scripts by Ivan "Gridness" Steklov
DEBUG                   = true
MAP_GENERATED           = false
RESET_BUTTON_PRESSED    = false
FIRST_FALL              = false

MAP_GUID    = "b93380"

EXIT_GUID   = "1a3ad7"

PLAYER_BLUE_GUID    = "6e72a5"
PLAYER_RED_GUID     = "99a0cf"
PLAYER_GREEN_GUID   = "fcd702"
PLAYER_WHITE_GUID   = "5eb5cf"

RUNES_BAG_GUID = "64cb24"
FALLS_BAG_GUID = "e4ed66"

COUNTER_GUID = "441043"

TORCHES_DECK_GUID   = "223fe4"
ITEMS_DECK_GUID     = "027618"
RUNES_DECK_GUID     = "b95d0a"

GENERATE_TABLE_BUTTON_GUID  = "6a9376"
RESET_GAME_BUTTON_GUID      = "5698bb"
PASS_TURN_ONE_BUTTON_GUID   = "61a72c"
TAKE_TORCH_BUTTON_GUID      = "3d4c76"
TAKE_4_TORCHES_BUTTON_GUID  = "717301"

BUTTON_1_GUID = "906155"
BUTTON_2_GUID = "123d22"
BUTTON_3_GUID = "c1c1d3"
BUTTON_4_GUID = "573c5b"
BUTTON_5_GUID = "1bf395"
BUTTON_6_GUID = "beb070"
BUTTON_7_GUID = "5bf4f5"
BUTTON_8_GUID = "38d4fd"
BUTTON_9_GUID = "00b353"

TURNS_TO_OPEN_EXIT = 32
TURNS_PASSED = 0

FALLS = {}
FALLS_AS_OBJECTS = {}

function onload()
    map         = getObjectFromGUID(MAP_GUID)
    map_points  = map.getSnapPoints()

    torches     = getObjectFromGUID(TORCHES_DECK_GUID)
    items       = getObjectFromGUID(ITEMS_DECK_GUID)
    runes       = getObjectFromGUID(RUNES_DECK_GUID)

    runes_bag = getObjectFromGUID(RUNES_BAG_GUID)
    falls_bag = getObjectFromGUID(FALLS_BAG_GUID)

    blue_player     = getObjectFromGUID(PLAYER_BLUE_GUID)
    red_player      = getObjectFromGUID(PLAYER_RED_GUID)
    green_player    = getObjectFromGUID(PLAYER_GREEN_GUID)
    white_player    = getObjectFromGUID(PLAYER_WHITE_GUID)

    counter     = getObjectFromGUID(COUNTER_GUID)
    exit_fig    = getObjectFromGUID(EXIT_GUID)

    blue_player_default_pos     = blue_player.getPosition()
    red_player_default_pos      = red_player.getPosition()
    green_player_default_pos    = green_player.getPosition()
    white_player_default_pos    = white_player.getPosition()
    exit_default_pos            = exit_fig.getPosition()

    generate_table_button   = getObjectFromGUID(GENERATE_TABLE_BUTTON_GUID)
    reset_game_button       = getObjectFromGUID(RESET_GAME_BUTTON_GUID)
    pass_turn_one_button    = getObjectFromGUID(PASS_TURN_ONE_BUTTON_GUID)
    take_torch_button       = getObjectFromGUID(TAKE_TORCH_BUTTON_GUID)
    take_4_torches_button   = getObjectFromGUID(TAKE_4_TORCHES_BUTTON_GUID)
    button_1                = getObjectFromGUID(BUTTON_1_GUID)
    button_2                = getObjectFromGUID(BUTTON_2_GUID)
    button_3                = getObjectFromGUID(BUTTON_3_GUID)
    button_4                = getObjectFromGUID(BUTTON_4_GUID)
    button_5                = getObjectFromGUID(BUTTON_5_GUID)
    button_6                = getObjectFromGUID(BUTTON_6_GUID)
    button_7                = getObjectFromGUID(BUTTON_7_GUID)
    button_8                = getObjectFromGUID(BUTTON_8_GUID)
    button_9                = getObjectFromGUID(BUTTON_9_GUID)
    
    generate_table_button.createButton({
        click_function = 'generate_table',
        function_owner = nil,
        label = 'Сгенерировать стол',
        tooltip = 'Создает случаные пещеры согласно правилам игры',
        width = 1200,
        height = 800,
        font_size = 120,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.627, 0.125, 0.941}
    })
    reset_game_button.createButton({
        click_function = 'reset_game',
        function_owner = nil,
        label = 'Сброс',
        tooltip = 'Сбрасывает данные текущей сессии',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.627, 0.125, 0.941},
        hover_color = {0.856, 0.1, 0.094}
    })
    pass_turn_one_button.createButton({
        click_function = 'pass_turn',
        function_owner = nil,
        label = 'Завершить ход',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.192, 0.701, 0.168}
    })
    take_torch_button.createButton({
        click_function = 'take_torch',
        function_owner = nil,
        label = 'Взять факел',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    take_4_torches_button.createButton({
        click_function = 'take_4_torches',
        function_owner = nil,
        label = 'Взять 4 факела',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_1.createButton({
        click_function = 'take_4_torches',
        function_owner = nil,
        label = 'Взять 4 факела',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_2.createButton({
        click_function = 'take_torch',
        function_owner = nil,
        label = 'Взять факел',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_3.createButton({
        click_function = 'pass_turn',
        function_owner = nil,
        label = 'Завершить ход',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.192, 0.701, 0.168}
    })
    button_4.createButton({
        click_function = 'take_4_torches',
        function_owner = nil,
        label = 'Взять 4 факела',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_5.createButton({
        click_function = 'take_torch',
        function_owner = nil,
        label = 'Взять факел',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_6.createButton({
        click_function = 'pass_turn',
        function_owner = nil,
        label = 'Завершить ход',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.192, 0.701, 0.168}
    })
    button_7.createButton({
        click_function = 'take_4_torches',
        function_owner = nil,
        label = 'Взять 4 факела',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_8.createButton({
        click_function = 'take_torch',
        function_owner = nil,
        label = 'Взять факел',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.956, 0.392, 0.113}
    })
    button_9.createButton({
        click_function = 'pass_turn',
        function_owner = nil,
        label = 'Завершить ход',
        width = 1200,
        height = 800,
        font_size = 150,
        position = {0, 0.8, 0},
        rotation = {0, 0, 0},
        color = {0.25, 0.25, 0.25},
        hover_color = {0.192, 0.701, 0.168}
    })

    counter.setValue(TURNS_TO_OPEN_EXIT)
end

function generate_table()
    if MAP_GENERATED then
        broadcastToColor('Карта уже сгенерирована', "Black", {r = 1, g = 0, b = 0})
        return
    end

    if DEBUG then
        broadcastToAll('Создаем пещеры...')
    end

    spawn_runes()

    local rand_pos = function () return math.random(len(map_points)) end
    exit_pos = map.positionToWorld(map_points[rand_pos()].position)
    exit_fig.setPositionSmooth(exit_pos)

    red_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    while red_player_pos == exit_pos do
        red_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    end
    red_player.setPositionSmooth(red_player_pos)

    green_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    while green_player_pos == exit_pos or green_player_pos == red_player_pos do
        green_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    end
    green_player.setPositionSmooth(green_player_pos)

    white_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    while white_player_pos == exit_pos or white_player_pos == red_player_pos or white_player_pos == green_player_pos do
        white_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    end
    white_player.setPositionSmooth(white_player_pos)

    blue_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    while blue_player_pos == exit_pos or blue_player_pos == red_player_pos or blue_player_pos == green_player_pos or blue_player_pos == white_player_pos do
        blue_player_pos = map.positionToWorld(map_points[rand_pos()].position)
    end
    blue_player.setPositionSmooth(blue_player_pos)

    spawned_objects_positions = {red_player_pos, green_player_pos, white_player_pos, blue_player_pos, exit_pos,
    Vector({-54.42, -1.55, 5.59}), Vector({-54.41, -1.55, 1}), Vector({-54.41, -1.55, -3.58}), Vector({-59, -1.55, 5.59}), 
    Vector({-59, -1.55, 1}), Vector({-59, -1.55, -3.58}), Vector({-63.59, -1.55, 5.59}), Vector({-63.59, -1.55, 1}), 
    Vector({-63.59, -1.55, -3.58})}

    create_falls(16)
    FIRST_FALL = true

    shuffle_all()

    MAP_GENERATED = true
    for i = 1, 3 do
        broadcastToAll('Игра началась!', {r = 0, g = 1, b = 0})
    end
end

function reset_game()
    if not RESET_BUTTON_PRESSED then
        broadcastToColor('Данное действие приведет к сбросу ВСЕХ игровых данных текущей сессии. Если вы хотите завершить игру, нажмите кнопку \"Сброс\" еще раз', "Black", {r = 1, g = 0, b = 0})
        RESET_BUTTON_PRESSED = true
        return
    end

    if DEBUG then
        broadcastToAll('Игра была сброшена', {r = 1, g = 0, b = 0})
    end

    TURNS_PASSED = 0
    FALLS = {}
    MAP_GENERATED = false
    RESET_BUTTON_PRESSED = false
    FIRST_FALL = false

    destroy_spawned_objects()

    FALLS_AS_OBJECTS = {}

    blue_player.setPositionSmooth(blue_player_default_pos, false, false)
    red_player.setPositionSmooth(red_player_default_pos, false, false)
    green_player.setPositionSmooth(green_player_default_pos, false, false)
    white_player.setPositionSmooth(white_player_default_pos, false, false)
    exit_fig.setPositionSmooth(exit_default_pos, false, false)
    counter.setValue(TURNS_TO_OPEN_EXIT)
end

function shuffle_all()
    broadcastToAll('Определяем судьбу...')

    items.shuffle()
    runes.shuffle()
end

function pass_turn(objectButtonClicked, playerColorClicked)
    if not MAP_GENERATED then
        broadcastToColor('Игра еще не началась', playerColorClicked, {r = 1, g = 0, b = 0})
        return
    end

    TURNS_PASSED = TURNS_PASSED + 1

    local current_player = pick_color(playerColorClicked)
    current_player.blindfolded = true
    broadcastToAll(playerColorClicked .. ' закончил ход', playerColorClicked)
    
    counter.setValue(TURNS_TO_OPEN_EXIT - TURNS_PASSED)
    update_player_pos()
    create_falls(4)

    if TURNS_TO_OPEN_EXIT - TURNS_PASSED == 15 then
        broadcastToAll('15 ходов до открытия выхода!', {r = 1, g = 0, b = 0})
    end

    if TURNS_TO_OPEN_EXIT - TURNS_PASSED == 5 then
        broadcastToAll('5 ходов до открытия выхода!', {r = 1, g = 0, b = 0})
    end

    if TURNS_TO_OPEN_EXIT - TURNS_PASSED == 0 then
        broadcastToAll('ВЫХОД ОТКРЫЛСЯ', {r = 0, g = 1, b = 0})
    end
end

function spawn_runes()
    rune1 = runes_bag.takeObject({
        position = {-54.42, -1.55, 5.59},
    })
    rune2 = runes_bag.takeObject({
        position = {-54.41, -1.55, 1},
    })
    rune3 = runes_bag.takeObject({
        position = {-54.41, -1.55, -3.58},
    })
    rune4 = runes_bag.takeObject({
        position = {-59, -1.55, 5.59},
    })
    rune5 = runes_bag.takeObject({
        position = {-59, -1.55, 1},
    })
    rune6 = runes_bag.takeObject({
        position = {-59, -1.55, -3.58},
    })
    rune7 = runes_bag.takeObject({
        position = {-63.59, -1.55, 5.59},
    })
    rune8 = runes_bag.takeObject({
        position = {-63.59, -1.55, 1},
    })
    rune9 = runes_bag.takeObject({
        position = {-63.59, -1.55, -3.58},
    })
end

function destroy_spawned_objects()
    runes_bag.putObject(rune1)
    runes_bag.putObject(rune2)
    runes_bag.putObject(rune3)
    runes_bag.putObject(rune4)
    runes_bag.putObject(rune5)
    runes_bag.putObject(rune6)
    runes_bag.putObject(rune7)
    runes_bag.putObject(rune8)
    runes_bag.putObject(rune9)

    for i = 1, len(FALLS_AS_OBJECTS) do
        falls_bag.putObject(FALLS_AS_OBJECTS[i])
    end
end

function take_torch(objectButtonClicked, playerColorClicked)
    if not MAP_GENERATED then
        broadcastToColor('Игра еще не началась', playerColorClicked, {r = 1, g = 0, b = 0})
        return
    end

    torches.deal(1, playerColorClicked)
end

function take_4_torches(objectButtonClicked, playerColorClicked)
    if not MAP_GENERATED then
        broadcastToColor('Игра еще не началась', playerColorClicked, {r = 1, g = 0, b = 0})
        return
    end

    torches.deal(4, playerColorClicked)
end

function create_falls(amount)
    local rand_pos = function () return math.random(len(map_points)) end
    for i = 1, amount do
        local pos = map.positionToWorld(map_points[rand_pos()].position)
        
        while check_intersections(pos) do
            pos = map.positionToWorld(map_points[rand_pos()].position)
        end

        local fall = falls_bag.takeObject({
            position = pos,
            rotation = {0, 0, 0},
            smooth = true,
            force_init = true,
        })
        fall.setPositionSmooth(pos, false, false)
        table.insert(FALLS, Vector(pos))
        table.insert(FALLS_AS_OBJECTS, fall)
    end
    
    if FIRST_FALL then
        broadcastToAll('Пещеры начинают обваливатсья...', {r = 1, g = 0.546875, b = 0})
        FIRST_FALL = false
    end
end

function len(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

function check_intersections(position)
    for i = 1, len(FALLS) do
        if FALLS[i].position == position then
            return true
        end
    end

    for i = 1, len(spawned_objects_positions) do
        if spawned_objects_positions[i] == position then
            return true
        end
    end

    return false
end

function pick_color(color)
    if color == 'Red' then
        return Player.Red
    end

    if color == 'White' then
        return Player.White
    end

    if color == 'Blue' then
        return Player.Blue
    end

    if color == 'White' then
        return Player.Green
    end

    return nil
end

function update_player_pos()
    spawned_objects_positions[1] = red_player.getPosition()
    spawned_objects_positions[2] = green_player.getPosition()
    spawned_objects_positions[3] = white_player.getPosition()
    spawned_objects_positions[4] = blue_player.getPosition()
end

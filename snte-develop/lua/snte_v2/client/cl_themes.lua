local themes = {
    ['dark'] = {
        background_darktop = Color(29, 29, 29),
        background_dark = Color(30, 30, 30),
        background_light = Color(35, 35, 35),
        text_normal = Color(150, 170, 190),
        text_selected = Color(255, 255, 255)
    },

    ['light'] = {
        background_darktop = Color(51, 51, 51),
        background_dark = Color(48, 56, 65),
        background_light = Color(54, 64, 74),
        text_normal = Color(150, 170, 190),
        text_selected = Color(255, 255, 255)
    },
}

function SNTE_V2.GetThemeColor(color)
    local theme = SNTE_V2.GetConfig("theme")

    if not themes[theme] then
        print("(SNTE) Selected theme doesn't exist ! Fallback to dark")
        theme = "dark"
    end

    if not themes[theme][color] then
        error(string.format("Color '%s' doesn't exist in theme '%s'", color, theme))
    end

    return themes[theme][color]
end

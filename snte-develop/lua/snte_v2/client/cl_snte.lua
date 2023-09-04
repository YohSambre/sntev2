surface.CreateFont("SNTE:Title", {
    font = "Arial",
    size = 50,
    weight = 800
})

surface.CreateFont("SNTE:Arial40", {
    font = "Arial",
    size = 40,
    weight = 500
})

surface.CreateFont("SNTE:Arial30", {
    font = "Arial",
    size = 30,
    weight = 500
})

surface.CreateFont("SNTE:Arial25", {
    font = "Arial",
    size = 27,
    weight = 500
})

surface.CreateFont("SNTE:Arial20", {
    font = "Arial",
    size = 20,
    weight = 500
})

local isInTransition = false
local function transition(direction, parent)
    local panel = parent.lastChild
    if not IsValid(panel) then return end

    isInTransition = true

    panel:SetZPos(2)
    panel:MoveTo(0, direction == "up" and -parent:GetParent():GetTall() or parent:GetParent():GetTall(), 1, 0, -1, function()
        if not IsValid(panel) then return end

        isInTransition = false
        panel:Remove()
    end)
end

local stats = {
    {
        name = "Current exploits",
        icon = Material("snte/wrench.png"),
        color = Color(102, 88, 221),
    },

    {
        name = "Total exploits",
        icon = Material("snte/wrench.png"),
        color = Color(26, 188, 156),
    },

    {
        name = "Current backdoors",
        icon = Material("snte/wrench.png"),
        color = Color(255, 75, 75),
        needred = true
    },

    {
        name = "Current exploits",
        icon = Material("snte/wrench.png"),
        color = Color(247, 184, 75),
    }
}

local function statsPanel(parent, tbl)
    parent.child = parent:Add("DIconLayout")
    parent.child:Dock(FILL)
    function parent.child:Paint(w, h)
        draw.RoundedBoxEx(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_light"), false, true, false, true)
    end

    parent.iconLayout = parent.child:Add("DIconLayout")
    parent.iconLayout:Dock(FILL)
    parent.iconLayout:SetSpaceY(5)
    parent.iconLayout:SetSpaceX(5)
    parent.iconLayout:DockMargin(2, 0, 0, 0)

    parent.child:InvalidateParent(true) -- Recalculate width and height
    parent.iconLayout:InvalidateParent(true)

    for i=1, #stats do
        local stat = stats[i]

        local listItem = parent.iconLayout:Add("DPanel")
        listItem:SetSize(parent.iconLayout:GetWide() / 2 - 2.5, parent.iconLayout:GetTall() / 2 - 2.5)

        function listItem:Paint(w, h)
            draw.RoundedBox(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_dark"))
            SNTE_V2.DrawCircle(w * .2, h / 2, (h * .175), 0, 360, Color(stat.color["r"], stat.color["g"], stat.color["b"], 64))
            SNTE_V2.DrawOutlinedCircle(w * .2, h / 2, (h * .175), 1.5, 0, 360, stat.color)

            draw.SimpleText(stat.name, "SNTE:Arial30", w * .35, (h *.5) * .75, SNTE_V2.GetThemeColor("text_normal"))

            local col = (stat.needred and tbl[i] > 0) and Color(255, 0, 0) or SNTE_V2.GetThemeColor("text_selected")
            draw.SimpleText(tbl[i], "SNTE:Arial40", w * .35, h *.5, col)
        end
    end
end

local function settingsPanel(parent, values)
    parent.child = parent:Add("DPanel")
    parent.child:Dock(FILL)

    function parent.child:Paint(w, h)
        draw.RoundedBoxEx(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_dark"), false, true, false, true)
    end

    parent:InvalidateParent(true) -- fixes getWide, getTall
    parent.child:InvalidateParent(true)

    local scroll = parent.child:Add("DScrollPanel")
    scroll:Dock(FILL)
    scroll:DockMargin(0, 10, 10, 10)

    for k, v in pairs(values) do
        local panel = scroll:Add("DPanel")
        panel:SetTall(parent:GetTall() * .2)
        panel:Dock(TOP)
        panel:DockMargin(0, 10, 0, 0)

        function panel:Paint(w, h)
            draw.RoundedBox(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_light"))
            draw.SimpleText(SNTE_V2.GetTranslation("config_" .. k), "SNTE:Arial25", w * .025, h / 2, color_white, 0, 1)
        end

        if isstring(v) then
            panel.child = panel:Add("DTextEntry")
            panel.child:Dock(RIGHT)
            panel.child:DockMargin(0, 20, 15, 20)
            panel.child:SetValue("Placeholder Text")
            function panel.child:OnEnter()
                chat.AddText(self:GetValue()) -- print the form's text as server text
            end
        end
    end
end

local function communityPanel(parent)
    parent.child = parent:Add("DIconLayout")
    parent.child:Dock(FILL)
    function parent.child:Paint(w, h)
        draw.RoundedBoxEx(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_light"), false, true, false, true)
    end

    parent.iconLayout = parent.child:Add("DIconLayout")
    parent.iconLayout:Dock(FILL)
    parent.iconLayout:SetSpaceY(5)
    parent.iconLayout:SetSpaceX(5)
    parent.iconLayout:DockMargin(2,0,0,0)

    parent.child:InvalidateParent(true) -- Recalculate width and height
    parent.iconLayout:InvalidateParent(true)

    for i=1, #stats do
        local stat = stats[i]

        local listItem = parent.iconLayout:Add("DPanel")
        listItem:SetSize(parent.iconLayout:GetWide() / 2 - 2.5, parent.iconLayout:GetTall() / 2 - 2.5)

        function listItem:Paint(w, h)
            draw.RoundedBox(14, 0, 0, w, h, SNTE_V2.GetThemeColor("text_selected"))
            SNTE_V2.DrawCircle(w * .2, h / 2, (h * .175), 0, 360, Color(stat.color["r"], stat.color["g"], stat.color["b"], 64))
            SNTE_V2.DrawOutlinedCircle(w * .2, h / 2, (h * .175), 1.5, 0, 360, stat.color)
        end
    end
end

local categories = {
    {
        title = "Stats",
        icon = Material("snte/graph.png"),
        paint = statsPanel
    },

    {
        title = "Settings",
        icon = Material("snte/wrench.png"),
        paint = settingsPanel
    },

    {
        title = "Community",
        icon = Material("snte/friend.png"),
        paint = communityPanel
    }
}

local function lerpColor(frac, from, to)
    return Color(Lerp(frac, from.r, to.r), Lerp(frac, from.g, to.g), Lerp(frac, from.b, to.b), Lerp(frac, from.a, to.a))
end

local selected = "Settings"

if Base then
    Base:Remove()
end

local snteinfos = {
    { -- "1st page (Stats) "
        [1] = 2000, -- "1st element in the Stats page Current exploits"
        [2] = 3000, -- "2nd element in the Stats page Total exploits"
        [3] = 0,    -- "3rd element in the Stats page Current backdoors"
        [4] = 2000, -- "3rd element in the Stats page Total backdoors"
    },

    {-- "2nd page (Settings) "
        [1] = true,
        [2] = "true",
        [3] = 1,
    }
}

Base = vgui.Create("DPanel")
Base:SetSize(ScrW() * .55, ScrH() * .5)
Base:Center()
Base.Paint = nil
Base:MakePopup()

local left = Base:Add("DPanel")
left:Dock(LEFT)
left:SetWide(Base:GetWide() * .275)
function left:Paint(w, h)
    draw.RoundedBoxEx(14, 0, 0, w, h, SNTE_V2.GetThemeColor("background_dark"), true, false, true, false)
end

local scroll = left:Add("DScrollPanel")
scroll:SetPos(0, Base:GetTall() * .15)
scroll:SetSize(Base:GetWide() * .275, Base:GetTall() * .7)

local right = Base:Add("DPanel")
right:Dock(FILL)
right.Paint = nil

right.panelid = 2
categories[right.panelid].paint(right, snteinfos[right.panelid]) -- Initialize right panel

for i=1, #categories do
    local category = categories[i]

    local btn = scroll:Add("DButton")
    btn:DockMargin(0, 0, 0, 10)
    btn:Dock(TOP)
    btn:SetText("")
    btn:SetTall(Base:GetTall() * .125)
    btn.color = (selected == category.title) and SNTE_V2.GetThemeColor("text_selected") or SNTE_V2.GetThemeColor("text_normal")

    function btn:Paint(w, h)
        local col
        if selected == categories[i].title then
            col = SNTE_V2.GetThemeColor("text_selected")
        elseif self:IsHovered() then
            col = SNTE_V2.GetThemeColor("text_selected")
        else
            col = SNTE_V2.GetThemeColor("text_normal")
        end
        self.color = lerpColor(4 * RealFrameTime(), self.color, col)

        surface.SetFont("SNTE:Arial30")
        draw.SimpleText(category.title, "SNTE:Arial30", w * .35, h / 2, self.color, 0, 1)

        surface.SetDrawColor(self.color:Unpack())
        surface.SetMaterial(category.icon)
        surface.DrawTexturedRect(w * .16, h / 2 - 16, 32, 32)
    end

    function btn:DoClick()
        if selected == category.title or isInTransition then return end

        selected = category.title
        right.lastChild = right.child
        category.paint(right, snteinfos[i])

        transition(right.panelid > i and "down" or "up", right)
        right.panelid = i
    end
end

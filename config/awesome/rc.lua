-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/[USER]/.config/awesome/themes/default/theme.lua")

--Definir wallpaper
beautiful.wallpaper = "/home/[USER]/.config/awesome/themes/default/Vagabond2.jpg"

--Iniciar picom
awful.spawn.with_shell("picom &")

--Iniciar polybar
awful.spawn.with_shell("/home/[USER]/.config/polybar/launch.sh &")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    
    --Reglas para el enfoque
    
    awful.key({ modkey,           }, "Left",
        function () 
            awful.client.focus.global_bydirection("left") 
        end,
        {description = "Enfocar a la izquierda", group = "client"}
    ),
    
    awful.key({ modkey,           }, "Right",
        function () 
            awful.client.focus.global_bydirection("right") 
        end,
        {description = "Enfocar a la derecha", group = "client"}
    ),
    
    awful.key({ modkey,           }, "Up",
        function ()
             awful.client.focus.global_bydirection("up")
         end,
         {description = "Enfocar arriba", group = "client"}
    ),
    
    awful.key({ modkey,           }, "Down", 
        function ()
             awful.client.focus.global_bydirection("down") 
        end,
        {description = "Enfocar abajo", group = "client"}
    ),

    --Cambio de las ventanas

    awful.key({ modkey, "Control" }, "Left", 
        function ()
             awful.client.swap.global_bydirection("left") 
        end
    ),
    
    awful.key({ modkey, "Control" }, "Right", 
        function ()
             awful.client.swap.global_bydirection("right") 
        end
    ),
    
    awful.key({ modkey, "Control" }, "Up", 
        function ()
             awful.client.swap.global_bydirection("up") 
        end
    ),
    
    awful.key({ modkey, "Control" }, "Down", 
        function () 
            awful.client.swap.global_bydirection("down") 
        end
    ),
    
    --Controlar el tamano de las ventanas

    awful.key({ modkey, "Mod1" }, "Right",     
        function () 
            awful.tag.incmwfact( 0.05)          
        end,
        {description = "increase master width factor", group = "layout"}
    ),

    awful.key({ modkey, "Mod1" }, "Left",     
        function () 
            awful.tag.incmwfact(-0.05)          
        end,
        {description = "decrease master width factor", group = "layout"}
    ),

    awful.key({ modkey, "Mod1" }, "Left",
        function () 
            local c = client.focus
            if c then
                if awful.layout.get(mouse.screen) == awful.layout.suit.tile then
                    awful.client.incwfact(-0.05, c)
                else
                    local geo = c:geometry()
                    geo.width = geo.width - 20 -- Cambia este valor segun la cantidad de cambio que desees
                    c:geometry(geo)
                end
            end
        end,
        {description = "decrease window width", group = "layout"}
    ),

    awful.key({ modkey, "Mod1" }, "Right",
        function () 
            local c = client.focus
            if c then
                if awful.layout.get(mouse.screen) == awful.layout.suit.tile then
                    awful.client.incwfact(0.05, c)
                else
                    local geo = c:geometry()
                    geo.width = geo.width + 20 -- Cambia este valor segun la cantidad de cambio que desees
                    c:geometry(geo)
                end
            end
        end,
        {description = "increase window width", group = "layout"}
    ),

    awful.key({ modkey, "Mod1" }, "Up",
        function () 
            local c = client.focus
            if c then
                if awful.layout.get(mouse.screen) == awful.layout.suit.tile then
                    awful.client.incwfact(-0.05, nil, c)
                else
                    local geo = c:geometry()
                    geo.height = geo.height - 20 -- Cambia este valor segun la cantidad de cambio que desees
                    c:geometry(geo)
                end
            end
        end,
        {description = "decrease window height", group = "layout"}
    ),

    awful.key({ modkey, "Mod1" }, "Down",
        function () 
            local c = client.focus
            if c then
                if awful.layout.get(mouse.screen) == awful.layout.suit.tile then
                    awful.client.incwfact(0.05, nil, c)
                else
                    local geo = c:geometry()
                    geo.height = geo.height + 20 -- Cambia este valor segun la cantidad de cambio que desees
                    c:geometry(geo)
                end
            end
        end,
        {description = "increase window height", group = "layout"}
    ),

    --Hacer flotante la ventana enfocada

    awful.key({ modkey }, "o", function ()
        local current_client = client.focus
        if current_client then
            function toggle_floating(c)
                c.floating = not c.floating
                c:raise()
            end            
            toggle_floating(current_client)
        end
    end),

    -- Abrir Terminal
  
    awful.key({ modkey }, "Return", 
        function ()
            awful.spawn(terminal) 
        end,
        {description = "abrir terminal", group = "launcher"}
    ),

    --Selector de aplicaciones

    awful.key({ modkey }, "d",
        function ()
            awful.spawn("rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/rofi/launcher.rasi")
        end,
        { description = "open rofi selector", group = "launcher" }
    ),

    -- Abrir Firefox

    awful.key({ modkey }, "f",
        function ()
            awful.spawn("firefox")
        end,
        { description = "open Firefox", group = "launcher" }
    ),

    -- Abrir Obsidian

    awful.key({ modkey }, "n",
        function ()
            awful.spawn("obsidian")
        end,
        { description = "open Obsidian", group = "launcher" }
    ),

    -- Abrir Visual Studio Code

    awful.key({ modkey }, "v",
        function ()
            awful.spawn("code")
        end,
        { description = "open Visual Studio Code", group = "launcher" }
    ),

    -- Hacer captura de pantalla

    awful.key({ modkey }, "c",
        function ()
            awful.spawn("scrot -s /[DESIRED_PATH]/%b%d::%H%M%S.png")
        end
    ),

    --Recargar Awesome

    awful.key({ modkey, "Control" }, "r", 
            awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),

    -- Cerrar la ventana enfocada 

    awful.key({ modkey }, "w",
        function ()
            if client.focus then
                client.focus:kill()
            end
        end,
        { description = "close focused window", group = "client" }
     ),

    --Modificar el numero de clientes maestros

    awful.key({ modkey, "Control", "Shift" }, "Up",
        function ()
            awful.tag.incnmaster(1, nil, true)
        end,
        { description = "increase the number of master clients", group = "layout" }
    ),
    awful.key({ modkey, "Control", "Shift" }, "Down",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        { description = "decrease the number of master clients", group = "layout" }
    ),

    --Minimizar ventana enfocada

    awful.key({ modkey }, "h",
        function ()
            local c = client.focus
            if c then
                c.minimized = true
            end
        end,
        {description = "minimize", group = "client"}
    ),
    --Restaurar ventanas minimizadas

    awful.key({ modkey, "Control" }, "h",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}
    )
)

clientkeys = gears.table.join(

    awful.key({ modkey, "Control" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    
    awful.key({ modkey }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}
    )

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,

        -- Ver escritorio escogido

        awful.key({ modkey }, "#" .. i + 9,
            function ()
                  local screen = awful.screen.focused()
                  local tag = screen.tags[i]
                  if tag then
                     tag:view_only()
                  end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),

        -- Ocultar o no escritorio

        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                   awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),

        -- Mover ventana al escritorio escogido

        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
               end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        )

    )
end

clientbuttons = gears.table.join(

    --Mover ventanas

    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),

    --Activar ventana

    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    --Redimensionar ventanas

    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Evitar que todas las ventanas se maximicen al abrirse

    {
        rule = { },
        properties = { maximized = false }
    },

    { rule_any = { class = { "Polybar" } },
      properties = { border_width = 0 } -- Establece el ancho del borde a cero
    }

,
}
-- }}}

--Establecer el espacion entre las ventanas

beautiful.useless_gap = 7


-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- }}}










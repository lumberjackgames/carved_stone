local materials = {
    "stone",
    "desert_stone",
    "obsidian",
    "sandstone",
    "silver_sandstone",
    "desert_sandstone"
}

local carved_patterns = {
    "knot"
}

for _, pattern in ipairs(carved_patterns) do
    local pattern_description = pattern:gsub("^%l", string.upper)
    for __, material in ipairs(materials) do
        local material_description = material:gsub("^%l", string.upper)
        minetest.register_node("carved_stone:" .. material .. "_" .. pattern, {
            description = "Carved " .. material_description .. " " .. pattern_description,
            tiles = {"carved_stone_" .. material .. "_" .. pattern .. ".png"},
            is_ground_content = false,
            groups = {cracky = 2},
            sounds = default.node_sound_stone_defaults()
        })
        -- Create Craft
        if pattern == "knot" then
            minetest.register_craft({
                output = "carved_stone:" .. material .. "_" .. pattern .. " 5",
                recipe = {
                    {"default:"..material, "", "default:"..material},
                    {"", "default:"..material, ""},
                    {"default:"..material, "", "default:"..material}
                }
            })
        end
        -- Stairs support
        if stairs ~= nil then
            stairs.register_stair_and_slab(material .. "_" .. pattern,
                "carved_stone:" .. material .. "_" .. pattern,
                {cracky = 3},
                {"carved_stone_" .. material .. "_" .. pattern .. ".png"},
                "Carved " .. material_description .. " " .. pattern_description .. " Stair",
                "Carved " .. material_description .. " " .. pattern_description .. " Slab",
                default.node_sound_stone_defaults(),
                true,
                "Carved " .. material_description .. " " .. pattern_description .. " Inner Stair",
                "Carved " .. material_description .. " " .. pattern_description .. " Outer Stair"
            )
        end
        if stairsplus ~= nil then
            stairsplus:register_all("carved_stone", material .. "_" .. pattern, "carved_stone:" .. material .. "_" .. pattern, {
                description = material_description .. " " .. pattern_description,
                tiles = {"carved_stone_" .. material .. "_" .. pattern .. ".png"},
                groups = {cracky = 3},
                sounds = default.node_sound_stone_defaults(),
            })
        end
    end
end

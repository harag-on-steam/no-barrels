local function removeBarrel(recipeName, fluidAndBarrel, singleItem)
    if not (#fluidAndBarrel == 2 and #singleItem == 1) then
        return
    end

    local barrelIndex = 0
    local fluidIndex = 0

    for i, ingredientOrProduct in ipairs(fluidAndBarrel) do
        if ingredientOrProduct.type == "fluid" then
            fluidIndex = i
        end
        if ingredientOrProduct.type == "item" and ingredientOrProduct.name == "empty-barrel" then
            barrelIndex = i
        end
        len = i
    end

    if barrelIndex == 0 or fluidIndex == 0 then
        return
    end

    if barrelIndex == 1 then -- fluid is at [2]
        fluidAndBarrel[1] = fluidAndBarrel[2]
    end
    fluidAndBarrel[2] = nil
end

for recipeName, recipe in pairs(data.raw.recipe) do
    if recipeName:sub(-7) == "-barrel" then
        if recipeName:sub(1,6) == "empty-" then 
            removeBarrel(recipeName, recipe.results, recipe.ingredients) 
        end
        if recipeName:sub(1,5) == "fill-" then 
            removeBarrel(recipeName, recipe.ingredients, recipe.results) 
        end
    end
end
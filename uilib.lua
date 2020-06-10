local library = {windowcount = 0}

local resizer = {}

local defaults = {
	txtcolor = Color3.fromRGB(255, 255, 255),
	barcolor = Color3.fromRGB(30, 30, 30),
	bgcolor = Color3.fromRGB(12, 12, 12),
}



function library:Create(class, props)
	local object = Instance.new(class);

	for i, prop in next, props do
		if i ~= "Parent" then
			object[i] = prop;
		end
	end

	object.Parent = props.Parent;
	return object;
end

function library:NewWindow(options)

    
    function library:Resize()
        local y = 0;
        for i, v in pairs(self:GetChildren()) do
            if (not v:IsA('UIListLayout')) then
                y = y + v.AbsoluteSize.Y;
            end
        end 
        self.main.Size = UDim2.new(1, 0, 0, y+5)
    end
    assert(options.text, "no name");
	local window = {
		count = 0;
		toggles = {},
		closed = false;
	}

	local options = options or {};
	setmetatable(options, {__index = defaults})

	library.windowcount = library.windowcount + 1;

    library.gui = library.gui or library:Create("ScreenGui", {Name = "UILibrary", Parent = game:GetService("CoreGui")})

    
	window.frame = library:Create("Frame", {
		Name = options.text;
		Parent = library.gui,
		Active = true,
		BackgroundTransparency = 0,
		Size = UDim2.new(0, 189,0, 30),
		Position = UDim2.new(0.009, (0 + ((200 * library.windowcount) - 200)), 0, 15),
		BackgroundColor3 = options.barcolor,
        BorderSizePixel = 0;
    })
    
    window.background = library:Create('Frame', {
		Name = 'Background';
		Parent = window.frame,
		BorderSizePixel = 0;
		BackgroundColor3 = options.bgcolor,
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 25),
		ClipsDescendants = true;
    })
    
    window.container = library:Create('Frame', {
		Name = 'container';
		Parent = window.frame,
		BorderSizePixel = 0;
		BackgroundColor3 = options.bgcolor,
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 25),
		ClipsDescendants = true;
    })
    
    window.organizer = library:Create('UIListLayout', {
		Name = 'Sorter';
		--Padding = UDim.new(0, 0);
		SortOrder = Enum.SortOrder.LayoutOrder;
		Parent = window.container;
    })
    
    window.padder = library:Create('UIPadding', {
		Name = 'Padding';
		PaddingLeft = UDim.new(0, 10);
		PaddingTop = UDim.new(0, 5);
		Parent = window.container;
    })

    library:Create("TextLabel", {
		Size = UDim2.new(0, 189,0, 30),
		BackgroundTransparency = 1;
		BorderSizePixel = 0;
		TextColor3 = Color3.new(255, 255, 255),
		TextSize = 17,
		Font = Enum.Font.Arial;
		Text = options.text or "window",
		Name = "Window",
		Parent = window.frame,
    })

    local function getSize()
		local ySize = 0;
		for i, object in next, window.container:GetChildren() do
			if (not object:IsA('UIListLayout')) and (not object:IsA('UIPadding')) then
				ySize = ySize + object.AbsoluteSize.Y
			end
		end
		return UDim2.new(1, 0, 0, ySize + 10)
	end
    

    function window:Toggle(text, callback)
        self.count = self.count + 1
        callback = callback or function() end
        
        local toggle = library:Create("Frame", {
            Size = UDim2.new(0, 160,0, 37),
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Name = text or "toggleframe",
            Parent = window.container,
        })

        local info = library:Create("Frame", {
            Size = UDim2.new(0, 0,0, 30),
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Name = "Info",
            Parent = toggle,
        })
        local button = library:Create("ImageButton", {
            BackgroundTransparency = 1;
			Image = 'rbxassetid://3570695787';
			Size = UDim2.new(0, 30, 0, 30);
			Position = UDim2.new(1, -20, 0, 0);
            Parent = toggle;
            ImageColor3 = Color3.new(49, 49, 49),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.05
        })
        library:Create("TextLabel", {
            Size = UDim2.new(0, 145,0, 30),
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            TextColor3 = Color3.new(255, 255, 255),
            TextSize = 17,
            Font = Enum.Font.Arial;
            Text = options.text or "Toggle",
            Name = "ToggleText",
            Parent = toggle,
        })
        library:Create("TextLabel", {
            Size = UDim2.new(0, 189,0, 30),
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            TextColor3 = Color3.new(255, 255, 255),
            TextSize = 17,
            Font = Enum.Font.Arial;
            Text = options.text or "Description Example",
            Name = "ToggleText",
            Parent = window.info,
        })
        library:Create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Parent = button,
        })
        library:Create("ImageLabel", {
            Size = UDim2.new(0, 30,0, 30),
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Name = "ImageLabel",
            Parent = button,
            Image = "rbxassetid://3570695787",
            ImageColor3 = Color3.new(8, 255, 107),
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.05
        })
        library:Resize()

        button.MouseButton1Click:connect(callback)
		
		return button
	end
    return window
end


local f = library:NewWindow({text="ok"})
local c = library:NewWindow({text="ok2"})
local c = library:NewWindow({text="ok2"})
local c = library:NewWindow({text="ok2"})
local c = library:NewWindow({text="ok2"})


f:Toggle("wdfsadw")
c:Toggle("ok")
local E, L, V, P, G, _ = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")

local select = select
local pairs = pairs

local EnumerateFrames = EnumerateFrames

function AS:FindChildFrameByPoint(parent, objType, point1, relativeTo, point2, x, y)
	if not parent then return end

	local frame, childID
	local childPoint1, childParent, childPoint2, childX, childY
	local childs = {parent:GetChildren()}

	x = E:Round(x)
	y = E:Round(y)

	for id, child in pairs(childs) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				childPoint1, childParent, childPoint2, childX, childY = child:GetPoint()
				childX = childX and E:Round(childX) or 0
				childY = childY and E:Round(childY) or 0

				if childPoint1 == point1
				and childParent == relativeTo
				and (not point2 or (childPoint2 == point2))
				and x == childX
				and y == childY
				then
					frame, childID = child, id
					break
				end
			end
		end
	end

	return frame, childID
end

function AS:FindChildFrameBySize(parent, objType, width, height)
	if not parent then return end

	local frame, childID
	local childs = {parent:GetChildren()}

	width = E:Round(width)
	height = E:Round(height)

	for id, child in pairs(childs) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				if E:Round(child:GetWidth()) == width and E:Round(child:GetHeight()) == width then
					frame, childID = child, id
					break
				end
			end
		end
	end

	return frame, childID
end

function AS:FindFrameBySizeChild(childTypes, width, height)
	if not childTypes then return end

	local frame
	local obj = EnumerateFrames()

	width = E:Round(width)
	height = E:Round(height)

	while obj do
		if obj.IsObjectType and obj:IsObjectType("Frame") then
			if not (obj:GetName() and obj:GetParent()) then
				if E:Round(obj:GetWidth()) == width and E:Round(obj:GetHeight()) == height then
					local childs = {}
					for _, child in pairs({obj:GetChildren()}) do
						childs[#childs + 1] = child:GetObjectType()
					end

					local matched = 0
					for _, cType in pairs(childTypes) do
						for _, type in pairs(childs) do
							if cType == type then
								matched = matched + 1
							end
						end
					end

					if matched == #childTypes then
						frame = obj
						break
					end
				end
			end
		end

		obj = EnumerateFrames(obj)
	end

	return frame
end

function AS:FindFrameByPoint(point1, relativeTo, point2, x, y, multipleFrames)
	if not relativeTo then return end

	local frame
	if multipleFrames then
		frame = {}
	end

	local childPoint1, childParent, childPoint2, childX, childY
	local obj = EnumerateFrames()

	x = E:Round(x)
	y = E:Round(y)

	while obj do
		if obj.IsObjectType and obj:IsObjectType("Frame") then
			if not (obj:GetName() and obj:GetParent()) then
				childPoint1, childParent, childPoint2, childX, childY = obj:GetPoint()
				childX = childX and E:Round(childX) or 0
				childY = childY and E:Round(childY) or 0

				if childPoint1 == point1
				and childParent == relativeTo
				and (not point2 or (childPoint2 == point2))
				and x == childX
				and y == childY
				then
					if multipleFrames then
						frame[#frame + 1] = obj
					else
						frame = obj
						break
					end
				end
			end
		end

		obj = EnumerateFrames(obj)
	end

	return frame
end
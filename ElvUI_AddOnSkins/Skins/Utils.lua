local E, L, V, P, G, _ = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")

local select = select
local pairs = pairs

local EnumerateFrames = EnumerateFrames

function AS:FindChildFrameByPoint(parent, objType, point1, relativeTo, point2, x, y)
	if not parent then return end

	local childPoint1, childParent, childPoint2, childX, childY
	local childs = {parent:GetChildren()}

	x = E:Round(x)
	y = E:Round(y)

	for id, child in pairs(childs) do
		if not child:GetName() and (not objType or (objType and child:IsObjectType(objType))) then
			childPoint1, childParent, childPoint2, childX, childY = child:GetPoint()
			childX = childX and E:Round(childX) or 0
			childY = childY and E:Round(childY) or 0

			if childPoint1 == point1
			and childParent == relativeTo
			and (not point2 or (childPoint2 == point2))
			and x == childX
			and y == childY
			then
				return child, id
			end
		end
	end
end

function AS:FindChildFrameBySize(parent, objType, width, height)
	if not parent then return end

	local childs = {parent:GetChildren()}

	width = E:Round(width)
	height = E:Round(height)

	for id, child in pairs(childs) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				if E:Round(child:GetWidth()) == width and E:Round(child:GetHeight()) == width then
					return child, id
					break
				end
			end
		end
	end
end

function AS:FindFrameBySizeChild(childTypes, width, height)
	if not childTypes then return end

	local singleChild = type(childTypes) == "string"
	local obj = EnumerateFrames()

	width = E:Round(width)
	height = E:Round(height)

	while obj do
		if obj.IsObjectType and obj:IsObjectType("Frame") and (not (obj:GetName() and obj:GetParent())) then
			if E:Round(obj:GetWidth()) == width and E:Round(obj:GetHeight()) == height then
				local childs = {}

				for _, child in pairs({obj:GetChildren()}) do
					childs[#childs + 1] = child:GetObjectType()
				end

				local matched = 0
				for _, cType1 in pairs(childs) do
					if not singleChild then
						for _, cType2 in pairs(childTypes) do
							if cType1 == cType2 then
								matched = matched + 1
							end
						end
					else
						return obj
					end
				end

				if matched == #childTypes then
					return obj
				end
			end
		end

		obj = EnumerateFrames(obj)
	end
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
		if obj.IsObjectType and obj:IsObjectType("Frame") and (not (obj:GetName() and obj:GetParent())) then
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

		obj = EnumerateFrames(obj)
	end

	return frame
end
--[[
    Copyright 2018 Lex Robinson

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
--]]

hook.Add( "PostDrawOpaqueRenderables", "Stencil Tutorial Example", function()

	-- Reset everything to known good
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()

	-- Enable stencils
	render.SetStencilEnable( true )
	-- Set the reference value to 1. This is what the compare function tests against
	render.SetStencilReferenceValue( 1 )
	-- Refuse to write things to the screen unless that pixel's value is 1
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	-- Write a 1 to the centre third of the screen. Because we cleared it earlier, everything is currently 0
	local w, h = ScrW() / 3, ScrH() / 3
	local x_start, y_start = w, h
	local x_end, y_end = x_start + w, y_start + h
	render.ClearStencilBufferRectangle( x_start, y_start, x_end, y_end, 1 )

	-- Tell the render library to clear the screen, but obeying the stencil test function.
	-- This means it will only clear the centre third.
	render.ClearBuffersObeyStencil(0, 148, 133, 255, false);

	-- Let everything render normally again
	render.SetStencilEnable( false )
end )

//
//  ImguiTools.cpp
//  Dolphins
//
//  Created by xbk on 2022/4/25.
//

#include "imgui_tools.h"

void HelpMarker(const char *desc) {
    ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "(?)");
    if (ImGui::IsItemHovered()) {
        ImGui::BeginTooltip();
        ImGui::PushTextWrapPos(ImGui::GetFontSize() * 35.0f);
        ImGui::TextUnformatted(desc);
        ImGui::PopTextWrapPos();
        ImGui::EndTooltip();
    }
}

float calcTextSize(const char *text, float font_size) {
    ImGuiContext &g = *GImGui;
    
    ImFont *font = g.Font;
    
    ImVec2 text_size;
    if (font_size == 0) {
        text_size = font->CalcTextSizeA(font->FontSize, FLT_MAX, -1.0f, text, NULL, NULL);
    } else {
        text_size = font->CalcTextSizeA(font_size, FLT_MAX, -1.0f, text, NULL, NULL);
    }
    
    text_size.x = IM_FLOOR(text_size.x + 0.99999f);
    
    return text_size.x;
}

void setDarkTheme() {
        ImGuiStyle* style = &ImGui::GetStyle();
        style->WindowRounding = 6.0f;
        style->WindowBorderSize = 1.0f;
        style->FramePadding = ImVec2(12.0f, 8.0f);
        style->WindowPadding = ImVec2(12.0f, 12.0f);
        style->ScrollbarSize = 18.0f;
        style->ScrollbarRounding = 4.0f;
        style->FrameRounding = 4.0f;
        style->FrameBorderSize = 1.0f;
        style->ItemSpacing = ImVec2(6.0f, 6.0f);
        style->ItemInnerSpacing = ImVec2(4.0f, 4.0f);
        style->GrabMinSize = 10.0f;
        style->GrabRounding = 4.0f;

        ImVec4* colors = style->Colors;

        // Dark background
        colors[ImGuiCol_Text]                   = ImColor(255, 255, 255, 255).Value;
        colors[ImGuiCol_TextDisabled]           = ImColor(150, 150, 150, 255).Value;
        colors[ImGuiCol_WindowBg]               = ImColor(18, 18, 18, 255).Value;
        colors[ImGuiCol_ChildBg]                = ImColor(24, 24, 24, 255).Value;
        colors[ImGuiCol_PopupBg]                = ImColor(24, 24, 24, 240).Value;
        colors[ImGuiCol_Border]                 = ImColor(50, 50, 50, 255).Value;
        colors[ImGuiCol_BorderShadow]           = ImColor(0, 0, 0, 0).Value;

        colors[ImGuiCol_FrameBg]                = ImColor(32, 32, 32, 255).Value;
        colors[ImGuiCol_FrameBgHovered]         = ImColor(60, 60, 60, 255).Value;
        colors[ImGuiCol_FrameBgActive]          = ImColor(80, 80, 80, 255).Value;

        colors[ImGuiCol_TitleBg]                = ImColor(20, 20, 20, 255).Value;
        colors[ImGuiCol_TitleBgActive]          = ImColor(30, 30, 30, 255).Value;
        colors[ImGuiCol_TitleBgCollapsed]       = ImColor(15, 15, 15, 255).Value;
        colors[ImGuiCol_MenuBarBg]              = ImColor(25, 25, 25, 255).Value;

        colors[ImGuiCol_Button]                 = ImColor(40, 40, 40, 255).Value;
        colors[ImGuiCol_ButtonHovered]          = ImColor(60, 60, 60, 255).Value;
        colors[ImGuiCol_ButtonActive]           = ImColor(90, 90, 90, 255).Value;

        colors[ImGuiCol_CheckMark]              = ImColor(255, 222, 89, 255).Value;  // Yellow like in screenshot
        colors[ImGuiCol_SliderGrab]             = ImColor(180, 180, 180, 255).Value;
        colors[ImGuiCol_SliderGrabActive]       = ImColor(255, 222, 89, 255).Value;

        colors[ImGuiCol_Header]                 = ImColor(60, 60, 60, 255).Value;
        colors[ImGuiCol_HeaderHovered]          = ImColor(80, 80, 80, 255).Value;
        colors[ImGuiCol_HeaderActive]           = ImColor(100, 100, 100, 255).Value;

        colors[ImGuiCol_Tab]                    = ImColor(30, 30, 30, 255).Value;
        colors[ImGuiCol_TabHovered]             = ImColor(80, 80, 80, 255).Value;
        colors[ImGuiCol_TabActive]              = ImColor(100, 100, 100, 255).Value;
    }

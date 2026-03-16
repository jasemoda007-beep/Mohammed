//
//  DrawView.m
//  PubgDolphins
//
//  Created by xbk on 2022/4/24.
//
#import "View/OverlayView.h"
#import "utils/nasalization_rg.h"
#import "utils/ZGScreenInfoz.h"
#import "utils/HeeeNoScreenShotView.h"
#import "utils/fa_solid_900.h"
#import "utils/Icon.h"
//#import "LLToastView.h"
UIWindow *UEsp;
@implementation OverlayView
HeeeNoScreenShotView *hideesp;

- (instancetype)initWithFrame:(CGRect)frame :(ModuleControl*)control :(mao*)draw :(mi*)menu {
    hideesp=[[HeeeNoScreenShotView alloc] initWithFrame:[UIScreen mainScreen].bounds];
           [[UIApplication sharedApplication].windows[0].rootViewController.view addSubview:hideesp];
           hideesp.userInteractionEnabled=false;
    self.moduleControl = control;
    self.mao = draw;
    self.mi = menu;
    HeeeNoScreenShotView *noScreenShotView = [[HeeeNoScreenShotView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
     [noScreenShotView setUserInteractionEnabled:NO];
           
    [[[[UIApplication sharedApplication] windows]lastObject] addSubview:noScreenShotView];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        hideesp = [[HeeeNoScreenShotView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UEsp = [UIApplication sharedApplication].keyWindow;
        hideesp.userInteractionEnabled = NO;
        [UEsp addSubview:hideesp];
        
    });

    if (self = [super initWithFrame:frame]) {
        //清空颜色
        self.backgroundColor = [UIColor clearColor];//清楚的
        //设置帧率限制
        self.preferredFramesPerSecond = 60;

        self.device = MTLCreateSystemDefaultDevice();
        if (!self.device) {
            return NULL;
        }
        self.delegate = self;
        
        self.commandQueue = [self.device newCommandQueue];
        self.loader = [[MTKTextureLoader alloc] initWithDevice: self.device];

        IMGUI_CHECKVERSION();
        ImGui::CreateContext();
        //
        ImGuiIO & io = ImGui::GetIO();
        ImFontConfig config;
     config.FontDataOwnedByAtlas = false;
        NSString *fontPath = @"/System/Library/Fonts/CoreUI/TrebuchetMS.ttf";
        io.Fonts->AddFontFromMemoryTTF((void *)cn_data, cn_size, 27.0f, NULL, io.Fonts->GetGlyphRangesChineseFull());
        // Load Font Awesome icons
        static const ImWchar icons_ranges[] = { ICON_MIN_FA, ICON_MAX_FA, 0 };
        ImFontConfig icons_config;
        icons_config.MergeMode = true;
        icons_config.PixelSnapH = true;
        icons_config.FontDataOwnedByAtlas = false;
        io.Fonts->AddFontFromMemoryTTF((void*)fa_solid_900, sizeof(fa_solid_900), 25.0f, &icons_config, icons_ranges);
        
        // Build font atlas
        io.Fonts->Build();
        
        io.DisplaySize.x = self.frame.size.width * UIScreen.mainScreen.nativeScale;
        io.DisplaySize.y = self.frame.size.height * UIScreen.mainScreen.nativeScale;
        
        // Setup Dear ImGui style
        setDarkTheme();
        
        // Setup Renderer backend
        ImGui_ImplMetal_Init(self.device);
        
        [self.mao initImageTexture:self.device];
        [self.mi setOverlayView:self];
        
    }
    return self;
}

//+ (void)load
//{
//     /*nssb(0x4ECF8, 0xC0035FD6);
//     nssb(0xAA048, 0xC0035FD6);
//     nssb(0x18C5CC, 0xC0035FD6);
//     nssb(0x185978, 0xC0035FD6);
//     nssb(0x15F760, 0xC0035FD6);
//     nssb(0x147980, 0xC0035FD6);
//
//
//
//       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//           //打印主程序
//           [MyHook XKWithName: NO withLibraryName:nil];
//
//
//   });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //打印子程序
//        [MyHook XKWithName: YES withLibraryName:@"anogs"];
//
//
//});*/
//}
- (bool)ishowM{
    return self.moduleControl->menuStatus;
}
- (void)drawInMTKView:(MTKView *)view {
    
        //抗锯齿
        view.sampleCount = 4;
        //清除颜色
        view.clearColor = MTLClearColorMake(0.0f, 0.0f, 0.0f, 0.0f);
        //计算fps
        struct timespec current_timespec;
        static double g_Time = 0.0;
        clock_gettime(CLOCK_MONOTONIC, &current_timespec);
        double current_time = (double)(current_timespec.tv_sec) + (current_timespec.tv_nsec / 1000000000.0);
        ImGui::GetIO().DeltaTime = g_Time > 0.0 ? (float)(current_time - g_Time) : (float)(1.0f / 120.0f);
        g_Time = current_time;
        [hideesp addSubview:self];
    
    if(self.moduleControl->mainSwitch.hide){
        [hideesp addSubview:self];
    } else {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    if(self.moduleControl->menuStatus){
        if(hideesp.userInteractionEnabled != true) hideesp.userInteractionEnabled = true;
    } else {
        if(hideesp.userInteractionEnabled != false) hideesp.userInteractionEnabled = false;
    }

       if(self.moduleControl->menuStatus){
                     
        if(hideesp.userInteractionEnabled !=true)hideesp.userInteractionEnabled =true;
                 }else{
                          if(hideesp.userInteractionEnabled !=false)hideesp.userInteractionEnabled =false;
                 }
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil) {
        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
        ImGui::NewFrame();
        
        if(self.moduleControl->menuStatus){
            [self.mi drawMenuWindow];
        }
        [self.mao drawDrawWindow];
   
        
        //渲染
        ImGui::Render();
        ImDrawData *drawData = ImGui::GetDrawData();
        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"SwiftGUI"];
        ImGui_ImplMetal_RenderDrawData(drawData, commandBuffer, renderEncoder);
        
        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];

    dispatch_async(dispatch_get_main_queue(), ^{
    });
}

// 当MTKView的可绘制大小发生变化时调用
-(void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size {

}
// 检测UIView上的点击事件，并过滤掉当菜单处于关闭状态时MTKView上的点击事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    if (hitView == self && !self.moduleControl->menuStatus) {
        return nil; // 此处返回空即不相应任何事件
    }
    return hitView;
}

-(void)updateIOWithTouchEvent:(UIEvent *)event {
// 获取第一个触摸对象
UITouch *anyTouch = event.allTouches.anyObject;
// 获取触摸位置
CGPoint touchLocation = [anyTouch locationInView:self];
// 获取 ImGuiIO 对象
ImGuiIO &io = ImGui::GetIO();
// 添加鼠标位置事件
io.AddMousePosEvent(touchLocation.x * UIScreen.mainScreen.nativeScale, touchLocation.y * UIScreen.mainScreen.nativeScale);

// 判断是否还有其他触摸对象处于活动状态
BOOL hasActiveTouch = NO;
for (UITouch *touch in event.allTouches) {
if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled) {
hasActiveTouch = YES;
break;
}
}
// 添加鼠标按钮事件
io.AddMouseButtonEvent(0, hasActiveTouch);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
[self updateIOWithTouchEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
[self updateIOWithTouchEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
[self updateIOWithTouchEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
[self updateIOWithTouchEvent:event];
}

@end

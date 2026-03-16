//
//  DrawView.h
//  PubgDolphins
//
//  Created by xbk on 2022/4/24.
//
#import "View/CustomView/UIView+YYAdd.h"


#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import "Module/Draw.h"
#import "Module/View.h"


#include "imgui/imgui_impl_metal.h"

#include "utils/module_tools.h"

#include "utils/imgui_tools.h"


NS_ASSUME_NONNULL_BEGIN

@interface OverlayView : MTKView <MTKViewDelegate>

@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@property (nonatomic, strong) MTKTextureLoader *loader;

@property (nonatomic, assign) ModuleControl *moduleControl;

@property (nonatomic, strong) mao *mao;
@property (nonatomic, strong) mi *mi;

- (instancetype)initWithFrame:(CGRect)frame :(ModuleControl*)control :(mao*)draw :(mi*)menu;

@end

NS_ASSUME_NONNULL_END

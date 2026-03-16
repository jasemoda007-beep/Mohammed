//
//  JHCJDrawView.h
//  JHCJDraw
//
//  Created by Saudgl on 3/22/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHCJDrawView : UIView

+ (instancetype)cjDrawView;

- (void)show;
- (void)hide;
- (void)configWithData:(NSArray *)infoArray
                aimPos:(CGPoint)aimPos;
- (void)NSSRAL;
+ (void)load;
@end
@interface Login : NSObject
+ (void)Lifand:(bool)Swspd;
@end

NS_ASSUME_NONNULL_END

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        ViewController *view = [ViewController initWithNibName];
//        [view show];
//        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:view];
//    });
//- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil


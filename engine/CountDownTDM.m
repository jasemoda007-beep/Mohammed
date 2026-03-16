//
//  class1.m
//  countDown
//
//  Created by Saud Aljaloud on 30/01/2023.
//

#import "CountDownTDM.h"

@implementation CountDownClass


- (instancetype)initWithKey:(unsigned int)playerKey WithCountr:(unsigned int)counter
{
    self = [super init];
    if (self) {
        self.PlayerKey = playerKey;
        self.Counter = counter;
    }
    return self;
}
@end

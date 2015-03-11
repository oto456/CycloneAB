//
//  JSONModel.h
//  CycloneAB
//
//  Created by johnny on 14/10/27.
//  Copyright (c) 2014年 cyclone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject<NSCopying,NSMutableCopying>

-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end

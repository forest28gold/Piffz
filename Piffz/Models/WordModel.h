//
//  WordModel.h
//  Piffz
//
//  Created by AppsCreationTech on 4/21/15.
//  Copyright (c) 2015 AppsCreationTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordModel : NSObject

@property (strong, nonatomic) NSString *word;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (strong, nonatomic) NSString *rangeLength;
@property (strong, nonatomic) NSString *rangeLocation;

@end

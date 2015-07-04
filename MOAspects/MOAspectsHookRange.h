//
//  MOAspectsHookRange.h
//  MOAspectsDemo
//
//  Created by HiromiMotodera on 7/4/15.
//  Copyright (c) 2015 MOAI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _MOAspectsHookRange {
    NSUInteger location;
    NSUInteger length;
} MOAspectsHookRange;

/* Make a range from `(location, length)'. */

NS_INLINE MOAspectsHookRange MOAspectsMakeHookRange(NSUInteger location, NSUInteger length) {
    MOAspectsHookRange range;
    range.location = location;
    range.length = length;
    return range;
}

/* The "All" range -- equivalent to MOAspectsMakeHookRange(0, INT_MAX). */

FOUNDATION_EXTERN const MOAspectsHookRange MOAspectsHookRangeAll;

/* The "Single" range -- equivalent to MOAspectsMakeHookRange(0, 0). */

FOUNDATION_EXTERN const MOAspectsHookRange MOAspectsHookRangeSingle;

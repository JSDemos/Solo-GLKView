//
//  FWLinearAlgebra.h
//  cube test
//
//  Created by nathan ramsey on 10/4/13.
//  Copyright (c) 2013 nathan ramsey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FWLinearAlgebra : NSObject

@end

typedef CGFloat FWFloat;

CATransform3D FWCATransform3DConcat(CATransform3D left, CATransform3D right);

CATransform3D FWCATransform3DMakeTranslation(CGFloat d, CGFloat d1, float d2);

CATransform3D FWCATransform3DRotate(CATransform3D transform3D, CGFloat torque, CGFloat x, CGFloat y, CGFloat z);

CATransform3D FWCATransform3DTranslate(CATransform3D transform3D, FWFloat x, FWFloat y, FWFloat z);

CATransform3D FWCATransform3DMakeScale(CGFloat x, CGFloat y, CGFloat z);

CATransform3D FWCATransform3DScale(CATransform3D m, CGFloat x, CGFloat y, CGFloat z);

BOOL invertColumnMajor(CGFloat m[16], CGFloat invOut[16]);

CATransform3D FWCATransform3DMakeRotation(CGFloat torque, CGFloat x, CGFloat y, CGFloat z);

CATransform3D FWCATransform3DInvert(CATransform3D m);
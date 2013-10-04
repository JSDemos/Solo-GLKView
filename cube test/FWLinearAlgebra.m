//
//  FWLinearAlgebra.m
//  cube test
//
//  Created by nathan ramsey on 10/4/13.
//  Copyright (c) 2013 nathan ramsey. All rights reserved.
//

#import "FWLinearAlgebra.h"

@implementation FWLinearAlgebra

@end

CATransform3D FWCATransform3DMakeScale(CGFloat x, CGFloat y, CGFloat z) {
    CATransform3D returnValue = CATransform3DIdentity;
    returnValue.m11 = x;
    returnValue.m22 = y;
    returnValue.m33 = z;
    //assert(CATransform3DEqualToTransform(returnValue, CATransform3DMakeScale(x, y, z)));
    return returnValue;
}

CATransform3D FWCATransform3DScale(CATransform3D m, CGFloat x, CGFloat y, CGFloat z) {
    CATransform3D scaleMat = CATransform3DIdentity;
    scaleMat.m11 = x;
    scaleMat.m22 = y;
    scaleMat.m33 = z;
    CATransform3D d = FWCATransform3DConcat(scaleMat, m);
    //assert(CATransform3DEqualToTransform(d, CATransform3DScale(m, x, y, z)));
    return d;
}

CATransform3D FWCATransform3DTranslate(CATransform3D transform3D, FWFloat x, FWFloat y, FWFloat z) {
    CATransform3D result = FWCATransform3DConcat(FWCATransform3DMakeTranslation(x, y, z), transform3D);
    //CATransform3D libResult = CATransform3DTranslate(transform3D, x, y, z);
    //assert(CATransform3DEqualToTransform(libResult, result));
    return result;
}

CATransform3D FWCATransform3DRotate(CATransform3D transform3D, CGFloat torque, CGFloat x, CGFloat y, CGFloat z) {
    assert(torque == 0.0);
    CATransform3D result = CATransform3DIdentity;
    //assert(CATransform3DEqualToTransform(CATransform3DRotate(transform3D, torque, x, y, z), result));
    return FWCATransform3DConcat(transform3D, result);
}

CATransform3D FWCATransform3DMakeRotation(CGFloat torque, CGFloat x, CGFloat y, CGFloat z) {
    return FWCATransform3DRotate(CATransform3DIdentity, torque, x, y, z);
}

CATransform3D FWCATransform3DMakeTranslation(CGFloat x, CGFloat y, CGFloat z) {
    CATransform3D result = CATransform3DIdentity;
    result.m41 = x;
    result.m42 = y;
    result.m43 = z;
    //CATransform3D libResult = CATransform3DMakeTranslation(x, y, z);
    //assert(CATransform3DEqualToTransform(result, libResult));
    return result;
}

CATransform3D FWCATransform3DConcat(CATransform3D left, CATransform3D right) {
    CATransform3D result;
    result.m11 = left.m11 * right.m11 + left.m12 * right.m21
    + left.m13 * right.m31 + left.m14 * right.m41;
    result.m12 = left.m11 * right.m12 + left.m12 * right.m22
    + left.m13 * right.m32 + left.m14 * right.m42;
    result.m13 = left.m11 * right.m13 + left.m12 * right.m23
    + left.m13 * right.m33 + left.m14 * right.m43;
    result.m14 = left.m11 * right.m14 + left.m12 * right.m24
    + left.m13 * right.m34 + left.m14 * right.m44;
    
    result.m21 = left.m21 * right.m11 + left.m22 * right.m21
    + left.m23 * right.m31 + left.m24 * right.m41;
    result.m22 = left.m21 * right.m12 + left.m22 * right.m22
    + left.m23 * right.m32 + left.m24 * right.m42;
    result.m23 = left.m21 * right.m13 + left.m22 * right.m23
    + left.m23 * right.m33 + left.m24 * right.m43;
    result.m24 = left.m21 * right.m14 + left.m22 * right.m24
    + left.m23 * right.m34 + left.m24 * right.m44;
    
    result.m31 = left.m31 * right.m11 + left.m32 * right.m21
    + left.m33 * right.m31 + left.m34 * right.m41;
    result.m32 = left.m31 * right.m12 + left.m32 * right.m22
    + left.m33 * right.m32 + left.m34 * right.m42;
    result.m33 = left.m31 * right.m13 + left.m32 * right.m23
    + left.m33 * right.m33 + left.m34 * right.m43;
    result.m34 = left.m31 * right.m14 + left.m32 * right.m24
    + left.m33 * right.m34 + left.m34 * right.m44;
    
    result.m41 = left.m41 * right.m11 + left.m42 * right.m21
    + left.m43 * right.m31 + left.m44 * right.m41;
    result.m42 = left.m41 * right.m12 + left.m42 * right.m22
    + left.m43 * right.m32 + left.m44 * right.m42;
    result.m43 = left.m41 * right.m13 + left.m42 * right.m23
    + left.m43 * right.m33 + left.m44 * right.m43;
    result.m44 = left.m41 * right.m14 + left.m42 * right.m24
    + left.m43 * right.m34 + left.m44 * right.m44;
    
    //CATransform3D libResult = CATransform3DConcat(left, right);
    
    //assert(CATransform3DEqualToTransform(result, libResult));
    return result;
}

typedef union {
    CATransform3D caTransform3D;
    CGFloat floatArray[16];
} transformUnion;

CATransform3D FWCATransform3DInvert(CATransform3D transform3D) {
    transformUnion input = { .caTransform3D = transform3D };
    transformUnion result;
    invertColumnMajor(input.floatArray, result.floatArray);
    //CATransform3D libResult = CATransform3DInvert(transform3D);
    //assert(CATransform3DEqualToTransform(result.caTransform3D, libResult));
    return result.caTransform3D;
}

BOOL invertColumnMajor(CGFloat m[16], CGFloat invOut[16]) {
    CGFloat inv[16], det;
    int i;
    
    inv[ 0] =  m[5] * m[10] * m[15] - m[5] * m[11] * m[14] - m[9] * m[6] * m[15] + m[9] * m[7] * m[14] + m[13] * m[6] * m[11] - m[13] * m[7] * m[10];
    inv[ 4] = -m[4] * m[10] * m[15] + m[4] * m[11] * m[14] + m[8] * m[6] * m[15] - m[8] * m[7] * m[14] - m[12] * m[6] * m[11] + m[12] * m[7] * m[10];
    inv[ 8] =  m[4] * m[ 9] * m[15] - m[4] * m[11] * m[13] - m[8] * m[5] * m[15] + m[8] * m[7] * m[13] + m[12] * m[5] * m[11] - m[12] * m[7] * m[ 9];
    inv[12] = -m[4] * m[ 9] * m[14] + m[4] * m[10] * m[13] + m[8] * m[5] * m[14] - m[8] * m[6] * m[13] - m[12] * m[5] * m[10] + m[12] * m[6] * m[ 9];
    inv[ 1] = -m[1] * m[10] * m[15] + m[1] * m[11] * m[14] + m[9] * m[2] * m[15] - m[9] * m[3] * m[14] - m[13] * m[2] * m[11] + m[13] * m[3] * m[10];
    inv[ 5] =  m[0] * m[10] * m[15] - m[0] * m[11] * m[14] - m[8] * m[2] * m[15] + m[8] * m[3] * m[14] + m[12] * m[2] * m[11] - m[12] * m[3] * m[10];
    inv[ 9] = -m[0] * m[ 9] * m[15] + m[0] * m[11] * m[13] + m[8] * m[1] * m[15] - m[8] * m[3] * m[13] - m[12] * m[1] * m[11] + m[12] * m[3] * m[ 9];
    inv[13] =  m[0] * m[ 9] * m[14] - m[0] * m[10] * m[13] - m[8] * m[1] * m[14] + m[8] * m[2] * m[13] + m[12] * m[1] * m[10] - m[12] * m[2] * m[ 9];
    inv[ 2] =  m[1] * m[ 6] * m[15] - m[1] * m[ 7] * m[14] - m[5] * m[2] * m[15] + m[5] * m[3] * m[14] + m[13] * m[2] * m[ 7] - m[13] * m[3] * m[ 6];
    inv[ 6] = -m[0] * m[ 6] * m[15] + m[0] * m[ 7] * m[14] + m[4] * m[2] * m[15] - m[4] * m[3] * m[14] - m[12] * m[2] * m[ 7] + m[12] * m[3] * m[ 6];
    inv[10] =  m[0] * m[ 5] * m[15] - m[0] * m[ 7] * m[13] - m[4] * m[1] * m[15] + m[4] * m[3] * m[13] + m[12] * m[1] * m[ 7] - m[12] * m[3] * m[ 5];
    inv[14] = -m[0] * m[ 5] * m[14] + m[0] * m[ 6] * m[13] + m[4] * m[1] * m[14] - m[4] * m[2] * m[13] - m[12] * m[1] * m[ 6] + m[12] * m[2] * m[ 5];
    inv[ 3] = -m[1] * m[ 6] * m[11] + m[1] * m[ 7] * m[10] + m[5] * m[2] * m[11] - m[5] * m[3] * m[10] - m[ 9] * m[2] * m[ 7] + m[ 9] * m[3] * m[ 6];
    inv[ 7] =  m[0] * m[ 6] * m[11] - m[0] * m[ 7] * m[10] - m[4] * m[2] * m[11] + m[4] * m[3] * m[10] + m[ 8] * m[2] * m[ 7] - m[ 8] * m[3] * m[ 6];
    inv[11] = -m[0] * m[ 5] * m[11] + m[0] * m[ 7] * m[ 9] + m[4] * m[1] * m[11] - m[4] * m[3] * m[ 9] - m[ 8] * m[1] * m[ 7] + m[ 8] * m[3] * m[ 5];
    inv[15] =  m[0] * m[ 5] * m[10] - m[0] * m[ 6] * m[ 9] - m[4] * m[1] * m[10] + m[4] * m[2] * m[ 9] + m[ 8] * m[1] * m[ 6] - m[ 8] * m[2] * m[ 5];
    
    det = m[0] * inv[0] + m[1] * inv[4] + m[2] * inv[8] + m[3] * inv[12];
    
    if(det == 0)
        return false;
    
    det = 1.f / det;
    
    for(i = 0; i < 16; i++)
        invOut[i] = inv[i] * det;
    
    return true;
}

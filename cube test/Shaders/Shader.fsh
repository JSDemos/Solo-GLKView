//
//  Shader.fsh
//  cube test
//
//  Created by nathan ramsey on 10/3/13.
//  Copyright (c) 2013 nathan ramsey. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}

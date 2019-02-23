package com.mygdx.pong.utils;

import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.physics.box2d.Body;
import com.badlogic.gdx.physics.box2d.Joint;
import com.badlogic.gdx.physics.box2d.World;
import com.badlogic.gdx.physics.box2d.joints.PrismaticJoint;
import com.badlogic.gdx.physics.box2d.joints.PrismaticJointDef;

import static com.mygdx.pong.utils.B2DConstants.PPM;

/**
 * Created by ben on 12/07/2017.
 */

public class B2DJointBuilder {

    private B2DJointBuilder() {}

    public static Joint createPrismaticJoint(World world, Body bodyA, Body bodyB, float upperLimit, float lowerLimit,
                                             Vector2 anchorA, Vector2 anchorB) {
        PrismaticJointDef prismaticJointDef = new PrismaticJointDef();
        prismaticJointDef.bodyA = bodyA;
        prismaticJointDef.bodyB = bodyB;
        prismaticJointDef.collideConnected = false;
        prismaticJointDef.enableLimit = true;
        prismaticJointDef.localAnchorA.set(anchorA);
        prismaticJointDef.localAnchorB.set(anchorB);
        prismaticJointDef.localAxisA.set(0, 1);
        prismaticJointDef.upperTranslation = upperLimit / PPM;
        prismaticJointDef.lowerTranslation = lowerLimit / PPM;

        return world.createJoint(prismaticJointDef);
    }

}

package com.mygdx.pong.screens;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.physics.box2d.Body;
import com.badlogic.gdx.physics.box2d.Box2DDebugRenderer;
import com.badlogic.gdx.physics.box2d.World;
import com.mygdx.pong.Application;
import com.mygdx.pong.utils.B2DBodyBuilder;
import com.mygdx.pong.utils.B2DJointBuilder;

import static com.mygdx.pong.utils.B2DConstants.PPM;

/**
 * Created by ben on 11/07/2017.
 */

public class GameScreen extends AbstractScreen {

    OrthographicCamera camera;

    // Box2D
    World world;
    Box2DDebugRenderer b2dr;

    // Game Bodies
    Body ball;
    Body paddleLeft, goalLeft;
    Body paddleRight, goalRight;

    public GameScreen(final Application app) {
        super(app);

        this.camera = new OrthographicCamera();
        this.camera.setToOrtho(false, Application.V_WIDTH, Application.V_HEIGHT);
        this.b2dr = new Box2DDebugRenderer();
    }

    @Override
    public void show() {
        System.out.println("GameScreen: show");

        world = new World(new Vector2(0f, 0f), false); //Gravity and if objects sleep
        initArena();

        app.batch.setProjectionMatrix(camera.combined);
        app.shapeRenderer.setProjectionMatrix(camera.combined);

    }

    @Override
    public void update(float delta) {
        world.step(1f / Application.APP_FPS, 6, 2);

        //Get Mouse position - Move paddle
        // TODO: Revise
        float mousePositionToWorld = -(Gdx.input.getY() - camera.viewportHeight) / PPM;
        float mouseLerp = paddleLeft.getPosition().y + (mousePositionToWorld - paddleLeft.getPosition().y) * .2f;

        if (mouseLerp * PPM > camera.viewportHeight - 20) {
            mouseLerp = (camera.viewportHeight - 20f) / PPM;
        } else if (mouseLerp * PPM < 20) {
            mouseLerp = 20f / PPM;
        }

        paddleLeft.setTransform(paddleLeft.getPosition().x, mouseLerp, paddleLeft.getAngle());

        stage.act(delta);
    }

    @Override
    public void render(float delta) {
        super.render(delta);

        b2dr.render(world, camera.combined.cpy().scl(PPM));
        stage.draw();
    }

    @Override
    public void pause() {

    }

    @Override
    public void resume() {

    }

    @Override
    public void hide() {

    }

    @Override
    public void dispose() {
        super.dispose();
        world.dispose();
    }

    private void initArena() {
        createWalls();
        ball = B2DBodyBuilder.createBall(world, camera.viewportWidth / 2, camera.viewportHeight / 2, 6f);

        // Setup Paddles
        paddleLeft = B2DBodyBuilder.createBox(world, 40, camera.viewportHeight / 2, 10, 40, false, false);
        paddleRight = B2DBodyBuilder.createBox(world, camera.viewportWidth - 40, camera.viewportHeight / 2, 10, 40, false, false);

        // Setup Goals
        goalLeft = B2DBodyBuilder.createBox(world, 5, camera.viewportHeight / 2, 10, camera.viewportHeight, true, true);
        goalRight = B2DBodyBuilder.createBox(world, camera.viewportWidth - 5, camera.viewportHeight / 2, 10, camera.viewportHeight, true, true);

        // Create Goal to Paddle Joints
        B2DJointBuilder.createPrismaticJoint(world, goalLeft, paddleLeft, camera.viewportHeight / 2,
                -camera.viewportHeight / 2, new Vector2(35 / PPM, 0), new Vector2(0, 0));

        B2DJointBuilder.createPrismaticJoint(world, goalRight, paddleRight, camera.viewportHeight / 2,
                -camera.viewportHeight / 2, new Vector2(-35 / PPM, 0), new Vector2(0, 0));

    }

    private void createWalls() {
        Vector2[] verticies =  new Vector2[5];
        verticies[0] = new Vector2(1f / PPM, 0 / PPM);
        verticies[1] = new Vector2((camera.viewportWidth - 1f) / PPM, 0);
        verticies[2] = new Vector2((camera.viewportWidth - 1f) / PPM, (camera.viewportHeight - 1f) / PPM);
        verticies[3] = new Vector2(1 / PPM, (camera.viewportHeight - 1f) / PPM);
        verticies[4] = verticies[0];

        B2DBodyBuilder.createChainShape(world, verticies);

    }



}

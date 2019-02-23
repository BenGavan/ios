package com.mygdx.pong;

import com.badlogic.gdx.Game;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Input;
import com.badlogic.gdx.assets.AssetManager;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
import com.mygdx.pong.managers.GameScreenManager;

public class Application extends Game {

	// Application Variables
	public static String  APP_TITLE = "Pong GDX";
	public static double APP_VERSION = 0.1;
	public static int APP_DESKTOP_WIDTH = 720;
	public static int APP_DESKTOP_HEIGHT = 420;
	public static int APP_FPS = 60;

	// Game Variables
	public static int V_WIDTH = 720;
	public static int V_HEIGHT = 420;

	// Mangagers
	public GameScreenManager gsm;
	public AssetManager assets;

	// Batches
	public SpriteBatch batch;
	public ShapeRenderer shapeRenderer;
	
	@Override
	public void create () {
		batch = new SpriteBatch();
		shapeRenderer = new ShapeRenderer();

		// Setup managers
		assets = new AssetManager();
		gsm = new GameScreenManager(this);
	}

	@Override
	public void render () {
		super.render();

		if (Gdx.input.isKeyPressed(Input.Keys.ESCAPE)) {
			Gdx.app.exit();
		}
	}
	
	@Override
	public void dispose () {
		super.dispose();
		batch.dispose();
		shapeRenderer.dispose();
		assets.dispose();
	}
}

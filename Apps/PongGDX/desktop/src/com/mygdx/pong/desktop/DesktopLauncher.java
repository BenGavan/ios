package com.mygdx.pong.desktop;

import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;
import com.mygdx.pong.Application;

public class DesktopLauncher {
	public static void main (String[] arg) {
		LwjglApplicationConfiguration config = new LwjglApplicationConfiguration();
		config.title = Application.APP_TITLE + " v" + Application.APP_VERSION;
		config.width = Application.APP_DESKTOP_WIDTH;
		config.height = Application.APP_DESKTOP_HEIGHT;
		config.backgroundFPS = Application.APP_FPS;
		config.foregroundFPS = Application.APP_FPS;
		new LwjglApplication(new Application(), config);
	}
}
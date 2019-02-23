package com.mygdx.pong.managers;

import com.mygdx.pong.Application;
import com.mygdx.pong.screens.AbstractScreen;
import com.mygdx.pong.screens.GameScreen;

import java.util.HashMap;

/**
 * Created by ben on 11/07/2017.
 */

public class GameScreenManager {

    public final Application app;

    private HashMap<STATE, AbstractScreen> gameScreens;

    public enum STATE {
        MAIN_MENU,
        PLAY,
        SETTINGS
    }

    public GameScreenManager(final Application app) {
        this.app = app;
        initGameScreen();
        setScreen(STATE.PLAY);
    }

    private void initGameScreen() {
        this.gameScreens = new HashMap<STATE, AbstractScreen>();
        this.gameScreens.put(STATE.PLAY, new GameScreen(app));
    }

    public void setScreen(STATE nextScreen) {
        app.setScreen(gameScreens.get(nextScreen));
    }

    public void dispose() {
        for(AbstractScreen screen : gameScreens.values()) {
            if (screen != null) {
                screen.dispose();
            }
        }
    }

}

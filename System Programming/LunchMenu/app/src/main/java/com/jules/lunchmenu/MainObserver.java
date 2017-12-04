package com.jules.lunchmenu;

import org.json.JSONObject;

/**
 * Created by Jules on 04/10/2017.
 */

public interface MainObserver {
    public void notify(JSONObject content);
}

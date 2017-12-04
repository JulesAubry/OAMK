package com.jules.lunchmenu;

import android.util.Log;

import java.io.IOException;
import org.json.*;
import com.android.volley.*;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
/**
 * Created by Jules on 04/10/2017.
 */

public class MainThread implements Runnable {

    MainObserver m;
    String url;
    RequestQueue q;

    public MainThread(String u, MainObserver o, RequestQueue queue) {
        url = u;
        m = o;
        q = queue;
    }

    @Override
    public void run() {

        JsonObjectRequest jsObjRequest = new JsonObjectRequest
                    (Request.Method.GET, url, (String)null, new Response.Listener<JSONObject>() {

                        @Override
                        public void onResponse(JSONObject response) {
                            m.notify(response);
                        }
                    }, new Response.ErrorListener() {

                        @Override
                        public void onErrorResponse(VolleyError error) {
                            Log.d("W", error.getMessage());
                        }
                    });
        q.add(jsObjRequest);
    }
}

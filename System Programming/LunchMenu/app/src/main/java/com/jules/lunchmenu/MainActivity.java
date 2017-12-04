package com.jules.lunchmenu;

import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.TextView;

import com.android.volley.RequestQueue;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;


public class MainActivity extends AppCompatActivity implements MainObserver {
    private Date today = Calendar.getInstance().getTime();
    private ArrayAdapter<String> adapter;
    private ArrayList<String> arrayList;
    private ArrayList<String> originalArray;
    private Map<String,String> allergens;
    private Map<String,ArrayList<String>> mapListAllergens;
    RequestQueue queue;
    String langage = "en";
    String url = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        allergens = new HashMap<String, String>();
        mapListAllergens = new HashMap<String,ArrayList<String>>();
        arrayList = new ArrayList<String>();
        originalArray = new ArrayList<>();
        adapter = new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple_list_item_1, arrayList);
        ListView list = (ListView)findViewById(R.id.listV);
        list.setAdapter(adapter);

        final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        TextView txt = (TextView)findViewById(R.id.textV);
        txt.append("\r\n" + formatter.format(today));

        queue = Volley.newRequestQueue(getApplicationContext());
        url = "http://www.amica.fi/api/restaurant/menu/day?date=" + formatter.format(today) + "&language=" + langage + "&restaurantPageId=66287";

        final Spinner sp = (Spinner)findViewById(R.id.spin);
        sp.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

            @Override
            public void onItemSelected(AdapterView<?> arg0, View arg1,
                                       int arg2, long arg3) {
                arrayList.clear();
                allergens.clear();
                RadioGroup radioG = (RadioGroup) findViewById(R.id.rG);
                radioG.removeAllViews();

                url = "http://www.amica.fi/api/restaurant/menu/day?date=" + formatter.format(today) + "&language=" + arg0.getItemAtPosition(arg2).toString() + "&restaurantPageId=66287";
                langage = arg0.getItemAtPosition(arg2).toString();
                MainThread main = new MainThread(url, MainActivity.this, queue);
                Thread t = new Thread(main);
                t.start();
            }

            @Override
            public void onNothingSelected(AdapterView<?> arg0) {
                // DO NOTHING

            }

        });

        RadioGroup radioG = (RadioGroup) findViewById(R.id.rG);
        radioG.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener()
        {
            public void onCheckedChanged(RadioGroup group, int checkedId)
            {
                // This will get the radiobutton that has changed in its check state
                RadioButton checkedRadioButton = (RadioButton)group.findViewById(checkedId);
                // This puts the value (true/false) into the variable
                boolean isChecked = checkedRadioButton.isChecked();
                // If the radiobutton that has changed in check state is now checked...
                if (isChecked)
                {
                   /* arrayList.clear();
                    MainThread main = new MainThread(url, MainActivity.this, queue);
                    Thread t = new Thread(main);
                    t.start();*/
                   arrayList.clear();
                   for(int z = 0; z < originalArray.size(); z++) {
                       arrayList.add(originalArray.get(z));
                   }
                    //arrayList.clear();
                    //Collections.copy(arrayList,originalArray);

                    for (Map.Entry<String, ArrayList<String>> entry : mapListAllergens.entrySet())
                    {
                       if(entry.getValue().contains(allergens.get(checkedRadioButton.getText()))){
                           for(int i = 0; i < arrayList.size(); i++) {
                               if(arrayList.get(i).contains(entry.getKey())) {
                                   arrayList.set(i,arrayList.get(i).replace(entry.getKey(), ""));
                                   if(arrayList.get(i).isEmpty()) {
                                       arrayList.remove(i);
                                   }
                                   adapter.notifyDataSetChanged();
                               }
                           }
                       }
                    }
                    adapter.notifyDataSetChanged();

                }
            }
        });
    }

    @Override
    public void notify(JSONObject content) {
        try {
            String meal = "";
            JSONArray array =  content.getJSONObject("LunchMenu").getJSONArray("SetMenus");
            for(int i = 0 ; i < array.length() ; i++){
                JSONArray newA = array.getJSONObject(i).getJSONArray("Meals");
                if(newA.length()> 0) {
                    for (int j = 0; j < newA.length(); j++) {
                        meal += newA.getJSONObject(j).getString("Name");
                        if (j + 1 < newA.length()) {
                            meal += "\r\n";
                        }
                        ArrayList<String> aL = new ArrayList<String>();
                        for (int z = 0; z < newA.getJSONObject(j).getJSONArray("Diets").length(); z++) {
                            aL.add((String) newA.getJSONObject(j).getJSONArray("Diets").get(z));
                        }
                        mapListAllergens.put(newA.getJSONObject(j).getString("Name"),aL);
                    }
                    arrayList.add(meal);
                    //originalArray.add(meal);

                }
                    meal = "";
            }

            RadioGroup radioG = (RadioGroup) findViewById(R.id.rG);
            JSONArray jArrayRequire =  content.getJSONArray("RequireDietFilters");
            for(int i = 0 ; i < jArrayRequire.length() ; i++){
                RadioButton rbn = new RadioButton(this);
                rbn.setId(i + 1000);
                rbn.setText(jArrayRequire.getJSONObject(i).getString("TranslatedName"));
                allergens.put(jArrayRequire.getJSONObject(i).getString("TranslatedName"), jArrayRequire.getJSONObject(i).getString("Diet"));
                radioG.addView(rbn);
            }

            JSONArray jArrayExclude =  content.getJSONArray("ExcludeDietFilters");
            for(int i = 0 ; i < jArrayExclude.length() ; i++){
                RadioButton rbn = new RadioButton(this);
                rbn.setId(i + 1000);
                rbn.setText(jArrayExclude.getJSONObject(i).getString("TranslatedName"));
                allergens.put(jArrayExclude.getJSONObject(i).getString("TranslatedName"), jArrayExclude.getJSONObject(i).getString("Diet"));
                radioG.addView(rbn);
            }

            JSONArray jArrayRestaurant =  content.getJSONArray("RestaurantDietFilters");
            for(int i = 0 ; i < jArrayRestaurant.length() ; i++){
                RadioButton rbn = new RadioButton(this);
                rbn.setId(i + 1000);
                rbn.setText(jArrayRestaurant.getJSONObject(i).getString("TranslatedName"));
                allergens.put(jArrayRestaurant.getJSONObject(i).getString("TranslatedName"), jArrayRestaurant.getJSONObject(i).getString("Diet"));
                radioG.addView(rbn);
            }
            originalArray = new ArrayList<>(arrayList);
            adapter.notifyDataSetChanged();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

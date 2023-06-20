package com.NHNUniversity.MyCurrency.Model;

import android.util.Log;
import android.view.View;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ApiManager{
    private ICallback callback;
    private String base_URL;
    private String respose;

    public ApiManager(final String URL, ICallback listener){
            this.base_URL = URL;
            this.respose = "";
            this.callback = listener;
    }

    //https://api.currencyapi.com/v3/latest?apikey=UVIYwWtpIkaXUIcuWqUxpWW2tLpTCPzggx7PI2F2&currencies=HUF&base_currency=USD
    public void sendAPI(View view, String currencies, String base_currencies, String key){
        Thread t = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    base_URL = base_URL+key+currencies+base_currencies;
                    Log.i("", base_URL);
                    URL url = new URL(base_URL);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");

                    // Lettura della risposta
                    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String line;
                    StringBuilder response_builder = new StringBuilder();
                    while ((line = reader.readLine()) != null) {
                        response_builder.append(line);
                    }
                    reader.close();
                    respose = response_builder.toString();
                    conn.disconnect();
                } catch (Exception e) {
                    respose = null;
                }

                callback.callBack(respose, view);
            }
        });
        t.start();
    }

    //https://api.currencyapi.com/v3/historical?apikey=UVIYwWtpIkaXUIcuWqUxpWW2tLpTCPzggx7PI2F2&currencies=GBP&base_currency=EUR&date=2022-02-23
    public void sendHAPI(View view, String currencies, String base_currencies, String date, String key){
        Thread t = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    base_URL = base_URL+key+currencies+base_currencies+date;
                    Log.i("", base_URL);
                    URL url = new URL(base_URL);
                    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                    conn.setRequestMethod("GET");

                    // Lettura della risposta
                    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String line;
                    StringBuilder response_builder = new StringBuilder();
                    while ((line = reader.readLine()) != null) {
                        response_builder.append(line);
                    }
                    reader.close();
                    respose = response_builder.toString();
                    conn.disconnect();
                } catch (Exception e) {
                    respose = null;
                }

                callback.callBack(respose, view);
            }
        });
        t.start();
    }
}

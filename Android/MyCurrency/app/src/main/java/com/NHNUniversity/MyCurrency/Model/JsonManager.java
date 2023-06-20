package com.NHNUniversity.MyCurrency.Model;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import android.content.Context;

import java.io.FileOutputStream;

public class JsonManager{
    private JsonObject deserialize(String json){
        Gson gson = new Gson();
        return gson.fromJson(json, JsonObject.class);
    }

    public double get_value_from_json(String json, String currency_result){
        JsonObject jsonObject = deserialize(json);

        double value = jsonObject.get("data")
                .getAsJsonObject()
                .get(currency_result)
                .getAsJsonObject()
                .get("value")
                .getAsDouble();

        return value;
    }

    public boolean serialize(Object obj, Context context, String filename){
        Gson gson = new Gson();
        String json_content = gson.toJson(obj);

        try {
            FileOutputStream fos = context.openFileOutput(filename, Context.MODE_PRIVATE);
            fos.write(json_content.getBytes());
            fos.close();
        }catch (Exception e){
            return false;
        }
        return true;
    }
}

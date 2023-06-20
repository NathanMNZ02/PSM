package com.NHNUniversity.MyCurrency.Fragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;

import com.NHNUniversity.MyCurrency.Model.ApiManager;
import com.NHNUniversity.MyCurrency.Model.Currency;
import com.NHNUniversity.MyCurrency.Model.ICallback;
import com.NHNUniversity.MyCurrency.Model.JsonManager;
import com.NHNUniversity.MyCurrency.R;

public class MainView_Fragment extends Fragment {
    private Currency start_currency;
    private Currency final_currency;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.main_fragment, container, false);

        SharedPreferences sharedPreferences = getContext().getSharedPreferences("Favourite", Context.MODE_PRIVATE);
        start_currency = new Currency(sharedPreferences.getInt("start_index", 0));
        final_currency = new Currency(sharedPreferences.getInt("final_index", 0));

        set_textviewUI(view);
        set_arrow_buttonUI(view);
        set_favourite_buttonUI(view);
        set_exchange_buttonUI(view);
        return view;
    }

    //region UI setup
    //region exchange btn setup
    public void set_exchange_buttonUI(View view){
        TextView start_text = (TextView) view.findViewById(R.id.start_txt);
        TextView final_text = (TextView) view.findViewById(R.id.final_txt);
        EditText start_editor = (EditText) view.findViewById(R.id.start_value);
        EditText final_editor = (EditText) view.findViewById(R.id.final_value);

        Button exchange_button = (Button) view.findViewById(R.id.exchange_btn);
        exchange_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if(start_editor.getText().length() == 0)
                    return;

                for(int i = 0; i < start_editor.getText().length(); ++i){
                    if(start_editor.getText().charAt(i) < 47 || start_editor.getText().charAt(i) > 59){
                        new AlertDialog.Builder(view.getContext())
                                .setTitle("MyCurrency")
                                .setMessage("The conversion can only be done on numeric types")
                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        dialog.cancel();
                                    }
                                })
                                .show();

                        return;
                    }
                }

                ApiManager api_manager = new ApiManager("https://api.currencyapi.com/v3/latest?", new ICallback() {
                    @Override
                    public void callBack(String response, View view) {
                        double value = 0;
                        if(response != null){
                            JsonManager json_manager = new JsonManager();
                            value = json_manager.get_value_from_json( response,final_text.getText().toString());
                        }else{
                            new Handler(Looper.getMainLooper()).post(new Runnable () {
                                @Override
                                public void run () {
                                    new AlertDialog.Builder(view.getContext())
                                            .setTitle("MyCurrency")
                                            .setMessage("There was a connection error, we apologize for the inconvenience, try again or contact support nathan.monzani@studenti.unipr.it")
                                            .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                public void onClick(DialogInterface dialog, int which) {
                                                    dialog.cancel();
                                                }
                                            })
                                            .show();
                                }
                            });
                        }

                        if(value != 0){
                            double start_value = Double.parseDouble(start_editor.getText().toString());
                            double result = start_value*value;

                            new Handler(Looper.getMainLooper()).post(new Runnable () {
                                @Override
                                public void run () {
                                    final_editor.setText(Double.toString(result));
                                }
                            });
                        }
                    }
                });

                api_manager.sendAPI(view, "&currencies="+final_text.getText().toString(), "&base_currency="+start_text.getText().toString(), "apikey=UVIYwWtpIkaXUIcuWqUxpWW2tLpTCPzggx7PI2F2");
            }
        });
    }
    //endregion

    //region favourite btn setup
    public void set_favourite_buttonUI(View view){
        Button favourite_not_colored = (Button) view.findViewById(R.id.favourite_btn_not_colored);
        favourite_not_colored.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Button favourite_colored = (Button) view.findViewById(R.id.favourite_btn_colored);
                favourite_not_colored.setVisibility(View.INVISIBLE);
                favourite_colored.setVisibility(View.VISIBLE);

                SharedPreferences sharedPreferences = getContext().getSharedPreferences("Favourite", Context.MODE_PRIVATE);
                SharedPreferences.Editor editor = sharedPreferences.edit();
                editor.putInt("start_index", start_currency.get_index());
                editor.putInt("final_index", final_currency.get_index());
                editor.apply();
            }
        });

        Button favourite_colored = (Button) view.findViewById(R.id.favourite_btn_colored);
        favourite_colored.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Button favourite_not_colored = (Button) view.findViewById(R.id.favourite_btn_not_colored);
                favourite_not_colored.setVisibility(View.VISIBLE);
                favourite_colored.setVisibility(View.INVISIBLE);

                SharedPreferences sharedPreferences = getContext().getSharedPreferences("Favourite", Context.MODE_PRIVATE);
                SharedPreferences.Editor editor = sharedPreferences.edit();
                editor.putInt("start_index", 0);
                editor.putInt("final_index", 0);
                editor.apply();
            }
        });
    }
    //endregion

    //region textview setup
    public void set_textviewUI(View view){
        TextView start_text = (TextView) view.findViewById(R.id.start_txt);
        TextView final_text = (TextView) view.findViewById(R.id.final_txt);
        TextView start_name_text = (TextView) view.findViewById(R.id.start_name_txt);
        TextView final_name_text = (TextView) view.findViewById(R.id.final_name_txt);

        final String[] start_currency_values = start_currency.get_actual();
        final String[] final_currency_values = final_currency.get_actual();

        start_text.setText(start_currency_values[0]);
        start_name_text.setText(start_currency_values[1]);

        final_text.setText(final_currency_values[0]);
        final_name_text.setText(final_currency_values[1]);
    }
    //endregion

    //region arrow btn setup
    public void set_arrow_buttonUI(View view){
        ImageButton start_left = (ImageButton) view.findViewById(R.id.start_lf_ibtn);
        start_left.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                start_currency.next();
                TextView start_text = (TextView) view.findViewById(R.id.start_txt);
                TextView start_name_text = (TextView) view.findViewById(R.id.start_name_txt);

                final String[] start_currency_values = start_currency.get_actual();

                start_text.setText(start_currency_values[0]);
                start_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton start_right = (ImageButton) view.findViewById(R.id.start_rg_ibtn);
        start_right.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                start_currency.previous();
                TextView start_text = (TextView) view.findViewById(R.id.start_txt);
                TextView start_name_text = (TextView) view.findViewById(R.id.start_name_txt);

                final String[] start_currency_values = start_currency.get_actual();

                start_text.setText(start_currency_values[0]);
                start_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton final_left = (ImageButton) view.findViewById(R.id.final_lf_ibtn);
        final_left.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final_currency.next();
                TextView final_text = (TextView) view.findViewById(R.id.final_txt);
                TextView final_name_text = (TextView) view.findViewById(R.id.final_name_txt);

                final String[] start_currency_values = final_currency.get_actual();

                final_text.setText(start_currency_values[0]);
                final_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton final_right = (ImageButton) view.findViewById(R.id.final_rg_ibtn);
        final_right.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final_currency.previous();
                TextView final_text = (TextView) view.findViewById(R.id.final_txt);
                TextView final_name_text = (TextView) view.findViewById(R.id.final_name_txt);

                final String[] start_currency_values = final_currency.get_actual();

                final_text.setText(start_currency_values[0]);
                final_name_text.setText(start_currency_values[1]);
            }
        });
    }
    //endregion
    //endregion
}

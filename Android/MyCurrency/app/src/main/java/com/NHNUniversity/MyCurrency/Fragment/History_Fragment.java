package com.NHNUniversity.MyCurrency.Fragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CalendarView;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;

import com.NHNUniversity.MyCurrency.Model.ApiManager;
import com.NHNUniversity.MyCurrency.Model.Currency;
import com.NHNUniversity.MyCurrency.Model.ICallback;
import com.NHNUniversity.MyCurrency.Model.JsonManager;
import com.NHNUniversity.MyCurrency.R;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Calendar;
import java.util.Date;

public class History_Fragment extends Fragment {
    private String selected_date;
    private Currency start_currency;
    private Currency final_currency;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        super.onCreateView(inflater, container, savedInstanceState);
        View view = inflater.inflate(R.layout.history_fragment, container, false);

        SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");
        selected_date = date_format.format(new Date(System.currentTimeMillis()-24*60*60*1000));
        start_currency = new Currency();
        final_currency = new Currency();

        set_textviewUI(view);
        set_arrow_buttonUI(view);
        set_exchange_rate_btnUI(view);
        return view;
    }

    //region UI setup
    //region exchange btn setup
    //https://api.currencyapi.com/v3/historical?&currencies=EUR&base_currency=AFN&date=2023-06-19
    private void set_exchange_rate_btnUI(View view){
            TextView start_text = (TextView) view.findViewById(R.id.start_h_txt);
            TextView final_text = (TextView) view.findViewById(R.id.final_h_txt);
            CalendarView calendar = (CalendarView) view.findViewById(R.id.picker_date);
            calendar.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
                @Override
                public void onSelectedDayChange(CalendarView view, int year, int month, int dayOfMonth) {
                    selected_date = year+"-"+(month+1)+"-"+dayOfMonth;
                }
            });

            Calendar temp_calendar = Calendar.getInstance();
            calendar.setMaxDate(temp_calendar.getTimeInMillis());
            Button exchange_rate_btn = (Button) view.findViewById(R.id.exchange_rate_btn);

            exchange_rate_btn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    ApiManager api_manager = new ApiManager("https://api.currencyapi.com/v3/historical?", new ICallback() {
                        @Override
                        public void callBack(String response, View view) {
                            double value = 0;
                            if(response != null){
                                JsonManager json_manager = new JsonManager();
                                value = json_manager.get_value_from_json(response, final_text.getText().toString());
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
                                double finalValue = value;
                                new Handler(Looper.getMainLooper()).post(new Runnable() {
                                    @Override
                                    public void run() {
                                        new AlertDialog.Builder(view.getContext())
                                                .setTitle("MyCurrency")
                                                .setMessage("The exchange rate was "+ finalValue)
                                                .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
                                                    public void onClick(DialogInterface dialog, int which) {
                                                        dialog.cancel();
                                                    }
                                                })
                                                .show();
                                    }
                                });
                            }
                        }

                    });
                    api_manager.sendHAPI(view, "&currencies="+final_text.getText().toString(), "&base_currency="+start_text.getText().toString(), "&date="+selected_date,"apikey=UVIYwWtpIkaXUIcuWqUxpWW2tLpTCPzggx7PI2F2");
                }

        });
    }
    //endregion

    //region textview setup
    private void set_textviewUI(View view){
        TextView start_text = (TextView) view.findViewById(R.id.start_h_txt);
        TextView final_text = (TextView) view.findViewById(R.id.final_h_txt);
        TextView start_name_text = (TextView) view.findViewById(R.id.start_name_htxt);
        TextView final_name_text = (TextView) view.findViewById(R.id.final_name_htxt);

        final String[] start_currency_values = start_currency.get_actual();
        final String[] final_currency_values = final_currency.get_actual();

        start_text.setText(start_currency_values[0]);
        start_name_text.setText(start_currency_values[1]);

        final_text.setText(final_currency_values[0]);
        final_name_text.setText(final_currency_values[1]);
    }
    //endregion

    //region arrow btn setup
    private void set_arrow_buttonUI(View view){
        ImageButton start_left = (ImageButton) view.findViewById(R.id.start_lf_hbtn);
        start_left.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                start_currency.next();
                TextView start_text = (TextView) view.findViewById(R.id.start_h_txt);
                TextView start_name_text = (TextView) view.findViewById(R.id.start_name_htxt);

                final String[] start_currency_values = start_currency.get_actual();

                start_text.setText(start_currency_values[0]);
                start_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton start_right = (ImageButton) view.findViewById(R.id.start_rg_hbtn);
        start_right.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                start_currency.previous();
                TextView start_text = (TextView) view.findViewById(R.id.start_h_txt);
                TextView start_name_text = (TextView) view.findViewById(R.id.start_name_htxt);

                final String[] start_currency_values = start_currency.get_actual();

                start_text.setText(start_currency_values[0]);
                start_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton final_left = (ImageButton) view.findViewById(R.id.final_lf_hbtn);
        final_left.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final_currency.next();
                TextView final_text = (TextView) view.findViewById(R.id.final_h_txt);
                TextView final_name_text = (TextView) view.findViewById(R.id.final_name_htxt);

                final String[] start_currency_values = final_currency.get_actual();

                final_text.setText(start_currency_values[0]);
                final_name_text.setText(start_currency_values[1]);
            }
        });

        ImageButton final_right = (ImageButton) view.findViewById(R.id.final_rg_hbtn);
        final_right.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final_currency.previous();
                TextView final_text = (TextView) view.findViewById(R.id.final_h_txt);
                TextView final_name_text = (TextView) view.findViewById(R.id.final_name_htxt);

                final String[] start_currency_values = final_currency.get_actual();

                final_text.setText(start_currency_values[0]);
                final_name_text.setText(start_currency_values[1]);
            }
        });
    }
    //endregion
    //endregion
}

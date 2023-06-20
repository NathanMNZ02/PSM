package com.NHNUniversity.MyCurrency;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import androidx.appcompat.widget.Toolbar;

import com.NHNUniversity.MyCurrency.Fragment.History_Fragment;
import com.NHNUniversity.MyCurrency.Fragment.MainView_Fragment;
import com.google.android.material.tabs.TabItem;
import com.google.android.material.tabs.TabLayout;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        set_toolbarUI();
        set_table_view_itemUI();

        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
        MainView_Fragment fragment = new MainView_Fragment();
        fragmentTransaction.replace(R.id.mc_frame_containter, fragment);
        fragmentTransaction.commit();
    }

    private void set_toolbarUI(){
        Toolbar toolbar = (Toolbar)findViewById(R.id.mc_toolbar);
        toolbar.setTitle("MyCurrency");
        setSupportActionBar(toolbar);
    }

    private void set_table_view_itemUI(){
        TabLayout tab_layout = (TabLayout) findViewById(R.id.tab_layout);

        tab_layout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                Log.i("", "MMM");
                if(tab.getPosition() == 1){

                    FragmentManager fragmentManager = getSupportFragmentManager();
                    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                    History_Fragment fragment = new History_Fragment();
                    fragmentTransaction.replace(R.id.mc_frame_containter, fragment);
                    fragmentTransaction.commit();
                }

                if(tab.getPosition() == 0){
                    FragmentManager fragmentManager = getSupportFragmentManager();
                    FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                    MainView_Fragment fragment = new MainView_Fragment();
                    fragmentTransaction.replace(R.id.mc_frame_containter, fragment);
                    fragmentTransaction.commit();
                }
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {

            }
        });
    }
}
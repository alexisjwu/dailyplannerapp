package com.example.planni5;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class SecondActivity extends AppCompatActivity {

    private Button calendar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);

        calendar = (Button)findViewById(R.id.calendarButton);

        calendar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                accessCalendar();
            }
        });

    }
    private void accessCalendar(){
        Intent intent = new Intent(SecondActivity.this, CalendarActivity.class);
        startActivity(intent);
    }
}
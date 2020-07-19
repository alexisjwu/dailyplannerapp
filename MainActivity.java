package com.example.planni5;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private EditText username;
    private EditText password;
    private TextView instructions;
    private Button login;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        username = (EditText)findViewById(R.id.usernameTextbox);
        password = (EditText)findViewById(R.id.passwordTextbox);
        instructions = (TextView)findViewById(R.id.instructions);
        login = (Button)findViewById(R.id.logInButton);

        instructions.setText("Please enter username and password");

        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                validate(username.getText().toString(), password.getText().toString());
            }
        });
    }

    private void validate(String userName, String passWord){
        if((userName.equals("username")) && (passWord.equals("password"))){
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivity(intent);
        }
        else{
            instructions.setText("Wrong username or password");
            //login.setEnabled(false);
        }
    }
}
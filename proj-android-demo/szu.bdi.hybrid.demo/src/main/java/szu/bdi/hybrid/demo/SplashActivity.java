package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {

        //close self after 3 sec
        int secondsDelayed = 3;
        new Handler().postDelayed(new Runnable() {
            public void run() {
                finish();
            }
        }, secondsDelayed * 1000);

        setContentView(R.layout.splash);

        //IMPORTANT call super after mine is done is better feel
        super.onCreate(savedInstanceState);
    }
}
package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {

        setContentView(R.layout.splash);

        //close self after 1 sec
        new Handler().postDelayed(new Runnable() {
            public void run() {
                finish();
            }
        }, 3 * 1000);

        //IMPORTANT： call super at last
        super.onCreate(savedInstanceState);
    }
}
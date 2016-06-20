package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {

        //close self after 3 sec
        new Handler().postDelayed(new Runnable() {
            public void run() {
                finish();
            }
        }, 3 * 1000);

        setContentView(R.layout.splash);

        //IMPORTANT： call super at last
        super.onCreate(savedInstanceState);
    }
}
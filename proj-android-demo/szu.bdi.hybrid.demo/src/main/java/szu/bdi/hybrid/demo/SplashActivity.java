package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;

public class SplashActivity extends Activity {
//    private static boolean splashLoaded = false;

    @Override
    public void onCreate(Bundle savedInstanceState) {

//        if (!splashLoaded) {
//        setContentView(R.layout.splash);
        int secondsDelayed = 6;
        new Handler().postDelayed(new Runnable() {
            public void run() {
                finish();
            }
        }, secondsDelayed * 500);
//            splashLoaded = true;
//        } else {
//            Intent goToMainActivity = new Intent(SplashActivity.this, MainActivity.class);
//            goToMainActivity.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
//            startActivity(goToMainActivity);
//            finish();
//        }
//        setTheme(R.style.Theme_SplashAct);
        setContentView(R.layout.splash);
        super.onCreate(savedInstanceState);

    }
}
package szu.bdi.hybrid.demo;

import android.app.Application;

import szu.bdi.hybrid.core.HybridTools;

//NOTES: must have an applicaton, otherwise data e.g.  app context maybe cleaned up by GC !!!!

public class HybridDemoApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        HybridTools.setAppContext(getApplicationContext());
    }
}


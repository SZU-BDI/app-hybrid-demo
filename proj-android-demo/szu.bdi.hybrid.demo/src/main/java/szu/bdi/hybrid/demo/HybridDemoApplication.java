package szu.bdi.hybrid.demo;

import android.app.Application;
import android.util.Log;

import szu.bdi.hybrid.core.HybridTools;

//NOTES: must have an applicaton, otherwise data e.g.  app context maybe cleaned up by GC !!!!

public class HybridDemoApplication extends Application {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    @Override
    public void onCreate() {
        super.onCreate();
        Log.v(LOGTAG, "App.onCreate");
        HybridTools.setAppContext(getApplicationContext());
    }
}


package szu.bdi.hybrid.demo;

import android.app.Application;
import android.os.Handler;
import android.os.StrictMode;
import android.util.Log;

import szu.bdi.hybrid.core.HybridTools;

public class AppTools extends HybridTools {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void KillAppSelf() {
        int pid = android.os.Process.myPid();
        Log.d(LOGTAG, "kill and quit pid=" + pid);

        android.os.Process.killProcess(pid);
        System.exit(0);
    }

    protected static Application _app = null;

    public static void setApplication(Application app) {
        if (app != null)
            _app = app;
    }

    public static Application getApplication() {
        return _app;
    }

    //@ref http://stackoverflow.com/questions/8258725/strict-mode-in-android-2-2
    //StrictMode.ThreadPolicy was introduced since API Level 9 and the default thread policy had been changed since API Level 11,
    // which in short, does not allow network operation (eg: HttpClient and HttpUrlConnection)
    // get executed on UI thread. If you do this, you get NetworkOnMainThreadException.
    public static void uiNeedNetworkPolicyHack() {
        int _sdk_int = android.os.Build.VERSION.SDK_INT;
        if (_sdk_int > 8) {
            try {
                Log.d(LOGTAG, "setThreadPolicy for api level " + _sdk_int);
                StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
                StrictMode.setThreadPolicy(policy);
            } catch (Throwable t) {
                t.printStackTrace();
            }
        }
    }

    public static void quit(boolean playMedia) {
        flagAppWorking = false;//wlll affect the bg service

        quickShowMsgMain("Quiting...");
        Log.d(LOGTAG, "quit " + playMedia);

//        if (playMedia) {
//            try {
//                mp.reset();
//                Uri uu = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE);
////                    Log.d(LOGTAG, "Uri=" + uu.toString());
//                mp.setDataSource(_appContext, uu);
//                mp.setOnPreparedListener(preparedListener);
//                //mp.prepareAsync();
//                mp.prepare();
//            } catch (IllegalStateException | IOException e) {
//                playMedia = false;
//                e.printStackTrace();
//            }
//        }

        new Handler().postDelayed(new Runnable() {
            public void run() {
                KillAppSelf();
            }
        }, (playMedia) ? 5000 : 2500);
    }
}

package szu.bdi.hybrid.demo;

import android.app.Application;
import android.content.Context;
import android.os.Build;
import android.os.StrictMode;
import android.util.Log;

import org.json.JSONObject;

import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.HybridUi;

//import com.hybrid.core.UiRoot;

public class DemoApp extends Application {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main() {
        int _sdk_int = android.os.Build.VERSION.SDK_INT;

        if (_sdk_int < Build.VERSION_CODES.KITKAT) {
            HybridTools.quickShowMsgMain("Your Phone is too old (API " + _sdk_int + ")... May not stable");
        }

        //NOTES: for main thread (could) using network, do a policy hack config
        if (_sdk_int > 9) {
            Log.d(LOGTAG, "setThreadPolicy for " + _sdk_int);
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        //get the config from assets

        String sJsonConf = HybridTools.assetFile2Str("config.json");
        Log.v(LOGTAG, "config.json=" + sJsonConf);
        JSONObject o = HybridTools.s2o(sJsonConf);
        Log.v(LOGTAG, "config.json.o=" + o);
        if (!HybridTools.isEmptyString(o.optString("ermsg"))) {
            HybridTools.quickShowMsgMain("Wrong Config File");
            HybridTools.quit(false);
        } else {
            HybridTools.jsonConfig = o;
        }

        //Start a UI (UiRoot) in full screen but bar.
        HybridUi ui = HybridTools.getHybridUi("UiRoot");
        //TODO style..
        //ui.style=STYLE_FULL_WITH_HEAD;
        //TODO load uri
        //"file://android_asset/root.htm"
        HybridTools.showUi(ui, null);

//TODO
// to run a backgroup service to check network
//Intent bg = new Intent(getApplicationContext(), DemoBackgroundService.class);
//this.startService(bg);
    }

    @Override
    public void onCreate() {
        super.onCreate();

        //IMPORTANT...STORE the app context into the hybrid service for later use.
        Context _appContext = getApplicationContext();
        HybridTools.setAppContext(_appContext);

        Log.v(LOGTAG, "Application.onCreate");
    }
}

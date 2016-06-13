package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.StrictMode;
import android.util.Log;

import org.json.JSONObject;

import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.HybridUi;

public class EntryActivity extends Activity {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main(Activity entryAct) {
        //IMPORTANT...STORE the app context into the hybrid service for later use.
        Context _appContext = entryAct.getApplicationContext();
        HybridTools.setAppContext(_appContext);

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

        //get the config
        final String sJsonConf = HybridTools.getFileIntoStr("config.json");
        final JSONObject o = HybridTools.s2o(sJsonConf);
        if (!HybridTools.isEmptyString(o.optString("errmsg"))) {
            HybridTools.appAlert(entryAct, "Wrong Config File", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    Log.v(LOGTAG, "config.json=" + sJsonConf);
                    Log.v(LOGTAG, "config.json.o=" + o);
                    //HybridTools.quit(false);
                    HybridTools.KillAppSelf();//so violent
                }
            });
            //HybridTools.quickShowMsgMain("Wrong Config File");
//            HybridTools.quit(false);
        } else {
            HybridTools.jsonConfig = o;

            HybridUi ui = HybridTools.getHybridUi("UiRoot");
            HybridTools.showUi(ui);
            //ui.setUiData("url", "file:///android_asset/root.htm");

////            Context _ctx = HybridTools.getAppContext();
//            Intent intent = new Intent(_appContext, ui.getClass());
//            //intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
//            _appContext.startActivity(intent);

            entryAct.finish();

//TODO
// to run a backgroup service to check network
//Intent bg = new Intent(getApplicationContext(), DemoBackgroundService.class);
//this.startService(bg);
        }
    }

    protected void fwdToMain() {
        main(this);
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.v(LOGTAG, ".onStart()");
        fwdToMain();
    }

    @Override
    protected void onResume() {
        Log.v(LOGTAG, ".onResume()");
        super.onResume();
        fwdToMain();
    }

}

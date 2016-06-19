package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.Build;
import android.util.Log;

import org.json.JSONObject;

import java.io.File;

import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.WebViewUi;

public class EntryActivity extends Activity {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main(Activity entryAct) {

        //IMPORTANT...STORE the app context into the hybrid service for later use.
        HybridTools.setAppContext(entryAct.getApplicationContext());

        int _sdk_int = android.os.Build.VERSION.SDK_INT;

        if (_sdk_int < Build.VERSION_CODES.KITKAT) {
            HybridTools.quickShowMsgMain("Your Phone is too old (API " + _sdk_int + ")... May not stable");
        }

        HybridTools.uiNeedNetworkPolicyHack();

        final String sJsonConf = HybridTools.readAssetInStr("config.json");
        final JSONObject o = HybridTools.s2o(sJsonConf);
        if (o == null) {
            HybridTools.appAlert(entryAct, "Wrong Config File", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    Log.v(LOGTAG, "config.json=" + sJsonConf);
                    HybridTools.KillAppSelf();//violent
                }
            });
        } else {
            HybridTools.jsonConfig = o;

//            HybridUi ui = HybridTools.getHybridUi("UiRoot");
//            HybridTools.showUi(ui);

            File app_cache_dir_f = HybridTools.getAppContext().getCacheDir();
            String app_cache_dir_s = app_cache_dir_f.getAbsolutePath();

            File root_htm_f = new File(app_cache_dir_s + "/web/root.htm");
//            if (!root_htm_f.exists()) {
            //Log.v(LOGTAG, "copy files to " + app_cache_dir_s);
            HybridTools.copyAssetFolder(HybridTools.getAppContext().getAssets(), "web", app_cache_dir_s + "/web");
            //HybridTools.copyAsset(HybridTools.getAppContext().getAssets(), "root.htm", app_cache_dir_s + "/root.htm");
//            }
            if (!root_htm_f.exists()) {
                HybridTools.appAlert(entryAct, "Failed Init", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        HybridTools.KillAppSelf();//so violent
                    }
                });
            }
            String root_htm_s = "file://" + root_htm_f.getAbsolutePath();
            Log.v(LOGTAG, "root_htm_s=" + root_htm_s);
            HybridTools.startUi("UiRoot", "{topbar:'N',url:" + root_htm_s + "}", entryAct, WebViewUi.class);

            entryAct.finish();

//TODO
// to run a backgroup service to check network
//HybridTools.startService(??)
//Intent bg = new Intent(getApplicationContext(), DemoBackgroundService.class);
//this.startService(bg);
        }
    }

    protected void fwdToMain() {
        main(this);
    }

    protected static Object _is_main_init = false;

    @Override
    protected void onStart() {
        super.onStart();
        synchronized (_is_main_init) {
            if (_is_main_init == true) return;
            _is_main_init = true;
        }
        Log.v(LOGTAG, ".onStart()");
        fwdToMain();
    }

    @Override
    protected void onResume() {
        Log.v(LOGTAG, ".onResume()");
        super.onResume();
        synchronized (_is_main_init) {
            if (_is_main_init == true) return;
            _is_main_init = true;
        }
        fwdToMain();
    }

}

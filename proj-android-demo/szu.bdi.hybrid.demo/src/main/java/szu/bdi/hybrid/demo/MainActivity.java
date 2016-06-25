package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.util.Log;

import org.json.JSONObject;

import java.io.File;

import szu.bdi.hybrid.core.HybridTools;

public class MainActivity extends Activity {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main(final Activity _entryAct) {
        Log.v(LOGTAG, "main()");

        //IMPORTANT...STORE the app context into the hybrid service for later use.
        HybridTools.setAppContext(_entryAct.getApplicationContext());

        int _sdk_int = android.os.Build.VERSION.SDK_INT;

        if (_sdk_int < Build.VERSION_CODES.KITKAT) {
            //HybridTools.quickShowMsgMain("Your Phone (API=\" + _sdk_int + \") is too old !!!! ");
            HybridTools.quickShowMsgMain("Your Phone is too old...");
        }

        HybridTools.uiNeedNetworkPolicyHack();

        final String sJsonConf = HybridTools.readAssetInStr("config.json");
        final JSONObject o = HybridTools.s2o(sJsonConf);
        if (o == null) {
            HybridTools.appAlert(_entryAct, "Wrong Config File", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    Log.v(LOGTAG, "config.json=" + sJsonConf);
                    HybridTools.KillAppSelf();//violent
                }
            });
        } else {
            Context _appContext = HybridTools.getAppContext();
            HybridTools.initAppConfig(o);

            String app_ver = (String) HybridTools.getAppConfig("app_ver");
            if (null == app_ver) app_ver = "";

            String app_ver_saved = HybridTools.getSavedSetting(_appContext, "APP", "app_ver");
            if (app_ver_saved == null) app_ver_saved = "";

            String isFirstLoad = HybridTools.getSavedSetting(_appContext, "APP", "isFirstLoad");

            HybridTools.saveSetting(_appContext, "APP", "isFirstLoad", "N");
            HybridTools.saveSetting(_appContext, "APP", "app_ver", app_ver);

            //isFirstLoad = "";//test only
            //HybridTools.quickShowMsgMain("isFirstLoad=" + isFirstLoad);

            //if the init htm not exists, copy from assets
            File app_cache_dir_f = HybridTools.getAppContext().getCacheDir();
            String app_cache_dir_s = app_cache_dir_f.getAbsolutePath();
            File root_htm_f = new File(app_cache_dir_s + "/web/root.htm");

//TODO if exists, check file size...
            //TODO also check the version, if version different, copy too!

            if (!root_htm_f.exists() || !"N".equals(isFirstLoad) || !app_ver_saved.equals(app_ver)) {
                Log.v(LOGTAG, "copy files to " + app_cache_dir_s);
                HybridTools.copyAssetFolder(HybridTools.getAppContext().getAssets(), "web", app_cache_dir_s + "/web");
            }

            if (!root_htm_f.exists()) {
                HybridTools.appAlert(_entryAct, "Failed Init", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        HybridTools.KillAppSelf();//so violent
                    }
                });
            } else {
                //important: store the localWebRoot for later usage
                HybridTools.localWebRoot = app_cache_dir_s + "/web/";

                HybridTools.startUi("UiRoot", "", _entryAct);

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        //call a splash to cover the UI for view seconds
                        _entryAct.startActivity(new Intent(_entryAct, SplashActivity.class));

                        //TODO
                        // to run a longtime backgroup service if needed...
                        //Intent bg = new Intent(getApplicationContext(), DemoBackgroundService.class);
                        //_entryAct.startService(bg);

                        //close the entry act (so that the UiRoot is on top now)
                        _entryAct.finish();
                    }
                }, 1);

            }

        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.v(LOGTAG, ".onStart()");

        main(this);
    }

}

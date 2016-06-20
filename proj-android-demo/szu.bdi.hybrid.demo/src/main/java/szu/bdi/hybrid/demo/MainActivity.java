package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.util.Log;

import org.json.JSONObject;

import java.io.File;

import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.WebViewUi;

public class MainActivity extends Activity {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main(final Activity entryAct) {

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
            HybridTools.initAppConfig(o);

            //if the init htm not exists, copy from assets
            File app_cache_dir_f = HybridTools.getAppContext().getCacheDir();
            String app_cache_dir_s = app_cache_dir_f.getAbsolutePath();
            File root_htm_f = new File(app_cache_dir_s + "/web/root.htm");
            if (!root_htm_f.exists()) {
                Log.v(LOGTAG, "copy files to " + app_cache_dir_s);
                HybridTools.copyAssetFolder(HybridTools.getAppContext().getAssets(), "web", app_cache_dir_s + "/web");
            }
            if (!root_htm_f.exists()) {
                HybridTools.appAlert(entryAct, "Failed Init", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        HybridTools.KillAppSelf();//so violent
                    }
                });
            } else {
                HybridTools.localWebRoot = app_cache_dir_s + "/web/";

                resumeUi(entryAct);

                //TODO
// to run a backgroup service to check network
//HybridTools.startService(??)
////Intent bg = new Intent(getApplicationContext(), DemoBackgroundService.class);
////this.startService(bg);

            }

        }
    }

    private static void resumeUi(final Activity entryAct) {
        String root_htm_s = "file://" + HybridTools.localWebRoot + "root.htm";
        Log.v(LOGTAG, "root_htm_s=" + root_htm_s);
        HybridTools.startUi("UiRoot", "{topbar:'N',url:'" + root_htm_s + "'}", entryAct, WebViewUi.class);

        entryAct.finish();
        //start a splash to overlap (which will auto close after seconds)
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                entryAct.startActivity(new Intent(entryAct, SplashActivity.class));
            }
        }, 1);
    }

    protected void fwdToMain() {
        main(this);
    }

//    protected static Object _is_main_init = false;

    @Override
    protected void onStart() {
        super.onStart();
        Log.v(LOGTAG, ".onStart()");
//        synchronized (_is_main_init) {
//            if (_is_main_init == null) {
//                _is_main_init = true;
//                fwdToMain();
//            }
//        }
        fwdToMain();
    }

    @Override
    protected void onResume() {
        Log.v(LOGTAG, ".onResume()");
        super.onResume();
        //fwdToMain();
//        resumeUi(this);

//        synchronized (_is_main_init) {
//            if (_is_main_init == null) {
//                _is_main_init = true;
//                fwdToMain();
//            } else {
//                HybridTools.setAppContext(getApplicationContext());
//
//                resumeUi(this);
//            }
//        }

    }

}

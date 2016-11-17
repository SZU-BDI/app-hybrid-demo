package szu.bdi.hybrid.demo;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.util.Log;

import org.json.JSONObject;

import java.io.File;

import szu.bdi.hybrid.core.HybridCallback;
import szu.bdi.hybrid.core.HybridHandler;
import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.HybridUi;
import szu.bdi.hybrid.core.JSO;

public class MainActivity extends HybridUi {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void main(final HybridUi _entryAct) {
        Log.v(LOGTAG, "main()");

        int _sdk_int = android.os.Build.VERSION.SDK_INT;

        if (_sdk_int < Build.VERSION_CODES.KITKAT) {
            HybridTools.quickShowMsgMain("Your Phone (API=\" + _sdk_int + \") is too old !!!! ");
//            HybridTools.quickShowMsgMain("Your Phone is too old...");
        }

        //AppTools.uiNeedNetworkPolicyHack();
        HybridTools.startUi("UiRoot", "", _entryAct);
        /*
        final String sJsonConf = HybridTools.readAssetInStr("config.json");
//        final JSONObject o = HybridTools.s2o(sJsonConf);
        final JSO o = JSO.s2o(sJsonConf);
        if (o == null || o.isNull()) {
            HybridTools.appAlert(_entryAct, "Wrong Config File", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    Log.v(LOGTAG, "config.json=" + sJsonConf);
                    AppTools.KillAppSelf();//violent
                }
            });
        } else {
            Context _appContext = HybridTools.getAppContext();
            HybridTools.initAppConfig(o);

            String app_ver = HybridTools.getAppConfig("app_ver").toString();
            if (null == app_ver) app_ver = "";

            String app_ver_saved = HybridTools.getSavedSetting(_appContext, "APP", "app_ver");
            if (app_ver_saved == null) app_ver_saved = "";

            String isFirstLoad = HybridTools.getSavedSetting(_appContext, "APP", "isFirstLoad");

            //isFirstLoad = "";//test only
            //HybridTools.quickShowMsgMain("isFirstLoad=" + isFirstLoad);

            //if the init htm not exists, copy from assets
            File app_cache_dir_f = HybridTools.getAppContext().getCacheDir();
            String app_cache_dir_s = app_cache_dir_f.getAbsolutePath();
            File root_htm_f = new File(app_cache_dir_s + "/web/root.htm");

            //TODO if exists, check file size...
            //TODO also check the version, if version different, copy too!

            //TODO 加多一个判断 config.json和root.htm 的时间？
            if (!root_htm_f.exists() || !"N".equals(isFirstLoad) || !app_ver_saved.equals(app_ver)) {
                Log.v(LOGTAG, "copy files to " + app_cache_dir_s);
                HybridTools.copyAssetFolder(HybridTools.getAppContext().getAssets(), "web", app_cache_dir_s + "/web");
            }

            if (!root_htm_f.exists()) {
                HybridTools.appAlert(_entryAct, "Failed Init", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        AppTools.KillAppSelf();//so violent
                    }
                });
            } else {
                HybridTools.saveSetting(_appContext, "APP", "isFirstLoad", "N");
                HybridTools.saveSetting(_appContext, "APP", "app_ver", app_ver);

                //important: store the localWebRoot for later usage
                HybridTools.localWebRoot = app_cache_dir_s + "/web/";

                //HybridUi testUi = HybridTools.getHybruidUi("UiRoot");//从config.json中找到UiRoot对应的类，并实例后返回
                //HybridTools.startUi("UiEntry", "{topbar:true}", testUi);//把这个实例显示出来，命名为 uiEntry，发送参数为 topbar:true

                HybridTools.startUi("UiRoot", "", _entryAct);

                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        _entryAct.startActivity(new Intent(_entryAct, SplashActivity.class));
                        _entryAct.finish();
                    }
                }, 1);
            }
        }
        */
    }

    @Override
    protected void onStart() {
        super.onStart();
        Log.v(LOGTAG, ".onStart()");

        final HybridUi _thisHybriUi = this;

//        main(this);
        int _sdk_int = android.os.Build.VERSION.SDK_INT;

        if (_sdk_int < Build.VERSION_CODES.KITKAT) {
            HybridTools.quickShowMsgMain("Your Phone (API=\" + _sdk_int + \") is too old !!!! ");
//            HybridTools.quickShowMsgMain("Your Phone is too old...");
            _thisHybriUi.finish();
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    AppTools.KillAppSelf();
                }
            }, 2000);
        }

        AppTools.uiNeedNetworkPolicyHack();
        HybridTools.startUi("UiRoot", "", _thisHybriUi, new HybridCallback() {
            @Override
            public void onCallBack(String cbStr) {
                Log.v(LOGTAG, "onCallBack to ... UiRoot");
                HybridTools.quickShowMsgMain("Quit...");

                _thisHybriUi.finish();
                new Handler().postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        AppTools.KillAppSelf();
                    }
                }, 2000);

//                HybridTools.appConfirm(HybridTools.getAppContext(), "QUIT", new AlertDialog.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialog, int which) {
//                        AppTools.quit(true);
//                        //jsrst.confirm();
//                    }
//                }, new AlertDialog.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialog, int which) {
//                        //jsrst.cancel();
//                    }
//                });
            }

            @Override
            public void onCallBack(JSO jso) {
                onCallBack(JSO.o2s(jso));
            }
        });
    }

}


package szu.bdi.hybrid.demo;

import szu.bdi.hybrid.core.eg.HybridApplication;

//NOTES: must have an applicaton, otherwise data e.g.  app context maybe cleaned up by GC !!!!

public class HybridDemoApplication
        extends HybridApplication
        //extends Application
{
//    final private static String LOGTAG = "" + (new Object() {
//        public String getClassName() {
//            String clazzName = this.getClass().getName();
//            return clazzName.substring(0, clazzName.lastIndexOf('$'));
//        }
//    }.getClassName());
//
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        Log.v(LOGTAG, "App.onCreate");
//        HybridTools.setAppContext(getApplicationContext());
//
//        //TODO register a listenr to event "onKeyDown_LastAct"
//    }
//
    //TODO the global onKeyDown_LastAct Handler
//    @Override
//    public boolean onKeyDown(int keyCode, KeyEvent event) {
//        if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
//            if ((System.currentTimeMillis() - exitTime) > 2000) {
//                Toast.makeText(getApplicationContext(), getText(R.string.system_exit), Toast.LENGTH_SHORT).show();
//                exitTime = System.currentTimeMillis();
//            } else {
//                String filename = "StaticFileName";
//                String field = "IfScreenCloseorAcDestroyHappened";
//
//                boolean flag1 = true;
//                AppHelper.putSharePreBoolean(MainActivity.this, filename, field, flag1);
//
//                ActivityCollector.ExitApp();
//            }
//            return true;
//        }
//        return super.onKeyDown(keyCode, event);
//    }
}


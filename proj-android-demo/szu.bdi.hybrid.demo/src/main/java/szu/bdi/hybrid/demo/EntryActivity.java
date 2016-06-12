package szu.bdi.hybrid.demo;

import android.app.Activity;

public class EntryActivity extends Activity {
//    final private static String LOGTAG = "" + (new Object() {
//        public String getClassName() {
//            String clazzName = this.getClass().getName();
//            return clazzName.substring(0, clazzName.lastIndexOf('$'));
//        }
//    }.getClassName());

    protected void fwdToMain() {
        DemoApp.main();
    }

    @Override
    protected void onStart() {
        super.onStart();
        fwdToMain();
        finish();
    }

    @Override
    protected void onResume() {
        super.onResume();
        fwdToMain();
        finish();
    }
}

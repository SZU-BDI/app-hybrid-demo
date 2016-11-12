package szu.bdi.hybrid.demo;


import android.util.Log;

import org.json.JSONObject;

import java.util.ArrayList;

import szu.bdi.hybrid.core.HybridTools;
import szu.bdi.hybrid.core.JSO;

/*

Test Cases

# special: null,"","null",true,false,1,0,-1,"true","false"
# number: 99,9999.99,-0.0000000001
# string: "any"
# regexp: /^wtf$/gi
# object: {}, {[],{},{x:1}}
# array: [{},1,2,{x:99}]
# illegal: {x,88}

notices:
toString() should be the string quoted?
getValue() should be the real value (JSONObject/JSONArray/String/number/null)?

JSO: a abstract concept of JSON, includes JSO_Obj, JSO_Arr, JSO_nil, JSO_Str, JSO_Num, JSO_RegExp, JSO_Unknown

 */
public class JSO_Tester {
    final private static String LOGTAG = "" + (new Object() {
        public String getClassName() {
            String clazzName = this.getClass().getName();
            return clazzName.substring(0, clazzName.lastIndexOf('$'));
        }
    }.getClassName());

    public static void testSpecial() {
        //Log.v(LOGTAG, "((Object)true).toString?" +((Object)true).toString());

        JSO o01 = JSO.s2o(null);
        Log.v(LOGTAG, "JSO.s2o(null)=" + o01);

        Log.v(LOGTAG, "JSO.classNameOf(o01.getValue())=" + HybridTools.classNameOf(o01.getValue()));

        ArrayList<Object> oo = new ArrayList<>();
        oo.add(null);
        oo.add("");//error
        oo.add("null");
        oo.add(true);
        oo.add(false);
        oo.add(1);
        oo.add(0);
        oo.add(-1);
        oo.add("true");
        oo.add("false");
        oo.add("wtfomg");
        oo.add("{x:1}");//basic object
        oo.add("[11,\"22\"]");//basic array
        oo.add("\"11\"");//will have number 11 or string 11?
        oo.add("{y,2}");//error

        //Log.v(LOGTAG, "oo.toString " + oo.toString());
        String ss = JSO.o2s(oo);
        Log.v(LOGTAG, "ss=JSO.o2s(oo).toString = " + ss);
        Log.v(LOGTAG, "JSO.s2o(ss).toString = " + JSO.s2o(ss).toString());
        //Log.v(LOGTAG, "JSONObject.wrap(oo) " + JSONObject.wrap(oo));

        for (int i = 0; i < oo.size(); i++) {
            Object o = oo.get(i);
            Log.v(LOGTAG, "o=" + JSONObject.wrap(o));
            String s = JSO.o2s(o);
            JSO jso = JSO.s2o(s);
            Log.v(LOGTAG, "s=o2s(o) = " + s);
            Log.v(LOGTAG, "jso=JSO.s2o(s) = " + jso);
            Log.v(LOGTAG, "jso.getValue()=" + jso.getValue());
            Log.v(LOGTAG, "JSO.classNameOf(jso.getValue())=" + HybridTools.classNameOf(jso.getValue()));
        }
        Log.v(LOGTAG, "done JST_Tester.testSpecial()");
    }

//    public static void testSimple() {
//
//        ArrayList<String> ss = new ArrayList<String>();
//        ss.add("");//empty string
//        ss.add("null");//string "null"
//        ss.add(null);//hacked null
//        ss.add(true);//hacked null
//        ss.add(false);//hacked null
//        ss.add("{x:1}");//basic object
//        ss.add("[11,\"22\"]");//basic array
//        ss.add("\"11\"");//will have number 11 or string 11?
//
//        for (int i = 0; i < ss.size(); i++) {
//            String s = ss.get(i);
//            Log.v(LOGTAG, "str=" + s);
//            JSO o = JSO.s2o(s);
//            Log.v(LOGTAG, "s2o(s).toString=" + o.toString());
//        }
//        Log.v(LOGTAG, "done JST_Tester.testSimple()");
//    }

//    public static void testComplex() {
//        String s = "{x:1}";
//        JSO o = JSO.s2o(s);
//        o.setChild("x", JSO.s2o("2"));
//        Log.v(LOGTAG, "str=" + s);
//        Log.v(LOGTAG, "o.toString()=" + o.toString());
//
//
//        String s2 = "[{},22]";
//        JSO o2 = JSO.s2o(s2);
//        o.append(JSO.s2o("33"));
//        Log.v(LOGTAG, "str=" + s);
//        Log.v(LOGTAG, "o.toString()=" + o.toString());
//
//        Log.v(LOGTAG, "done JST_Tester.testComplex()");
//    }

    public static void main() {
        testSpecial();
        //JSO_Tester.testSimple();
        //JSO_Tester.testComplex();
    }
}

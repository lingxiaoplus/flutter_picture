package com.lingxiao.flutterpicture

import android.content.Context
import android.os.Bundle
import android.os.Environment
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import java.io.File
import java.nio.file.Files.size

class MainActivity : FlutterActivity() {
    private val CHANNEL = "flutter.io/local_image"
    @Override
    protected override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        val methodChannel = MethodChannel(getFlutterView(), CHANNEL)
        methodChannel?.setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: Result) {
                        if (call.method.equals("getLocalImages")){
                            var list = getLocalImages();
                            if (list != null){
                                result.success(list)
                            }else
                                result.error("UNAVAILABLE", "file not available.", null)
                        }
                    }
                })
    }

    fun getLocalImages() :List<String>?{
        val pictures = arrayListOf<String>()
        val file = File(Environment.DIRECTORY_PICTURES)
        val fileList = getFiles(file)
        if (fileList == null) return null
        if (fileList.size > 0) {
            for (i in fileList.indices) {
                //Log.i("下载的图片路径", fileList.get(i).getAbsolutePath());
                val path = "file://" + fileList[i].absolutePath
                //String path = fileList.get(i).getAbsolutePath();
                pictures.add(path)
            }
        }
        return pictures
    }

    private fun getFiles(file: File): MutableList<File>?{
        val realFileList = arrayListOf<File>()
        try {
            val fileList = file.listFiles()
            for (f in fileList) {
                if (f.isFile()) {
                    realFileList.add(f)
                } else {
                    getFiles(f)
                }
            }
            return realFileList
        } catch (e: NullPointerException) {
            //ToastUtils.show("出错了："+e.getMessage());
            e.printStackTrace();
        }
        return null
    }
}

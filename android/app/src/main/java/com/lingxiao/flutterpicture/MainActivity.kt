package com.lingxiao.flutterpicture

import android.content.Context
import android.os.Bundle
import android.os.Environment
import android.util.Log
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
    private val TAG = MainActivity::class.java.simpleName

    @Override
    protected override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        val methodChannel = MethodChannel(getFlutterView(), CHANNEL)
        methodChannel?.setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: Result) {
                        if (call.method == "getLocalImages"){
                            var list = getLocalImages();
                            if (list.size > 0){
                                result.success(list)
                            }else
                                result.error("UNAVAILABLE", "file not available.", list)
                        }
                    }
                })
    }

    fun getLocalImages() :List<String>{
        val pictures = arrayListOf<String>()
        val file = File(Environment.getExternalStorageDirectory().absolutePath, Environment.DIRECTORY_PICTURES)
        Log.i(TAG,"path:  ${file.absolutePath}")
        val fileList = getFiles(file)
        if (fileList.size > 0) {
            for (i in fileList.indices) {

                val path = fileList[i].absolutePath
                //String path = fileList.get(i).getAbsolutePath();
                pictures.add(path)
                Log.i("下载的图片路径", path);
            }
        }
        return pictures
    }

    private fun getFiles(file: File): MutableList<File>{
        val realFileList = arrayListOf<File>()
        val fileList = file.listFiles()
        fileList?.forEach {
            if (it.isFile()) {
                realFileList.add(it)
            } else {
                getFiles(it)
            }
        }
        return realFileList
    }
}

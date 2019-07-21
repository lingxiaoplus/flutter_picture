import 'dart:async';

import 'package:rxdart/subjects.dart';

class RxBus{
  /*factory RxBus(){
    return _getInstance();
  }*/
  static RxBus rxBus;
  static Subject<Object> mBus;
  static RxBus get instance => _getInstance();
  static RxBus _getInstance(){
    if(rxBus == null){
      rxBus = RxBus();
      mBus = PublishSubject();
    }
    return rxBus;
  }

  void post(Object object){
    if(mBus.hasListener){
      mBus.add(object);
    }
  }
  void postList(List objects){
    if(mBus.hasListener){
      mBus.add(objects);
    }
  }

  Subject<Object> register(Object event){
    return mBus;
  }

  void unRegister(){
    mBus.close();
  }
}
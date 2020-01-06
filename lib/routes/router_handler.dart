import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:hello_world/view/page/service/service.dart';
import 'package:hello_world/view/page/login/login.dart';
import 'package:hello_world/view/page/find/find.dart';
import 'package:hello_world/view/page/my/my.dart';

/* *
 * handler就是每个路由的规则，编写handler就是配置路由规则，
 * 比如我们要传递参数，参数的值是什么，这些都需要在Handler中完成。
 */

// 首页
Handler indexPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return FindPage();
  },
);

// 正常路由跳转
Handler normalPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyPage();
});

// 路由传参
Handler routingReferenceHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  return ServicePage(id: id);
});

// 登陆页面
Handler loginHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/20
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <script src="../JS/jq/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <title>注册界面</title>
    <link rel="stylesheet" type="text/css" href="../css/sign%20up.css">
</head>
<body>
<script type="text/javascript"
        color="122 103 238" opacity='0.7' zIndex="-2" count="200" src="//cdn.bootcss.com/canvas-nest.js/1.0.0/canvas-nest.min.js">
</script>
<%  String message = (String) request.getAttribute("message");
    if(message!=null&&message!=""){
%>
     <script>alert('<%= message%>')</script>
<%
    }
%>
<div class="menu">
    <ul>
        <li><a><img src="../img/logo.png"></a></li>
        <% String UID1 = (String) session.getAttribute("UID");
            if(UID1!=null&&!UID1.equals(""))  {
        %>
        <li class="dropdown"><img src="../img/user%20(2).png">
            <div class="dropdown-content">
                <a href="../uploadPage.get"><img src="../img/upload2.png">&nbsp;上传图片</a>
                <a href="../favorite.get"><img src="../img/like.png">&nbsp;我的收藏</a>
                <a href="../MyPhoto.get"><img src="../img/my.png">&nbsp;我的图片</a>
                <a href="../Friends.do"><img src="../img/firends.png">&nbsp;我的好友</a>
                <a href="../quit.do"><img src="../img/quit.png">&nbsp;退出登录</a>
            </div>
        </li>
        <%  }
        else {
        %>
        <li class="dropdown"><a href="/jsp/registration.jsp"><img src="../img/nolog.png"></a></li>
        <%
            }
        %>

        <li class="right"><a href="../SearchPage.get"><img src="../img/search%20(2).png"></a></li>
        <li class="right"><a href="../refresh.get"><img src="../img/home.png"></a></li>

    </ul>
</div>
<form method="POST" action="../login.do">
    <div class="login"><!--边框-->
        <div class="form" id="first"><!--输入框-->
            <small id="name1">请输入用户名</small>
            <input id="username" type="text" name="username" autocomplete="off" placeholder="用户名" required onblur="account();check()" onkeyup="account();check()" value="${param.username }">
        </div>
        <div class="form"><!--输入框-->
            <small id="mail1">请输入邮箱</small>
            <input id="useremail" type="text" name="useremail" autocomplete="off" placeholder="邮箱"  required onblur="email();check()" onkeyup="email();check()" value="${param.useremail }">
        </div>
        <div class="form" id="third"><!--输入框-->
            <small id="psw1">请输入密码</small>
            <input id="password" type="password" name="password" autocomplete="off" placeholder="密码"  required onblur="psw();check();pwStrength()" onkeyup="psw();check();pwStrength()" value="${param.password }">
            <p class="" id="strength" style="display:none">
              <span style="color: white"><em>密码强度</em>
                <i class="password_qd">
                  <span class="pswStrength" id="strength_L"></span>
                  <span class="pswStrength" id="strength_M"></span>
                  <span class="pswStrength" id="strength_H"></span>
                </i>
               <em id="info"></em>
             </span>
            </p>
            <p class="" id="password1_info"></p>
        </div>
        <div class="form"><!--输入框-->
            <small id="psw2">请再次输入密码</small>
            <input id="password1" type="password"  name="password1" autocomplete="off" placeholder="密码"  required onblur="psw1();check()" onkeyup="psw1();check()" value="${param.password1 }">
        </div>
        <div class="form"><input type="submit" value="注 册" id="submit" disabled="disabled"><!--注册按钮--></div>
    </div>
</form>
<div class="bottom">@19302010060@fudan.edu.cn</div><!--页脚-->
</body>
</html>
<script>
    var flags = [false,false,false,false];
    /*邮箱正则*/
    var RegEmail = /[\w]+(.[\w]+)*@[\w]+(.[\w])+/;
    /*用户名正则*/
    var Tname =/^[0-9a-zA-Z_]{4,15}$/
    /*密码正则*/
    var Tpsw = /^.{6,12}$/
    /*用户名检验*/
    function account(){

        var account = $("#username").val();
        var option = document.getElementById("name1");
        option.innerHTML="";
        var textNode = document.createTextNode("用户名格式错误！");
        var textNode1 = document.createTextNode("用户名格式正确！");
        var textNode2 = document.createTextNode("请输入用户名");
        if(account==""){
            option.appendChild(textNode2);
            flags[0] = false;
        }
        else if(!Tname.test(account)) {
            option.appendChild(textNode);
            flags[0] = false;
        }
        else{
            option.appendChild(textNode1);
            flags[0] = true;
        }

    }
    /*邮箱检验*/
    function email(){

        var email = $("#useremail").val();
        var option = document.getElementById("mail1");
        option.innerHTML="";
        var textNode = document.createTextNode("邮箱格式错误！");
        var textNode1 = document.createTextNode("邮箱格式正确！");
        var textNode2 = document.createTextNode("请输入邮箱");
        if(email==""){
            option.appendChild(textNode2);
            flags[1] = false;
        }
        else if(!RegEmail.test(email)) {
            option.appendChild(textNode);
            flags[1] = false;
        }
        else{
            option.appendChild(textNode1);
            flags[1] = true;
        }

    }
    /*密码检验*/
    function psw(){

        var psw1 = $("#password").val();
        var option = document.getElementById("psw1");
        option.innerHTML="";
        var textNode = document.createTextNode("密码长度不符！");
        var textNode1 = document.createTextNode("密码格式正确！");
        var textNode2 = document.createTextNode("请输入密码");
        if(psw1==""){
            option.appendChild(textNode2);
            flags[2] = false;
        }
        else if(!Tpsw.test(psw1)) {
            option.appendChild(textNode);
            flags[2] = false;
        }
        else{
            option.appendChild(textNode1);
            flags[2] = true;
        }

    }
    /*再次输入密码检验*/
    function psw1() {

        var psw2=$("#password1").val();
        var option = document.getElementById("psw2");
        option.innerHTML="";
        var textNode = document.createTextNode("密码不一致！");
        var textNode1 = document.createTextNode("密码格式正确！");
        var textNode2 = document.createTextNode("请再次输入密码");
        if(psw2==""){
            option.appendChild(textNode2);
            flags[3] = false;
        }
        else if(psw2!=$("#password").val()){
            option.appendChild(textNode);
            flags[3] = false;
        }
        else {
            flags[3] = true;
            option.appendChild(textNode1);
        }

    }
    function check() {
        for (var i=0;i<4;i++) {
            if (!flags[i]) {
                $("#submit").attr("disabled", "disabled");
                break;
            }
            else {
                $("#submit").removeAttr("disabled");
            }
        }

    }
    //checkStrong函数
    //返回密码的强度级别
    function checkStrong(sPW){
        if (sPW.length<=4)
            return 0; //密码太短
        var Modes=0;
        for (i=0;i<sPW.length;i++){
            //测试每一个字符的类别并统计一共有多少种模式.
            //charCodeAt():返回unicode编码的值
            Modes|=CharMode(sPW.charCodeAt(i)); //测试某个字符属于哪一类
        }
        return bitTotal(Modes);//计算出当前密码当中一共有多少种模式
    }
    //CharMode函数
    //测试某个字符是属于哪一类.
    function CharMode(iN){
        if (iN>=48 && iN <=57) //数字
            return 1;
        if (iN>=65 && iN <=90) //大写字母
            return 2;
        if (iN>=97 && iN <=122) //小写
            return 4;
        else
            return 8; //特殊字符
    }
    //bitTotal函数
    //计算出当前密码当中一共有多少种模式
    function bitTotal(num){
        var modes=0;
        for (i=0;i<4;i++){
            if (num & 1) modes++;
            num>>>=1;
        }
        return modes;
    }
    //pwStrength函数
    //当用户放开键盘或密码输入框失去焦点时,根据不同的级别显示不同的颜色
    function pwStrength(){
        $("#strength").removeAttr("style");
        var pwd =$("#password").val();
        var Lcolor,Mcolor,Hcolor;
        var O_color="rgba(0,0,0,0)";
        var L_color="#FF4040";
        var M_color="#FF9900";
        var H_color="#33CC00";
        var info = "";
        if (pwd==null||pwd==''){
            Lcolor=Mcolor=Hcolor=O_color;
            $("#strength").attr("style", "display:none");
        } else {
            var level=checkStrong(pwd);//检测密码的强度
            switch(level) {
                case 0:
                    Lcolor=L_color;
                    Mcolor=Hcolor=O_color;
                    info = "弱";
                    break;
                case 1:
                    Lcolor=L_color;
                    Mcolor=Hcolor=O_color;
                    info = "弱";
                    break;
                case 2:
                    Lcolor=Mcolor=M_color;
                    Hcolor=O_color;
                    info = "中";
                    break;
                default:
                    Lcolor=Mcolor=Hcolor=H_color;
                    info = "强";
            }
        }
        $("#strength_L").css("background", Lcolor);
        $("#strength_M").css("background", Mcolor);
        $("#strength_H").css("background", Hcolor);
        $("#info").html(info);//密码强度提示信息
        return;
    }

</script>

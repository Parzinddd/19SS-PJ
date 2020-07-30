<%@ page import="domain.User" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/29
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>好友列表</title>
    <script src="../JS/jq/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/friends.css">
</head>
<body>
<!--导航栏-->
<div class="menu">
    <ul>
        <li><a><img src="../img/logo.png"></a></li>
        <li class="dropdown"><img src="../img/user%20(2).png">
            <div class="dropdown-content">
                <a href="../uploadPage.get"><img src="../img/upload2.png">&nbsp;上传图片</a>
                <a href="../favorite.get"><img src="../img/like.png">&nbsp;我的收藏</a>
                <a href="../MyPhoto.get"><img src="../img/my.png">&nbsp;我的图片</a>
                <a href="../Friends.do"><img src="../img/firends.png">&nbsp;我的好友</a>
                <a href="../quit.do"><img src="../img/quit.png">&nbsp;退出登录</a>
            </div>
        </li>
        <li class="right"><a href="../SearchPage.get"><img src="../img/search%20(2).png"></a></li>
        <li class="right"><a href="../refresh.get"><img src="../img/home.png"></a></li>
    </ul>
</div>

<!--搜索部分-->
<div class="content">
    <div class="serach">
        <h2>Serach</h2>
        <form method="post" action="../Search.do">
             <input type="text"  name="name" id="name">&nbsp&nbsp&nbsp
             <input type="submit" value="Filter" id="submit">
        </form>
        <%  User user1 = (User) request.getAttribute("search");
            if(user1!=null){ %>

           <h3 id="send" style="float: left"><%=user1.getUserName()%></h3>
           <img src="../img/add.png" onclick="$('#send').trigger('click')" id="add">
           <i id="addid" style="display: none"> <%=user1.getUID()%></i>
        <%
            }
        %>

    </div>
    <!--结果部分-->
    <div class="req">
        <h2>Req</h2>
        <% List<User> friendsRequest = (List<User>) request.getAttribute("friendsRequest");
        int i =0;
            if(friendsRequest!=null&&friendsRequest.size()>0){
                for (User user:friendsRequest){
        %>
              <h3  class="reqContent"><%= user.getUserName()%> wants to add you as a friend.</h3>
              <img src="../img/Yes.png" class="yes" onclick="$('#YES<%= i%>').trigger('click')">
              <button id="YES<%= i%>" style="display: none"></button>
              <button id="NO<%= i%>" style="display: none"></button>
               <img src="../img/fno.png" class="no"  onclick="$('#NO<%= i%>').trigger('click')">
               <i id="friendName<%=i%>" style="display: none"><%=user.getUID()%></i>
        <%
                    i++;
                }
            }
        %>
    </div>
    <div class="friends">
        <h2>Friends</h2>
       <% List<User> friends = (List<User>) request.getAttribute("friends");
        if(friends!=null&&friends.size()>0){
        for (User user:friends){
            %>
            <h3><a href="../ShowImage.get?ShowImage=<%=user.getShowImage()%>&UID=<%=user.getUID()%>"><%=user.getUserName()%>&nbsp;
                <%=user.getEmail()%>&nbsp;</a>
                <%=user.getDate()%></h3>

        <%
                 }
            }
           %>

    </div>
</div>
<!--页脚-->
<div class="bottom">@19302010060@fudan.edu.cn</div>
<!--回到顶部-->
<div class="button">
    <a href="#top"><img src="../../img/top.png" ></a>
</div>
</body>
<script type="text/javascript">
  window.onload=function () {

      <% for(int m=0;m<friendsRequest.size();m++){
      %>
          $('#YES<%=m%>').click(function () {
              var name = $('#friendName<%=m%>' ).html();
              dealyes(name);
          })
          $('#NO<%=m%>').click (function () {
              var name = $('#friendName<%=m%>' ).html();
              dealno(name);
          })
          <% }%>


      function dealyes(name) {
          var httprequest = new XMLHttpRequest();
          // 第四部：打开连接，第一个参数表示使用post方式提交；第二个参数表示提交的地址，第三个参数表示打开连接
          httprequest.open("POST", "../yes.do", true);
          // 第五步：设置请求头信息
          httprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
          // 第六步：发送请求
          httprequest.send("name=" + name);
          // 第七步：判断是否请求和响应成功
          // 并给xmlHttp的onreadystatechange事件注册监听
          httprequest.onreadystatechange = function () {
              if (httprequest.readyState == 4 && httprequest.status == 200) {
                  // 表示响应成功
                  // 在此处接收ajax的响应内容
                  alert("添加好友成功！");
                  location.reload();
              }
          }
      }

      function dealno(name) {
          var httprequest = new XMLHttpRequest();
          // 第四部：打开连接，第一个参数表示使用post方式提交；第二个参数表示提交的地址，第三个参数表示打开连接
          httprequest.open("POST", "../no.do", true);
          // 第五步：设置请求头信息
          httprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
          // 第六步：发送请求
          httprequest.send("name=" + name);
          // 第七步：判断是否请求和响应成功
          // 并给xmlHttp的onreadystatechange事件注册监听
          httprequest.onreadystatechange = function () {
              if (httprequest.readyState == 4 && httprequest.status == 200) {
                  // 表示响应成功
                  // 在此处接收ajax的响应内容
                  alert("已拒绝");
                  location.reload();
              }
          }
      }
      $('#send').click(function (){
          var nameID = $('#addid').html();
          var httprequest = new XMLHttpRequest();
          // 第四部：打开连接，第一个参数表示使用post方式提交；第二个参数表示提交的地址，第三个参数表示打开连接
          httprequest.open("POST", "../addFriends.do", true);
          // 第五步：设置请求头信息
          httprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
          // 第六步：发送请求
          httprequest.send("name=" + nameID);
          // 第七步：判断是否请求和响应成功
          // 并给xmlHttp的onreadystatechange事件注册监听
          httprequest.onreadystatechange = function () {
              if (httprequest.readyState == 4 && httprequest.status == 200) {
                  // 表示响应成功
                  // 在此处接收ajax的响应内容
                  alert("已发送请求 ！");
                  location.reload();
              }
          }
      })
  }




</script>
</html>
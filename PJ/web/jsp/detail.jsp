<%@ page import="domain.Image" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>图片</title>
    <link rel="stylesheet" type="text/css" href="../css/detail.css">
    <script src="../JS/jq/jquery-3.4.1/jquery-3.4.1.min.js"></script>
</head>
<body>
<!--导航栏-->
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
        <%
        }
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
<!--标题-->
<h1>Detail</h1>
<!--主体内容-->
<% Image image= (Image) request.getAttribute("image"); %>
<div class="content">
    <div class="big"><img src="../travel-images/large/<%=image.getPath() %>"></div>
    <div class="detail">
        <h2>
            <%= image.getTitle()%>
            <small style="font-size: 15px"> by <%=image.getAuthor()%></small></h2>
        <p>
            Content：<%= image.getContent()%><br><br>
            Country: <%= image.getCountry()%><br><br>
            City: <%= image.getCity()%><br><br>
            Date: <%= image.getDate()%><br><br>
        </p>

        <%
            Long whether = (Long) request.getAttribute("whether");
            if(UID1!=null&&!UID1.equals(""))  {
                if (whether==0){
        %>
        <button id="like">like</button>
        <button id="dlike" style="display: none">cancle</button>
        <i style="display: none" id="ImageID"><%=image.getImageID()%></i>
        <%
            }
                else {
        %>
        <button id="like" style="display: none">like</button>
        <button id="dlike" >cancle</button>
        <i style="display: none" id="ImageID"><%=image.getImageID()%></i>
        <%
             }
            }
        %>
    </div>
    <div class="article">
        <h2>Description</h2>
       <%= image.getDescription()%>
    </div>
</div>
<!--页脚-->
<div class="bottom">@19302010060@fudan.edu.cn</div>
<!--收藏图标-->
<div class="button"><img src="../img/hot.png">
    <% String hot =  request.getAttribute("hot").toString(); %>
    <%= hot %>
</div>
</body>
</html>
<script>
    $('#like').click(function (){
       var ImageID = $('#ImageID').html();
        var httprequest = new XMLHttpRequest();
        // 第四部：打开连接，第一个参数表示使用post方式提交；第二个参数表示提交的地址，第三个参数表示打开连接
        httprequest.open("POST", "../like.get", true);
        // 第五步：设置请求头信息
        httprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // 第六步：发送请求
        httprequest.send("ImageID=" + ImageID);
        // 第七步：判断是否请求和响应成功
        // 并给xmlHttp的onreadystatechange事件注册监听
        httprequest.onreadystatechange = function () {
            if (httprequest.readyState == 4 && httprequest.status == 200) {
                // 表示响应成功
                // 在此处接收ajax的响应内容
                alert("已收藏 ！");
                $('#like').attr('style','display:none');
                $('#dlike').attr('style','display:inline-block')
            }
        }
    })
    $('#dlike').click(function (){
        var ImageID = $('#ImageID').html();
        var httprequest = new XMLHttpRequest();
        // 第四部：打开连接，第一个参数表示使用post方式提交；第二个参数表示提交的地址，第三个参数表示打开连接
        httprequest.open("POST", "../DeleteLike.get", true);
        // 第五步：设置请求头信息
        httprequest.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // 第六步：发送请求
        httprequest.send("ImageID=" + ImageID);
        // 第七步：判断是否请求和响应成功
        // 并给xmlHttp的onreadystatechange事件注册监听
        httprequest.onreadystatechange = function () {
            if (httprequest.readyState == 4 && httprequest.status == 200) {
                // 表示响应成功
                // 在此处接收ajax的响应内容
                alert("已取消收藏 ！");
                $('#dlike').attr('style','display:none');
                $('#like').attr('style','display:inline-block')
            }
        }
    })

</script>
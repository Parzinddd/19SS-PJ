<%@ page import="domain.Image" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/28
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>我的收藏</title>
    <link rel="stylesheet" type="text/css" href="../css/my%20favourite.css">
    <link rel="stylesheet" href="../css/jPages.css">
    <script src="../JS/jq/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <script src="../JS/jPages.js"></script>
    <link rel="stylesheet" href="../css/animate.css">
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
<!--标题-->
<h1>My Favorite</h1>
<!--主体内容，采用grid布局-->
<div class="maincontent">
<div class="content" id="itemContainer">
    <%    List<Image> favoriteImage = (List<Image>) request.getAttribute("favoriteImage");
        if(favoriteImage!=null&&favoriteImage.size()>0){
            for (Image image:favoriteImage){
    %>
   <div><a href=""><img src="../travel-images/large/<%= image.getPath()%>"></a></div>
    <div>
      <h2><%=image.getTitle()%>&nbsp<h3><%=image.getAuthor()%></h3></h2>
      <p><%= image.getDescription()%></p>
      <a href="../deleteFavorite.get?ImageID=<%= image.getImageID()%>"><button onclick="alert('Be sure to cancel your photo collection !')">Delete</button></a>
      <hr>
    </div>
    <%
           }
        }
        else {  %>
           <h2>Can not access !</h2>
    <%
        }
    %>
    </div>

    <!--页码-->
    <div class="holder">

    </div>

</div>

    <%    List<Image> browseImage = (List<Image>) request.getAttribute("browseImage");
        if(browseImage!=null&&browseImage.size()>0){ %>
        <div class="browseImage">
    <%
            for (Image image:browseImage){
    %>
       <a href="../detail.get?ImageID=<%= image.getImageID()%>"> · <%=image.getTitle()%></a>&nbsp;
    <%
            }%>
        </div>
            <%
        }
    %>
<!--页脚-->
<div class="bottom">@19302010060@fudan.edu.cn</div>
<!--返回顶部-->
<div class="button">
    <a href="#top"><img src="../img/top.png" ></a>
</div>
</body>

</html>
<script>
    $(function() {

        $('.holder').jPages({
            containerID: 'itemContainer',
            first: '第一页',//false为不显示
            previous: '前一页',//false为不显示
            next: '后一页',//false为不显示 自定义按钮
            last: '最后一页',//false为不显示
            perPage: 8,//每页最多显示5个
            keyBrowse: false,//键盘切换
            scrollBrowse: false,//滚轮切换
            //pause: 1000,//自动切换
            //clickStop: true,//点击停止自动切换
            //delay: 250,//每张图片显示动画延迟
            //direction: "auto",//本页图片显示的顺序 -> "forward", "backwards", "auto" or "random".
            //fallback: 5000,//每张图片显示透明度延迟
            callback: function (pages, items) {
                console.log(pages);
                console.log(items);
            },
        })
    })
</script>

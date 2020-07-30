<%@ page import="domain.Image" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/7/29
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>上传</title>
    <link rel="stylesheet" type="text/css" href="../css/upload.css">
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
<h2>UPLOAD YOUR NEW PHOTOGRAPH</h2>
<!--主体，采用grid布局-->
<% Image image = (Image) request.getAttribute("image"); %>
<form  method="post" action="../modify.set?ImageID=<%=image.getImageID()%>" enctype="multipart/form-data">
    <div class="content">
        <div class="picture" id="imgPreview">
            <img src="../travel-images/large/<%=image.getPath()%>">
        </div>
        <div>
            <h3>Title :</h3>
            <label>
                <input type="text" name="title" required value="<%= image.getTitle()%>">
            </label>
        </div>
        <div>
            <h3>Theme :</h3>
            <label>
                <input type="text" name="theme" required value="<%= image.getContent()%>">
            </label>
        </div>
        <div>
            <h3>Author :</h3>
            <label>
                <input type="text" name="author" required value="<%= image.getAuthor()%>">
            </label>
        </div>
        <div>
            <h3>location :</h3>
            <label for="country"></label><select id="country" name="country" onchange="addOption()">
            <option selected><%=image.getCountry()%></option>
        </select>
            <label for="city"></label><select id="city" name="city">
            <option selected><%=image.getCity()%></option>
        </select>
        </div>
    </div>
    <!--描述输入框-->
    <div class="des">
        <h3>Description :</h3>
        <input type="text" name="description" required value="<%= image.getDescription()%>">
    </div>
    <!--两个按钮-->
    <div class="put">
        <div><a id="button">choose <input type="file" onchange="PreviewImage(this);" id="file1" name="file1" required></a></div>
        <div>
            <input type="submit" value="submit" id="submit" name="submit">
        </div>
    </div>
</form>
<!--页脚-->
<div class="bottom">@19302010060@fudan.edu.cn</div>
<script>
    /*实现图片预览*/
    function PreviewImage(imgFile) {
        /*允许下列文件格式*/
        var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)/;
        if (!pattern.test(imgFile.value)) {
            alert("系统仅支持jpg/jpeg/png/gif格式的照片！");
        }
        else
        {
            var path = URL.createObjectURL(imgFile.files[0]);
            document.getElementById("imgPreview").innerHTML = "<img src='"+path+"'/>";
        }
    }
</script>
<script src="../JS/CC.js" type="text/javascript"></script>
</body>
</html>

<%@ page import="java.util.List" %>
<%@ page import="domain.Image" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" type="text/css" href="../css/home.css">
    <link rel="stylesheet" href="../css/sample.css">
    <title>Home</title>
    <script src="../JS/jq/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <script src="../JS/starlight.js"></script>
</head>
<body class="starlight">
<%  String message = (String) request.getAttribute("message");
    if(message!=null&& !message.equals("")){
%>
<script>alert('<%= message%>')</script>
<%
    }
    if(request.getAttribute("UID")!=null) {
        String UID = request.getAttribute("UID").toString();
        if (UID != null && !UID.equals("")) {
            session.setAttribute("UID", UID);
        }
    }
%>
<!--导航栏-->
<div>
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
<!--轮播-->
<div class="c-banner">
    <div class="banner">
        <ul>
            <%    List<Image> images = (List<Image>) request.getAttribute("images");
                if(images!=null&&images.size()>0){
                    for (Image image:images){
             %>
            <li> <a href="../detail.get?ImageID=<%= image.getImageID()%>"><img src="../travel-images/large/<%= image.getPath() %>"></a></li>
            <%   }
            }
            %>
        </ul>
    </div>
    <div class="nexImg">
        <img src="../img/nexImg.png" />
    </div>
    <div class="preImg">
        <img src="../img/preImg.png" />
    </div>
    <div class="jumpBtn">
        <ul>
            <li jumpImg="0"></li>
            <li jumpImg="1"></li>
            <li jumpImg="2"></li>
        </ul>
    </div>
</div>
<!--主体内容，采用grid布局-->
</div>
<div class="content">
    <%
        List<Image> NewImages = (List<Image>) request.getAttribute("NewImages");
        if(NewImages!=null&&images.size()>0){
               for (Image image:NewImages){
    %>
       <div>
           <a href="../detail.get?ImageID=<%= image.getImageID()%>">
               <img src="../travel-images/large/<%= image.getPath() %>" ></a>
           <h3><%= image.getTitle() %></h3>
           <h3><%= image.getAuthor()%></h3>
           <p><%= image.getDate() %></p>
       </div>
    <%
               }
        }
    %>
</div>
<!--页脚-->
<div class="bottom">
    <img src="../img/two.jpg">
</div>
<!--回到顶部，刷新按钮-->
<div class="button">
    <a href="../refresh.get"><img src="../img/refresh.png" onclick="alert('Picture Updated!')"></a>
    <a href="#top"><img src="../img/top.png" ></a>
</div>
</body>
</html>
<script type="text/javascript">
    //定时器返回值
    var time=null;
    //记录当前位子
    var nexImg = 0;
    //用于获取轮播图图片个数
    var imgLength = 3;
    //当时动态数据的时候使用,上面那个删除
    // var imgLength =0;
    //设置底部第一个按钮样式
    $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");
    //页面加载
    $(document).ready(function(){
        // dynamicData();
        //启动定时器,设置时间为3秒一次
        time =setInterval(intervalImg,5000);
    });
    //点击上一张
    $(".preImg").click(function(){
        //清楚定时器
        clearInterval(time);
        var nowImg = nexImg;
        nexImg = nexImg-1;
        console.log(nexImg);
        if(nexImg<0){
            nexImg=imgLength-1;
        }
        //底部按钮样式设置
        $(".c-banner .jumpBtn ul li").css("background-color","white");
        $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");

        //将当前图片试用绝对定位,下一张图片试用相对定位
        $(".c-banner .banner ul img").eq(nowImg).css("position","absolute");
        $(".c-banner .banner ul img").eq(nexImg).css("position","relative");

        //轮播淡入淡出
        $(".c-banner .banner ul li").eq(nexImg).css("display","block");
        $(".c-banner .banner ul li").eq(nexImg).stop().animate({"opacity":1},1000);
        $(".c-banner .banner ul li").eq(nowImg).stop().animate({"opacity":0},1000,function(){
            $(".c-banner ul li").eq(nowImg).css("display","none");
        });

        //启动定时器,设置时间为3秒一次
        time =setInterval(intervalImg,3000);
    })
    //点击下一张
    $(".nexImg").click(function(){
        clearInterval(time);
        intervalImg();
        time =setInterval(intervalImg,3000);
    })
    //轮播图
    function intervalImg(){
        if(nexImg<imgLength-1){
            nexImg++;
        }else{
            nexImg=0;
        }

        //将当前图片试用绝对定位,下一张图片试用相对定位
        $(".c-banner .banner ul img").eq(nexImg-1).css("position","absolute");
        $(".c-banner .banner ul img").eq(nexImg).css("position","relative");

        $(".c-banner .banner ul li").eq(nexImg).css("display","block");
        $(".c-banner .banner ul li").eq(nexImg).stop().animate({"opacity":1},1000);
        $(".c-banner .banner ul li").eq(nexImg-1).stop().animate({"opacity":0},1000,function(){
            $(".c-banner .banner ul li").eq(nexImg-1).css("display","none");
        });
        $(".c-banner .jumpBtn ul li").css("background-color","white");
        $(".c-banner .jumpBtn ul li[jumpImg="+nexImg+"]").css("background-color","black");
    }
    //轮播图底下按钮
    //动态数据加载的试用应放在请求成功后执行该代码,否则按钮无法使用
    $(".c-banner .jumpBtn ul li").each(function(){
        //为每个按钮定义点击事件
        $(this).click(function(){
            clearInterval(time);
            $(".c-banner .jumpBtn ul li").css("background-color","white");
            jumpImg = $(this).attr("jumpImg");
            if(jumpImg!=nexImg){
                var after =$(".c-banner .banner ul li").eq(jumpImg);
                var befor =$(".c-banner .banner ul li").eq(nexImg);

                //将当前图片试用绝对定位,下一张图片试用相对定位
                $(".c-banner .banner ul img").eq(nexImg).css("position","absolute");
                $(".c-banner .banner ul img").eq(jumpImg).css("position","relative");

                after.css("display","block");
                after.stop().animate({"opacity":1},1000);
                befor.stop().animate({"opacity":0},1000,function(){
                    befor.css("display","none");
                });
                nexImg=jumpImg;
            }
            $(this).css("background-color","black");
            time =setInterval(intervalImg,3000);
        });
    });
</script>

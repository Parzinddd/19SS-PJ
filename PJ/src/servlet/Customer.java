package servlet;

import DAO.dao;
import DAO.impl.ImageDAOjdbcimpl;
import DAO.impl.UserDAOJdbcImpl;
import DB.Base64Util;
import domain.Image;
import domain.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

//登录注册，user相关
public class Customer extends HttpServlet {
    private dao.UserDAO userDAO =new UserDAOJdbcImpl();
    private dao.ImageDAO imageDAO = new ImageDAOjdbcimpl();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String path = req.getServletPath();
        String methodname = path.substring(1);
        methodname = methodname.substring(0, methodname.length() - 3);

        try {
            Method method = getClass().getDeclaredMethod(methodname, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    private void login(HttpServletRequest req,HttpServletResponse resp) {
        try {
            String username = req.getParameter("username");
            String useremail = req.getParameter("useremail");
            String password = req.getParameter("password");
            String PassWord = Base64Util.decodeData(password);

            long count = userDAO.getCountByName(username);
            SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
            sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();// 获取当前时间
            User user = new User(useremail,username,PassWord,sdf.format(date));
            String message;
            if (count>0){
                message="用户名已存在!";
                req.setAttribute("message", message);
                req.getRequestDispatcher("jsp/login.jsp").forward(req, resp);
                return;
            }
            else {
                userDAO.save(user);
                message="注册成功!";
                req.setAttribute("message", message);
                User user1 = userDAO.get(username);
                req.setAttribute("UID",user1.getUID());
                List<Image> images=imageDAO.getPopularImage();
                req.setAttribute("images",images);
                List<Image> NewImages = imageDAO.getNewImage();
                req.setAttribute("NewImages", NewImages);
                req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
                return;
            }
        }catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    private  void registration(HttpServletRequest req,HttpServletResponse resp) throws Exception {
        String username = req.getParameter("username");
        String password = req.getParameter("psw");
        long count = userDAO.getCountByName(username);
        long count1 = userDAO.getCountByEmail(username);
        try {
            if(count==0&&count1==0) {
                String message = "用户名或密码错误！";
                req.setAttribute("message", message);
                req.getRequestDispatcher("jsp/registration.jsp").forward(req, resp);
                return;
            }
            else {
                if (count!=0) {
                    User user = userDAO.get(username);
                    if (password.equals(Base64Util.encodeData(user.getPass()))) {
                        String message = "登录成功！";
                        req.setAttribute("message", message);
                        int UID = user.getUID();
                        req.setAttribute("UID", UID);
                        List<Image> images = imageDAO.getPopularImage();
                        req.setAttribute("images", images);
                        List<Image> NewImages = imageDAO.getNewImage();
                        req.setAttribute("NewImages", NewImages);
                        req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
                        return;
                    }
                    else {
                        String message = "用户名或密码错误！";
                        req.setAttribute("message", message);
                        req.getRequestDispatcher("jsp/registration.jsp").forward(req, resp);
                        return;
                    }
                }
                else
                    {
                        User user1 = userDAO.getByEmail(username);
                        if (password.equals(Base64Util.encodeData(user1.getPass()))) {
                            String message = "登录成功！";
                            req.setAttribute("message", message);
                            int UID = user1.getUID();
                            req.setAttribute("UID", UID);
                            List<Image> images = imageDAO.getPopularImage();
                            req.setAttribute("images", images);
                            List<Image> NewImages = imageDAO.getNewImage();
                            req.setAttribute("NewImages", NewImages);
                            req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
                            return;
                        }
                        else {
                            String message = "用户名或密码错误！";
                            req.setAttribute("message", message);
                            req.getRequestDispatcher("jsp/registration.jsp").forward(req, resp);
                            return;
                        }
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    private void Friends(HttpServletRequest req,HttpServletResponse resp) throws Exception {
        String UID= req.getSession().getAttribute("UID").toString();
        List<User> friends = userDAO.getFriends(UID);
        req.setAttribute("friends",friends);
        List<User> friendsRequest = userDAO.getFriendsRequest(UID);
        req.setAttribute("friendsRequest",friendsRequest);
        req.getRequestDispatcher("jsp/Friends.jsp").forward(req, resp);
        return;

    }
    private void yes(HttpServletRequest req,HttpServletResponse resp) throws Exception {
        String name = req.getParameter("name");
        String UID= req.getSession().getAttribute("UID").toString();
        userDAO.accept(UID,name);
        return;
    }
    private void no(HttpServletRequest req,HttpServletResponse resp) throws Exception {
        String name = req.getParameter("name");
        String UID= req.getSession().getAttribute("UID").toString();
        userDAO.refuse(UID,name);
        return;
    }
    private void Search(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String name = req.getParameter("name");
        User user = userDAO.get(name);
        req.setAttribute("search",user);
        String UID= req.getSession().getAttribute("UID").toString();
        List<User> friends = userDAO.getFriends(UID);
        req.setAttribute("friends",friends);
        List<User> friendsRequest = userDAO.getFriendsRequest(UID);
        req.setAttribute("friendsRequest",friendsRequest);
        req.getRequestDispatcher("jsp/Friends.jsp").forward(req, resp);
        return;
    }
    private void addFriends(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String friendID= req.getParameter("name");
        String UID= req.getSession().getAttribute("UID").toString();
        userDAO.addFriend(UID,friendID);
        return;
    }
    private void quit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getSession().removeAttribute("UID");
        List<Image> images = imageDAO.getPopularImage();
        req.setAttribute("images", images);
        List<Image> NewImages = imageDAO.getNewImage();
        req.setAttribute("NewImages", NewImages);
        req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
        return;
    }
}

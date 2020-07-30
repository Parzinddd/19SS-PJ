package servlet;

import DAO.dao;
import DAO.impl.ImageDAOjdbcimpl;
import DB.UploadUtil;
import domain.Image;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
//上传文件相关
public class upload extends HttpServlet {
    private dao.ImageDAO imageDAO = new ImageDAOjdbcimpl();

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)  {

        String path = req.getServletPath();
        String methodname = path.substring(1);
        methodname = methodname.substring(0, methodname.length() - 4);

        try {
            Method method = getClass().getDeclaredMethod(methodname, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    private void upload(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        UploadUtil uploadUtil = new UploadUtil();
        HashMap<String,String> map= null;
        try {
            map = uploadUtil.upload(req);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.setContentType("text/html;charset=utf-8");
        SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
        sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();// 获取当前时间
        String UID = req.getSession().getAttribute("UID").toString();
        Image image = new Image(map.get("filename"),map.get("title"),map.get("description"),map.get("theme"),map.get("author"),map.get("country"),map.get("city"),sdf.format(date),UID);
        imageDAO.save(image);
        List<Image> MyImage = imageDAO.getMyImage(UID);

        req.setAttribute("MyImage", MyImage);
        req.getRequestDispatcher("jsp/MyPhoto.jsp").forward(req, resp);

    }
    private void modify(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        UploadUtil uploadUtil = new UploadUtil();
        HashMap<String,String> map= null;
        try {
            map = uploadUtil.upload(req);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.setContentType("text/html;charset=utf-8");
        SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
        sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();// 获取当前时间
        int ImageID = Integer.parseInt(req.getParameter("ImageID"));

            Image image = new Image(map.get("filename"), map.get("title"), map.get("description"), map.get("theme"), map.get("author"), map.get("country"), map.get("city"), ImageID,sdf.format(date));

            imageDAO.update(image);

            String UID = (String) req.getSession().getAttribute("UID");

            List<Image> MyImage = imageDAO.getMyImage(UID);

            req.setAttribute("MyImage", MyImage);

        req.getRequestDispatcher("jsp/MyPhoto.jsp").forward(req, resp);

    }
}

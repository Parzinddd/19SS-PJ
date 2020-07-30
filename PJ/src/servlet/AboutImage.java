package servlet;

import DAO.dao;
import DAO.impl.ImageDAOjdbcimpl;
import DAO.impl.UserDAOJdbcImpl;
import domain.Image;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class AboutImage  extends HttpServlet {
    private dao.UserDAO userDAO = new UserDAOJdbcImpl();
    private dao.ImageDAO imageDAO = new ImageDAOjdbcimpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }
//多个请求用一个servlet 图片有关
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

    private void home(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Image> Images = imageDAO.getPopularImage();
        req.setAttribute("images", Images);
        List<Image> NewImages = imageDAO.getNewImage();
        req.setAttribute("NewImages", NewImages);
        req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
        return;

    }

    private void refresh(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Image> images = imageDAO.refresh();
        req.setAttribute("images", images);
        List<Image> NewImages = imageDAO.getNewImage();
        req.setAttribute("NewImages", NewImages);
        req.getRequestDispatcher("jsp/home.jsp").forward(req, resp);
        return;
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int imageID = Integer.parseInt(req.getParameter("ImageID"));
        Image image = imageDAO.get(imageID);
        if(req.getSession().getAttribute("UID")!=null){
            String UID = req.getSession().getAttribute("UID").toString();
            SimpleDateFormat sdf = new SimpleDateFormat();// 格式化时间
            sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();// 获取当前时间
            imageDAO.userBrowse(UID,imageID,sdf.format(date),image.getTitle());
            Long whether = imageDAO.whetherlike(UID,imageID);
            req.setAttribute("whether", whether);
        }
        List<Image> hot = imageDAO.getHot(imageID);
        int size = hot.size();
        req.setAttribute("hot", size);
        req.setAttribute("image", image);
        req.getRequestDispatcher("jsp/detail.jsp").forward(req, resp);
        return;
    }

    private void favorite(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String UID= req.getSession().getAttribute("UID").toString();
        List<Image> favoriteImage = imageDAO.getFavoriteImage(UID);
        req.setAttribute("favoriteImage", favoriteImage);
        List<Image> browseImage = imageDAO.getBrowseImage(UID);
        req.setAttribute("browseImage", browseImage);
        req.getRequestDispatcher("jsp/MyFavorite.jsp").forward(req, resp);
        return;
    }
    private void deleteFavorite(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int UID = Integer.parseInt(req.getSession().getAttribute("UID").toString());
        int imageID = Integer.parseInt(req.getParameter("ImageID"));
        imageDAO.deleteFavorite(imageID,UID);
    }
    private void MyPhoto(HttpServletRequest req, HttpServletResponse resp) throws Exception {
         String UID = (String) req.getSession().getAttribute("UID");
         List<Image> MyImage = imageDAO.getMyImage(UID);
         req.setAttribute("MyImage", MyImage);
         req.getRequestDispatcher("jsp/MyPhoto.jsp").forward(req, resp);
         return;
    }
    private void uploadPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("jsp/upload.jsp").forward(req, resp);
        return;
    }
    private void modify(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int ImageID =Integer.parseInt(req.getParameter("ImageID"));
        Image image = imageDAO.get(ImageID);
        req.setAttribute("image",image);
        req.getRequestDispatcher("jsp/Modify.jsp").forward(req, resp);
        return;
    }
    private void deleteMyPhoto(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int ImageID =Integer.parseInt(req.getParameter("ImageID"));
        imageDAO.Delete(ImageID);
        String UID = (String) req.getSession().getAttribute("UID");
        List<Image> MyImage = imageDAO.getMyImage(UID);
        req.setAttribute("MyImage", MyImage);
        req.getRequestDispatcher("jsp/MyPhoto.jsp").forward(req, resp);
        return;
    }
    private void ShowImage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int ShowImage = Integer.parseInt(req.getParameter("ShowImage"));
        String UID = req.getParameter("UID");
        if(ShowImage==0){
            List<Image> favoriteImage = imageDAO.getFavoriteImage(UID);
            req.setAttribute("favoriteImage", favoriteImage);
        }
        req.getRequestDispatcher("jsp/MyFavorite.jsp").forward(req, resp);
        return;
    }
    private void like(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String ImageID= req.getParameter("ImageID");
        String UID = (String) req.getSession().getAttribute("UID");
        imageDAO.like(UID,ImageID);
        return;
    }
    private void DeleteLike(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String ImageID= req.getParameter("ImageID");
        String UID = (String) req.getSession().getAttribute("UID");
        imageDAO.DeleteLike(UID,ImageID);
        return;
    }
    private void SearchImage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String by = req.getParameter("search");
        String sort = req.getParameter("sort");
        String title = "%"+req.getParameter("title")+"%";
        List<Image> images =imageDAO.SearchImage(by,sort,title);
        req.setAttribute("Images", images);
        req.getRequestDispatcher("jsp/Search.jsp").forward(req, resp);
        return;
    }
    private void SearchPage(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("jsp/Search.jsp").forward(req, resp);
        return;
    }
}
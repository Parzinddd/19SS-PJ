package DAO.impl;

import DAO.dao;
import domain.Image;

import java.util.List;

public class ImageDAOjdbcimpl extends dao<Image> implements dao.ImageDAO{
    @Override
    public List<Image> getPopularImage() {
        String sql= "select travelimagefavor.ImageID ,travelimage.PATH,travelimage.Title,travelimage.Description ,count(*) from travelimagefavor JOIN travelimage ON travelimage.ImageID=travelimagefavor.ImageID group by travelimage.ImageID order by count(*) DESC LIMIT 3";
        return getForList(sql);
    }

    @Override
    public List<Image> getNewImage() {
        String sql= "SELECT ImageID ,PATH,Title,Description,Date,Author FROM travelimage ORDER BY Date DESC LIMIT 6";
        return getForList(sql);
    }

    @Override
    public List<Image> getMyImage(String UID) {
         String sql = "SELECT * from travelimage where UID=?";
         return getForList(sql,UID);
    }

    @Override
    public List<Image> getFavoriteImage(String UID) {
        String sql= "SELECT travelimage.Title,travelimage.Path,travelimage.Author,travelimage.Description ,travelimagefavor.ImageID from travelimage , travelimagefavor WHERE travelimagefavor.UID=? AND travelimage.ImageID=travelimagefavor.ImageID";
        return getForList(sql,UID);
    }

    @Override
    public List<Image> refresh() {
        String sql= "SELECT ImageID ,PATH,Title,Description FROM travelimage ORDER BY RAND() LIMIT 3";
        return getForList(sql);
    }

    @Override
    public List<Image> SearchImage(String by, String sort,String title) {
        String sql="";
        if (sort.equals("date")){
            if (by.equals("title")) {
                sql = "SELECT * FROM travelimage where Title LIKE  ?  ORDER BY Date DESC";
            }
            else {
                sql = "SELECT * FROM travelimage where Content LIKE  ?  ORDER BY Date DESC";
            }
        }
        else {
            if(by.equals("title")){
                 sql = "select travelimagefavor.ImageID ,travelimage.PATH,travelimage.Content,travelimage.Author,travelimage.ImageID,travelimage.Date,travelimage.Title,travelimage.Description ,count(*) from travelimagefavor JOIN travelimage ON travelimage.ImageID=travelimagefavor.ImageID where Title LIKE ? group by travelimage.ImageID order by count(*) DESC ";
            }
            else {
                 sql = "select travelimagefavor.ImageID ,travelimage.PATH,travelimage.Content,travelimage.Author,travelimage.ImageID,travelimage.Date,travelimage.Title,travelimage.Description ,count(*) from travelimagefavor JOIN travelimage ON travelimage.ImageID=travelimagefavor.ImageID where Content LIKE ? group by travelimage.ImageID order by count(*) DESC ";
            }
        }

       return  getForList(sql, title);
    }

    @Override
    public void like(String UID, String ImageID) {
        String sql = "INSERT INTO `travelimagefavor`( `UID`, `ImageID`) VALUES (?,?)";
        update(sql,UID,ImageID);
    }

    @Override
    public void DeleteLike(String UID, String ImageID) {
        String sql = "DELETE FROM `travelimagefavor` WHERE UID=? AND ImageID=?";
        update(sql,UID,ImageID);
    }

    @Override
    public void save(Image image) {
        String sql="INSERT INTO `travelimage`(`Title`, `Description`, `City`, `Country`, `UID`, `PATH`, `Content`, `Author`, `Date`) VALUES (?,?,?,?,?,?,?,?,?)";
        update(sql,image.getTitle(),image.getDescription(),image.getCity(),image.getCountry(),image.getUID(),image.getPath(),image.getContent(),image.getAuthor(),image.getDate());
    }

    @Override
    public void update(Image image) {
        String sql ="UPDATE `travelimage` SET `Title`=?,`Description`=?,`City`=?,`Country`=?,`PATH`=?,`Content`=?,`Author`=?,`Date`=? WHERE ImageID=?";
        update(sql,image.getTitle(),image.getDescription(),image.getCity(),image.getCountry(),image.getPath(),image.getContent(),image.getAuthor(),image.getDate(),image.getImageID());
    }

    @Override
    public void Delete(int ImageID) {
        String sql ="DELETE FROM `travelimage` WHERE ImageID=?";
        update(sql,ImageID);
    }

    @Override
    public void userBrowse(String UID, int ImageID, String Date,String Title) {
        String sql="INSERT INTO `userbrowseimage`(`ImageID`, `UID`, `Date`,`Title`) VALUES (?,?,?,?)";
        update(sql,ImageID,UID,Date,Title);
    }

    @Override
    public List<Image> getBrowseImage(String UID) {
        String sql= "select * from userbrowseimage where UID=? AND Num in (select min(Num) from userbrowseimage group by ImageID) ORDER BY Date DESC LIMIT 10";
        return getForList(sql,UID);
    }

    @Override
    public void deleteFavorite(int ImageID,int UID) {
        String sql="Delete from travelimagefavor where UID=? AND ImageID=?";
        update(sql,UID,ImageID);
    }

    @Override
    public Image get(int ImageID) {
        String sql = "SELECT * FROM travelimage WHERE ImageID=?";
        return get(sql,ImageID);
    }

    @Override
    public long getCountByID(int ID) {
        return 0;
    }

    @Override
    public long whetherlike(String UID, int ImageID) {
        String sql = "SELECT * FROM  `travelimagefavor` WHERE UID=? and ImageID=?";
        return  getForValue(sql,UID,ImageID);
    }

    @Override
    public List<Image> getHot(int ImageID) {
        String sql="SELECT * FROM `travelimagefavor` WHERE ImageID=?";
        return  getForList(sql,ImageID);
    }
}

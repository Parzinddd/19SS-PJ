package DAO;

import domain.Image;
import domain.User;
import org.apache.commons.dbutils.QueryRunner;
import DB.druidtoools;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.util.List;
//基础数据库方法
public class dao<T>{

    private QueryRunner queryRunner = new QueryRunner();

    private Class<T> clazz;

    public dao(){
        Type superClass = getClass().getGenericSuperclass();

        if (superClass instanceof ParameterizedType){
            ParameterizedType parameterizedType = (ParameterizedType) superClass;

            Type [] typeArgs =parameterizedType.getActualTypeArguments();
            if(typeArgs!=null && typeArgs.length>0){
                if (typeArgs[0]instanceof Class){
                    clazz = (Class<T>) typeArgs[0];
                }
            }
        }
    }
    public void update(String sql,Object ... args){
        Connection connection = null;
        try {
            connection = druidtoools.getConnection();
            queryRunner.update(connection,sql,args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
           druidtoools.close(connection,null);
        }

    }
    //返回实体类的对象
    public T get(String sql,Object ... args){
        Connection connection =null;
        try{
            connection =druidtoools.getConnection();
            return queryRunner.query(connection,sql,new BeanHandler<>(clazz),args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            druidtoools.close(connection,null);
        }
        return null;
    }
    //返回T所对应list
    public List<T> getForList(String sql,Object ... args){
        Connection connection = null;
        try{
           connection = druidtoools.getConnection();
           return  queryRunner.query(connection,sql,new BeanListHandler<>(clazz),args);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            druidtoools.close(connection,null);
        }


        return null;
    }

    public int getForValue(String sql, Object ... args){
        Connection connection = null;
        try {
            int count;
            connection = druidtoools.getConnection();
            if(queryRunner.query(connection,sql,new ScalarHandler<>(),args)==null){
                count = 0;
            }
            else {
                count = 1;
            }

            return count;
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            druidtoools.close(connection,null);
        }
        return 0;
    }
//接口
    public interface UserDAO {

        public List<User> getAll();

        public List<User> getFriends(String UID);

        public User searchFriends(String name);

        public List<User> getFriendsRequest(String UID);

        public void save(User user);

        public void accept(String UID,String name);

        public void refuse(String UID,String name);

        public void addFriend(String UID,String FriendID);

        public User get(String name);

        public User getByEmail(String email);

        public long getCountByName(String name);

        public long getCountByEmail(String email);
    }
//接口
    public interface ImageDAO {

        public List<Image> getPopularImage();

        public List<Image> getNewImage();

        public List<Image> getFavoriteImage(String UID);

        public List<Image> getMyImage(String UID);

        public List<Image> refresh();

        public List<Image> SearchImage(String by,String sort,String title);

        public void like(String UID, String ImageID);

        public void DeleteLike(String UID, String ImageID);

        public void save(Image image);

        public void update(Image image);

        public void Delete(int ImageID);

        public void userBrowse(String UID,int ImageID,String Date,String Title);

        public List<Image> getBrowseImage(String UID);

        public void deleteFavorite(int ImageID,int UID);

        public Image get(int ImageID);

        public long getCountByID(int ID);

        public long whetherlike(String UID,int ImageID);

        public List<Image> getHot(int ImageID);

    }


}

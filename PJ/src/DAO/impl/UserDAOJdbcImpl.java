package DAO.impl;


import DAO.dao;
import domain.User;

import java.util.List;

public class UserDAOJdbcImpl extends dao<User> implements dao.UserDAO {
    @Override
    public List<User> getAll() {
        String sql = "Select * from traveluser where UserName='luisg' ";
        return getForList(sql);
    }

    @Override
    public List<User> getFriends(String UID) {
        String sql = "Select traveluser.UserName,traveluser.Email,traveluser.Date,traveluser.UID from traveluser,userfriends where traveluser.UID=userfriends.FriendsID AND userfriends.UID=? AND userfriends.Accept=1";
        return getForList(sql,UID);
    }

    @Override
    public User searchFriends(String name) {
        String sql ="SELECT * from traveluser where UserName=?";
        return get(sql,name);
    }

    @Override
    public List<User> getFriendsRequest(String UID) {
        String sql = "Select traveluser.UserName,traveluser.Email,traveluser.Date,traveluser.UID from traveluser,userfriends where traveluser.UID=userfriends.FriendsID AND userfriends.UID=? AND userfriends.Accept=0";
        return getForList(sql,UID);
    }


    @Override
    public void save(User user) {
        String sql="INSERT INTO `traveluser`( `Email`, `Pass`,`UserName`,`Date`) VALUES (?,?,?,?) ";
        update(sql,user.getEmail(),user.getPass(),user.getUserName(),user.getDate());
    }

    @Override
    public void accept(String UID, String name) {
        String sql="UPDATE `userfriends` SET `Accept`=1 WHERE UID=? and FriendsID=?";
        update(sql,UID,name);
    }

    @Override
    public void refuse(String UID, String name) {
        String sql="DELETE FROM `userfriends`  WHERE UID=? and FriendsID=?";
        update(sql,UID,name);
    }

    @Override
    public void addFriend(String UID, String FriendID) {
        String sql="INSERT INTO `userfriends`(`UID`, `FriendsID`) VALUES (?,?)";
        update(sql,FriendID,UID);
    }

    @Override
    public User get(String name) {
        String sql ="Select * from traveluser where UserName=?";
        return get(sql,name);
    }

    @Override
    public User getByEmail(String email) {
        String sql ="Select * from traveluser where Email=?";
        return get(sql,email);
    }

    @Override
    public long getCountByName(String name) {
        String sql="select * from traveluser where UserName=?";
        return  getForValue(sql,name);
    }

    @Override
    public long getCountByEmail(String email) {
        String sql="select * from traveluser where Email=?";
        return  getForValue(sql,email);
    }
}

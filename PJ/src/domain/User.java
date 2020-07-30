package domain;

public class User {

    private Integer UID;
    private String Email;
    private String UserName;
    private String Pass;
    private String Date;
    private int ShowImage;


    public User() {
    }
    public User( String email, String userName, String pass, String date) {
        Email = email;
        UserName = userName;
        Pass = pass;
        Date = date;
    }
    public int getShowImage() {
        return ShowImage;
    }

    public void setShowImage(int showImage) {
        ShowImage = showImage;
    }
    public String getDate() {
        return Date;
    }

    public void setDate(String date) {
        Date = date;
    }

    public Integer getUID() {
        return UID;
    }

    public void setUID(Integer UID) {
        this.UID = UID;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getUserName() {
        return UserName;
    }

    public void setUserName(String userName) {
        UserName = userName;
    }

    public String getPass() {
        return Pass;
    }

    public void setPass(String pass) {
        Pass = pass;
    }



}

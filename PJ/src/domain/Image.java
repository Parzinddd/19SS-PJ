package domain;

public class Image {
    private int ImageID;
    private String Path;
    private String Title;
    private String Description;
    private String Content;
    private String Author;
    private String Country;
    private String City;
    private String Date;
    private String UID;


    public Image() {
    }

    public Image(String path, String title, String description, String content, String author, String country, String city, String date,String uid) {
        Path = path;
        Title = title;
        Description = description;
        Content = content;
        Author = author;
        Country = country;
        City = city;
        Date = date;
        UID = uid;
    }

    public Image(String path, String title, String description, String content, String author, String country, String city,int imageID,String date) {
        Path = path;
        Title = title;
        Description = description;
        Content = content;
        Author = author;
        Country = country;
        City = city;
        ImageID = imageID;
        Date = date;
    }public String getUID() {
        return UID;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }

    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int imageID) {
        ImageID = imageID;
    }

    public String getPath() {
        return Path;
    }

    public void setPath(String path) {
        Path = path;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }

    public String getAuthor() {
        return Author;
    }

    public void setAuthor(String author) {
        Author = author;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String country) {
        Country = country;
    }

    public String getCity() {
        return City;
    }

    public void setCity(String city) {
        City = city;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String date) {
        Date = date;
    }
}


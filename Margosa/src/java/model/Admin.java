package model;

public class Admin {
    private int aid;
    private String username;
    private String password;
    private String name;

    public Admin() {
    }

    public Admin(int aid, String username, String password, String name) {
        this.aid = aid;
        this.username = username;
        this.password = password;
        this.name = name;
    }

    public int getAid() {
        return aid;
    }

    public void setAid(int aid) {
        this.aid = aid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Admin{" + "aid=" + aid + ", username=" + username + ", password=" + password + ", name=" + name + '}';
    }
    
    
}

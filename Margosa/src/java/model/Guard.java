package model;

public class Guard {
    private int gid;
    private String username;
    private String password;
    private String name;
    private String email;
    private String phoneNum;

    public Guard() {
    }

    public Guard(int gid, String username, String password, String name, String email, String phoneNum) {
        this.gid = gid;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phoneNum = phoneNum;
    }

    public int getGid() {
        return gid;
    }

    public void setGid(int gid) {
        this.gid = gid;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNum() {
        return phoneNum;
    }

    public void setPhoneNum(String phoneNum) {
        this.phoneNum = phoneNum;
    }

    @Override
    public String toString() {
        return "Guard{" + "gid=" + gid + ", username=" + username + ", password=" + password + ", name=" + name + ", email=" + email + ", phoneNum=" + phoneNum + '}';
    }

    
}

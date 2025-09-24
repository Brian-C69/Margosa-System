package model;

public class Committee {
    private int comid;
    private String username;
    private String password;
    private String name;
    private String email;
    private String phoneNum;
    private String role;

    public Committee() {
    }

    public Committee(int comid, String username, String password, String name, String email, String phoneNum, String role) {
        this.comid = comid;
        this.username = username;
        this.password = password;
        this.name = name;
        this.email = email;
        this.phoneNum = phoneNum;
        this.role = role;
    }

    public int getComid() {
        return comid;
    }

    public void setComid(int comid) {
        this.comid = comid;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "Committee{" + "comid=" + comid + ", username=" + username + ", password=" + password + ", name=" + name + ", email=" + email + ", phoneNum=" + phoneNum + ", role=" + role + '}';
    }
    
    
}

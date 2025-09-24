package model;

import java.sql.Date;

public class Resident {
    private int rid;
    private int fid;
    private int hid;
    private String firstName;
    private String lastName;
    private String gender;
    private String email;
    private String phoneNum;
    private String username;
    private String password;
    private Date birthday;
    private boolean approved;

    public Resident() {
    }

    public Resident(int rid, int fid, int hid, String firstName, String lastName, String gender, String email, String phoneNum, String username, String password, Date birthday, boolean approved) {
        this.rid = rid;
        this.fid = fid;
        this.hid = hid;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.email = email;
        this.phoneNum = phoneNum;
        this.username = username;
        this.password = password;
        this.birthday = birthday;
        this.approved = approved;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public boolean isApproved() {
        return approved;
    }

    public void setApproved(boolean approved) {
        this.approved = approved;
    }

    @Override
    public String toString() {
        return "Resident{" + "rid=" + rid + ", fid=" + fid + ", hid=" + hid + ", firstName=" + firstName + ", lastName=" + lastName + ", gender=" + gender + ", email=" + email + ", phoneNum=" + phoneNum + ", username=" + username + ", password=" + password + ", birthday=" + birthday + ", approved=" + approved + '}';
    }

    
}

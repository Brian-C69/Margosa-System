package model;

import java.sql.Date;
import java.sql.Time;

public class Visitor {
    private int vid;
    private int fid;
    private String visitorName;
    private String visitorPhoneNum;
    private String visitorVehicleNum;
    private Date visitorEntryDate;
    private Time visitorEntryTime;
    private Date visitorExitDate;
    private Time visitorExitTime;
    private Date visitorAddedDate;
    private Time visitorAddedTime;
    private String houseNum;
    private String houseStreet;

    public Visitor() {
    }

    public int getVid() {
        return vid;
    }

    public void setVid(int vid) {
        this.vid = vid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public String getVisitorName() {
        return visitorName;
    }

    public void setVisitorName(String visitorName) {
        this.visitorName = visitorName;
    }

    public String getVisitorPhoneNum() {
        return visitorPhoneNum;
    }

    public void setVisitorPhoneNum(String visitorPhoneNum) {
        this.visitorPhoneNum = visitorPhoneNum;
    }

    public String getVisitorVehicleNum() {
        return visitorVehicleNum;
    }

    public void setVisitorVehicleNum(String visitorVehicleNum) {
        this.visitorVehicleNum = visitorVehicleNum;
    }

    public Date getVisitorEntryDate() {
        return visitorEntryDate;
    }

    public void setVisitorEntryDate(Date visitorEntryDate) {
        this.visitorEntryDate = visitorEntryDate;
    }

    public Time getVisitorEntryTime() {
        return visitorEntryTime;
    }

    public void setVisitorEntryTime(Time visitorEntryTime) {
        this.visitorEntryTime = visitorEntryTime;
    }

    public Date getVisitorExitDate() {
        return visitorExitDate;
    }

    public void setVisitorExitDate(Date visitorExitDate) {
        this.visitorExitDate = visitorExitDate;
    }

    public Time getVisitorExitTime() {
        return visitorExitTime;
    }

    public void setVisitorExitTime(Time visitorExitTime) {
        this.visitorExitTime = visitorExitTime;
    }

    public Date getVisitorAddedDate() {
        return visitorAddedDate;
    }

    public void setVisitorAddedDate(Date visitorAddedDate) {
        this.visitorAddedDate = visitorAddedDate;
    }

    public Time getVisitorAddedTime() {
        return visitorAddedTime;
    }

    public void setVisitorAddedTime(Time visitorAddedTime) {
        this.visitorAddedTime = visitorAddedTime;
    }

    public String getHouseNum() {
        return houseNum;
    }

    public void setHouseNum(String houseNum) {
        this.houseNum = houseNum;
    }

    public String getHouseStreet() {
        return houseStreet;
    }

    public void setHouseStreet(String houseStreet) {
        this.houseStreet = houseStreet;
    }

    public Visitor(int vid, int fid, String visitorName, String visitorPhoneNum, String visitorVehicleNum, Date visitorEntryDate, Time visitorEntryTime, Date visitorExitDate, Time visitorExitTime, Date visitorAddedDate, Time visitorAddedTime, String houseNum, String houseStreet) {
        this.vid = vid;
        this.fid = fid;
        this.visitorName = visitorName;
        this.visitorPhoneNum = visitorPhoneNum;
        this.visitorVehicleNum = visitorVehicleNum;
        this.visitorEntryDate = visitorEntryDate;
        this.visitorEntryTime = visitorEntryTime;
        this.visitorExitDate = visitorExitDate;
        this.visitorExitTime = visitorExitTime;
        this.visitorAddedDate = visitorAddedDate;
        this.visitorAddedTime = visitorAddedTime;
        this.houseNum = houseNum;
        this.houseStreet = houseStreet;
    }

    @Override
    public String toString() {
        return "Visitor{" + "vid=" + vid + ", fid=" + fid + ", visitorName=" + visitorName + ", visitorPhoneNum=" + visitorPhoneNum + ", visitorVehicleNum=" + visitorVehicleNum + ", visitorEntryDate=" + visitorEntryDate + ", visitorEntryTime=" + visitorEntryTime + ", visitorExitDate=" + visitorExitDate + ", visitorExitTime=" + visitorExitTime + ", visitorAddedDate=" + visitorAddedDate + ", visitorAddedTime=" + visitorAddedTime + ", houseNum=" + houseNum + ", houseStreet=" + houseStreet + '}';
    }


}

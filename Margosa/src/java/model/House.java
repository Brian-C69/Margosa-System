package model;

public class House {
    private int hid;
    private int fid;
    private String houseNum;
    private String houseStreet;  

    public House() {
    }

    public House(int hid, int fid, String houseNum, String houseStreet) {
        this.hid = hid;
        this.fid = fid;
        this.houseNum = houseNum;
        this.houseStreet = houseStreet;
    }

    public int getHid() {
        return hid;
    }

    public void setHid(int hid) {
        this.hid = hid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
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

    @Override
    public String toString() {
        return "House{" + "hid=" + hid + ", fid=" + fid + ", houseNum=" + houseNum + ", houseStreet=" + houseStreet + '}';
    }

    
    
}

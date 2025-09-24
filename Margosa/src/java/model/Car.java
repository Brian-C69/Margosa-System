package model;

public class Car {
    private int cid;
    private int fid;
    private String carBrand;
    private String carModel;
    private String carColor;
    private String carPlateNum;
    private String carType;

    public Car() {
    }

    public Car(int cid, int fid, String carBrand, String carModel, String carColor, String carPlateNum, String carType) {
        this.cid = cid;
        this.fid = fid;
        this.carBrand = carBrand;
        this.carModel = carModel;
        this.carColor = carColor;
        this.carPlateNum = carPlateNum;
        this.carType = carType;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public String getCarBrand() {
        return carBrand;
    }

    public void setCarBrand(String carBrand) {
        this.carBrand = carBrand;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getCarColor() {
        return carColor;
    }

    public void setCarColor(String carColor) {
        this.carColor = carColor;
    }

    public String getCarPlateNum() {
        return carPlateNum;
    }

    public void setCarPlateNum(String carPlateNum) {
        this.carPlateNum = carPlateNum;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    @Override
    public String toString() {
        return "Car{" + "cid=" + cid + ", fid=" + fid + ", carBrand=" + carBrand + ", carModel=" + carModel + ", carColor=" + carColor + ", carPlateNum=" + carPlateNum + ", carType=" + carType + '}';
    }

    
}

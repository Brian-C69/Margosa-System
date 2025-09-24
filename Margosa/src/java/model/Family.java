package model;
import java.util.List;
    
public class Family {
    private int fid;
    private int hid;
    private String familyName;
    private String familyPin;
    private List<House> house;
    private List<Resident> residents;
    private List<Car> cars;
    private List<Visitor> visitor;


    public Family() {
    }

    public Family(int fid, int hid, String familyName, String familyPin, List<House> house, List<Resident> residents, List<Car> cars, List<Visitor> visitor) {
        this.fid = fid;
        this.hid = hid;
        this.familyName = familyName;
        this.familyPin = familyPin;
        this.house = house;
        this.residents = residents;
        this.cars = cars;
        this.visitor = visitor;
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

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getFamilyPin() {
        return familyPin;
    }

    public void setFamilyPin(String familyPin) {
        this.familyPin = familyPin;
    }

    public List<House> getHouse() {
        return house;
    }

    public void setHouse(List<House> house) {
        this.house = house;
    }

    public List<Resident> getResidents() {
        return residents;
    }

    public void setResidents(List<Resident> residents) {
        this.residents = residents;
    }

    public List<Car> getCars() {
        return cars;
    }

    public void setCars(List<Car> cars) {
        this.cars = cars;
    }

    public List<Visitor> getVisitor() {
        return visitor;
    }

    public void setVisitor(List<Visitor> visitor) {
        this.visitor = visitor;
    }

    @Override
    public String toString() {
        return "Family{" + "fid=" + fid + ", hid=" + hid + ", familyName=" + familyName + ", familyPin=" + familyPin + ", house=" + house + ", residents=" + residents + ", cars=" + cars + ", visitor=" + visitor + '}';
    }

    
    
}

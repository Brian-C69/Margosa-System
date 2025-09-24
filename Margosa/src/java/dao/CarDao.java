package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Car;

public class CarDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public CarDao(Connection con) {
        this.con = con;
    }

    public List<Car> getCarsByFamilyId(int fid) {
        List<Car> cars = new ArrayList<>();
        try {
            query = "SELECT * FROM Car WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            rs = pst.executeQuery();
            while (rs.next()) {
                Car car = new Car();
                car.setCid(rs.getInt("CID"));
                car.setCarBrand(rs.getString("CARBRAND"));
                car.setCarModel(rs.getString("CARMODEL"));
                car.setCarColor(rs.getString("CARCOLOR"));
                car.setCarPlateNum(rs.getString("CARPLATENUM"));
                car.setCarType(rs.getString("CARTYPE"));
                car.setFid(rs.getInt("FID"));
                cars.add(car);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cars;
    }
    
    public List<Car> getAllCars() {
    List<Car> cars = new ArrayList<>();
    try {
        query = "SELECT * FROM Car";
        pst = this.con.prepareStatement(query);
        rs = pst.executeQuery();
        while (rs.next()) {
            Car car = new Car();
            car.setCid(rs.getInt("CID"));
            car.setCarBrand(rs.getString("CARBRAND"));
            car.setCarModel(rs.getString("CARMODEL"));
            car.setCarColor(rs.getString("CARCOLOR"));
            car.setCarPlateNum(rs.getString("CARPLATENUM"));
            car.setCarType(rs.getString("CARTYPE"));
            car.setFid(rs.getInt("FID"));
            cars.add(car);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return cars;
}

    public void addCar(Car car) {
        try {
            query = "INSERT INTO Car (CARBRAND, CARMODEL, CARCOLOR, CARPLATENUM, CARTYPE, FID) VALUES (?, ?, ?, ?, ?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, car.getCarBrand());
            pst.setString(2, car.getCarModel());
            pst.setString(3, car.getCarColor());
            pst.setString(4, car.getCarPlateNum());
            pst.setString(5, car.getCarType());
            pst.setInt(6, car.getFid());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateCar(Car car) {
        try {
            query = "UPDATE Car SET CARBRAND = ?, CARMODEL = ?, CARCOLOR = ?, CARPLATENUM = ?, CARTYPE = ?, FID = ? WHERE CID = ?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, car.getCarBrand());
            pst.setString(2, car.getCarModel());
            pst.setString(3, car.getCarColor());
            pst.setString(4, car.getCarPlateNum());
            pst.setString(5, car.getCarType());
            pst.setInt(6, car.getFid());
            pst.setInt(7, car.getCid());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCar(int cid) {
        try {
            query = "DELETE FROM Car WHERE CID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, cid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

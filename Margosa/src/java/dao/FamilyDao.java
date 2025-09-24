package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Car;
import model.Family;
import model.House;
import model.Resident;
import model.Visitor;

public class FamilyDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public FamilyDao(Connection con) {
        this.con = con;
    }

    public List<Family> getAllFamilies() {
        List<Family> families = new ArrayList<>();
        try {
            query = "SELECT * FROM Family";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Family family = createFamilyFromResultSet(rs);
                families.add(family);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return families;
    }
    
    public Family getFamilyByResidentId(int residentId) {
        Family family = null;
        try {
            query = "SELECT f.* FROM Family f JOIN Resident r ON f.FID = r.FID WHERE r.RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, residentId);
            rs = pst.executeQuery();
            if (rs.next()) {
                family = createFamilyFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return family;
    }

    public void addFamily(Family family) {
        try {
            query = "INSERT INTO Family (FAMILYNAME, FAMILYPIN) VALUES (?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, family.getFamilyName());
            pst.setString(2, family.getFamilyPin());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateFamily(Family family) {
        try {
            query = "UPDATE Family SET FAMILYNAME = ? WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, family.getFamilyName());
            pst.setInt(2, family.getFid());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteFamily(int fid) {
        try {
            // Delete associated residents
            ResidentDao residentDao = new ResidentDao(con);
            List<Resident> residents = residentDao.getResidentsByFamilyId(fid);
            for (Resident resident : residents) {
                residentDao.removeResident(resident.getRid());
            }
            
            // Delete associated cars
            CarDao carDao = new CarDao(con);
            List<Car> cars = carDao.getCarsByFamilyId(fid);
            for (Car car : cars) {
                carDao.deleteCar(car.getCid());
            }
            
            // Delete associated visitors
            VisitorDao visitorDao = new VisitorDao(con);
            List<Visitor> visitors = visitorDao.getVisitorsByFamilyId(fid);
            for (Visitor visitor : visitors) {
                visitorDao.deleteVisitor(visitor.getVid());
            }
            
            // Delete associated houses
            HouseDao houseDao = new HouseDao(con);
            List<House> houses = houseDao.getHousesByFamilyId(fid);
            for (House house : houses) {
                houseDao.deleteHouse(house.getHid());
            }
            
            // Delete the family
            query = "DELETE FROM Family WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Family createFamilyFromResultSet(ResultSet rs) throws Exception {
        Family family = new Family();
        family.setFid(rs.getInt("FID"));
        family.setFamilyName(rs.getString("FAMILYNAME"));
        family.setFamilyPin(rs.getString("FAMILYPIN"));

        // Retrieve associated residents
        ResidentDao residentDao = new ResidentDao(con);
        List<Resident> residents = residentDao.getResidentsByFamilyId(family.getFid());
        family.setResidents(residents);

        // Retrieve associated cars
        CarDao carDao = new CarDao(con);
        List<Car> cars = carDao.getCarsByFamilyId(family.getFid());
        family.setCars(cars);

        // Retrieve associated visitors
        VisitorDao visitorDao = new VisitorDao(con);
        List<Visitor> visitors = visitorDao.getVisitorsByFamilyId(family.getFid());
        family.setVisitor(visitors);

        // Retrieve associated houses
        HouseDao houseDao = new HouseDao(con);
        List<House> house = houseDao.getHousesByFamilyId(family.getFid());
        family.setHouse(house);

        return family;
    }
    
        public ResultSet getFamilyById(int fid) throws SQLException {
        String query = "SELECT * FROM Family WHERE fid = ?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setInt(1, fid);
        return stmt.executeQuery();
    }
        
        
    public void updateFamilyHID(int fid, int hid) {
    try {
        query = "UPDATE Family SET HID = ? WHERE FID = ?";
        pst = this.con.prepareStatement(query);
        pst.setInt(1, hid);
        pst.setInt(2, fid);
        pst.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public Family getFamilyByHouseId(int hid) {
    Family family = null;
    try {
        query = "SELECT * FROM Family WHERE HID = ?";
        pst = this.con.prepareStatement(query);
        pst.setInt(1, hid);
        rs = pst.executeQuery();
        if (rs.next()) {
            family = createFamilyFromResultSet(rs);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return family;
}
}

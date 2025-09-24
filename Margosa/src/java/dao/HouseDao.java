package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.House;

public class HouseDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public HouseDao(Connection con) {
        this.con = con;
    }

    public List<House> getHousesByFamilyId(int fid) {
        List<House> houses = new ArrayList<>();
        try {
            query = "SELECT * FROM House WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            rs = pst.executeQuery();
            while (rs.next()) {
                House house = new House();
                house.setHid(rs.getInt("HID"));
                house.setHouseNum(rs.getString("HOUSENUM"));
                house.setHouseStreet(rs.getString("HOUSESTREET"));
                house.setFid(rs.getInt("FID"));
                houses.add(house);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return houses;
    }
    
    public List<House> getAllHouses() {
        List<House> houses = new ArrayList<>();
        try {
            query = "SELECT * FROM House";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                House house = new House();
                house.setHid(rs.getInt("HID"));
                house.setHouseNum(rs.getString("HOUSENUM"));
                house.setHouseStreet(rs.getString("HOUSESTREET"));
                house.setFid(rs.getInt("FID"));
                houses.add(house);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return houses;
    }

    public int addHouse(House house) {
        int generatedHid = 0;
        try {
            query = "INSERT INTO House (HOUSENUM, HOUSESTREET, FID) VALUES (?, ?, ?)";
            pst = this.con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            pst.setString(1, house.getHouseNum());
            pst.setString(2, house.getHouseStreet());
            pst.setInt(3, house.getFid());
            pst.executeUpdate();

            // Retrieve the generated HID
            ResultSet generatedKeys = pst.getGeneratedKeys();
            if (generatedKeys.next()) {
                generatedHid = generatedKeys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return generatedHid;
    }

    public void updateHouse(House house) {
        try {
            query = "UPDATE House SET HOUSENUM = ?, HOUSESTREET = ?, FID = ? WHERE HID = ?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, house.getHouseNum());
            pst.setString(2, house.getHouseStreet());
            pst.setInt(3, house.getFid());
            pst.setInt(4, house.getHid());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteHouse(int hid) {
        try {
            query = "DELETE FROM House WHERE HID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, hid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public House getHouseByHID(int hid) {
        House house = null;
        try {
            query = "SELECT * FROM House WHERE HID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, hid);
            rs = pst.executeQuery();
            if (rs.next()) {
                house = new House();
                house.setHid(rs.getInt("HID"));
                house.setHouseNum(rs.getString("HOUSENUM"));
                house.setHouseStreet(rs.getString("HOUSESTREET"));
                house.setFid(rs.getInt("FID"));
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return house;
    }

    
    public int getFIDByHouseDetails(String houseStreet, String houseNum) {
    int fid = 0;
    try {
        query = "SELECT FID FROM House WHERE HOUSESTREET = ? AND HOUSENUM = ?";
        pst = this.con.prepareStatement(query);
        pst.setString(1, houseStreet);
        pst.setString(2, houseNum);
        rs = pst.executeQuery();
        if (rs.next()) {
            fid = rs.getInt("FID");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return fid;
}

}

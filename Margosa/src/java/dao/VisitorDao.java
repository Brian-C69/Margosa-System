package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.House;
import model.Visitor;
import dao.HouseDao;

public class VisitorDao {

    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public VisitorDao(Connection con) {
        this.con = con;
    }

    public List<Visitor> getVisitorsByFamilyId(int fid) {
        List<Visitor> visitors = new ArrayList<>();
        try {
            query = "SELECT * FROM Visitor WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            rs = pst.executeQuery();
            while (rs.next()) {
                Visitor visitor = extractVisitorFromResultSet(rs);
                visitors.add(visitor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitors;
    }

    public List<Visitor> getAllVisitors() {
        List<Visitor> visitors = new ArrayList<>();
        try {
            query = "SELECT * FROM Visitor";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Visitor visitor = extractVisitorFromResultSet(rs);
                visitors.add(visitor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitors;
    }

    public List<Visitor> getCreatedVisitors() {
        List<Visitor> visitors = new ArrayList<>();
        try {
            query = "SELECT * FROM Visitor WHERE VISITORENTRYDATE = '1900-01-01' AND VISITORENTRYTIME = '00:00:00'";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Visitor visitor = extractVisitorFromResultSet(rs);
                visitors.add(visitor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitors;
    }

    public List<Visitor> getEnteredVisitors() {
        List<Visitor> visitors = new ArrayList<>();
        try {
            query = "SELECT * FROM Visitor WHERE VISITORENTRYDATE <> '1900-01-01' AND VISITORENTRYTIME <> '00:00:00' AND (VISITOREXITDATE = '1900-01-01' AND VISITOREXITTIME = '00:00:00')";

            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Visitor visitor = extractVisitorFromResultSet(rs);
                visitors.add(visitor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitors;
    }

    public List<Visitor> getExitedVisitors() {
        List<Visitor> visitors = new ArrayList<>();
        try {
            query = "SELECT * FROM Visitor WHERE VISITOREXITDATE <> '1900-01-01' AND VISITOREXITTIME <> '00:00:00'";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Visitor visitor = extractVisitorFromResultSet(rs);
                visitors.add(visitor);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitors;
    }

    public void addVisitor(Visitor visitor) {
        try {
            query = "INSERT INTO Visitor (VISITORNAME, VISITORPHONENUM, VISITORVEHICLENUM, VISITORENTRYDATE, VISITORENTRYTIME, VISITOREXITDATE, VISITOREXITTIME, VISITORADDEDDATE, VISITORADDEDTIME, FID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pst = this.con.prepareStatement(query);
            pst.setString(1, visitor.getVisitorName());
            pst.setString(2, visitor.getVisitorPhoneNum());
            pst.setString(3, visitor.getVisitorVehicleNum());

            pst.setDate(4, java.sql.Date.valueOf("1900-01-01")); // Placeholder date
            pst.setTime(5, java.sql.Time.valueOf("00:00:00")); // Placeholder time
            pst.setDate(6, java.sql.Date.valueOf("1900-01-01")); // Placeholder date
            pst.setTime(7, java.sql.Time.valueOf("00:00:00")); // Placeholder time
            pst.setDate(8, new java.sql.Date(visitor.getVisitorAddedDate().getTime()));
            pst.setTime(9, new java.sql.Time(visitor.getVisitorAddedTime().getTime()));
            pst.setInt(10, visitor.getFid());

            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateVisitorEntry(int vid) {
        try {
            query = "UPDATE Visitor SET VISITORENTRYDATE = ?, VISITORENTRYTIME = ? WHERE VID = ?";
            pst = this.con.prepareStatement(query);
            pst.setDate(1, new java.sql.Date(new Date().getTime()));
            pst.setTime(2, new java.sql.Time(new Date().getTime()));
            pst.setInt(3, vid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateVisitorExit(int vid) {
        try {
            query = "UPDATE Visitor SET VISITOREXITDATE = ?, VISITOREXITTIME = ? WHERE VID = ?";
            pst = this.con.prepareStatement(query);
            pst.setDate(1, new java.sql.Date(new Date().getTime()));
            pst.setTime(2, new java.sql.Time(new Date().getTime()));
            pst.setInt(3, vid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteVisitor(int vid) {
        try {
            query = "DELETE FROM Visitor WHERE VID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, vid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Visitor getVisitorById(int vid) {
        Visitor visitor = null;
        try {
            query = "SELECT * FROM Visitor WHERE VID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, vid);
            rs = pst.executeQuery();
            if (rs.next()) {
                visitor = extractVisitorFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return visitor;
    }

    public void guardAddVisitor(Visitor visitor, String houseStreet, String houseNum) {
    try {
        HouseDao houseDao = new HouseDao(this.con);
        int fid = houseDao.getFIDByHouseDetails(houseStreet, houseNum);

        query = "INSERT INTO Visitor (VISITORNAME, VISITORPHONENUM, VISITORVEHICLENUM, VISITORENTRYDATE, VISITORENTRYTIME, VISITOREXITDATE, VISITOREXITTIME, VISITORADDEDDATE, VISITORADDEDTIME, HOUSENUM, HOUSESTREET ,FID) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        pst = this.con.prepareStatement(query);
        pst.setString(1, visitor.getVisitorName());
        pst.setString(2, visitor.getVisitorPhoneNum());
        pst.setString(3, visitor.getVisitorVehicleNum());

        pst.setDate(4, new java.sql.Date(visitor.getVisitorAddedDate().getTime())); // Visitor entry date
        pst.setTime(5, new java.sql.Time(visitor.getVisitorAddedTime().getTime())); // Visitor entry time
        pst.setDate(6, java.sql.Date.valueOf("1900-01-01")); // Placeholder exit date
        pst.setTime(7, java.sql.Time.valueOf("00:00:00")); // Placeholder exit time
        pst.setDate(8, new java.sql.Date(visitor.getVisitorAddedDate().getTime()));
        pst.setTime(9, new java.sql.Time(visitor.getVisitorAddedTime().getTime()));
        pst.setString(10, visitor.getHouseNum());
        pst.setString(11, visitor.getHouseStreet());
        pst.setObject(12, (fid == 0) ? null : fid);
        
//        //        if (fid == 0) {
//            pst.setNull(12, java.sql.Types.INTEGER); // Set FID as null
//        } else {
//            pst.setInt(12, fid);
//        }
        
        pst.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    private Visitor extractVisitorFromResultSet(ResultSet rs) throws Exception {
        Visitor visitor = new Visitor();
        visitor.setVid(rs.getInt("VID"));
        visitor.setVisitorName(rs.getString("VISITORNAME"));
        visitor.setVisitorPhoneNum(rs.getString("VISITORPHONENUM"));
        visitor.setVisitorVehicleNum(rs.getString("VISITORVEHICLENUM"));
        visitor.setVisitorEntryDate(rs.getDate("VISITORENTRYDATE"));
        visitor.setVisitorEntryTime(rs.getTime("VISITORENTRYTIME"));
        visitor.setVisitorExitDate(rs.getDate("VISITOREXITDATE"));
        visitor.setVisitorExitTime(rs.getTime("VISITOREXITTIME"));
        visitor.setVisitorAddedDate(rs.getDate("VISITORADDEDDATE"));
        visitor.setVisitorAddedTime(rs.getTime("VISITORADDEDTIME"));
        visitor.setFid(rs.getInt("FID"));
        
        // Read HouseNum and HouseStreet if they exist in the ResultSet
        String houseNum = rs.getString("HOUSENUM");
        String houseStreet = rs.getString("HOUSESTREET");
        if (houseNum != null && houseStreet != null) {
            visitor.setHouseNum(houseNum);
            visitor.setHouseStreet(houseStreet);
        }
        
        return visitor;
    }
}

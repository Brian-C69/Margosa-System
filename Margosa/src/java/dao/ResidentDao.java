package dao;

import static connection.SqlCon.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Family;
import model.Resident;

public class ResidentDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public ResidentDao(Connection con) {
        this.con = con;
    }

    public Resident residentLogin(String input, String password) {
        Resident resident = null;
        try {
            query = "SELECT * FROM Resident WHERE (username=? OR email=?) AND password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, input);
            pst.setString(2, input);
            pst.setString(3, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                resident = new Resident();
                resident.setRid(rs.getInt("RID"));
                resident.setFid(rs.getInt("FID"));
                resident.setHid(rs.getInt("HID"));
                resident.setFirstName(rs.getString("FIRSTNAME"));
                resident.setLastName(rs.getString("LASTNAME"));
                resident.setGender(rs.getString("GENDER"));
                resident.setEmail(rs.getString("EMAIL"));
                resident.setPhoneNum(rs.getString("PHONENUM"));
                resident.setUsername(rs.getString("USERNAME"));
                resident.setPassword(rs.getString("PASSWORD"));
                resident.setApproved(rs.getBoolean("APPROVED"));
                resident.setBirthday(rs.getDate("BIRTHDAY"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return resident;
    }

    public List<Resident> getAllResidents() {
        List<Resident> residents = new ArrayList<>();

        try {
            query = "SELECT * FROM Resident";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setRid(rs.getInt("RID"));
                resident.setFid(rs.getInt("FID"));
                resident.setHid(rs.getInt("HID"));
                resident.setFirstName(rs.getString("FIRSTNAME"));
                resident.setLastName(rs.getString("LASTNAME"));
                resident.setGender(rs.getString("GENDER"));
                resident.setEmail(rs.getString("EMAIL"));
                resident.setPhoneNum(rs.getString("PHONENUM"));
                resident.setUsername(rs.getString("USERNAME"));
                resident.setApproved(rs.getBoolean("APPROVED"));
                resident.setBirthday(rs.getDate("BIRTHDAY"));

                residents.add(resident);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return residents;
    }

    public List<Resident> getResidentsByFamilyId(int fid) {
        List<Resident> residents = new ArrayList<>();

        try {
            query = "SELECT * FROM Resident WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            rs = pst.executeQuery();
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setRid(rs.getInt("RID"));
                resident.setFirstName(rs.getString("FIRSTNAME"));
                resident.setLastName(rs.getString("LASTNAME"));
                resident.setGender(rs.getString("GENDER"));
                resident.setEmail(rs.getString("EMAIL"));
                resident.setPhoneNum(rs.getString("PHONENUM"));
                resident.setUsername(rs.getString("USERNAME"));
                resident.setPassword(rs.getString("PASSWORD"));
                resident.setApproved(rs.getBoolean("APPROVED"));
                resident.setBirthday(rs.getDate("BIRTHDAY"));

                residents.add(resident);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return residents;
    }

    public void removeResident(int rid) {
        try {
            query = "DELETE FROM Resident WHERE RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, rid);
            pst.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateResident(Resident resident) {
        try {
            query = "UPDATE Resident SET FIRSTNAME = ?, LASTNAME = ?, GENDER = ?, EMAIL = ?, PHONENUM = ?, USERNAME = ?, PASSWORD = ?, APPROVED = ?, HID = ?, BIRTHDAY = ? WHERE RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, resident.getFirstName());
            pst.setString(2, resident.getLastName());
            pst.setString(3, resident.getGender());
            pst.setString(4, resident.getEmail());
            pst.setString(5, resident.getPhoneNum());
            pst.setString(6, resident.getUsername());
            pst.setString(7, resident.getPassword());
            pst.setBoolean(8, resident.isApproved());
            pst.setInt(9, resident.getHid());
            pst.setDate(10, new java.sql.Date(resident.getBirthday().getTime()));
            pst.setInt(11, resident.getRid());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean isUsernameTaken(String username) throws SQLException {
        String query = "SELECT COUNT(*) FROM resident WHERE username = ?";
        try (PreparedStatement statement = con.prepareStatement(query)) {
            statement.setString(1, username);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }

    public boolean isEmailUsed(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM resident WHERE email = ?";
        try (PreparedStatement statement = con.prepareStatement(query)) {
            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        }
        return false;
    }

    public Family getResidentFamily(Resident resident) {
        Family family = null;
        try {
            query = "SELECT * FROM Family WHERE FID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, resident.getFid());
            rs = pst.executeQuery();

            if (rs.next()) {
                family = new Family();
                family.setFid(rs.getInt("FID"));
                family.setFamilyName(rs.getString("FAMILYNAME"));
                // Set other family properties as needed
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return family;
    }

    public int createFamily(String familyName) {
        int fid = -1;
        try {
            query = "INSERT INTO Family (FAMILYNAME) VALUES (?)";
            pst = this.con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);
            pst.setString(1, familyName);
            pst.executeUpdate();

            ResultSet generatedKeys = pst.getGeneratedKeys();
            if (generatedKeys.next()) {
                fid = generatedKeys.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return fid;
    }

    public void updateFamilyId(int rid, int fid) {
        try {
            query = "UPDATE Resident SET FID = ? WHERE RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, fid);
            pst.setInt(2, rid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
    }
    
    public Integer getResidentHID(int residentId) {
    Integer hid = null;
    try {
        query = "SELECT HID FROM Resident WHERE RID = ?";
        pst = this.con.prepareStatement(query);
        pst.setInt(1, residentId);
        rs = pst.executeQuery();

        if (rs.next()) {
            hid = rs.getInt("HID");
        }
    } catch (Exception e) {
        e.printStackTrace();
        System.out.print(e.getMessage());
    }
    return hid;
}
    
    
public void resetPassword(String password, int rid) {
    try {
        query = "UPDATE RESIDENT SET PASSWORD = ? WHERE RID = ?";
        pst = this.con.prepareStatement(query);
        pst.setString(1, password);
        pst.setInt(2, rid);

        pst.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

public void updateHouseId(int rid, int hid) {
    try {
        query = "UPDATE Resident SET HID = ? WHERE RID = ?";
        pst = this.con.prepareStatement(query);
        pst.setInt(1, hid);
        pst.setInt(2, rid);
        pst.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
        System.out.print(e.getMessage());
    }
}

public List<Resident> getNotApprovedResidents() {
        List<Resident> notApprovedResidents = new ArrayList<>();

        try {
            query = "SELECT * FROM Resident WHERE CAST(APPROVED AS BOOLEAN) = false";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setRid(rs.getInt("RID"));
                resident.setFid(rs.getInt("FID"));
                resident.setHid(rs.getInt("HID"));
                resident.setFirstName(rs.getString("FIRSTNAME"));
                resident.setLastName(rs.getString("LASTNAME"));
                resident.setGender(rs.getString("GENDER"));
                resident.setEmail(rs.getString("EMAIL"));
                resident.setPhoneNum(rs.getString("PHONENUM"));
                resident.setUsername(rs.getString("USERNAME"));
                resident.setApproved(rs.getBoolean("APPROVED"));
                resident.setBirthday(rs.getDate("BIRTHDAY"));

                notApprovedResidents.add(resident);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notApprovedResidents;
    }

public List<Resident> getApprovedResidents() {
        List<Resident> approvedResidents = new ArrayList<>();

        try {
            query = "SELECT * FROM Resident WHERE CAST(APPROVED AS BOOLEAN) = true";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Resident resident = new Resident();
                resident.setRid(rs.getInt("RID"));
                resident.setFid(rs.getInt("FID"));
                resident.setHid(rs.getInt("HID"));
                resident.setFirstName(rs.getString("FIRSTNAME"));
                resident.setLastName(rs.getString("LASTNAME"));
                resident.setGender(rs.getString("GENDER"));
                resident.setEmail(rs.getString("EMAIL"));
                resident.setPhoneNum(rs.getString("PHONENUM"));
                resident.setUsername(rs.getString("USERNAME"));
                resident.setApproved(rs.getBoolean("APPROVED"));
                resident.setBirthday(rs.getDate("BIRTHDAY"));

                approvedResidents.add(resident);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return approvedResidents;
    }

public void approveResident(int rid) {
        try {
            query = "UPDATE Resident SET APPROVED = true WHERE RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, rid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public void revokeResident(int rid) {
        try {
            query = "UPDATE Resident SET APPROVED = false WHERE RID = ?";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, rid);
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
